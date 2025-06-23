/// Status of frame streaming process
/// Represents the current state of camera frame streaming to backend
enum StreamingStatus {
  /// Not streaming frames (default state)
  idle,

  /// Actively streaming frames to backend
  active,

  /// Streaming encountered an error
  error,
}
