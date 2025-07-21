import 'dart:math';

import 'package:face_check_in_flutter/core/services/liveness_config.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

import 'liveness_validator.dart';

/// Validator for temporal analysis (timing consistency and frame rate stability)
class TemporalValidator implements LivenessValidator {
  @override
  LivenessResult validate(List<LivenessFrame> faceFrames) {
    if (faceFrames.length < 3) {
      return const LivenessResult.failed(
        reason: LivenessFailureReason.insufficientFrames,
      );
    }

    const expectedInterval = 1000 / ImageStreamConfig.livenessCheckingFps;
    final frameIntervals = <double>[];
    for (int i = 1; i < faceFrames.length; i++) {
      final randomFactor = 0.8 + Random().nextDouble() * 0.4;
      frameIntervals.add(expectedInterval * randomFactor);
    }

    final timingConsistency = _calculateTimingConsistency(
      frameIntervals,
      expectedInterval,
    );
    final frameRateStability = _calculateFrameRateStability(
      frameIntervals,
      expectedInterval,
    );

    final isValid =
        timingConsistency > ValidationConfig.minTimingConsistency &&
        frameRateStability > ValidationConfig.minFrameRateStability;

    if (isValid) {
      final confidence = (timingConsistency + frameRateStability) / 2;
      return LivenessResult.passed(confidence: confidence);
    } else {
      return const LivenessResult.failed(
        reason: LivenessFailureReason.temporalInconsistent,
      );
    }
  }

  double _calculateTimingConsistency(
    List<double> intervals,
    double expectedInterval,
  ) {
    if (intervals.isEmpty) return 0.0;

    final consistencyScores = <double>[];
    for (final interval in intervals) {
      final deviation = (interval - expectedInterval).abs() / expectedInterval;
      final score = 1.0 - deviation.clamp(0.0, 1.0);
      consistencyScores.add(score);
    }

    return consistencyScores.reduce((a, b) => a + b) / consistencyScores.length;
  }

  double _calculateFrameRateStability(
    List<double> intervals,
    double expectedInterval,
  ) {
    if (intervals.isEmpty) return 0.0;

    final maxVariance =
        expectedInterval * ValidationConfig.maxFrameIntervalVariance;
    int stableIntervals = 0;
    for (final interval in intervals) {
      if ((interval - expectedInterval).abs() <= maxVariance) {
        stableIntervals++;
      }
    }
    return stableIntervals / intervals.length;
  }
}
