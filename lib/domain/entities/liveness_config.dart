/// Configuration for the liveness detection algorithms and batch processing.
class LivenessConfig {
  // === BATCH PROCESSING CONFIGURATION ===
  /// Minimum number of frames/faces required for liveness detection
  static const int MIN_FRAMES_FOR_LIVENESS = 8;

  /// Maximum batch size to prevent memory issues
  static const int MAX_BATCH_SIZE = 32;

  /// Timeout duration for batch collection
  static const Duration BATCH_TIMEOUT = Duration(seconds: 5);

  /// Duration to cache liveness results
  static const Duration RESULT_CACHE_DURATION = Duration(seconds: 2);

  /// Maximum number of failed retry attempts
  static const int MAX_FAILED_RETRIES = 2;

  /// Ratio of frames to keep after failed liveness check (for retry)
  static const double PARTIAL_RESET_RATIO = 0.5;

  // === DETECTION THRESHOLDS ===
  /// Overall confidence threshold for liveness pass/fail decision
  static const double LIVENESS_THRESHOLD = 0.75;

  /// Maximum allowed face movement for stability check (in pixels)
  static const double MAX_STABILITY_MOVEMENT = 15.0;

  /// Minimum ratio of good quality frames required
  static const double MIN_QUALITY_FRAME_RATIO = 0.7;

  // === HEAD POSE CONSTRAINTS ===
  /// Maximum head yaw angle (left/right rotation) in degrees
  static const double MAX_HEAD_ANGLE_Y = 15.0;

  /// Maximum head roll angle in degrees
  static const double MAX_HEAD_ANGLE_Z = 10.0;

  // === EYE STATE THRESHOLDS ===
  /// Probability threshold for eyes being considered "open"
  static const double EYE_OPEN_PROBABILITY = 0.8;

  /// Probability threshold for eyes being considered "closed"
  static const double EYE_CLOSED_PROBABILITY = 0.2;
}
