/// Status of face detection process
/// Represents the current state of face detection and recognition
enum FaceDetectionStatus {
  /// Initial state, no detection performed yet
  none,

  /// Face detected and successfully recognized
  faceFound,

  /// Face detected but not recognized/unknown person
  faceUnrecognized,

  /// Multiple faces detected in the frame
  multipleFaces,

  /// No face detected in the frame
  noFace,

  /// Error occurred during processing (backend/network/processing error)
  error,
}
