import 'dart:async';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/domain/entities/liveness_check_result.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_config.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';

abstract class LivenessServiceV2 {
  Future<bool> processFaceList(List<Face> faces);
}

@LazySingleton(as: LivenessServiceV2)
class LivenessServiceV2Impl implements LivenessServiceV2 {
  @override
  Future<bool> processFaceList(List<Face> faces) async {
    final livenessFrames =
        faces
            .map(
              (face) => LivenessFrame(
                face: face,
                image: null,
                timestamp: DateTime.now(),
              ),
            )
            .toList();

    return _performCheck(livenessFrames);
  }

  Future<bool> _performCheck(List<LivenessFrame> frames) async {
    final blinkResult = _detectBlink(frames);
    final stabilityResult = _detectStability(frames);
    final qualityResult = _checkQuality(frames);

    final confidence = _calculateOverallConfidence(
      blinkResult,
      stabilityResult,
      qualityResult,
    );

    final isAlive = confidence >= LivenessConfig.LIVENESS_THRESHOLD;
    return isAlive;
  }

  LivenessCheckResult _detectBlink(List<LivenessFrame> frames) {
    if (frames.length < 3) {
      return const LivenessCheckResult.failed('Need more frames');
    }

    final eyeStates = frames.map((f) => _getEyeState(f.face)).toList();

    bool foundOpenStart = false;
    bool foundClosed = false;
    for (final state in eyeStates) {
      if (state == EyeState.open && !foundClosed) foundOpenStart = true;
      if (state == EyeState.closed && foundOpenStart) foundClosed = true;
      if (state == EyeState.open && foundClosed) {
        return LivenessCheckResult(
          confidence: 1.0,
          reason: 'Blink detected',
          details: {'sequence': 'open-close-open'},
        );
      }
    }

    return const LivenessCheckResult.failed('No blink detected');
  }

  LivenessCheckResult _detectStability(List<LivenessFrame> frames) {
    if (frames.length < 2) {
      return const LivenessCheckResult.failed('Need more frames');
    }

    final firstCenter = frames.first.face.boundingBox.center;
    final lastCenter = frames.last.face.boundingBox.center;
    final movement = (firstCenter - lastCenter).distance;

    final isStable = movement < LivenessConfig.MAX_STABILITY_MOVEMENT;

    return LivenessCheckResult(
      confidence: isStable ? 1.0 : 0.0,
      reason: isStable ? 'Face is stable' : 'Excessive movement detected',
      details: {
        'movement': movement.toStringAsFixed(2),
        'threshold': LivenessConfig.MAX_STABILITY_MOVEMENT,
      },
    );
  }

  LivenessCheckResult _checkQuality(List<LivenessFrame> frames) {
    final goodFrames = frames.where((f) => _isFrameQualityGood(f.face)).length;
    final qualityRatio = goodFrames / frames.length;

    final passed = qualityRatio >= LivenessConfig.MIN_QUALITY_FRAME_RATIO;

    return LivenessCheckResult(
      confidence: qualityRatio,
      reason: passed ? 'Good image quality' : 'Poor image quality',
      details: {
        'qualityRatio': qualityRatio.toStringAsFixed(2),
        'passedFrames': goodFrames,
        'totalFrames': frames.length,
      },
    );
  }

  double _calculateOverallConfidence(
    LivenessCheckResult blink,
    LivenessCheckResult stability,
    LivenessCheckResult quality,
  ) {
    return 0.5 + (quality.confidence * 0.3) + (stability.confidence * 0.2);
  }

  bool _isFrameQualityGood(Face face) {
    final angleY = face.headEulerAngleY?.abs() ?? 99;
    final angleZ = face.headEulerAngleZ?.abs() ?? 99;
    return angleY < LivenessConfig.MAX_HEAD_ANGLE_Y &&
        angleZ < LivenessConfig.MAX_HEAD_ANGLE_Z;
  }

  EyeState _getEyeState(Face face) {
    final left = face.leftEyeOpenProbability;
    final right = face.rightEyeOpenProbability;
    if (left == null || right == null) return EyeState.unknown;

    final avg = (left + right) / 2.0;
    if (avg > LivenessConfig.EYE_OPEN_PROBABILITY) return EyeState.open;
    if (avg < LivenessConfig.EYE_CLOSED_PROBABILITY) return EyeState.closed;
    return EyeState.unknown;
  }
}
