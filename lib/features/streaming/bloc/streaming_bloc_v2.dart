import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/face_detection_service_v2.dart';
import 'package:face_check_in_flutter/core/services/image_stream_service_v2.dart';
import 'package:face_check_in_flutter/core/services/liveness_service_v2.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

import 'streaming_error.dart';

part 'streaming_event_v2.dart';
part 'streaming_state_v2.dart';
part 'streaming_bloc_v2.freezed.dart';

/// BLoC for managing complete image streaming and processing pipeline
/// Handles streaming, frame processing, and WebSocket communication
@lazySingleton
class StreamingBlocV2 extends Bloc<StreamingEventV2, StreamingStateV2> {
  final ImageStreamServiceV2 _imageStreamService;

  StreamSubscription? _streamingStatusSubscription;
  StreamSubscription? _processingStatusSubscription;
  StreamSubscription? _processingResultSubscription;

  StreamingBlocV2(this._imageStreamService) : super(const StreamingStateV2()) {
    _registerEventHandlers();
    _setupServiceListeners();
  }

  void _registerEventHandlers() {
    // Streaming lifecycle events - processed sequentially to maintain state consistency
    on<BucketSequentialStreamingEventV2>((event, emit) {
      event.whenOrNull(
        startStreaming: (controller) => _onStartStreaming(controller, emit),
        stopStreaming: () => _onStopStreaming(emit),
      );
    }, transformer: sequential());

    // Status change events - processed sequentially to maintain consistency
    on<BucketSequentialStreamingStatusEventV2>((event, emit) {
      event.whenOrNull(
        streamingStatusChanged:
            (status) => _onStreamingStatusChanged(status, emit),
        processingStatusChanged:
            (status) => _onProcessingStatusChanged(status, emit),
      );
    }, transformer: sequential());

    // Processing results - use restartable to handle high-frequency updates
    on<SeparatedRestartableStreamingEventV2>((event, emit) {
      event.whenOrNull(
        processingResultReceived:
            (result) => _onProcessingResultReceived(result, emit),
      );
    }, transformer: restartable());
  }

  void _setupServiceListeners() {
    _streamingStatusSubscription?.cancel();
    _streamingStatusSubscription = _imageStreamService.streamingStatusStream
        .listen(
          (status) => add(
            BucketSequentialStreamingStatusEventV2.streamingStatusChanged(
              status,
            ),
          ),
        );

    _processingStatusSubscription?.cancel();
    _processingStatusSubscription = _imageStreamService.processingStatusStream
        .listen(
          (status) => add(
            BucketSequentialStreamingStatusEventV2.processingStatusChanged(
              status,
            ),
          ),
        );

    _processingResultSubscription?.cancel();
    _processingResultSubscription = _imageStreamService.processingResultStream
        .listen(
          (result) => add(
            SeparatedRestartableStreamingEventV2.processingResultReceived(
              result,
            ),
          ),
        );
  }

  void _onStartStreaming(
    CameraController controller,
    Emitter<StreamingStateV2> emit,
  ) {
    _imageStreamService.startStreaming(controller);
  }

  void _onStopStreaming(Emitter<StreamingStateV2> emit) {
    _imageStreamService.stopStreaming();
  }

  void _onStreamingStatusChanged(
    StreamingStatus status,
    Emitter<StreamingStateV2> emit,
  ) {
    StreamingError? error;

    if (status == StreamingStatus.error) {
      error = const StreamingError.streamingFailed();
    }

    emit(state.copyWith(streamingStatus: status, error: error));
  }

  void _onProcessingStatusChanged(
    ProcessingStatus status,
    Emitter<StreamingStateV2> emit,
  ) {
    StreamingError? error;

    if (status == ProcessingStatus.error) {
      error = const StreamingError.processingFailed();
    }

    emit(state.copyWith(processingStatus: status, error: error));
  }

  void _onProcessingResultReceived(
    HybridProcessingResult result,
    Emitter<StreamingStateV2> emit,
  ) {
    emit(
      state.copyWith(
        processingStatus: result.status,
        faceDetectionResult: result.faceDetectionResult,
        livenessResult: result.livenessResult,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _streamingStatusSubscription?.cancel();
    await _processingStatusSubscription?.cancel();
    await _processingResultSubscription?.cancel();
    return super.close();
  }
}
