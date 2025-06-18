/// Enum representing the current status of frame capture
enum FrameCaptureStatus {
  /// Frame capture is not initialized
  idle,

  /// Frame capture is starting up
  initializing,

  /// Frame capture is running and capturing frames
  active,

  /// Frame capture is paused
  paused,

  /// Frame capture is stopping
  stopping,

  /// Frame capture has stopped
  stopped,

  /// Frame capture encountered an error
  error,
}

/// Extension to provide useful methods for FrameCaptureStatus
extension FrameCaptureStatusExtension on FrameCaptureStatus {
  /// Returns true if frame capture is currently active
  bool get isActive => this == FrameCaptureStatus.active;

  /// Returns true if frame capture can be started
  bool get canStart =>
      this == FrameCaptureStatus.idle ||
      this == FrameCaptureStatus.stopped ||
      this == FrameCaptureStatus.error;

  /// Returns true if frame capture can be stopped
  bool get canStop =>
      this == FrameCaptureStatus.active || this == FrameCaptureStatus.paused;

  /// Returns true if frame capture can be paused
  bool get canPause => this == FrameCaptureStatus.active;

  /// Returns true if frame capture can be resumed
  bool get canResume => this == FrameCaptureStatus.paused;

  /// Returns a human-readable description of the status
  String get description {
    switch (this) {
      case FrameCaptureStatus.idle:
        return 'Ready to start capturing';
      case FrameCaptureStatus.initializing:
        return 'Starting frame capture...';
      case FrameCaptureStatus.active:
        return 'Capturing frames';
      case FrameCaptureStatus.paused:
        return 'Frame capture paused';
      case FrameCaptureStatus.stopping:
        return 'Stopping frame capture...';
      case FrameCaptureStatus.stopped:
        return 'Frame capture stopped';
      case FrameCaptureStatus.error:
        return 'Frame capture error';
    }
  }
}
