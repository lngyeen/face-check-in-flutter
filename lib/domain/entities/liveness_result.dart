enum LivenessResult { needMoreFrames, processing, passed, failed, error }

extension LivenessResultExtension on LivenessResult {
  bool get isPassed =>
      this == LivenessResult.passed || this == LivenessResult.processing;
}
