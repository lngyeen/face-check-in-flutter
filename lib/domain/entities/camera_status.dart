/// Status of camera initialization and operation
/// Represents the current state of camera hardware and permissions
enum CameraStatus {
  /// Initial camera state (not initialized)
  initial,

  /// Camera permission denied by user
  permissionDenied,

  /// Camera is being initialized (includes permission request)
  initializing,

  /// Camera is opening
  opening,

  /// Front camera is not available on this device
  frontCameraNotAvailable,

  /// Camera has encountered an error
  error,
}
