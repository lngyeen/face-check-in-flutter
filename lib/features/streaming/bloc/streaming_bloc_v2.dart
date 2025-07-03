import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/image_stream_service_v2.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

import 'streaming_error.dart';

part 'streaming_event_v2.dart';
part 'streaming_state_v2.dart';
part 'streaming_bloc_v2.freezed.dart';

/// BLoC for managing complete image streaming and processing pipeline
/// Handles streaming, frame processing, and WebSocket communication
@LazySingleton()
class StreamingBlocV2 extends Bloc<StreamingEventV2, StreamingStateV2> {
  final ImageStreamServiceV2 _imageStreamService;

  StreamSubscription? _statusSubscription;

  StreamingBlocV2(this._imageStreamService) : super(const StreamingStateV2()) {
    _registerEventHandlers();
    _setupServiceListeners();
  }

  void _registerEventHandlers() {
    on<StreamingEventV2>((event, emit) {
      event.when(
        startStreaming: (controller) => _onStartStreaming(controller, emit),
        stopStreaming: () => _onStopStreaming(emit),
        setMaxFps: (fps) => _onSetMaxFps(fps, emit),
        statusChanged: (status) => _onStatusChanged(status, emit),
      );
    });
  }

  void _setupServiceListeners() {
    _statusSubscription?.cancel();
    _statusSubscription = _imageStreamService.statusStream.listen(
      (status) => add(StreamingEventV2.statusChanged(status)),
    );
  }

  void _onStartStreaming(
    CameraController controller,
    Emitter<StreamingStateV2> emit,
  ) {
    if (state.status == StreamingStatus.active) return;
    _imageStreamService.startStreaming(controller);
  }

  void _onStopStreaming(Emitter<StreamingStateV2> emit) {
    _imageStreamService.stopStreaming();
  }

  void _onSetMaxFps(int fps, Emitter<StreamingStateV2> emit) {
    _imageStreamService.setMaxFps(fps);
    emit(state.copyWith(maxFps: fps));
  }

  void _onStatusChanged(
    StreamingStatus status,
    Emitter<StreamingStateV2> emit,
  ) {
    StreamingError? error;

    if (status == StreamingStatus.error) {
      error = const StreamingError.processingFailed();
    }

    emit(state.copyWith(status: status, error: error));
  }

  @override
  Future<void> close() async {
    await _statusSubscription?.cancel();
    return super.close();
  }
}
