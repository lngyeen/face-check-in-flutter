part of 'check_in_bloc.dart';

@freezed
class CheckInEvent with _$CheckInEvent {
  // App lifecycle events
  /// The application has started and is ready for initialization.
  const factory CheckInEvent.appStarted() = AppStarted;

  /// The application is being disposed.
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

  // WebSocket connection events
  /// Request to connect to the WebSocket server.
  const factory CheckInEvent.webSocketConnectionRequested() =
      WebSocketConnectionRequested;

  /// The WebSocket connection status has changed.
  const factory CheckInEvent.webSocketStatusChanged(ConnectionStatus status) =
      WebSocketStatusChanged;

  /// Request to disconnect from the WebSocket server.
  const factory CheckInEvent.webSocketDisconnectionRequested() =
      WebSocketDisconnectionRequested;

  // WebSocket message events
  /// A message was received from the WebSocket server.
  const factory CheckInEvent.webSocketMessageReceived(String message) =
      WebSocketMessageReceived;

  // Streaming events
  /// Request to start frame streaming
  const factory CheckInEvent.streamingStarted() = StreamingStarted;

  /// Request to stop frame streaming
  const factory CheckInEvent.streamingStopped() = StreamingStopped;

  /// Request to pause frame streaming
  const factory CheckInEvent.streamingPaused() = StreamingPaused;

  /// Request to resume frame streaming
  const factory CheckInEvent.streamingResumed() = StreamingResumed;

  /// Streaming status has changed
  const factory CheckInEvent.streamingStatusChanged(StreamingStatus status) =
      StreamingStatusChanged;

  /// A streaming error has occurred
  const factory CheckInEvent.streamingFailed(String error) = StreamingFailed;

  /// A frame has been processed
  const factory CheckInEvent.frameProcessed() = FrameProcessed;

  /// A frame has been captured
  const factory CheckInEvent.frameCaptured(CameraImage image) = _FrameCaptured;

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
  const factory CheckInEvent.recognitionResultReceived(
    Map<String, dynamic> data,
  ) = RecognitionResultReceived;

  /// Frame result received from backend
  const factory CheckInEvent.frameResultReceived({
    required List<Map<String, dynamic>> faces,
  }) = FrameResultReceived;

  /// An error was received from the backend
  const factory CheckInEvent.responseErrorReceived({
    required String error,
    String? message,
  }) = ResponseErrorReceived;
}
