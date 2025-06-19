/// Represents the current streaming status
enum StreamingStatus {
  /// Not streaming frames
  idle,

  /// Starting frame streaming
  starting,

  /// Actively streaming frames
  active,

  /// Streaming is paused
  paused,

  /// Stopping frame streaming
  stopping,

  /// Streaming encountered an error
  error,
}

/// Extension for StreamingStatus utility methods
extension StreamingStatusExtension on StreamingStatus {
  bool get canStart =>
      this == StreamingStatus.idle || this == StreamingStatus.error;
  bool get canStop =>
      this == StreamingStatus.active || this == StreamingStatus.paused;
  bool get isStreaming =>
      this == StreamingStatus.active || this == StreamingStatus.paused;
  bool get canPause => this == StreamingStatus.active;
  bool get canResume => this == StreamingStatus.paused;
  bool get isActive => this == StreamingStatus.active;

  String get displayName {
    switch (this) {
      case StreamingStatus.idle:
        return 'Idle';
      case StreamingStatus.starting:
        return 'Starting';
      case StreamingStatus.active:
        return 'Active';
      case StreamingStatus.paused:
        return 'Paused';
      case StreamingStatus.stopping:
        return 'Stopping';
      case StreamingStatus.error:
        return 'Error';
    }
  }

  String get description {
    switch (this) {
      case StreamingStatus.idle:
        return 'Ready to start streaming';
      case StreamingStatus.starting:
        return 'Starting frame streaming...';
      case StreamingStatus.active:
        return 'Streaming frames';
      case StreamingStatus.paused:
        return 'Frame streaming paused';
      case StreamingStatus.stopping:
        return 'Stopping frame streaming...';
      case StreamingStatus.error:
        return 'Frame streaming error';
    }
  }
}
