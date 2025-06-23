part of 'check_in_bloc.dart';

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

  // WebSocket connection events
  /// Request to connect to the WebSocket server.
  const factory CheckInEvent.connectWebSocket() = ConnectWebSocket;

  /// The WebSocket connection status has changed.
  const factory CheckInEvent.webSocketStatusChanged(ConnectionStatus status) =
      WebSocketStatusChanged;

  /// Request to disconnect from the WebSocket server.
  const factory CheckInEvent.disconnectWebSocket() = DisconnectWebSocket;

  // WebSocket message events
  /// A message was received from the WebSocket server.
  const factory CheckInEvent.webSocketMessageReceived(dynamic data) =
      WebSocketMessageReceived;

  // Streaming events
  /// Request to start frame streaming
  const factory CheckInEvent.startStreaming() = StartStreaming;

  /// Request to stop frame streaming
  const factory CheckInEvent.stopStreaming() = StopStreaming;

  /// A streaming error has occurred
  const factory CheckInEvent.streamingFailed(String error) = StreamingFailed;

  // Debug events
  const factory CheckInEvent.toggleDebugMode() = ToggleDebugMode;

  // Stream configuration events
  const factory CheckInEvent.configureStream({required int maxFps}) =
      ConfigureStream;

  // Backend response events
  const factory CheckInEvent.frameResultReceived({
    List<Map<String, dynamic>>? faces,
    FaceDetectionResponse? response,
  }) = FrameResultReceived;

  const factory CheckInEvent.responseErrorReceived({
    required String error,
    String? message,
  }) = ResponseErrorReceived;

  // Connection management events
  /// Connection summary received from ConnectionManager
  const factory CheckInEvent.connectionSummaryReceived({
    required conn.ConnectionSummary summary,
  }) = ConnectionSummaryReceived;

  /// Manual retry requested by user
  const factory CheckInEvent.requestManualRetry() = RequestManualRetry;

  // Internal events
  const factory CheckInEvent.frameCaptured(CameraImage image) = _FrameCaptured;
}
