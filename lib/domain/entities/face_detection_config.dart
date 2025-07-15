/// Configuration constants for face detection.
class FaceDetectionConfig {
  /// The minimum width of the bounding box for a face to be considered valid (in pixels).
  static const double MIN_FACE_WIDTH = 120.0;

  /// The minimum height of the bounding box for a face to be considered valid (in pixels).
  static const double MIN_FACE_HEIGHT = 120.0;

  /// The minimum size of a face relative to the smaller dimension of the image.
  static const double MIN_FACE_SIZE_RATIO = 0.15;
}
