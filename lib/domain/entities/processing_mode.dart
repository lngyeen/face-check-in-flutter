/// Defines the processing strategy for the image stream.
enum ProcessingMode {
  /// Sends all frames to the server for processing.
  serverSide,

  /// Performs face detection and liveness checks locally before sending data.
  hybrid,
}

/// Represents the status of the local hybrid processing pipeline.
enum ProcessingStatus {
  /// Waiting for a valid face to be detected.
  waitingForFace,

  /// Liveness checks are in progress.
  livenessChecking,

  /// Liveness passed, ready for server-side recognition.
  readyForCheckIn,

  /// Liveness check completed successfully, no further processing needed.
  completed,

  /// An error occurred during processing.
  error,
}
