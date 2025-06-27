import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';

part 'check_in_event.freezed.dart';

@freezed
class CheckInEvent with _$CheckInEvent {
  const factory CheckInEvent.initialize() = Initialize;

  const factory CheckInEvent.startCamera() = StartCamera;

  const factory CheckInEvent.stopCamera() = StopCamera;

  const factory CheckInEvent.webSocketMessageReceived(dynamic data) =
      WebSocketMessageReceived;

  const factory CheckInEvent.toggleDebugMode() = ToggleDebugMode;

  const factory CheckInEvent.frameResultReceived({
    required FaceDetectionResponse response,
  }) = FrameResultReceived;

  const factory CheckInEvent.responseErrorReceived({
    required String error,
    String? message,
  }) = ResponseErrorReceived;

  const factory CheckInEvent.connectionStateChanged(
    ConnectionState connectionState,
  ) = ConnectionStateChanged;
}
