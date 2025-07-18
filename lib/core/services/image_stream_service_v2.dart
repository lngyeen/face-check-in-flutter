import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/face_detection_cache.dart';
import 'package:face_check_in_flutter/core/services/frame_pipeline_data.dart';
import 'package:face_check_in_flutter/core/services/image_converter.dart';
import 'package:face_check_in_flutter/core/services/liveness_progress_view_model.dart';
import 'package:face_check_in_flutter/core/services/liveness_state_tracker.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/hybrid_processing_result.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_metrics.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';
import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';
import 'package:face_check_in_flutter/domain/entities/processed_frame.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

import 'face_detection_service_v2.dart';
import 'liveness_config.dart';
import 'liveness_validators.dart';

abstract class ImageStreamServiceV2 {
  Stream<StreamingStatus> get streamingStatusStream;
  Stream<ProcessingStatus> get processingStatusStream;
  Stream<HybridProcessingResult> get processingResultStream;
  Stream<LivenessProgressViewModel> get livenessProgressStream;
  ProcessingMode get processingMode;

  Future<void> startStreaming(CameraController controller);
  Future<void> stopStreaming();
  void dispose();
}

@LazySingleton(as: ImageStreamServiceV2)
class ImageStreamServiceV2Impl implements ImageStreamServiceV2 {
  final WebSocketService _webSocketService;
  final FaceDetectionServiceV2 _faceDetectionService;

  CameraController? _activeController;
  StreamSubscription? _frameProcessorSubscription;
  StreamSubscription? _metricsSubscription;

  final _frameSubject = PublishSubject<CameraImage>();
  final ProcessingMode _processingMode = ProcessingMode.hybrid;
  final _streamingStatusSubject = BehaviorSubject<StreamingStatus>.seeded(
    StreamingStatus.idle,
  );
  final _processingResultSubject =
      BehaviorSubject<HybridProcessingResult>.seeded(
        HybridProcessingResult(status: ProcessingStatus.waitingForFace),
      );
  final _livenessProgressSubject =
      BehaviorSubject<LivenessProgressViewModel>.seeded(
        LivenessProgressViewModel(const LivenessMetrics()),
      );
  late final BehaviorSubject<Duration> _throttleDurationSubject;
  final _faceDetectionCache = FaceDetectionCache();
  late final LivenessStateTracker _livenessStateTracker;
  bool _hasPassedLiveness = false; // ← Track if liveness has been passed

  // ← NEW: Track consecutive no-face frames to avoid aggressive reset
  int _consecutiveNoFaceFrames = 0;
  static const int _maxNoFaceFramesBeforeReset = 1;

  bool get _isStreaming =>
      _streamingStatusSubject.valueOrNull == StreamingStatus.active ||
      _streamingStatusSubject.valueOrNull == StreamingStatus.initializing;
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
  Stream<LivenessProgressViewModel> get livenessProgressStream =>
      _livenessProgressSubject.stream;
  @override
  ProcessingMode get processingMode => _processingMode;

  ImageStreamServiceV2Impl(this._webSocketService, this._faceDetectionService) {
    // Khởi tạo danh sách các validator sẽ được sử dụng
    final allValidators = [
      BlinkValidator(),
      QualityValidator(),
      StabilityValidator(),
      TemporalValidator(),
    ];

    // Tiêm danh sách validator vào StateTracker.
    _livenessStateTracker = LivenessStateTracker(allValidators);

    _metricsSubscription = _livenessStateTracker.metricsStream
        .map((metrics) => LivenessProgressViewModel(metrics))
        .distinct()
        .listen((viewModel) {
          if (!_livenessProgressSubject.isClosed) {
            _livenessProgressSubject.add(viewModel);
          }
        });

    _throttleDurationSubject = BehaviorSubject<Duration>.seeded(
      _getThrottleForCurrentStage(ProcessingStatus.waitingForFace),
    );
  }

  void _initialize() {
    _initializeFrameProcessor();
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
        .map(_createPipelineData)
        .where((data) => data != null)
        .cast<FramePipelineData>()
        .asyncMap(_performFaceDetection)
        .asyncMap(_performLivenessAndConversion)
        .map(_mapPipelineToOutput)
        .listen(
          _handleProcessingOutput,
          onError: (error, stackTrace) {
            if (!_processingResultSubject.isClosed) {
              _processingResultSubject.add(
                HybridProcessingResult(status: ProcessingStatus.error),
              );
            }
          },
        );
  }

  FramePipelineData? _createPipelineData(CameraImage image) {
    final controller = _activeController;
    if (controller == null) return null;
    return FramePipelineData(image, controller.description);
  }

  Future<FramePipelineData> _performFaceDetection(
    FramePipelineData data,
  ) async {
    if (_processingMode != ProcessingMode.hybrid) {
      data.faceResult = const LocalFaceDetectionResult.skip();
      return data;
    }

    try {
      // BƯỚC 1: Luôn chạy detection để có dữ liệu mới nhất
      final detectionResult = await _faceDetectionService.detectFace(
        data.image,
        data.camera,
      );

      // BƯỚC 2: Đưa kết quả mới vào cache để nó cập nhật trạng thái ổn định
      _faceDetectionCache.process(detectionResult);

      // BƯỚC 3: Luôn sử dụng kết quả mới nhất cho các bước tiếp theo
      data.faceResult = detectionResult;
    } catch (e) {
      data.error = 'Face detection failed: $e';
      _faceDetectionCache.invalidate();
    }
    return data;
  }

  Future<FramePipelineData> _performLivenessAndConversion(
    FramePipelineData data,
  ) async {
    if (data.error != null) return data;

    // ← REMOVED: Early return for completion - let normal flow handle it

    if (_processingMode != ProcessingMode.hybrid) {
      data.livenessResult = const LivenessResult.passed();
      return data;
    }

    final faceResult = data.faceResult;

    // BƯỚC 4: Dùng cờ isFaceStable từ cache làm "người gác cổng"
    if (faceResult != null &&
        faceResult.isSingleValidFace &&
        _faceDetectionCache.isFaceStable) {
      final faceFrame = LivenessFrame(
        face: faceResult.face!,
        image: data.image,
      );
      _livenessStateTracker.addFace(faceFrame);

      if (_livenessStateTracker.isReadyForProcessing) {
        data.livenessResult =
            await _livenessStateTracker.processCurrentChallenge();
      } else {
        data.livenessResult = const LivenessResult.needMoreFrames();
      }
    } else {
      // Nếu không có mặt hoặc mặt chưa ổn định, reset tracker
      _livenessStateTracker.handleFaceLost();
      data.livenessResult = const LivenessResult.needMoreFrames();
    }

    if (data.livenessResult is Passed) {
      // ← FIXED: Convert frame and mark as passed
      await _convertImageConcurrently(data);

      // ← NEW: Mark as passed and cache as completed
      _hasPassedLiveness = true;
      _faceDetectionCache.markCompleted();
      // ← NOTE: Reset will happen when user leaves camera
    }
    return data;
  }

  (HybridProcessingResult, ProcessedFrame?)? _mapPipelineToOutput(
    FramePipelineData data,
  ) {
    if (data.error != null) {
      return (HybridProcessingResult(status: ProcessingStatus.error), null);
    }

    // ← FIXED: Check no-face for all cases, not just when passed
    if (data.faceResult?.isSingleValidFace != true) {
      _consecutiveNoFaceFrames++;
      if (_consecutiveNoFaceFrames >= _maxNoFaceFramesBeforeReset) {
        _resetCompletionIfNoFace();
        return (
          HybridProcessingResult(
            status: ProcessingStatus.waitingForFace,
            faceDetectionResult: data.faceResult,
          ),
          null, // ← Don't send frame during reset
        );
      }
    } else {
      _consecutiveNoFaceFrames = 0; // Reset counter when face is detected
    }

    final livenessResult = data.livenessResult;
    if (livenessResult == null) return null;

    // ← FIXED: Handle pass case and continue sending frames when readyForCheckIn
    if (livenessResult is Passed ||
        (_hasPassedLiveness && data.faceResult?.isSingleValidFace == true)) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.readyForCheckIn,
          faceDetectionResult: data.faceResult,
          livenessResult:
              livenessResult is Passed
                  ? livenessResult
                  : const LivenessResult.completed(),
        ),
        data.processedFrame, // ← FIXED: Always send frame when readyForCheckIn
      );
    }

    // ← REMOVED: Completed condition - no longer needed since we reset completely

    final status = livenessResult.when(
      passed:
          (_) =>
              ProcessingStatus.readyForCheckIn, // ← This case is handled above
      failed: (_) => ProcessingStatus.livenessChecking,
      error: (_) => ProcessingStatus.error,
      processing: () => ProcessingStatus.livenessChecking,
      needMoreFrames: () => ProcessingStatus.livenessChecking,
      completed:
          () => ProcessingStatus.completed, // ← NEW: Handle completed state
    );

    if (data.faceResult?.isSingleValidFace != true) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.waitingForFace,
          faceDetectionResult: data.faceResult,
        ),
        null,
      );
    }

    return (
      HybridProcessingResult(
        status: status,
        faceDetectionResult: data.faceResult,
        livenessResult: livenessResult,
      ),
      null, // ← Passed case is handled above, so no frame here
    );
  }

  void _handleProcessingOutput(
    (HybridProcessingResult, ProcessedFrame?)? output,
  ) {
    if (output == null || !_isStreaming || _processingResultSubject.isClosed) {
      return;
    }

    final (processingResult, processedFrame) = output;

    // ← REMOVED: Special completed handling - let normal flow handle it

    _processingResultSubject.add(processingResult);
    _updateThrottleDuration();

    if (processedFrame != null) {
      _sendFrameToWebSocket(processedFrame);
    }
  }

  Future<void> _convertImageConcurrently(FramePipelineData data) async {
    data.processedFrame = await Isolate.run(
      () => ImageConverter.convertCameraImageToProcessedFrameSync(
        data.image,
        sensorOrientation: data.camera.sensorOrientation,
        lensDirection: data.camera.lensDirection,
      ),
    );
  }

  @override
  Future<void> startStreaming(CameraController controller) async {
    if (_isStreaming) return;
    _streamingStatusSubject.add(StreamingStatus.initializing);
    _activeController = controller;
    _faceDetectionCache.reset();
    _livenessStateTracker.reset();
    _hasPassedLiveness = false; // ← Reset passed flag
    _consecutiveNoFaceFrames = 0; // ← Reset counter
    _initialize();
    if (!_processingResultSubject.isClosed) {
      _processingResultSubject.add(
        HybridProcessingResult(status: ProcessingStatus.waitingForFace),
      );
    }

    try {
      await controller.startImageStream((CameraImage image) {
        if (_isStreaming && !_frameSubject.isClosed) _frameSubject.add(image);
      });
      _streamingStatusSubject.add(StreamingStatus.active);
    } catch (e) {
      _streamingStatusSubject.add(StreamingStatus.error);
      if (!_processingResultSubject.isClosed) {
        _processingResultSubject.add(
          HybridProcessingResult(status: ProcessingStatus.error),
        );
      }
    }
  }

  @override
  Future<void> stopStreaming() async {
    if (!_isStreaming && _activeController == null) return;
    _streamingStatusSubject.add(StreamingStatus.idle);
    if (_activeController?.value.isStreamingImages ?? false) {
      try {
        await _activeController?.stopImageStream();
      } catch (e) {
        /* Ignore */
      }
    }
    _activeController = null;
    // ← NEW: Coordinate state reset across all components
    _hasPassedLiveness = false; // ← Reset passed flag
    _faceDetectionCache.reset();
    _livenessStateTracker.reset();
    _consecutiveNoFaceFrames = 0; // ← Reset counter
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
    _metricsSubscription?.cancel();
    _frameSubject.close();
    _streamingStatusSubject.close();
    _processingResultSubject.close();
    _throttleDurationSubject.close();
    _livenessProgressSubject.close();
    _livenessStateTracker.dispose();
    _faceDetectionService.dispose();
  }

  Duration _getThrottleForCurrentStage(ProcessingStatus status) {
    return switch (status) {
      ProcessingStatus.waitingForFace => fpsToDuration(
        ImageStreamConfig.waitingForFaceFps,
      ),
      ProcessingStatus.livenessChecking => fpsToDuration(
        ImageStreamConfig.livenessCheckingFps,
      ),
      ProcessingStatus.readyForCheckIn => fpsToDuration(
        ImageStreamConfig.readyForCheckInFps,
      ),
      ProcessingStatus.completed => fpsToDuration(0), // ← NEW: Stop processing
      ProcessingStatus.error => fpsToDuration(
        ImageStreamConfig.waitingForFaceFps,
      ),
    };
  }

  static Duration fpsToDuration(int fps) {
    if (fps <= 0) return const Duration(milliseconds: 1000);
    return Duration(milliseconds: (1000 / fps).round());
  }

  void _clearFrameQueue() {
    // ← NEW: Clear frame queue to prevent processing old frames
    _frameSubject.drain();
  }

  void _resetCompletionIfNoFace() {
    // ← FIXED: Reset all states completely when user leaves camera
    _hasPassedLiveness = false; // ← Reset passed flag
    _faceDetectionCache.reset();
    _livenessStateTracker.reset();
    _consecutiveNoFaceFrames = 0; // ← Reset counter

    // ← NEW: Clear frame queue and update throttle immediately
    _clearFrameQueue();

    // ← NEW: Force update throttle to waiting for face
    if (!_processingResultSubject.isClosed) {
      _processingResultSubject.add(
        HybridProcessingResult(status: ProcessingStatus.waitingForFace),
      );
    }
  }

  void _updateThrottleDuration() {
    if (_processingResultSubject.isClosed) return;
    final newDuration = _getThrottleForCurrentStage(
      _processingResultSubject.value.status,
    );
    if (_throttleDurationSubject.value != newDuration) {
      _throttleDurationSubject.add(newDuration);
    }
  }
}
