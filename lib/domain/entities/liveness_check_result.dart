/// The internal result of a single, individual liveness check.
class LivenessCheckResult {
  final double confidence;
  final String reason;
  final Map<String, dynamic> details;

  const LivenessCheckResult({
    required this.confidence,
    required this.reason,
    required this.details,
  });

  const LivenessCheckResult.failed(this.reason)
    : confidence = 0.0,
      details = const {};

  Map<String, dynamic> toMap() => {
    'confidence': confidence.toStringAsFixed(2),
    'reason': reason,
    'details': details,
  };
}

/// The state of the user's eyes.
enum EyeState { open, closed, unknown }
