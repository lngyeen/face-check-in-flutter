enum CameraStatus {
  initial,
  permissionDenied,
  initializing,
  ready,
  frontCameraNotAvailable,
  error,
}

extension CameraStatusX on CameraStatus {
  bool get isActive =>
      this == CameraStatus.ready || this == CameraStatus.initializing;
}
