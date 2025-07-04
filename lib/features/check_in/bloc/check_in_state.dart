part of 'check_in_bloc.dart';

/// Represents the current status of the camera
enum CameraStatus {
  /// Camera is not initialized
  initial,

  /// Requesting camera permissions
  permissionRequesting,

  /// Camera permissions were denied
  permissionDenied,

  /// Camera is initializing
  initializing,

  /// Camera is ready and working
  ready,

  /// Camera is actively streaming
  streaming,

  /// Camera is paused
  paused,

  /// Camera has encountered an error
  error,
}

/// Represents the current permission status
enum PermissionStatus {
  /// Initial permission state
  initial,

  /// Permission granted by user
  granted,

  /// Permission denied by user
  denied,

  /// Permission permanently denied by user
  permanentlyDenied,
}

/// Represents the current WebSocket connection status
/// Enhanced for Story 2.1 requirements
enum ConnectionStatus {
  /// Not connected to backend
  disconnected,

  /// Attempting to connect
  connecting,

  /// Successfully connected
  connected,

  /// Connection failed
  failed,

  /// Connection timeout occurred
  timeout,

  /// Retrying connection after failure
  retrying,
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

    /// Current permission status
    @Default(PermissionStatus.initial) PermissionStatus permissionStatus,

    /// Current WebSocket connection status
    @Default(ConnectionStatus.disconnected) ConnectionStatus connectionStatus,

    /// Current frame streaming status
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,

    /// Whether the app is in a loading state
    @Default(false) bool isLoading,

    /// Current error message, if any
    String? errorMessage,

    /// Camera controller instance
    CameraController? cameraController,

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

    // WebSocket specific state fields for Story 2.1
    /// Number of connection attempts made
    @Default(0) int connectionAttempts,

    /// Timestamp of last connection attempt
    DateTime? lastConnectionAttempt,

    /// WebSocket specific error message
    String? connectionError,

    /// Whether auto-connection is enabled
    @Default(true) bool autoConnectionEnabled,

    /// Connection retry timer active
    @Default(false) bool isRetryTimerActive,
  }) = _CheckInState;
}

// --- UI Helper Extensions ---

extension CameraStatusX on CameraStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case CameraStatus.ready:
        return Colors.green;
      case CameraStatus.error:
        return Colors.red;
      case CameraStatus.initial:
      case CameraStatus.permissionRequesting:
      case CameraStatus.initializing:
        return Colors.orange;
      case CameraStatus.permissionDenied:
        return Colors.red;
      case CameraStatus.streaming:
      case CameraStatus.paused:
        return Colors.grey;
    }
  }
}

extension ConnectionStatusX on ConnectionStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.failed:
      case ConnectionStatus.timeout:
        return Colors.red;
      case ConnectionStatus.connecting:
      case ConnectionStatus.retrying:
        return Colors.orange;
      case ConnectionStatus.disconnected:
        return Colors.grey;
    }
  }

  /// Whether this status indicates an active connection attempt
  bool get isAttemptingConnection {
    return this == ConnectionStatus.connecting ||
        this == ConnectionStatus.retrying;
  }

  /// Whether this status indicates a connection failure
  bool get isFailureStatus {
    return this == ConnectionStatus.failed || this == ConnectionStatus.timeout;
  }
}

extension StreamingStatusX on StreamingStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case StreamingStatus.active:
        return Colors.green;
      case StreamingStatus.error:
        return Colors.red;
      case StreamingStatus.idle:
      case StreamingStatus.paused:
        return Colors.grey;
    }
  }
}
