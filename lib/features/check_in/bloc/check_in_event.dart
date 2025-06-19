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
  const factory CheckInEvent.connectionRequested() = ConnectionRequested;

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

  /// Frame streaming successfully started
  const factory CheckInEvent.streamingStarted() = StreamingStarted;

  /// Request to stop frame streaming
  const factory CheckInEvent.streamingStopRequested() = StreamingStopRequested;

  /// Frame streaming successfully stopped
  const factory CheckInEvent.streamingStopped() = StreamingStopped;

  /// Request to pause frame streaming
  const factory CheckInEvent.streamingPauseRequested() =
      StreamingPauseRequested;

  /// Frame streaming paused
  const factory CheckInEvent.streamingPaused() = StreamingPaused;

  /// Request to resume frame streaming
  const factory CheckInEvent.streamingResumeRequested() =
      StreamingResumeRequested;

  /// Frame streaming resumed
  const factory CheckInEvent.streamingResumed() = StreamingResumed;

  /// Streaming status has changed
  const factory CheckInEvent.streamingStatusChanged(StreamingStatus status) =
      StreamingStatusChanged;

  /// Frame streaming error occurred
  const factory CheckInEvent.streamingError(String error) = StreamingError;

  // Frame processing events
  /// A frame has been captured
  const factory CheckInEvent.frameCaptured(String frameId) = FrameCaptured;

  /// A frame has been processed and encoded
  const factory CheckInEvent.frameProcessed(String frameId) = FrameProcessed;

  /// A frame has been sent to backend
  const factory CheckInEvent.frameSent(
    String frameId,
    int size,
    double latency,
  ) = FrameSent;

  /// Frame send failed
  const factory CheckInEvent.frameSendFailed(String frameId, String error) =
      FrameSendFailed;

  /// Streaming metrics updated
  const factory CheckInEvent.streamingMetricsUpdated({
    required double frameRate,
    required int framesCaptured,
    required int framesStreamed,
    required int framesFailed,
    required double averageLatency,
    required int totalBytes,
  }) = StreamingMetricsUpdated;

  // Face detection events
  /// Face detection result received from backend
  const factory CheckInEvent.faceDetectionResult({
    required List<FaceDetectionResult> faces,
    required double confidence,
    required DateTime timestamp,
  }) = FaceDetectionResultReceived;

  /// Face detection status changed
  const factory CheckInEvent.faceDetectionStatusChanged(
    FaceDetectionStatus status,
  ) = FaceDetectionStatusChanged;

  /// Face detection error occurred
  const factory CheckInEvent.faceDetectionError(String error) =
      FaceDetectionError;

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
}
