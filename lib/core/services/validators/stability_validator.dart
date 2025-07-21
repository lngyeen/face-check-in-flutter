import 'package:face_check_in_flutter/core/services/liveness_config.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

import 'liveness_validator.dart';

/// Validator for checking face movement stability
class StabilityValidator implements LivenessValidator {
  @override
  LivenessResult validate(List<LivenessFrame> faceFrames) {
    if (faceFrames.length < 2) {
      return const LivenessResult.failed(
        reason: LivenessFailureReason.insufficientFrames,
      );
    }

    final centers = faceFrames.map((f) => f.face.boundingBox.center).toList();
    final movements = <double>[];
    for (int i = 1; i < centers.length; i++) {
      movements.add((centers[i] - centers[i - 1]).distance);
    }

    final overallMovement = (centers.first - centers.last).distance;
    final bool isStable =
        overallMovement <= ValidationConfig.maxStabilityMovement;

    if (isStable) {
      final confidence =
          1.0 - (overallMovement / ValidationConfig.maxStabilityMovement);
      return LivenessResult.passed(confidence: confidence.clamp(0.0, 1.0));
    } else {
      return LivenessResult.failed(
        reason: LivenessFailureReason.unstableMovement,
      );
    }
  }
}
