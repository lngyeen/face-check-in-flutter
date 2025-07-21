import 'package:face_check_in_flutter/core/services/frame_pipeline_data.dart';
import 'package:face_check_in_flutter/domain/entities/hybrid_processing_result.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';
import 'package:face_check_in_flutter/domain/entities/processed_frame.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';

class ProcessingResultMapper {
  (HybridProcessingResult, ProcessedFrame?)? mapToOutput(
    FramePipelineData data,
    bool hasPassedLiveness,
    int consecutiveNoFaceFrames,
    int maxNoFaceFramesBeforeReset,
  ) {
    if (data.error != null) {
      return (HybridProcessingResult(status: ProcessingStatus.error), null);
    }

    if (data.faceResult?.isSingleValidFace != true) {
      if (consecutiveNoFaceFrames >= maxNoFaceFramesBeforeReset) {
        return (
          HybridProcessingResult(
            status: ProcessingStatus.waitingForFace,
            faceDetectionResult: data.faceResult,
          ),
          null,
        );
      }
    }

    final livenessResult = data.livenessResult;
    if (livenessResult == null) return null;

    if (livenessResult is Passed ||
        (hasPassedLiveness && data.faceResult?.isSingleValidFace == true)) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.readyForCheckIn,
          faceDetectionResult: data.faceResult,
          livenessResult:
              livenessResult is Passed
                  ? livenessResult
                  : const LivenessResult.completed(),
        ),
        data.processedFrame,
      );
    }

    final status = _mapLivenessResultToStatus(livenessResult);

    if (data.faceResult?.isSingleValidFace != true) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.waitingForFace,
          faceDetectionResult: data.faceResult,
        ),
        null,
      );
    }

    return (
      HybridProcessingResult(
        status: status,
        faceDetectionResult: data.faceResult,
        livenessResult: livenessResult,
      ),
      null,
    );
  }

  ProcessingStatus _mapLivenessResultToStatus(LivenessResult result) {
    return result.when(
      passed: (_) => ProcessingStatus.readyForCheckIn,
      failed: (_) => ProcessingStatus.livenessChecking,
      error: (_) => ProcessingStatus.error,
      processing: () => ProcessingStatus.livenessChecking,
      needMoreFrames: () => ProcessingStatus.livenessChecking,
      completed: () => ProcessingStatus.completed,
    );
  }
}
