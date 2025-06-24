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

    // Frame streaming specific state fields for Phase 2
    /// Current frame rate being captured/streamed
    @Default(0.0) double currentFrameRate,

    /// Total frames captured since streaming started
    @Default(0) int framesCaptured,

    /// Total frames successfully streamed
    @Default(0) int framesStreamed,

    /// Total frames failed to stream
    @Default(0) int framesFailed,

    /// Average streaming latency in milliseconds
    @Default(0.0) double averageStreamingLatency,

    /// Total bytes streamed
    @Default(0) int totalBytesStreamed,

    /// Timestamp when last frame was streamed
    DateTime? lastFrameStreamedAt,

    /// Timestamp when streaming session started
    DateTime? streamingSessionStartTime,

    // Face detection state fields for Phase 2
    /// Current face detection status
    @Default(FaceDetectionStatus.none) FaceDetectionStatus faceDetectionStatus,

    /// List of currently detected faces
    @Default([]) List<FaceDetectionResult> detectedFaces,

    /// Confidence score of primary face (0.0 - 1.0)
    @Default(0.0) double primaryFaceConfidence,

    /// Timestamp of last face detection
    DateTime? lastFaceDetectionTime,

    /// Number of face detections performed
    @Default(0) int faceDetectionsCount,

    /// Frame streaming error message
    String? streamingError,
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
        return Colors.blue;
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
      case StreamingStatus.starting:
      case StreamingStatus.stopping:
        return Colors.orange;
      case StreamingStatus.idle:
      case StreamingStatus.paused:
        return Colors.grey;
    }
  }
}
