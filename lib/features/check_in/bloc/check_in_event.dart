import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';

part 'check_in_event.freezed.dart';

abstract class CheckInEvent {}

@freezed
class SeparatedSequentialCheckInEvent extends CheckInEvent
    with _$SeparatedSequentialCheckInEvent {
  const factory SeparatedSequentialCheckInEvent.initialize() = Initialize;
  const factory SeparatedSequentialCheckInEvent.webSocketMessageReceived({
    required dynamic data,
  }) = WebSocketMessageReceived;
}

@freezed
class BucketRestartableCheckInEvent extends CheckInEvent
    with _$BucketRestartableCheckInEvent {
  const factory BucketRestartableCheckInEvent.startCamera() = StartCamera;
  const factory BucketRestartableCheckInEvent.stopCamera() = StopCamera;
  const factory BucketRestartableCheckInEvent.startImageStream() =
      StartImageStream;
  const factory BucketRestartableCheckInEvent.stopImageStream() =
      StopImageStream;
}

@freezed
class SeparatedRestartableCheckInEvent extends CheckInEvent
    with _$SeparatedRestartableCheckInEvent {
  const factory SeparatedRestartableCheckInEvent.connectionStateChanged({
    required ConnectionState connectionState,
  }) = ConnectionStateChanged;
  const factory SeparatedRestartableCheckInEvent.cameraStatusChanged({
    required CameraStatus status,
  }) = CameraStatusChanged;
  const factory SeparatedRestartableCheckInEvent.cameraControllerChanged({
    CameraController? controller,
  }) = CameraControllerChanged;
  const factory SeparatedRestartableCheckInEvent.streamingStatusChanged({
    required StreamingStatus status,
  }) = StreamingStatusChanged;
}

@freezed
class DroppableCheckInEvent extends CheckInEvent with _$DroppableCheckInEvent {
  const factory DroppableCheckInEvent.toggleDebugMode() = ToggleDebugMode;
}
