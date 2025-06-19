/// Represents face detection status from backend responses
enum FaceDetectionStatus {
  /// No face detection performed
  none,

  /// Currently detecting faces
  detecting,

  /// Single face found
  faceFound,

  /// Multiple faces detected
  multipleFaces,

  /// No face detected in frame
  noFace,

  /// Face detection error
  error,
}
