import 'package:face_check_in_flutter/core/services/face_detection_cache.dart';
import 'package:face_check_in_flutter/core/services/face_detection_service_v2.dart';
import 'package:face_check_in_flutter/core/services/frame_pipeline_data.dart';
import 'package:face_check_in_flutter/core/services/liveness_state_tracker.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';
import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';

class FramePipelineProcessor {
  final FaceDetectionServiceV2 _faceDetectionService;
  final FaceDetectionCache _faceDetectionCache;
  final LivenessStateTracker _livenessStateTracker;
  final ProcessingMode _processingMode;

  FramePipelineProcessor({
    required FaceDetectionServiceV2 faceDetectionService,
    required FaceDetectionCache faceDetectionCache,
    required LivenessStateTracker livenessStateTracker,
    ProcessingMode processingMode = ProcessingMode.hybrid,
  }) : _faceDetectionService = faceDetectionService,
       _faceDetectionCache = faceDetectionCache,
       _livenessStateTracker = livenessStateTracker,
       _processingMode = processingMode;

  Future<FramePipelineData> processFrame(FramePipelineData data) async {
    data = await _performFaceDetection(data);
    data = await _performLivenessAndConversion(data);
    return data;
  }

  Future<FramePipelineData> _performFaceDetection(
    FramePipelineData data,
  ) async {
    if (_processingMode != ProcessingMode.hybrid) {
      data.faceResult = const LocalFaceDetectionResult.skip();
      return data;
    }

    try {
      // Step 1: Always run detection to get latest data
      final detectionResult = await _faceDetectionService.detectFace(
        data.image,
        data.camera,
      );

      // Step 2: Put new result into cache to update stable state
      _faceDetectionCache.process(detectionResult);

      // Step 3: Always use latest result for next steps
      data.faceResult = detectionResult;
    } catch (e) {
      data.error = 'Face detection failed: $e';
      _faceDetectionCache.invalidate();
    }
    return data;
  }

  Future<FramePipelineData> _performLivenessAndConversion(
    FramePipelineData data,
  ) async {
    if (data.error != null) return data;

    if (_processingMode != ProcessingMode.hybrid) {
      data.livenessResult = const LivenessResult.passed();
      return data;
    }

    final faceResult = data.faceResult;

    // Step 4: Use isFaceStable flag from cache as "gatekeeper"
    if (faceResult != null &&
        faceResult.isSingleValidFace &&
        _faceDetectionCache.isFaceStable) {
      final faceFrame = LivenessFrame(
        face: faceResult.face!,
        image: data.image,
      );
      _livenessStateTracker.addFace(faceFrame);

      if (_livenessStateTracker.isReadyForProcessing) {
        data.livenessResult =
            await _livenessStateTracker.processCurrentChallenge();
      } else {
        data.livenessResult = const LivenessResult.needMoreFrames();
      }
    } else {
      _livenessStateTracker.handleFaceLost();
      data.livenessResult = const LivenessResult.needMoreFrames();
    }

    return data;
  }

  ProcessingMode get processingMode => _processingMode;

  FaceDetectionCache get faceDetectionCache => _faceDetectionCache;

  LivenessStateTracker get livenessStateTracker => _livenessStateTracker;
}
