import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/connection/connection.dart';

part 'check_in_event.freezed.dart';

@freezed
class CheckInEvent with _$CheckInEvent {
  // Camera permission events
  /// Request camera permission
  const factory CheckInEvent.requestCameraPermission() =
      RequestCameraPermission;

  /// Camera permission has been granted
  const factory CheckInEvent.cameraPermissionGranted() =
      CameraPermissionGranted;

  /// Camera permission has been denied
  const factory CheckInEvent.cameraPermissionDenied() = CameraPermissionDenied;

  /// Open app settings for permissions
  const factory CheckInEvent.openAppSettings() = OpenAppSettings;

  // Camera lifecycle events
  /// Request to initialize the camera
  const factory CheckInEvent.initializeCamera() = InitializeCamera;

  /// Request to stop the camera
  const factory CheckInEvent.stopCamera() = StopCamera;

  // WebSocket message events
  /// A message was received from the WebSocket server.
  const factory CheckInEvent.webSocketMessageReceived(dynamic data) =
      WebSocketMessageReceived;

  // Debug events
  const factory CheckInEvent.toggleDebugMode() = ToggleDebugMode;

  // Backend response events
  const factory CheckInEvent.frameResultReceived({
    List<Map<String, dynamic>>? faces,
    FaceDetectionResponse? response,
  }) = FrameResultReceived;

  const factory CheckInEvent.responseErrorReceived({
    required String error,
    String? message,
  }) = ResponseErrorReceived;

  /// Connection state changed (from ConnectionBloc)
  const factory CheckInEvent.connectionStateChanged(
    ConnectionState connectionState,
  ) = ConnectionStateChanged;

  // Internal events
  const factory CheckInEvent.frameCaptured(CameraImage image) = FrameCaptured;
}
