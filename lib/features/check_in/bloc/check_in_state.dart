import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_state.freezed.dart';

/// Represents the current status of the camera
enum CameraStatus {
  /// Camera is not initialized
  initial,

  /// Camera is ready and working
  ready,

  /// Camera has encountered an error
  error,
}

/// Represents the current WebSocket connection status
enum ConnectionStatus {
  /// Not connected to backend
  disconnected,

  /// Attempting to connect
  connecting,

  /// Successfully connected
  connected,

  /// Connection failed
  failed,
}

/// Represents the current streaming status
enum StreamingStatus {
  /// Not streaming frames
  idle,

  /// Actively streaming frames
  active,

  /// Streaming is paused
  paused,

  /// Streaming encountered an error
  error,
}

/// Represents the current toast notification status
enum ToastStatus {
  /// No toast to show
  none,

  /// Toast is currently showing
  showing,
}

/// Main state for the check-in feature
/// Contains all state information needed for camera, WebSocket, and UI management
@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState({
    /// Current camera status
    @Default(CameraStatus.initial) CameraStatus cameraStatus,

    /// Current WebSocket connection status
    @Default(ConnectionStatus.disconnected) ConnectionStatus connectionStatus,

    /// Current frame streaming status
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,

    /// Whether the app is in a loading state
    @Default(false) bool isLoading,

    /// Current error message, if any
    String? errorMessage,

    /// Current toast notification status
    @Default(ToastStatus.none) ToastStatus toastStatus,

    /// Message to display in toast notification
    String? toastMessage,

    /// Whether debug mode is enabled
    @Default(false) bool isDebugMode,

    /// Last recognition result timestamp
    DateTime? lastRecognitionTime,

    /// Number of frames processed
    @Default(0) int framesProcessed,
  }) = _CheckInState;
}
