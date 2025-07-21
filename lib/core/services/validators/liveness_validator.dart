import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

/// Base interface for all liveness validators
abstract class LivenessValidator {
  /// Validates a list of liveness frames and returns a validation result
  LivenessResult validate(List<LivenessFrame> faceFrames);
}
