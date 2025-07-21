import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:face_check_in_flutter/core/services/liveness_config.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

import 'liveness_validator.dart';

/// Validator for checking image and face quality
class QualityValidator implements LivenessValidator {
  @override
  LivenessResult validate(List<LivenessFrame> faceFrames) {
    if (faceFrames.isEmpty) {
      return const LivenessResult.failed(
        reason: LivenessFailureReason.insufficientFrames,
      );
    }

    int goodFramesCount = 0;
    for (final faceFrame in faceFrames) {
      if (_isFrameQualityGood(faceFrame)) {
        goodFramesCount++;
      }
    }

    final qualityRatio = goodFramesCount / faceFrames.length;

    if (qualityRatio >= ValidationConfig.minQualityFrameRatio) {
      return LivenessResult.passed(confidence: qualityRatio);
    } else {
      return const LivenessResult.failed(
        reason: LivenessFailureReason.lowQualityFrames,
      );
    }
  }

  bool _isFrameQualityGood(LivenessFrame faceFrame) {
    final face = faceFrame.face;
    final angleY = face.headEulerAngleY?.abs() ?? 99;
    final angleZ = face.headEulerAngleZ?.abs() ?? 99;
    if (angleY > QualityConfig.maxHeadAngleY ||
        angleZ > QualityConfig.maxHeadAngleZ) {
      return false;
    }

    final imageWidth = faceFrame.imageSize.width;
    final faceSizeRatio = face.boundingBox.width / imageWidth;
    if (faceSizeRatio < QualityConfig.minFaceSizeRatio ||
        faceSizeRatio > QualityConfig.maxFaceSizeRatio) {
      return false;
    }

    final hasEyes =
        face.landmarks[FaceLandmarkType.leftEye] != null &&
        face.landmarks[FaceLandmarkType.rightEye] != null;
    if (!hasEyes) return false;

    return true;
  }
}
