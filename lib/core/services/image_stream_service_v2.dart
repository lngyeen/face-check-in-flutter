import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/face_detection_cache.dart';
import 'package:face_check_in_flutter/core/services/frame_pipeline_data.dart';
import 'package:face_check_in_flutter/core/services/image_converter.dart';
import 'package:face_check_in_flutter/core/services/image_stream_service_interface.dart';
import 'package:face_check_in_flutter/core/services/liveness_batch_processor.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/hybrid_processing_result.dart';
import 'package:face_check_in_flutter/domain/entities/image_stream_config.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';
import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';
import 'package:face_check_in_flutter/domain/entities/processed_frame.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

import 'face_detection_service_v2.dart';
import 'liveness_service_v2.dart';

@LazySingleton(as: ImageStreamServiceV2)
class ImageStreamServiceV2Impl implements ImageStreamServiceV2 {
  final WebSocketService _webSocketService;
  final LivenessServiceV2 _livenessService;
  final FaceDetectionServiceV2 _faceDetectionService;

  CameraController? _activeController;
  StreamSubscription? _frameProcessorSubscription;
  final _frameSubject = PublishSubject<CameraImage>();

  final ProcessingMode _processingMode = ProcessingMode.hybrid;
  final _streamingStatusSubject = BehaviorSubject<StreamingStatus>.seeded(
    StreamingStatus.idle,
  );
  final _processingResultSubject =
      BehaviorSubject<HybridProcessingResult>.seeded(
        HybridProcessingResult(status: ProcessingStatus.waitingForFace),
      );

  late final BehaviorSubject<Duration> _throttleDurationSubject;

  final _faceDetectionCache = FaceDetectionCache();
  late final LivenessBatchProcessor _livenessBatchProcessor;

  bool get _isStreaming => switch (_streamingStatusSubject.value) {
    StreamingStatus.idle => false,
    StreamingStatus.initializing => true,
    StreamingStatus.active => true,
    StreamingStatus.error => false,
  };

  @override
  Stream<StreamingStatus> get streamingStatusStream =>
      _streamingStatusSubject.stream;

  @override
  Stream<ProcessingStatus> get processingStatusStream =>
      _processingResultSubject.stream.map((result) => result.status).distinct();

  @override
  Stream<HybridProcessingResult> get processingResultStream =>
      _processingResultSubject.stream;

  @override
  ProcessingMode get processingMode => _processingMode;

  ImageStreamServiceV2Impl(
    this._webSocketService,
    this._livenessService,
    this._faceDetectionService,
  ) {
    _livenessBatchProcessor = LivenessBatchProcessor(_livenessService);

    final initialThrottleDuration = _getThrottleForCurrentStage(
      ProcessingStatus.waitingForFace,
    );

    _throttleDurationSubject = BehaviorSubject<Duration>.seeded(
      initialThrottleDuration,
    );
  }

  void _initialize() {
    _initializeFrameProcessor();
  }

  Duration _getThrottleForCurrentStage(ProcessingStatus status) {
    switch (status) {
      case ProcessingStatus.waitingForFace:
        return ImageStreamConfig.waitingForFaceThrottleDuration;
      case ProcessingStatus.livenessChecking:
        return ImageStreamConfig.livenessCheckingThrottleDuration;
      case ProcessingStatus.readyForCheckIn:
        return ImageStreamConfig.readyForCheckInThrottleDuration;
      case ProcessingStatus.error:
        return ImageStreamConfig.waitingForFaceThrottleDuration;
    }
  }

  void _updateThrottleDuration() {
    final currentResult = _processingResultSubject.value;
    final newDuration = _getThrottleForCurrentStage(currentResult.status);

    if (_throttleDurationSubject.value != newDuration) {
      _throttleDurationSubject.add(newDuration);
    }
  }

  void _initializeFrameProcessor() {
    _frameProcessorSubscription?.cancel();

    final throttledFrameStream = _throttleDurationSubject.stream
        .distinct()
        .switchMap((duration) {
          return _frameSubject
              .where((_) => _isStreaming)
              .throttleTime(duration, trailing: true);
        });

    _frameProcessorSubscription = throttledFrameStream
        .map((image) {
          final controller = _activeController;
          if (controller == null) return null;
          return FramePipelineData(image, controller.description);
        })
        .where((data) => data != null)
        .cast<FramePipelineData>()
        .asyncMap((data) async {
          if (_processingMode == ProcessingMode.hybrid) {
            try {
              final cachedResult = _faceDetectionCache.getCachedResult();

              if (cachedResult != null) {
                data.faceResult = cachedResult;
              } else {
                final detectionResult = await _faceDetectionService.detectFace(
                  data.image,
                  data.camera,
                );
                data.faceResult = _faceDetectionCache.processDetectionResult(
                  detectionResult,
                );
              }
            } catch (e) {
              data.error = 'Face detection failed: $e';
              _faceDetectionCache.invalidate();
            }
          } else {
            data.faceResult = const LocalFaceDetectionResult.skip();
          }
          return data;
        })
        .asyncMap((data) async {
          if (data.error != null) return data;

          final isHybridMode = _processingMode == ProcessingMode.hybrid;
          final isFaceDetected = data.faceResult?.isSingleValidFace == true;
          final isServerSide = _processingMode == ProcessingMode.serverSide;

          final futures = <Future>[];

          if (isHybridMode && isFaceDetected) {
            futures.add(_processLivenessNonBlocking(data));
          } else if (isHybridMode) {
            _livenessBatchProcessor.handleFaceLost();
            data.livenessResult = LivenessResult.needMoreFrames;
          } else {
            data.livenessResult = LivenessResult.passed;
          }

          final shouldConvertImage =
              isServerSide || (isHybridMode && isFaceDetected);

          if (shouldConvertImage) {
            futures.add(_convertImageConcurrently(data));
          }

          if (futures.isNotEmpty) {
            await Future.wait(futures);
          }

          return data;
        })
        .map(_mapOptimizedPipelineDataToResult)
        .listen(
          (result) {
            if (result == null || !_isStreaming) return;

            final (processingResult, processedFrame) = result;
            _processingResultSubject.add(processingResult);

            _updateThrottleDuration();

            if (processedFrame != null) {
              _sendFrameToWebSocket(processedFrame);
            }
          },
          onError: (error) {
            _processingResultSubject.add(
              HybridProcessingResult(status: ProcessingStatus.error),
            );
          },
        );
  }

  Future<void> _processLivenessNonBlocking(FramePipelineData data) async {
    try {
      final cachedResult = _livenessBatchProcessor.getCachedResult(
        data.faceResult?.face,
      );

      if (cachedResult != null) {
        data.livenessResult = cachedResult;
        return;
      }

      _livenessBatchProcessor.addFace(data.faceResult!.face!);

      if (_livenessBatchProcessor.isBatchReady) {
        data.livenessResult = await _livenessBatchProcessor.processBatch();
      } else {
        data.livenessResult = LivenessResult.needMoreFrames;
      }
    } catch (e) {
      data.error = 'Liveness check failed: $e';
    }
  }

  Future<void> _convertImageConcurrently(FramePipelineData data) async {
    final image = data.image;
    final sensorOrientation = data.camera.sensorOrientation;
    final lensDirection = data.camera.lensDirection;

    data.processedFrame = await _convertImageInIsolate(
      image,
      sensorOrientation,
      lensDirection,
    );
  }

  Future<ProcessedFrame?> _convertImageInIsolate(
    CameraImage image,
    int sensorOrientation,
    CameraLensDirection lensDirection,
  ) {
    return Isolate.run(
      () => ImageConverter.convertCameraImageToProcessedFrameSync(
        image,
        sensorOrientation: sensorOrientation,
        lensDirection: lensDirection,
      ),
    );
  }

  @override
  Future<void> startStreaming(CameraController controller) async {
    if (_isStreaming) return;

    _streamingStatusSubject.add(StreamingStatus.initializing);
    _activeController = controller;

    try {
      _faceDetectionCache.reset();
      _livenessBatchProcessor.reset();

      _initialize();

      _streamingStatusSubject.add(StreamingStatus.active);
      _processingResultSubject.add(
        HybridProcessingResult(status: ProcessingStatus.waitingForFace),
      );

      await controller.startImageStream((CameraImage image) {
        if (_isStreaming) {
          _frameSubject.add(image);
        }
      });
    } catch (e) {
      _streamingStatusSubject.add(StreamingStatus.error);
      _processingResultSubject.add(
        HybridProcessingResult(status: ProcessingStatus.error),
      );
    }
  }

  @override
  Future<void> stopStreaming() async {
    if (!_isStreaming && _activeController == null) return;

    try {
      if (_activeController?.value.isStreamingImages ?? false) {
        await _activeController?.stopImageStream();
      }
    } catch (e) {
      // Ignore errors on stopping stream
    }

    _activeController = null;
    _streamingStatusSubject.add(StreamingStatus.idle);

    _faceDetectionCache.reset();
    _livenessBatchProcessor.reset();
  }

  void _sendFrameToWebSocket(ProcessedFrame frame) {
    if (_webSocketService.currentStatus !=
        WebSocketConnectionStatus.connected) {
      return;
    }

    final payload = {'type': 'processFrame', 'image': frame.base64Image};
    _webSocketService.sendMessage(json.encode(payload));
  }

  @override
  void dispose() {
    stopStreaming();
    _frameProcessorSubscription?.cancel();
    _frameSubject.close();
    _streamingStatusSubject.close();
    _processingResultSubject.close();
    _throttleDurationSubject.close();

    _faceDetectionCache.reset();
    _livenessBatchProcessor.reset();

    _faceDetectionService.dispose();
  }

  (HybridProcessingResult, ProcessedFrame?)? _mapOptimizedPipelineDataToResult(
    FramePipelineData data,
  ) {
    if (data.error != null) {
      return (HybridProcessingResult(status: ProcessingStatus.error), null);
    }

    if (_processingMode == ProcessingMode.serverSide) {
      return (
        HybridProcessingResult(status: ProcessingStatus.readyForCheckIn),
        data.processedFrame,
      );
    }

    final faceResult = data.faceResult;
    if (faceResult == null) {
      return (HybridProcessingResult(status: ProcessingStatus.error), null);
    }

    if (!faceResult.isSingleValidFace) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.waitingForFace,
          faceDetectionResult: faceResult,
        ),
        null,
      );
    }

    final livenessResult = data.livenessResult;

    if (livenessResult != null && livenessResult.isPassed) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.readyForCheckIn,
          faceDetectionResult: faceResult,
          livenessResult: livenessResult,
        ),
        data.processedFrame,
      );
    } else {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.livenessChecking,
          faceDetectionResult: faceResult,
          livenessResult: livenessResult,
        ),
        null,
      );
    }
  }
}
