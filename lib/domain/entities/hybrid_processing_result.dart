import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';

/// The result of a single hybrid processing operation.
class HybridProcessingResult {
  final ProcessingStatus status;
  final LocalFaceDetectionResult? faceDetectionResult;
  final LivenessResult? livenessResult;

  const HybridProcessingResult({
    required this.status,
    this.faceDetectionResult,
    this.livenessResult,
  });
}
