import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/connection/connection.dart';

part 'check_in_event.freezed.dart';

@freezed
class CheckInEvent with _$CheckInEvent {
  const factory CheckInEvent.initialize() = Initialize;

  const factory CheckInEvent.openAppSettings() = OpenAppSettings;

  const factory CheckInEvent.startCamera() = StartCamera;

  const factory CheckInEvent.stopCamera() = StopCamera;

  const factory CheckInEvent.webSocketMessageReceived(dynamic data) =
      WebSocketMessageReceived;

  const factory CheckInEvent.toggleDebugMode() = ToggleDebugMode;

  const factory CheckInEvent.frameResultReceived({
    List<Map<String, dynamic>>? faces,
    FaceDetectionResponse? response,
  }) = FrameResultReceived;

  const factory CheckInEvent.responseErrorReceived({
    required String error,
    String? message,
  }) = ResponseErrorReceived;

  const factory CheckInEvent.connectionStateChanged(
    ConnectionState connectionState,
  ) = ConnectionStateChanged;
}
