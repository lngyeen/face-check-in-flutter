import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/face_detection_cache.dart';
import 'package:face_check_in_flutter/core/services/face_detection_service_v2.dart';
import 'package:face_check_in_flutter/core/services/frame_pipeline_data.dart';
import 'package:face_check_in_flutter/core/services/liveness_progress_view_model.dart';
import 'package:face_check_in_flutter/core/services/liveness_state_tracker.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/hybrid_processing_result.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_metrics.dart';
import 'package:face_check_in_flutter/domain/entities/processed_frame.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

import 'config/image_stream_configuration.dart';
import 'managers/throttle_manager.dart';
import 'mappers/processing_result_mapper.dart';
import 'processors/frame_pipeline_processor.dart';

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
  final FramePipelineProcessor _pipelineProcessor;
  final ProcessingResultMapper _resultMapper;
  final ThrottleManager _throttleManager;

  CameraController? _activeController;
  StreamSubscription? _frameProcessorSubscription;
  StreamSubscription? _metricsSubscription;

  final _frameSubject = PublishSubject<CameraImage>();
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

  final _faceDetectionCache = FaceDetectionCache();
  late final LivenessStateTracker _livenessStateTracker;

  bool _hasPassedLiveness = false;
  int _consecutiveNoFaceFrames = 0;

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
  ProcessingMode get processingMode =>
      ImageStreamConfiguration.defaultProcessingMode;

  ImageStreamServiceV2Impl(this._webSocketService, this._faceDetectionService)
    : _pipelineProcessor = FramePipelineProcessor(
        faceDetectionService: _faceDetectionService,
        faceDetectionCache: FaceDetectionCache(),
        livenessStateTracker: LivenessStateTracker(
          ImageStreamConfiguration.getDefaultValidators(),
        ),
        processingMode: ImageStreamConfiguration.defaultProcessingMode,
      ),
      _resultMapper = ProcessingResultMapper(),
      _throttleManager = ThrottleManager() {
    _livenessStateTracker = LivenessStateTracker(
      ImageStreamConfiguration.getDefaultValidators(),
    );

    _metricsSubscription = _livenessStateTracker.metricsStream
        .map((metrics) => LivenessProgressViewModel(metrics))
        .distinct()
        .listen((viewModel) {
          if (!_livenessProgressSubject.isClosed) {
            _livenessProgressSubject.add(viewModel);
          }
        });

    _initializeFrameProcessor();
  }

  void _initializeFrameProcessor() {
    _frameProcessorSubscription?.cancel();
    final throttledFrameStream = _throttleManager.throttleStream
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
        .asyncMap(_pipelineProcessor.processFrame)
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

  (HybridProcessingResult, ProcessedFrame?)? _mapPipelineToOutput(
    FramePipelineData data,
  ) {
    return _resultMapper.mapToOutput(
      data,
      _hasPassedLiveness,
      _consecutiveNoFaceFrames,
      ImageStreamConfiguration.maxNoFaceFramesBeforeReset,
    );
  }

  void _handleProcessingOutput(
    (HybridProcessingResult, ProcessedFrame?)? output,
  ) {
    if (output == null || !_isStreaming || _processingResultSubject.isClosed) {
      return;
    }

    final (processingResult, processedFrame) = output;

    _processingResultSubject.add(processingResult);
    _throttleManager.updateThrottle(processingResult.status);

    if (processedFrame != null) {
      _sendFrameToWebSocket(processedFrame);
    }
  }

  void _sendFrameToWebSocket(ProcessedFrame frame) {
    if (_webSocketService.currentStatus !=
        WebSocketConnectionStatus.connected) {
      return;
    }
    final payload = {'type': 'processFrame', 'image': frame.base64Image};
    _webSocketService.sendMessage(json.encode(payload));
  }

  void _resetAllStates() {
    _hasPassedLiveness = false;
    _faceDetectionCache.reset();
    _livenessStateTracker.reset();
    _consecutiveNoFaceFrames = 0;
  }

  @override
  Future<void> startStreaming(CameraController controller) async {
    if (_isStreaming) return;

    _streamingStatusSubject.add(StreamingStatus.initializing);
    _activeController = controller;
    _resetAllStates();
    _initializeFrameProcessor();

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
    _resetAllStates();
  }

  @override
  void dispose() {
    stopStreaming();
    _frameProcessorSubscription?.cancel();
    _metricsSubscription?.cancel();
    _frameSubject.close();
    _streamingStatusSubject.close();
    _processingResultSubject.close();
    _livenessProgressSubject.close();
    _livenessStateTracker.dispose();
    _faceDetectionService.dispose();
    _throttleManager.dispose();
  }
}
