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

enum FaceDetectionStatus {
  none,
  detecting,
  faceFound,
  multipleFaces,
  noFace,
  backendError,
  error,
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

    // WebSocket specific state
    @Default(0) int connectionAttempts,
    String? connectionError,

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

    /// Total number of frames processed
    @Default(0) int totalFramesProcessed,

    /// Number of successful recognitions
    @Default(0) int successfulRecognitions,

    /// Number of failed recognitions
    @Default(0) int failedRecognitions,

    /// Detected faces
    @Default([]) List<FaceDetectionResult> detectedFaces,

    /// Last frame sent time
    DateTime? lastFrameSentTime,
    @Default(FaceDetectionStatus.none) FaceDetectionStatus faceStatus,
    @Default(0.0) double faceConfidence,
    DateTime? lastFaceDetection,
    BackendError? responseError,
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

@freezed
class BackendError with _$BackendError {
  const factory BackendError({required String error, String? message}) =
      _BackendError;
}
