part of 'check_in_bloc.dart';

/// Events for the check-in feature
/// Defines all possible user interactions and system events
@freezed
class CheckInEvent with _$CheckInEvent {
  // App lifecycle events
  /// App has started and needs initialization
  const factory CheckInEvent.appStarted() = AppStarted;

  /// App is being disposed
  const factory CheckInEvent.appDisposed() = AppDisposed;

  // Camera permission events
  /// Request camera permission
  const factory CheckInEvent.cameraPermissionRequested() =
      CameraPermissionRequested;

  /// Camera permission has been granted
  const factory CheckInEvent.cameraPermissionGranted() =
      CameraPermissionGranted;

  /// Camera permission has been denied
  const factory CheckInEvent.cameraPermissionDenied() = CameraPermissionDenied;

  // Camera lifecycle events
  /// Request to initialize the camera
  const factory CheckInEvent.cameraInitRequested() = CameraInitRequested;

  /// Request to start the camera
  const factory CheckInEvent.cameraStarted() = CameraStarted;

  /// Request to pause the camera
  const factory CheckInEvent.cameraPaused() = CameraPaused;

  /// Request to resume the camera
  const factory CheckInEvent.cameraResumed() = CameraResumed;

  /// Request to stop the camera
  const factory CheckInEvent.cameraStopped() = CameraStopped;

  // Camera events
  /// Camera status has changed
  const factory CheckInEvent.cameraStatusChanged(CameraStatus status) =
      CameraStatusChanged;

  /// Request to start camera preview
  const factory CheckInEvent.cameraPreviewStarted() = CameraPreviewStarted;

  /// Request to stop camera preview
  const factory CheckInEvent.cameraPreviewStopped() = CameraPreviewStopped;

  // Legacy WebSocket events (keeping for compatibility)
  /// Request to connect to WebSocket backend
  const factory CheckInEvent.connectionRequested({
    @Default(false) bool isAutoConnect,
  }) = ConnectionRequested;

  /// WebSocket connection status has changed
  const factory CheckInEvent.connectionStatusChanged(ConnectionStatus status) =
      ConnectionStatusChanged;

  /// Request to disconnect from WebSocket
  const factory CheckInEvent.disconnectionRequested() = DisconnectionRequested;

  // Enhanced WebSocket connection events for Story 2.1
  /// WebSocket connection process started
  const factory CheckInEvent.webSocketConnectionRequested() =
      WebSocketConnectionRequested;

  /// WebSocket is in connecting state
  const factory CheckInEvent.webSocketConnecting() = WebSocketConnecting;

  /// WebSocket successfully connected
  const factory CheckInEvent.webSocketConnected() = WebSocketConnected;

  /// WebSocket disconnected
  const factory CheckInEvent.webSocketDisconnected() = WebSocketDisconnected;

  /// WebSocket connection failed with error
  const factory CheckInEvent.webSocketConnectionFailed(String error) =
      WebSocketConnectionFailed;

  /// WebSocket connection timeout occurred
  const factory CheckInEvent.webSocketConnectionTimeout() =
      WebSocketConnectionTimeout;

  /// WebSocket is retrying connection
  const factory CheckInEvent.webSocketRetrying(int attempt) = WebSocketRetrying;

  // Enhanced WebSocket message events for Story 2.1
  /// WebSocket message received from backend
  const factory CheckInEvent.webSocketMessageReceived(
    Map<String, dynamic> message,
  ) = WebSocketMessageReceived;

  /// WebSocket message sent to backend
  const factory CheckInEvent.webSocketMessageSent(
    Map<String, dynamic> message,
  ) = WebSocketMessageSent;

  /// WebSocket message send failed
  const factory CheckInEvent.webSocketSendError(String error) =
      WebSocketSendError;

  // Auto-connection events for Story 2.1
  /// Auto-connection should be triggered (camera ready)
  const factory CheckInEvent.autoConnectionTriggered() =
      AutoConnectionTriggered;

  /// Auto-connection enabled/disabled
  const factory CheckInEvent.autoConnectionToggled(bool enabled) =
      AutoConnectionToggled;

  // Streaming events
  /// Request to start frame streaming
  const factory CheckInEvent.streamingStartRequested() =
      StreamingStartRequested;

  /// Request to stop frame streaming
  const factory CheckInEvent.streamingStopRequested() = StreamingStopRequested;

  /// Frame streaming started successfully
  const factory CheckInEvent.streamingStarted() = StreamingStarted;

  /// Frame streaming stopped successfully
  const factory CheckInEvent.streamingStopped() = StreamingStopped;

  /// Streaming status has changed
  const factory CheckInEvent.streamingStatusChanged(StreamingStatus status) =
      StreamingStatusChanged;

  /// A frame has been processed
  const factory CheckInEvent.frameProcessed() = FrameProcessed;

  // UI events
  /// An error has occurred
  const factory CheckInEvent.errorOccurred(String message) = ErrorOccurred;

  /// A camera-specific error has occurred
  const factory CheckInEvent.cameraError(String error) = CameraError;

  /// Error has been cleared
  const factory CheckInEvent.errorCleared() = ErrorCleared;

  /// Request to show a toast message
  const factory CheckInEvent.toastRequested(String message) = ToastRequested;

  // Debug events
  /// Toggle debug mode
  const factory CheckInEvent.debugModeToggled() = DebugModeToggled;

  /// Reset all statistics
  const factory CheckInEvent.statisticsReset() = StatisticsReset;

  // Backend response events
  /// Recognition result received from backend
  const factory CheckInEvent.recognitionResultReceived({
    required bool success,
    required String message,
    String? employeeName,
  }) = RecognitionResultReceived;

  /// Backend response received with face detection data
  const factory CheckInEvent.backendResponseReceived(
    FaceDetectionResult result,
  ) = BackendResponseReceived;

  const factory CheckInEvent.disconnectRequested() = DisconnectRequested;
  const factory CheckInEvent.webSocketError(String error) = WebSocketError;
}
