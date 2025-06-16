import 'package:freezed_annotation/freezed_annotation.dart';

import 'check_in_state.dart';

part 'check_in_event.freezed.dart';

/// Events for the check-in feature
/// Defines all possible user interactions and system events
@freezed
class CheckInEvent with _$CheckInEvent {
  // App lifecycle events
  /// App has started and needs initialization
  const factory CheckInEvent.appStarted() = AppStarted;

  /// App is being disposed
  const factory CheckInEvent.appDisposed() = AppDisposed;

  // Camera events (placeholders for future integration)
  /// Request to initialize the camera
  const factory CheckInEvent.cameraInitRequested() = CameraInitRequested;

  /// Camera status has changed
  const factory CheckInEvent.cameraStatusChanged(CameraStatus status) =
      CameraStatusChanged;

  /// Request to start camera preview
  const factory CheckInEvent.cameraPreviewStarted() = CameraPreviewStarted;

  /// Request to stop camera preview
  const factory CheckInEvent.cameraPreviewStopped() = CameraPreviewStopped;

  // WebSocket events (placeholders for future integration)
  /// Request to connect to WebSocket backend
  const factory CheckInEvent.connectionRequested() = ConnectionRequested;

  /// WebSocket connection status has changed
  const factory CheckInEvent.connectionStatusChanged(ConnectionStatus status) =
      ConnectionStatusChanged;

  /// Request to disconnect from WebSocket
  const factory CheckInEvent.disconnectionRequested() = DisconnectionRequested;

  // Streaming events
  /// Request to start frame streaming
  const factory CheckInEvent.streamingStarted() = StreamingStarted;

  /// Request to stop frame streaming
  const factory CheckInEvent.streamingStopped() = StreamingStopped;

  /// Streaming status has changed
  const factory CheckInEvent.streamingStatusChanged(StreamingStatus status) =
      StreamingStatusChanged;

  /// A frame has been processed
  const factory CheckInEvent.frameProcessed() = FrameProcessed;

  // UI events
  /// An error has occurred
  const factory CheckInEvent.errorOccurred(String message) = ErrorOccurred;

  /// Error has been cleared
  const factory CheckInEvent.errorCleared() = ErrorCleared;

  /// Request to show a toast message
  const factory CheckInEvent.toastRequested(String message) = ToastRequested;

  /// Toast has been dismissed
  const factory CheckInEvent.toastDismissed() = ToastDismissed;

  // Debug events
  /// Toggle debug mode
  const factory CheckInEvent.debugModeToggled() = DebugModeToggled;

  /// Reset all statistics
  const factory CheckInEvent.statisticsReset() = StatisticsReset;

  // Backend response events (placeholders for future integration)
  /// Recognition result received from backend
  const factory CheckInEvent.recognitionResultReceived({
    required bool success,
    required String message,
    String? employeeName,
  }) = RecognitionResultReceived;
}
