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
