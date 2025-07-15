/// Configuration constants for image stream processing.
class ImageStreamConfig {
  /// Throttle for waiting for face detection (responsive UX).
  static const Duration waitingForFaceThrottleDuration = Duration(
    milliseconds: 1000,
  );

  /// Throttle for liveness checking phase (efficient processing).
  static const Duration livenessCheckingThrottleDuration = Duration(
    milliseconds: 250,
  );

  /// Throttle for ready state (conservative server communication).
  static const Duration readyForCheckInThrottleDuration = Duration(seconds: 1);

  /// Cache expiry duration for face detection results.
  static const Duration faceDetectionCacheExpiry = Duration(seconds: 3);

  /// Number of frames needed for stable face detection.
  static const int faceDetectionStabilityThreshold = 3;

  /// Number of frames needed to invalidate face detection cache.
  static const int faceDetectionInvalidationThreshold = 2;

  /// Spatial threshold for face comparison (stricter).
  static const double faceDetectionSpatialThreshold = 0.8;
}
