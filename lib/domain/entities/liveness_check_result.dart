/// The internal result of a single, individual liveness check.
class LivenessCheckResult {
  final double confidence;
  final String reason;

  const LivenessCheckResult({required this.confidence, required this.reason});

  const LivenessCheckResult.failed(this.reason) : confidence = 0.0;

  Map<String, dynamic> toMap() => {
    'confidence': confidence.toStringAsFixed(2),
    'reason': reason,
  };
}

/// The state of the user's eyes.
enum EyeState { open, closed, unknown }
