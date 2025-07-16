import 'dart:async';
import 'dart:ui';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/image_stream_service_v2.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_check_result.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';

/// Result of multi-factor blink validation
class MultiFactorBlinkResult {
  final bool isValid;
  final String? failureReason;
  final String description;
  final double symmetryScore;
  final double movementNaturalness;
  final double timingNaturalness;
  final double overallQuality;
  final BlinkPatternResult patternResult;

  const MultiFactorBlinkResult._({
    required this.isValid,
    this.failureReason,
    required this.description,
    required this.symmetryScore,
    required this.movementNaturalness,
    required this.timingNaturalness,
    required this.overallQuality,
    required this.patternResult,
  });

  factory MultiFactorBlinkResult.valid({
    required double symmetryScore,
    required double movementNaturalness,
    required double timingNaturalness,
    required double overallQuality,
    required BlinkPatternResult patternResult,
  }) {
    return MultiFactorBlinkResult._(
      isValid: true,
      description:
          'Symmetry: ${(symmetryScore * 100).round()}%, Movement: ${(movementNaturalness * 100).round()}%, Timing: ${(timingNaturalness * 100).round()}%, Quality: ${(overallQuality * 100).round()}%',
      symmetryScore: symmetryScore,
      movementNaturalness: movementNaturalness,
      timingNaturalness: timingNaturalness,
      overallQuality: overallQuality,
      patternResult: patternResult,
    );
  }

  factory MultiFactorBlinkResult.invalid(
    String reason,
    BlinkPatternResult patternResult,
  ) {
    return MultiFactorBlinkResult._(
      isValid: false,
      failureReason: reason,
      description: 'Multi-factor validation failed: $reason',
      symmetryScore: 0.0,
      movementNaturalness: 0.0,
      timingNaturalness: 0.0,
      overallQuality: 0.0,
      patternResult: patternResult,
    );
  }
}

/// Result of blink pattern validation
class BlinkPatternResult {
  final bool isValid;
  final String? failureReason;
  final String description;
  final int openBeforeCount;
  final int closedCount;
  final int openAfterCount;
  final int totalLength;
  final double? quality;

  const BlinkPatternResult._({
    required this.isValid,
    this.failureReason,
    required this.description,
    required this.openBeforeCount,
    required this.closedCount,
    required this.openAfterCount,
    required this.totalLength,
    this.quality,
  });

  factory BlinkPatternResult.valid({
    required int openBeforeCount,
    required int closedCount,
    required int openAfterCount,
    required int totalLength,
    double quality = 1.0,
  }) {
    return BlinkPatternResult._(
      isValid: true,
      description:
          'Open($openBeforeCount) → Closed($closedCount) → Open($openAfterCount) [Quality: ${(quality * 100).round()}%]',
      openBeforeCount: openBeforeCount,
      closedCount: closedCount,
      openAfterCount: openAfterCount,
      totalLength: totalLength,
    );
  }

  factory BlinkPatternResult.invalid(String reason) {
    return BlinkPatternResult._(
      isValid: false,
      failureReason: reason,
      description: 'Invalid pattern',
      openBeforeCount: 0,
      closedCount: 0,
      openAfterCount: 0,
      totalLength: 0,
      quality: null,
    );
  }
}

/// Result of temporal pattern analysis
class TemporalAnalysisResult {
  final bool isValid;
  final String? failureReason;
  final String description;
  final double timingConsistency;
  final double patternNaturalness;
  final double frameRateStability;
  final List<double> frameIntervals;
  final double averageInterval;
  final double intervalVariance;

  const TemporalAnalysisResult._({
    required this.isValid,
    this.failureReason,
    required this.description,
    required this.timingConsistency,
    required this.patternNaturalness,
    required this.frameRateStability,
    required this.frameIntervals,
    required this.averageInterval,
    required this.intervalVariance,
  });

  factory TemporalAnalysisResult.valid({
    required double timingConsistency,
    required double patternNaturalness,
    required double frameRateStability,
    required List<double> frameIntervals,
    required double averageInterval,
    required double intervalVariance,
  }) {
    return TemporalAnalysisResult._(
      isValid: true,
      description:
          'Timing: ${(timingConsistency * 100).round()}%, Naturalness: ${(patternNaturalness * 100).round()}%, Stability: ${(frameRateStability * 100).round()}%',
      timingConsistency: timingConsistency,
      patternNaturalness: patternNaturalness,
      frameRateStability: frameRateStability,
      frameIntervals: frameIntervals,
      averageInterval: averageInterval,
      intervalVariance: intervalVariance,
    );
  }

  factory TemporalAnalysisResult.invalid(String reason) {
    return TemporalAnalysisResult._(
      isValid: false,
      failureReason: reason,
      description: 'Invalid temporal pattern',
      timingConsistency: 0.0,
      patternNaturalness: 0.0,
      frameRateStability: 0.0,
      frameIntervals: [],
      averageInterval: 0.0,
      intervalVariance: 0.0,
    );
  }
}

/// Result of stability pattern analysis
class StabilityAnalysisResult {
  final bool isValid;
  final String? failureReason;
  final String description;
  final double overallMovement;
  final double movementVariance;
  final int consecutiveStableFrames;
  final int totalFrames;

  const StabilityAnalysisResult._({
    required this.isValid,
    this.failureReason,
    required this.description,
    required this.overallMovement,
    required this.movementVariance,
    required this.consecutiveStableFrames,
    required this.totalFrames,
  });

  factory StabilityAnalysisResult.valid({
    required double overallMovement,
    required double movementVariance,
    required int consecutiveStableFrames,
    required int totalFrames,
  }) {
    return StabilityAnalysisResult._(
      isValid: true,
      description:
          'Movement: ${overallMovement.toStringAsFixed(2)}px, Variance: ${movementVariance.toStringAsFixed(2)}px, Stable: ${consecutiveStableFrames}frames',
      overallMovement: overallMovement,
      movementVariance: movementVariance,
      consecutiveStableFrames: consecutiveStableFrames,
      totalFrames: totalFrames,
    );
  }

  factory StabilityAnalysisResult.invalid(String reason) {
    return StabilityAnalysisResult._(
      isValid: false,
      failureReason: reason,
      description: 'Invalid stability pattern',
      overallMovement: 0.0,
      movementVariance: 0.0,
      consecutiveStableFrames: 0,
      totalFrames: 0,
    );
  }
}

/// Configuration for the liveness detection algorithms and batch processing.
/// Note: Face size validation is handled by FaceDetectionServiceV2Config
/// Note: Frame requirements are aligned with LivenessBatchProcessorConfig
class LivenessConfig {
  /// Overall confidence threshold for liveness pass/fail decision
  static const double livenessThreshold = 0.65;

  /// Maximum allowed face movement for stability check (in pixels)
  static const double maxStabilityMovement = 25.0;

  /// Minimum ratio of good quality frames required
  static const double minQualityFrameRatio = 0.6;

  /// Maximum head yaw angle (left/right rotation) in degrees
  static const double maxHeadAngleY = 15.0;

  /// Maximum head roll angle in degrees
  static const double maxHeadAngleZ = 10.0;

  /// Probability threshold for eyes being considered "open"
  static const double eyeOpenProbability = 0.6;

  /// Probability threshold for eyes being considered "closed"
  static const double eyeClosedProbability = 0.4;

  /// Weight for blink detection in overall confidence calculation
  static const double blinkWeight = 0.4;

  /// Weight for quality check in overall confidence calculation
  static const double qualityWeight = 0.4;

  /// Weight for stability check in overall confidence calculation
  static const double stabilityWeight = 0.2;

  /// Minimum frames required for stability detection
  static const int minFramesForStability = 2;

  /// Maximum variance allowed for face movement (in pixels)
  static const double maxMovementVariance = 10.0;

  /// Minimum consecutive stable frames required
  static const int minStableFrames = 3;

  // Face size validation is handled by FaceDetectionServiceV2Config.minFaceSizeRatio

  /// Minimum face size for quality validation (in pixels)
  static const double minFaceSize = 120.0;

  /// Maximum face size for quality validation (in pixels)
  static const double maxFaceSize = 400.0;

  /// Minimum overall quality score required
  static const double minOverallQuality = 0.6;

  /// Maximum blur threshold for image quality
  static const double maxBlurThreshold = 0.3;

  /// Minimum lighting quality threshold
  static const double minLightingQuality = 0.5;

  /// Confidence value for successful detection
  static const double successConfidence = 1.0;

  /// Confidence value for failed detection
  static const double failureConfidence = 0.0;

  /// Fallback angle value when head angle is null (in degrees)
  static const double fallbackAngle = 99.0;

  /// Divisor for calculating average eye probability
  static const double eyeProbabilityDivisor = 2.0;

  /// Time-based blink detection configuration
  /// Aligned with LivenessBatchProcessorConfig.minFramesForLiveness = 8
  static const Duration minBlinkDuration = Duration(
    milliseconds: 1000,
  ); // 1.0s (8 frames at 8 FPS)
  static const Duration maxBlinkDuration = Duration(milliseconds: 1400); // 1.4s
  static const Duration minOpenDurationBeforeBlink = Duration(
    milliseconds: 375,
  ); // 0.375s (3 frames at 8 FPS)
  static const Duration minOpenDurationAfterBlink = Duration(
    milliseconds: 375,
  ); // 0.375s (3 frames at 8 FPS)

  /// Helper methods to calculate frames based on FPS
  /// These values are aligned with LivenessBatchProcessorConfig.minFramesForLiveness = 8
  static int get minFramesForBlink =>
      (minBlinkDuration.inMilliseconds *
              ImageStreamConfig.livenessCheckingFps /
              1000)
          .round(); // = 8 frames at 8 FPS

  static int get maxBlinkDurationFrames =>
      (maxBlinkDuration.inMilliseconds *
              ImageStreamConfig.livenessCheckingFps /
              1000)
          .round(); // = 11 frames at 8 FPS

  static int get minOpenFramesBeforeBlink =>
      (minOpenDurationBeforeBlink.inMilliseconds *
              ImageStreamConfig.livenessCheckingFps /
              1000)
          .round(); // = 3 frames at 8 FPS

  static int get minOpenFramesAfterBlink =>
      (minOpenDurationAfterBlink.inMilliseconds *
              ImageStreamConfig.livenessCheckingFps /
              1000)
          .round(); // = 3 frames at 8 FPS

  /// Temporal analysis configuration
  /// Expected frame interval in milliseconds (based on FPS)
  static double get expectedFrameInterval =>
      1000.0 / ImageStreamConfig.livenessCheckingFps; // = 125ms at 8 FPS

  /// Maximum allowed frame interval variance (as percentage of expected)
  static const double maxFrameIntervalVariance = 0.3; // 30% variance allowed

  /// Minimum timing consistency score required
  static const double minTimingConsistency = 0.7;

  /// Minimum pattern naturalness score required
  static const double minPatternNaturalness = 0.6;

  /// Minimum frame rate stability score required
  static const double minFrameRateStability = 0.8;

  /// Multi-factor blink validation configuration
  /// Minimum symmetry score for blink validation
  static const double minBlinkSymmetry = 0.7;

  /// Minimum movement naturalness score
  static const double minMovementNaturalness = 0.6;

  /// Minimum timing naturalness score
  static const double minTimingNaturalness = 0.7;

  /// Maximum allowed asymmetry between left and right eye
  static const double maxEyeAsymmetry = 0.3;

  /// Minimum overall multi-factor blink quality
  static const double minMultiFactorBlinkQuality = 0.65;

  /// Adaptive threshold configuration
  /// Base thresholds that will be adjusted based on conditions
  static const double baseLivenessThreshold = 0.65;
  static const double baseBlinkSymmetry = 0.7;
  static const double baseMovementNaturalness = 0.6;
  static const double baseTimingNaturalness = 0.7;
  static const double baseStabilityMovement = 25.0;
  static const double baseQualityThreshold = 0.6;

  /// Adaptive adjustment factors
  static const double lightingAdjustmentFactor = 0.1; // ±10% adjustment
  static const double movementAdjustmentFactor = 0.15; // ±15% adjustment
  static const double qualityAdjustmentFactor = 0.12; // ±12% adjustment
  static const double confidenceAdjustmentFactor = 0.08; // ±8% adjustment

  /// Minimum and maximum bounds for adaptive thresholds
  static const double minLivenessThreshold = 0.55;
  static const double maxLivenessThreshold = 0.75;
  static const double minBlinkSymmetryThreshold = 0.55;
  static const double maxBlinkSymmetryThreshold = 0.85;
  static const double minMovementNaturalnessThreshold = 0.45;
  static const double maxMovementNaturalnessThreshold = 0.75;
  static const double minTimingNaturalnessThreshold = 0.55;
  static const double maxTimingNaturalnessThreshold = 0.85;
  static const double minStabilityMovementThreshold = 15.0;
  static const double maxStabilityMovementThreshold = 35.0;
  static const double minQualityThreshold = 0.48;
  static const double maxQualityThreshold = 0.72;
}

/// Result of adaptive threshold calculation
class AdaptiveThresholdResult {
  final double adjustedLivenessThreshold;
  final double adjustedBlinkSymmetry;
  final double adjustedMovementNaturalness;
  final double adjustedTimingNaturalness;
  final double adjustedStabilityMovement;
  final double adjustedQualityThreshold;
  final String description;
  final Map<String, double> adjustments;

  const AdaptiveThresholdResult._({
    required this.adjustedLivenessThreshold,
    required this.adjustedBlinkSymmetry,
    required this.adjustedMovementNaturalness,
    required this.adjustedTimingNaturalness,
    required this.adjustedStabilityMovement,
    required this.adjustedQualityThreshold,
    required this.description,
    required this.adjustments,
  });

  factory AdaptiveThresholdResult.create({
    required double adjustedLivenessThreshold,
    required double adjustedBlinkSymmetry,
    required double adjustedMovementNaturalness,
    required double adjustedTimingNaturalness,
    required double adjustedStabilityMovement,
    required double adjustedQualityThreshold,
    required Map<String, double> adjustments,
  }) {
    final adjustmentDescriptions = adjustments.entries
        .map((e) => '${e.key}: ${(e.value * 100).round()}%')
        .join(', ');

    return AdaptiveThresholdResult._(
      adjustedLivenessThreshold: adjustedLivenessThreshold,
      adjustedBlinkSymmetry: adjustedBlinkSymmetry,
      adjustedMovementNaturalness: adjustedMovementNaturalness,
      adjustedTimingNaturalness: adjustedTimingNaturalness,
      adjustedStabilityMovement: adjustedStabilityMovement,
      adjustedQualityThreshold: adjustedQualityThreshold,
      description: 'Adaptive thresholds applied: $adjustmentDescriptions',
      adjustments: adjustments,
    );
  }
}

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
    final startTime = DateTime.now();
    print('=== LIVENESS DETECTION START ===');
    print('Input frames: ${frames.length}');
    print(
      'Base liveness threshold: ${(LivenessConfig.baseLivenessThreshold * 100).round()}%',
    );

    // Calculate adaptive thresholds based on frame characteristics
    print('🔧 Calculating adaptive thresholds...');
    final averageLightingQuality = _calculateAverageLightingQuality(frames);
    final averageMovement = _calculateAverageMovement(frames);
    final averageQuality = _calculateAverageQuality(frames);

    // Use a preliminary confidence estimate for adaptive threshold calculation
    final preliminaryConfidence = _calculatePreliminaryConfidence(frames);

    final adaptiveThresholds = _calculateAdaptiveThresholds(
      frames: frames,
      averageLightingQuality: averageLightingQuality,
      averageMovement: averageMovement,
      averageQuality: averageQuality,
      currentConfidence: preliminaryConfidence,
    );

    _logAdaptiveThresholds(adaptiveThresholds);

    // Perform individual checks with adaptive thresholds
    final blinkResult = _detectBlink(frames, adaptiveThresholds);
    final stabilityResult = _detectStability(frames, adaptiveThresholds);
    final qualityResult = _checkQuality(frames, adaptiveThresholds);
    final temporalResult = _analyzeTemporalPattern(frames);

    // Calculate overall confidence with enhanced logic
    final confidence = _calculateOverallConfidence(
      blinkResult,
      stabilityResult,
      qualityResult,
      temporalResult,
    );

    // Make final decision using adaptive threshold
    final isAlive = confidence >= adaptiveThresholds.adjustedLivenessThreshold;
    final duration = DateTime.now().difference(startTime);

    // Comprehensive result logging
    print('=== LIVENESS DETECTION RESULT ===');
    print('📊 Final confidence: ${(confidence * 100).round()}%');
    print(
      '📊 Adaptive threshold: ${(adaptiveThresholds.adjustedLivenessThreshold * 100).round()}%',
    );
    print(
      '📊 Base threshold: ${(LivenessConfig.baseLivenessThreshold * 100).round()}%',
    );
    print('📊 Decision: ${isAlive ? 'ALIVE ✅' : 'NOT ALIVE ❌'}');
    print('📊 Duration: ${duration.inMilliseconds}ms');

    // Component summary
    print('📊 Component Summary:');
    print(
      '   Blink: ${(blinkResult.confidence * 100).round()}% - ${blinkResult.reason}',
    );
    print(
      '   Stability: ${(stabilityResult.confidence * 100).round()}% - ${stabilityResult.reason}',
    );
    print(
      '   Quality: ${(qualityResult.confidence * 100).round()}% - ${qualityResult.reason}',
    );
    print(
      '   Temporal: ${(temporalResult.timingConsistency * 100).round()}% - ${temporalResult.description}',
    );

    // Decision reasoning
    if (isAlive) {
      print(
        '✅ LIVENESS DETECTED: All checks passed with sufficient confidence',
      );
    } else {
      print(
        '❌ LIVENESS NOT DETECTED: Insufficient confidence or failed checks',
      );
      if (confidence < adaptiveThresholds.adjustedLivenessThreshold) {
        print(
          '   Reason: Confidence ${(confidence * 100).round()}% below adaptive threshold ${(adaptiveThresholds.adjustedLivenessThreshold * 100).round()}%',
        );
      }
    }

    print('=== LIVENESS DETECTION END ===');
    return isAlive;
  }

  LivenessCheckResult _detectBlink(
    List<LivenessFrame> frames,
    AdaptiveThresholdResult adaptiveThresholds,
  ) {
    final startTime = DateTime.now();
    print('=== MULTI-FACTOR BLINK DETECTION START ===');
    print('Input frames: ${frames.length}');
    print('Required frames: ${LivenessConfig.minFramesForBlink}');

    if (frames.length < LivenessConfig.minFramesForBlink) {
      final duration = DateTime.now().difference(startTime);
      print('❌ BLINK DETECTION FAILED: Insufficient frames');
      print('   Duration: ${duration.inMilliseconds}ms');
      print('=== MULTI-FACTOR BLINK DETECTION END ===');
      return const LivenessCheckResult.failed('Need more frames');
    }

    final eyeStates = frames.map((f) => _getEyeState(f.face)).toList();
    print('📊 Eye states: ${eyeStates.map((s) => s.name).toList()}');
    print('📊 State distribution: ${_getStateDistribution(eyeStates)}');

    // Step 1: Basic blink pattern validation
    print('🔍 Step 1: Validating basic blink pattern...');
    final blinkPattern = _validateBlinkPattern(eyeStates);

    if (!blinkPattern.isValid) {
      final duration = DateTime.now().difference(startTime);
      print('❌ BLINK DETECTION FAILED: Basic pattern validation failed');
      print('   Reason: ${blinkPattern.failureReason}');
      print('   Duration: ${duration.inMilliseconds}ms');
      print('=== MULTI-FACTOR BLINK DETECTION END ===');
      return LivenessCheckResult.failed(
        blinkPattern.failureReason ?? 'Unknown blink pattern error',
      );
    }

    // Step 2: Multi-factor validation
    print('🔍 Step 2: Performing multi-factor validation...');
    final multiFactorResult = _validateMultiFactorBlink(
      frames,
      eyeStates,
      blinkPattern,
    );

    if (multiFactorResult.isValid) {
      final confidence = multiFactorResult.overallQuality;
      final duration = DateTime.now().difference(startTime);
      print('✅ MULTI-FACTOR BLINK DETECTION SUCCESS');
      print('   Pattern: ${blinkPattern.description}');
      print('   Multi-factor: ${multiFactorResult.description}');
      print('   Final confidence: ${(confidence * 100).round()}%');
      print('   Duration: ${duration.inMilliseconds}ms');
      print('=== MULTI-FACTOR BLINK DETECTION END ===');
      return LivenessCheckResult(
        confidence: confidence,
        reason:
            'Multi-factor validated blink: ${multiFactorResult.description}',
      );
    }

    final duration = DateTime.now().difference(startTime);
    print(
      '❌ MULTI-FACTOR BLINK DETECTION FAILED: ${multiFactorResult.failureReason}',
    );
    print('   Duration: ${duration.inMilliseconds}ms');
    print('=== MULTI-FACTOR BLINK DETECTION END ===');
    return LivenessCheckResult.failed(
      multiFactorResult.failureReason ?? 'Multi-factor validation failed',
    );
  }

  Map<String, int> _getStateDistribution(List<EyeState> states) {
    final distribution = <String, int>{};
    for (final state in states) {
      distribution[state.name] = (distribution[state.name] ?? 0) + 1;
    }
    return distribution;
  }

  List<String> _getSmoothingChanges(
    List<EyeState> original,
    List<EyeState> smoothed,
  ) {
    final changes = <String>[];
    for (int i = 0; i < original.length; i++) {
      if (original[i] != smoothed[i]) {
        changes.add('Frame $i: ${original[i].name} → ${smoothed[i].name}');
      }
    }
    return changes.isEmpty ? ['No changes'] : changes;
  }

  BlinkPatternResult _validateBlinkPattern(List<EyeState> eyeStates) {
    print('🔍 Validating blink pattern with ${eyeStates.length} frames');

    // Pre-process: handle unknown states by smoothing
    print('🔄 Applying smoothing algorithm...');
    final smoothedStates = _smoothEyeStates(eyeStates);
    print('📊 Smoothed states: ${smoothedStates.map((s) => s.name).toList()}');
    print(
      '📊 Smoothing changes: ${_getSmoothingChanges(eyeStates, smoothedStates)}',
    );

    // Find consecutive open frames at the beginning
    int openStartCount = 0;
    for (int i = 0; i < smoothedStates.length; i++) {
      if (smoothedStates[i] == EyeState.open) {
        openStartCount++;
      } else {
        break;
      }
    }

    print(
      '🔍 Checking open frames before blink: $openStartCount (required: ${LivenessConfig.minOpenFramesBeforeBlink})',
    );
    if (openStartCount < LivenessConfig.minOpenFramesBeforeBlink) {
      print('❌ FAILED: Insufficient open frames before blink');
      return BlinkPatternResult.invalid(
        'Insufficient open frames before blink: $openStartCount < ${LivenessConfig.minOpenFramesBeforeBlink}',
      );
    }
    print('✅ PASSED: Sufficient open frames before blink');

    // Find blink sequence: closed frames after open frames
    int closedStartIndex = openStartCount;
    int closedCount = 0;
    int unknownInClosed = 0;
    for (int i = closedStartIndex; i < smoothedStates.length; i++) {
      if (smoothedStates[i] == EyeState.closed) {
        closedCount++;
      } else if (smoothedStates[i] == EyeState.unknown) {
        unknownInClosed++;
        // Allow 1 unknown frame in closed sequence
        if (unknownInClosed > 1) break;
      } else {
        break;
      }
    }

    print(
      '🔍 Checking closed frames: $closedCount (max: ${LivenessConfig.maxBlinkDurationFrames})',
    );
    if (closedCount == 0) {
      print('❌ FAILED: No closed frames detected');
      return BlinkPatternResult.invalid('No closed frames detected');
    }

    if (closedCount > LivenessConfig.maxBlinkDurationFrames) {
      print('❌ FAILED: Blink duration too long');
      return BlinkPatternResult.invalid(
        'Blink duration too long: $closedCount > ${LivenessConfig.maxBlinkDurationFrames}',
      );
    }
    print('✅ PASSED: Valid blink duration');

    // Find consecutive open frames after blink
    int openAfterStartIndex = closedStartIndex + closedCount + unknownInClosed;
    int openAfterCount = 0;
    int unknownInOpenAfter = 0;
    for (int i = openAfterStartIndex; i < smoothedStates.length; i++) {
      if (smoothedStates[i] == EyeState.open) {
        openAfterCount++;
      } else if (smoothedStates[i] == EyeState.unknown) {
        unknownInOpenAfter++;
        // Allow 1 unknown frame in open sequence
        if (unknownInOpenAfter > 1) break;
      } else {
        break;
      }
    }

    print(
      '🔍 Checking open frames after blink: $openAfterCount (required: ${LivenessConfig.minOpenFramesAfterBlink})',
    );
    if (openAfterCount < LivenessConfig.minOpenFramesAfterBlink) {
      print('❌ FAILED: Insufficient open frames after blink');
      return BlinkPatternResult.invalid(
        'Insufficient open frames after blink: $openAfterCount < ${LivenessConfig.minOpenFramesAfterBlink}',
      );
    }
    print('✅ PASSED: Sufficient open frames after blink');

    // Validate total pattern length
    final totalPatternLength =
        openStartCount +
        closedCount +
        unknownInClosed +
        openAfterCount +
        unknownInOpenAfter;
    print(
      '🔍 Checking total pattern length: $totalPatternLength (required: ${LivenessConfig.minFramesForBlink})',
    );
    if (totalPatternLength < LivenessConfig.minFramesForBlink) {
      print('❌ FAILED: Pattern too short');
      return BlinkPatternResult.invalid(
        'Pattern too short: $totalPatternLength < ${LivenessConfig.minFramesForBlink}',
      );
    }
    print('✅ PASSED: Pattern length sufficient');

    // Calculate pattern quality metrics
    print('📊 Calculating pattern quality...');
    final patternQuality = _calculatePatternQuality(
      openStartCount,
      closedCount,
      openAfterCount,
      unknownInClosed + unknownInOpenAfter,
    );
    print('📊 Pattern quality: ${(patternQuality * 100).round()}%');

    print('✅ BLINK PATTERN VALIDATION SUCCESS');
    print(
      '   Pattern: Open($openStartCount) → Closed($closedCount) → Open($openAfterCount)',
    );
    print('   Unknown frames: ${unknownInClosed + unknownInOpenAfter}');
    print('   Total length: $totalPatternLength');

    return BlinkPatternResult.valid(
      openBeforeCount: openStartCount,
      closedCount: closedCount,
      openAfterCount: openAfterCount,
      totalLength: totalPatternLength,
      quality: patternQuality,
    );
  }

  List<EyeState> _smoothEyeStates(List<EyeState> states) {
    if (states.length < 3) return states;

    final smoothed = <EyeState>[];

    for (int i = 0; i < states.length; i++) {
      if (i == 0 || i == states.length - 1) {
        // Keep first and last states unchanged
        smoothed.add(states[i]);
      } else {
        // Apply 3-point smoothing: if middle is unknown, use majority of neighbors
        final prev = states[i - 1];
        final current = states[i];
        final next = states[i + 1];

        if (current == EyeState.unknown) {
          if (prev == next && prev != EyeState.unknown) {
            smoothed.add(prev); // Use neighbor state
          } else {
            smoothed.add(current); // Keep unknown
          }
        } else {
          smoothed.add(current);
        }
      }
    }

    return smoothed;
  }

  double _calculatePatternQuality(
    int openBeforeCount,
    int closedCount,
    int openAfterCount,
    int unknownCount,
  ) {
    double quality = 1.0;
    final adjustments = <String>[];

    // Penalty for unknown states (noise)
    if (unknownCount > 0) {
      final penalty = unknownCount * 0.1;
      quality -= penalty;
      adjustments.add('Unknown penalty: -${(penalty * 100).round()}%');
    }

    // Bonus for longer open periods (more stable)
    if (openBeforeCount > LivenessConfig.minOpenFramesBeforeBlink + 1) {
      quality += 0.05;
      adjustments.add('Long open before: +5%');
    }
    if (openAfterCount > LivenessConfig.minOpenFramesAfterBlink + 1) {
      quality += 0.05;
      adjustments.add('Long open after: +5%');
    }

    // Bonus for ideal blink duration (2-3 frames)
    if (closedCount >= 2 && closedCount <= 3) {
      quality += 0.1;
      adjustments.add('Ideal blink duration: +10%');
    } else if (closedCount == 1 || closedCount == 4) {
      quality += 0.05;
      adjustments.add('Good blink duration: +5%');
    }

    // Penalty for very short or very long blinks
    if (closedCount > 5) {
      quality -= 0.2;
      adjustments.add('Very long blink: -20%');
    }

    final finalQuality = quality.clamp(0.0, 1.0);
    print('📊 Quality calculation: ${adjustments.join(', ')}');
    print('📊 Final quality: ${(finalQuality * 100).round()}%');

    return finalQuality;
  }

  MultiFactorBlinkResult _validateMultiFactorBlink(
    List<LivenessFrame> frames,
    List<EyeState> eyeStates,
    BlinkPatternResult patternResult,
  ) {
    print('📊 Starting multi-factor blink validation...');

    // 1. Eye symmetry analysis
    final symmetryScore = _calculateEyeSymmetry(frames);
    print('📊 Eye symmetry score: ${(symmetryScore * 100).round()}%');

    // 2. Movement naturalness analysis
    final movementNaturalness = _calculateMovementNaturalness(
      frames,
      eyeStates,
    );
    print('📊 Movement naturalness: ${(movementNaturalness * 100).round()}%');

    // 3. Timing naturalness analysis
    final timingNaturalness = _calculateTimingNaturalness(frames, eyeStates);
    print('📊 Timing naturalness: ${(timingNaturalness * 100).round()}%');

    // 4. Calculate overall quality
    final overallQuality = _calculateMultiFactorBlinkQuality(
      symmetryScore: symmetryScore,
      movementNaturalness: movementNaturalness,
      timingNaturalness: timingNaturalness,
      patternQuality: patternResult.quality ?? 1.0,
    );
    print(
      '📊 Overall multi-factor quality: ${(overallQuality * 100).round()}%',
    );

    // 5. Validate all factors
    final isValid =
        symmetryScore >= LivenessConfig.minBlinkSymmetry &&
        movementNaturalness >= LivenessConfig.minMovementNaturalness &&
        timingNaturalness >= LivenessConfig.minTimingNaturalness &&
        overallQuality >= LivenessConfig.minMultiFactorBlinkQuality;

    if (isValid) {
      print('📊 Multi-factor validation: PASSED');
      return MultiFactorBlinkResult.valid(
        symmetryScore: symmetryScore,
        movementNaturalness: movementNaturalness,
        timingNaturalness: timingNaturalness,
        overallQuality: overallQuality,
        patternResult: patternResult,
      );
    } else {
      final reasons = <String>[];
      if (symmetryScore < LivenessConfig.minBlinkSymmetry) {
        reasons.add(
          'symmetry ${(symmetryScore * 100).round()}% < ${(LivenessConfig.minBlinkSymmetry * 100).round()}%',
        );
      }
      if (movementNaturalness < LivenessConfig.minMovementNaturalness) {
        reasons.add(
          'movement naturalness ${(movementNaturalness * 100).round()}% < ${(LivenessConfig.minMovementNaturalness * 100).round()}%',
        );
      }
      if (timingNaturalness < LivenessConfig.minTimingNaturalness) {
        reasons.add(
          'timing naturalness ${(timingNaturalness * 100).round()}% < ${(LivenessConfig.minTimingNaturalness * 100).round()}%',
        );
      }
      if (overallQuality < LivenessConfig.minMultiFactorBlinkQuality) {
        reasons.add(
          'overall quality ${(overallQuality * 100).round()}% < ${(LivenessConfig.minMultiFactorBlinkQuality * 100).round()}%',
        );
      }

      final reason = 'Multi-factor validation failed: ${reasons.join(', ')}';
      print('📊 Multi-factor validation: FAILED - $reason');
      return MultiFactorBlinkResult.invalid(reason, patternResult);
    }
  }

  double _calculateBlinkConfidence(BlinkPatternResult pattern) {
    print('📊 Calculating blink confidence...');

    // Use pattern quality as base confidence
    double confidence = pattern.quality ?? LivenessConfig.successConfidence;
    print(
      '📊 Base confidence (pattern quality): ${(confidence * 100).round()}%',
    );

    final adjustments = <String>[];

    // Additional adjustments based on pattern characteristics
    final idealClosedCount = 2; // Ideal blink duration
    final closedCountDiff = (pattern.closedCount - idealClosedCount).abs();

    // Fine-tune confidence based on blink duration
    if (closedCountDiff == 0) {
      confidence += 0.05; // Perfect duration
      adjustments.add('Perfect duration: +5%');
    } else if (closedCountDiff == 1) {
      confidence += 0.02; // Good duration
      adjustments.add('Good duration: +2%');
    } else {
      confidence -= 0.05; // Penalty for non-ideal duration
      adjustments.add('Non-ideal duration: -5%');
    }

    // Bonus for longer open periods (more stable)
    if (pattern.openBeforeCount > LivenessConfig.minOpenFramesBeforeBlink + 1) {
      confidence += 0.03;
      adjustments.add('Stable open before: +3%');
    }
    if (pattern.openAfterCount > LivenessConfig.minOpenFramesAfterBlink + 1) {
      confidence += 0.03;
      adjustments.add('Stable open after: +3%');
    }

    final finalConfidence = confidence.clamp(0.0, 1.0);
    print('📊 Confidence adjustments: ${adjustments.join(', ')}');
    print('📊 Final confidence: ${(finalConfidence * 100).round()}%');

    return finalConfidence;
  }

  LivenessCheckResult _detectStability(
    List<LivenessFrame> frames,
    AdaptiveThresholdResult adaptiveThresholds,
  ) {
    final startTime = DateTime.now();
    print('=== STABILITY DETECTION START ===');
    print('Input frames: ${frames.length}');
    print('Required frames: ${LivenessConfig.minFramesForStability}');

    if (frames.length < LivenessConfig.minFramesForStability) {
      final duration = DateTime.now().difference(startTime);
      print('❌ STABILITY DETECTION FAILED: Insufficient frames');
      print('   Duration: ${duration.inMilliseconds}ms');
      print('=== STABILITY DETECTION END ===');
      return const LivenessCheckResult.failed('Need more frames');
    }

    // Calculate movement pattern analysis
    print('🔍 Analyzing movement pattern...');
    final stabilityAnalysis = _analyzeStabilityPattern(frames);

    if (stabilityAnalysis.isValid) {
      final confidence = _calculateStabilityConfidence(stabilityAnalysis);
      final duration = DateTime.now().difference(startTime);
      print('✅ STABILITY DETECTION SUCCESS');
      print(
        '   Overall movement: ${stabilityAnalysis.overallMovement.toStringAsFixed(2)}px',
      );
      print(
        '   Movement variance: ${stabilityAnalysis.movementVariance.toStringAsFixed(2)}px',
      );
      print(
        '   Consecutive stable frames: ${stabilityAnalysis.consecutiveStableFrames}',
      );
      print('   Confidence: ${(confidence * 100).round()}%');
      print('   Duration: ${duration.inMilliseconds}ms');
      print('=== STABILITY DETECTION END ===');
      return LivenessCheckResult(
        confidence: confidence,
        reason: 'Face movement is stable: ${stabilityAnalysis.description}',
      );
    }

    final duration = DateTime.now().difference(startTime);
    print('❌ STABILITY DETECTION FAILED: ${stabilityAnalysis.failureReason}');
    print('   Duration: ${duration.inMilliseconds}ms');
    print('=== STABILITY DETECTION END ===');
    return LivenessCheckResult.failed(
      stabilityAnalysis.failureReason ?? 'Unknown stability error',
    );
  }

  StabilityAnalysisResult _analyzeStabilityPattern(List<LivenessFrame> frames) {
    print('📊 Calculating face centers...');
    final centers = frames.map((f) => f.face.boundingBox.center).toList();
    print(
      '📊 Face centers: ${centers.map((c) => '(${c.dx.toStringAsFixed(1)}, ${c.dy.toStringAsFixed(1)})').toList()}',
    );

    // Calculate overall movement (first to last)
    final overallMovement = (centers.first - centers.last).distance;
    print('📊 Overall movement calculation:');
    print(
      '   First center: (${centers.first.dx.toStringAsFixed(1)}, ${centers.first.dy.toStringAsFixed(1)})',
    );
    print(
      '   Last center: (${centers.last.dx.toStringAsFixed(1)}, ${centers.last.dy.toStringAsFixed(1)})',
    );
    print(
      '   Distance: ${overallMovement.toStringAsFixed(2)}px (max: ${LivenessConfig.maxStabilityMovement}px)',
    );

    if (overallMovement > LivenessConfig.maxStabilityMovement) {
      print('❌ FAILED: Excessive overall movement');
      return StabilityAnalysisResult.invalid(
        'Excessive overall movement: ${overallMovement.toStringAsFixed(2)}px > ${LivenessConfig.maxStabilityMovement}px',
      );
    }
    print('✅ PASSED: Overall movement within limits');

    // Calculate movement variance
    print('📊 Calculating movement variance...');
    final movements = <double>[];
    for (int i = 1; i < centers.length; i++) {
      final movement = (centers[i] - centers[i - 1]).distance;
      movements.add(movement);
      print('   Frame ${i - 1} → ${i}: ${movement.toStringAsFixed(2)}px');
    }
    print(
      '📊 Individual movements: ${movements.map((m) => m.toStringAsFixed(2)).toList()}',
    );

    final movementVariance = _calculateVariance(movements);
    print('📊 Movement variance calculation:');
    print(
      '   Mean: ${(movements.reduce((a, b) => a + b) / movements.length).toStringAsFixed(2)}px',
    );
    print(
      '   Variance: ${movementVariance.toStringAsFixed(2)}px (max: ${LivenessConfig.maxMovementVariance}px)',
    );

    if (movementVariance > LivenessConfig.maxMovementVariance) {
      print('❌ FAILED: Excessive movement variance');
      return StabilityAnalysisResult.invalid(
        'Excessive movement variance: ${movementVariance.toStringAsFixed(2)}px > ${LivenessConfig.maxMovementVariance}px',
      );
    }
    print('✅ PASSED: Movement variance within limits');

    // Check consecutive stable frames
    print('📊 Analyzing consecutive stable frames...');
    final consecutiveStableFrames = _countConsecutiveStableFrames(movements);
    print(
      '📊 Consecutive stable frames: $consecutiveStableFrames (required: ${LivenessConfig.minStableFrames})',
    );

    if (consecutiveStableFrames < LivenessConfig.minStableFrames) {
      print('❌ FAILED: Insufficient consecutive stable frames');
      return StabilityAnalysisResult.invalid(
        'Insufficient consecutive stable frames: $consecutiveStableFrames < ${LivenessConfig.minStableFrames}',
      );
    }
    print('✅ PASSED: Sufficient consecutive stable frames');

    print('✅ STABILITY PATTERN ANALYSIS SUCCESS');
    print('   Overall movement: ${overallMovement.toStringAsFixed(2)}px');
    print('   Movement variance: ${movementVariance.toStringAsFixed(2)}px');
    print('   Consecutive stable: ${consecutiveStableFrames}frames');
    print('   Total frames: ${frames.length}');

    return StabilityAnalysisResult.valid(
      overallMovement: overallMovement,
      movementVariance: movementVariance,
      consecutiveStableFrames: consecutiveStableFrames,
      totalFrames: frames.length,
    );
  }

  double _calculateVariance(List<double> values) {
    if (values.isEmpty) return 0.0;

    final mean = values.reduce((a, b) => a + b) / values.length;
    print('📊 Variance calculation:');
    print('   Values: ${values.map((v) => v.toStringAsFixed(2)).toList()}');
    print('   Mean: ${mean.toStringAsFixed(2)}');

    final squaredDifferences = values.map((v) => (v - mean) * (v - mean));
    print(
      '   Squared differences: ${squaredDifferences.map((d) => d.toStringAsFixed(2)).toList()}',
    );

    final variance = squaredDifferences.reduce((a, b) => a + b) / values.length;
    print('   Variance: ${variance.toStringAsFixed(2)}');

    return variance;
  }

  int _countConsecutiveStableFrames(List<double> movements) {
    int maxConsecutive = 0;
    int currentConsecutive = 0;
    final stableThreshold = LivenessConfig.maxStabilityMovement / 2;

    print('📊 Consecutive stable frames analysis:');
    print('   Stable threshold: ${stableThreshold.toStringAsFixed(2)}px');

    for (int i = 0; i < movements.length; i++) {
      final movement = movements[i];
      if (movement < stableThreshold) {
        currentConsecutive++;
        print(
          '   Frame ${i + 1}: ${movement.toStringAsFixed(2)}px (stable, count: $currentConsecutive)',
        );
        maxConsecutive =
            maxConsecutive > currentConsecutive
                ? maxConsecutive
                : currentConsecutive;
      } else {
        print(
          '   Frame ${i + 1}: ${movement.toStringAsFixed(2)}px (unstable, reset count)',
        );
        currentConsecutive = 0;
      }
    }

    print('   Max consecutive stable frames: $maxConsecutive');
    return maxConsecutive;
  }

  double _calculateStabilityConfidence(StabilityAnalysisResult analysis) {
    print('📊 Calculating stability confidence...');

    double confidence = LivenessConfig.successConfidence;
    final adjustments = <String>[];

    // Base scoring based on overall movement (40% weight)
    final movementScore = _calculateMovementScore(analysis.overallMovement);
    confidence *= 0.6 + (movementScore * 0.4);
    adjustments.add('Movement score: ${(movementScore * 100).round()}%');

    // Variance scoring (30% weight)
    final varianceScore = _calculateVarianceScore(analysis.movementVariance);
    confidence *= 0.7 + (varianceScore * 0.3);
    adjustments.add('Variance score: ${(varianceScore * 100).round()}%');

    // Consecutive stable frames scoring (20% weight)
    final stabilityScore = _calculateStabilityScore(
      analysis.consecutiveStableFrames,
    );
    confidence *= 0.8 + (stabilityScore * 0.2);
    adjustments.add('Stability score: ${(stabilityScore * 100).round()}%');

    // Pattern consistency bonus (10% weight)
    final patternBonus = _calculatePatternBonus(analysis);
    confidence += patternBonus;
    if (patternBonus > 0) {
      adjustments.add('Pattern bonus: +${(patternBonus * 100).round()}%');
    }

    final finalConfidence = confidence.clamp(0.0, 1.0);
    print('📊 Stability scoring breakdown:');
    print('   Movement: ${(movementScore * 100).round()}% (40% weight)');
    print('   Variance: ${(varianceScore * 100).round()}% (30% weight)');
    print('   Stability: ${(stabilityScore * 100).round()}% (20% weight)');
    print('   Pattern: +${(patternBonus * 100).round()}% (10% weight)');
    print('📊 Final stability confidence: ${(finalConfidence * 100).round()}%');

    return finalConfidence;
  }

  double _calculateMovementScore(double overallMovement) {
    final ratio = overallMovement / LivenessConfig.maxStabilityMovement;

    if (ratio <= 0.2) return 1.0; // Excellent
    if (ratio <= 0.4) return 0.9; // Very good
    if (ratio <= 0.6) return 0.7; // Good
    if (ratio <= 0.8) return 0.5; // Fair
    if (ratio <= 1.0) return 0.3; // Poor
    return 0.0; // Very poor
  }

  double _calculateVarianceScore(double variance) {
    final ratio = variance / LivenessConfig.maxMovementVariance;

    if (ratio <= 0.2) return 1.0; // Very consistent
    if (ratio <= 0.4) return 0.9; // Consistent
    if (ratio <= 0.6) return 0.7; // Moderate
    if (ratio <= 0.8) return 0.5; // Inconsistent
    if (ratio <= 1.0) return 0.3; // Very inconsistent
    return 0.0; // Erratic
  }

  double _calculateStabilityScore(int consecutiveStableFrames) {
    if (consecutiveStableFrames >= 6) return 1.0; // Excellent stability
    if (consecutiveStableFrames >= 5) return 0.9; // Very stable
    if (consecutiveStableFrames >= 4) return 0.8; // Stable
    if (consecutiveStableFrames >= 3) return 0.7; // Adequate
    if (consecutiveStableFrames >= 2) return 0.5; // Poor
    return 0.0; // Very poor
  }

  double _calculatePatternBonus(StabilityAnalysisResult analysis) {
    double bonus = 0.0;

    // Bonus for very low movement and variance
    final movementRatio =
        analysis.overallMovement / LivenessConfig.maxStabilityMovement;
    final varianceRatio =
        analysis.movementVariance / LivenessConfig.maxMovementVariance;

    if (movementRatio < 0.2 && varianceRatio < 0.2) {
      bonus += 0.05; // Very stable pattern
    } else if (movementRatio < 0.3 && varianceRatio < 0.3) {
      bonus += 0.03; // Stable pattern
    }

    // Bonus for long consecutive stable periods
    if (analysis.consecutiveStableFrames >= 5) {
      bonus += 0.02; // Long stable period
    }

    // Bonus for consistent movement pattern (low variance relative to movement)
    if (analysis.overallMovement > 0 &&
        analysis.movementVariance / analysis.overallMovement < 0.5) {
      bonus += 0.02; // Consistent pattern
    }

    return bonus;
  }

  TemporalAnalysisResult _analyzeTemporalPattern(List<LivenessFrame> frames) {
    print(
      '📊 Starting temporal pattern analysis for ${frames.length} frames...',
    );

    if (frames.length < 2) {
      print('📊 Insufficient frames for temporal analysis');
      return TemporalAnalysisResult.invalid(
        'Insufficient frames for temporal analysis',
      );
    }

    // Calculate frame intervals
    final frameIntervals = <double>[];
    for (int i = 1; i < frames.length; i++) {
      final interval =
          frames[i].timestamp
              .difference(frames[i - 1].timestamp)
              .inMilliseconds
              .toDouble();
      frameIntervals.add(interval);
    }

    print(
      '📊 Frame intervals: ${frameIntervals.map((i) => i.toStringAsFixed(1)).toList()}ms',
    );

    // Calculate timing consistency
    final timingConsistency = _calculateTimingConsistency(frameIntervals);
    print('📊 Timing consistency: ${(timingConsistency * 100).round()}%');

    // Calculate pattern naturalness
    final patternNaturalness = _calculatePatternNaturalness(frameIntervals);
    print('📊 Pattern naturalness: ${(patternNaturalness * 100).round()}%');

    // Calculate frame rate stability
    final frameRateStability = _calculateFrameRateStability(frameIntervals);
    print('📊 Frame rate stability: ${(frameRateStability * 100).round()}%');

    // Calculate average interval and variance
    final averageInterval =
        frameIntervals.reduce((a, b) => a + b) / frameIntervals.length;
    final intervalVariance = _calculateVariance(frameIntervals);

    print(
      '📊 Average interval: ${averageInterval.toStringAsFixed(1)}ms (expected: ${LivenessConfig.expectedFrameInterval.toStringAsFixed(1)}ms)',
    );
    print('📊 Interval variance: ${intervalVariance.toStringAsFixed(2)}');

    // Validate temporal pattern
    final isValid =
        timingConsistency >= LivenessConfig.minTimingConsistency &&
        patternNaturalness >= LivenessConfig.minPatternNaturalness &&
        frameRateStability >= LivenessConfig.minFrameRateStability;

    if (isValid) {
      print('📊 Temporal analysis: PASSED');
      return TemporalAnalysisResult.valid(
        timingConsistency: timingConsistency,
        patternNaturalness: patternNaturalness,
        frameRateStability: frameRateStability,
        frameIntervals: frameIntervals,
        averageInterval: averageInterval,
        intervalVariance: intervalVariance,
      );
    } else {
      final reasons = <String>[];
      if (timingConsistency < LivenessConfig.minTimingConsistency) {
        reasons.add(
          'timing consistency ${(timingConsistency * 100).round()}% < ${(LivenessConfig.minTimingConsistency * 100).round()}%',
        );
      }
      if (patternNaturalness < LivenessConfig.minPatternNaturalness) {
        reasons.add(
          'pattern naturalness ${(patternNaturalness * 100).round()}% < ${(LivenessConfig.minPatternNaturalness * 100).round()}%',
        );
      }
      if (frameRateStability < LivenessConfig.minFrameRateStability) {
        reasons.add(
          'frame rate stability ${(frameRateStability * 100).round()}% < ${(LivenessConfig.minFrameRateStability * 100).round()}%',
        );
      }

      final reason = 'Temporal analysis failed: ${reasons.join(', ')}';
      print('📊 Temporal analysis: FAILED - $reason');
      return TemporalAnalysisResult.invalid(reason);
    }
  }

  LivenessCheckResult _checkQuality(
    List<LivenessFrame> frames,
    AdaptiveThresholdResult adaptiveThresholds,
  ) {
    print('📊 Starting enhanced quality check for ${frames.length} frames...');

    if (frames.isEmpty) {
      print('📊 No frames to check quality');
      return LivenessCheckResult(
        confidence: 0.0,
        reason: 'No frames available',
      );
    }

    // Enhanced multi-factor quality analysis
    final qualityScores = <double>[];

    for (int i = 0; i < frames.length; i++) {
      final frame = frames[i];
      final face = frame.face;

      print('📊 Analyzing frame ${i + 1} quality...');

      // 1. Face size validation with aspect ratio check
      final faceSize = face.boundingBox.width * face.boundingBox.height;
      final minFaceSize =
          LivenessConfig.minFaceSize * LivenessConfig.minFaceSize;
      final maxFaceSize =
          LivenessConfig.maxFaceSize * LivenessConfig.maxFaceSize;

      final faceSizeScore = _calculateFaceSizeScore(
        faceSize,
        minFaceSize,
        maxFaceSize,
      );
      print(
        '📊 Frame ${i + 1} - Face size: ${faceSize.toStringAsFixed(0)}, Score: ${faceSizeScore.toStringAsFixed(3)}',
      );

      if (faceSize < minFaceSize) {
        print(
          '📊 Frame ${i + 1} - Face size too small: ${faceSize.toStringAsFixed(0)} < ${minFaceSize.toStringAsFixed(0)}',
        );
        qualityScores.add(0.0);
        continue;
      }

      if (faceSize > maxFaceSize) {
        print(
          '📊 Frame ${i + 1} - Face size too large: ${faceSize.toStringAsFixed(0)} > ${maxFaceSize.toStringAsFixed(0)}',
        );
        qualityScores.add(0.0);
        continue;
      }

      // 2. Face aspect ratio validation
      final aspectRatio = face.boundingBox.width / face.boundingBox.height;
      final aspectRatioScore = _calculateAspectRatioScore(aspectRatio);
      print(
        '📊 Frame ${i + 1} - Aspect ratio: ${aspectRatio.toStringAsFixed(3)}, Score: ${aspectRatioScore.toStringAsFixed(3)}',
      );

      // 3. Head angle validation (existing logic enhanced)
      final angleY =
          face.headEulerAngleY?.abs() ?? LivenessConfig.fallbackAngle;
      final angleZ =
          face.headEulerAngleZ?.abs() ?? LivenessConfig.fallbackAngle;
      final headAngleScore = _calculateHeadAngleScore(angleY, angleZ);
      print(
        '📊 Frame ${i + 1} - Head angles: Y=${angleY.toStringAsFixed(1)}°, Z=${angleZ.toStringAsFixed(1)}°, Score: ${headAngleScore.toStringAsFixed(3)}',
      );

      // 4. Face position validation (center of frame)
      // Note: Using default position score since image size is not available in LivenessFrame
      final positionScore = 1.0; // Default to good position score
      print(
        '📊 Frame ${i + 1} - Position score: ${positionScore.toStringAsFixed(3)} (default)',
      );

      // 5. Lighting quality check (not available in current LivenessFrame)
      final lightingScore = 1.0; // Default to good lighting score
      print(
        '📊 Frame ${i + 1} - Lighting score: ${lightingScore.toStringAsFixed(3)} (default)',
      );

      // 6. Multi-factor quality scoring
      final frameQualityScore = _calculateFrameQualityScore(
        faceSizeScore: faceSizeScore,
        aspectRatioScore: aspectRatioScore,
        headAngleScore: headAngleScore,
        positionScore: positionScore,
        lightingScore: lightingScore,
      );

      print(
        '📊 Frame ${i + 1} - Overall quality score: ${frameQualityScore.toStringAsFixed(3)}',
      );
      qualityScores.add(frameQualityScore);
    }

    // Calculate overall quality metrics
    final averageQuality =
        qualityScores.reduce((a, b) => a + b) / qualityScores.length;
    final goodFrames =
        qualityScores
            .where((score) => score >= LivenessConfig.minOverallQuality)
            .length;
    final qualityRatio = goodFrames / frames.length;

    print('📊 Quality analysis summary:');
    print('   Average quality score: ${averageQuality.toStringAsFixed(3)}');
    print(
      '   Good frames: $goodFrames/${frames.length} (${(qualityRatio * 100).round()}%)',
    );
    print(
      '   Quality ratio threshold: ${(LivenessConfig.minQualityFrameRatio * 100).round()}%',
    );

    final passed =
        qualityRatio >= LivenessConfig.minQualityFrameRatio &&
        averageQuality >= LivenessConfig.minOverallQuality;

    final reason =
        passed
            ? 'Good image quality (${(averageQuality * 100).round()}% avg, ${(qualityRatio * 100).round()}% good frames)'
            : 'Poor image quality (${(averageQuality * 100).round()}% avg, ${(qualityRatio * 100).round()}% good frames)';

    print('📊 Quality check result: ${passed ? 'PASSED' : 'FAILED'} - $reason');

    return LivenessCheckResult(confidence: averageQuality, reason: reason);
  }

  double _calculateOverallConfidence(
    LivenessCheckResult blink,
    LivenessCheckResult stability,
    LivenessCheckResult quality,
    TemporalAnalysisResult temporal,
  ) {
    print('📊 Starting enhanced overall confidence calculation...');

    // Base weighted calculation
    final baseConfidence =
        blink.confidence * LivenessConfig.blinkWeight +
        quality.confidence * LivenessConfig.qualityWeight +
        stability.confidence * LivenessConfig.stabilityWeight;

    print('📊 Base confidence: ${(baseConfidence * 100).round()}%');
    print('📊 Component breakdown:');
    print(
      '   Blink: ${(blink.confidence * 100).round()}% (weight: ${(LivenessConfig.blinkWeight * 100).round()}%)',
    );
    print(
      '   Quality: ${(quality.confidence * 100).round()}% (weight: ${(LivenessConfig.qualityWeight * 100).round()}%)',
    );
    print(
      '   Stability: ${(stability.confidence * 100).round()}% (weight: ${(LivenessConfig.stabilityWeight * 100).round()}%)',
    );

    // Multi-factor confidence enhancement
    final enhancedConfidence = _calculateEnhancedConfidence(
      baseConfidence: baseConfidence,
      blink: blink,
      stability: stability,
      quality: quality,
      temporal: temporal,
    );

    print('📊 Enhanced confidence: ${(enhancedConfidence * 100).round()}%');
    print(
      '📊 Confidence improvement: ${((enhancedConfidence - baseConfidence) * 100).round()}%',
    );

    return enhancedConfidence;
  }

  double _calculateEnhancedConfidence({
    required double baseConfidence,
    required LivenessCheckResult blink,
    required LivenessCheckResult stability,
    required LivenessCheckResult quality,
    required TemporalAnalysisResult temporal,
  }) {
    double confidence = baseConfidence;
    final adjustments = <String>[];

    // 1. Consistency bonus: Reward when all components are high
    final consistencyBonus = _calculateConsistencyBonus(
      blink,
      stability,
      quality,
    );
    if (consistencyBonus > 0) {
      confidence += consistencyBonus;
      adjustments.add(
        'Consistency bonus: +${(consistencyBonus * 100).round()}%',
      );
    }

    // 2. Quality floor protection: Penalize if quality is too low
    final qualityPenalty = _calculateQualityPenalty(quality);
    if (qualityPenalty > 0) {
      confidence -= qualityPenalty;
      adjustments.add('Quality penalty: -${(qualityPenalty * 100).round()}%');
    }

    // 3. Blink pattern bonus: Reward natural blink patterns
    final blinkBonus = _calculateBlinkPatternBonus(blink);
    if (blinkBonus > 0) {
      confidence += blinkBonus;
      adjustments.add('Blink pattern bonus: +${(blinkBonus * 100).round()}%');
    }

    // 4. Stability consistency bonus: Reward consistent stability
    final stabilityBonus = _calculateStabilityBonus(stability);
    if (stabilityBonus > 0) {
      confidence += stabilityBonus;
      adjustments.add('Stability bonus: +${(stabilityBonus * 100).round()}%');
    }

    // 5. Temporal analysis bonus/penalty
    final temporalAdjustment = _calculateTemporalAdjustment(temporal);
    if (temporalAdjustment != 0) {
      confidence += temporalAdjustment;
      if (temporalAdjustment > 0) {
        adjustments.add(
          'Temporal bonus: +${(temporalAdjustment * 100).round()}%',
        );
      } else {
        adjustments.add(
          'Temporal penalty: ${(temporalAdjustment * 100).round()}%',
        );
      }
    }

    // 6. Anti-spoofing penalty: Penalize suspicious patterns
    final spoofingPenalty = _calculateSpoofingPenalty(
      blink,
      stability,
      quality,
      temporal,
    );
    if (spoofingPenalty > 0) {
      confidence -= spoofingPenalty;
      adjustments.add(
        'Anti-spoofing penalty: -${(spoofingPenalty * 100).round()}%',
      );
    }

    final finalConfidence = confidence.clamp(0.0, 1.0);

    if (adjustments.isNotEmpty) {
      print('📊 Confidence adjustments: ${adjustments.join(', ')}');
    }

    return finalConfidence;
  }

  double _calculateConsistencyBonus(
    LivenessCheckResult blink,
    LivenessCheckResult stability,
    LivenessCheckResult quality,
  ) {
    // Reward when all components are above 80%
    const highThreshold = 0.8;
    const bonusMultiplier = 0.05; // 5% bonus

    final highComponents =
        [
          blink.confidence,
          stability.confidence,
          quality.confidence,
        ].where((score) => score >= highThreshold).length;

    if (highComponents == 3) {
      return bonusMultiplier; // All components high
    } else if (highComponents == 2) {
      return bonusMultiplier * 0.5; // Two components high
    }

    return 0.0;
  }

  double _calculateQualityPenalty(LivenessCheckResult quality) {
    // Penalize if quality is below 50%
    const lowThreshold = 0.5;
    const penaltyMultiplier = 0.1; // 10% penalty

    if (quality.confidence < lowThreshold) {
      return penaltyMultiplier *
          (lowThreshold - quality.confidence) /
          lowThreshold;
    }

    return 0.0;
  }

  double _calculateBlinkPatternBonus(LivenessCheckResult blink) {
    // Reward natural blink patterns (confidence > 90%)
    const highConfidenceThreshold = 0.9;
    const bonusMultiplier = 0.03; // 3% bonus

    if (blink.confidence >= highConfidenceThreshold) {
      return bonusMultiplier;
    }

    return 0.0;
  }

  double _calculateStabilityBonus(LivenessCheckResult stability) {
    // Reward high stability (confidence > 85%)
    const highConfidenceThreshold = 0.85;
    const bonusMultiplier = 0.02; // 2% bonus

    if (stability.confidence >= highConfidenceThreshold) {
      return bonusMultiplier;
    }

    return 0.0;
  }

  double _calculateTemporalAdjustment(TemporalAnalysisResult temporal) {
    if (!temporal.isValid) {
      return -0.1; // 10% penalty for invalid temporal patterns
    }

    double adjustment = 0.0;

    // Bonus for excellent timing consistency
    if (temporal.timingConsistency >= 0.9) {
      adjustment += 0.03; // 3% bonus
    } else if (temporal.timingConsistency >= 0.8) {
      adjustment += 0.02; // 2% bonus
    }

    // Bonus for natural patterns
    if (temporal.patternNaturalness >= 0.9) {
      adjustment += 0.02; // 2% bonus
    }

    // Bonus for stable frame rate
    if (temporal.frameRateStability >= 0.95) {
      adjustment += 0.02; // 2% bonus
    }

    // Penalty for suspicious patterns
    if (temporal.patternNaturalness < 0.4) {
      adjustment -= 0.05; // 5% penalty for unnatural patterns
    }

    return adjustment;
  }

  double _calculateSpoofingPenalty(
    LivenessCheckResult blink,
    LivenessCheckResult stability,
    LivenessCheckResult quality,
    TemporalAnalysisResult temporal,
  ) {
    double penalty = 0.0;

    // 1. Penalize perfect scores (too good to be true)
    if (blink.confidence > 0.98 && stability.confidence > 0.98) {
      penalty += 0.05; // 5% penalty for suspiciously perfect scores
    }

    // 2. Penalize inconsistent patterns
    final scoreVariance = _calculateScoreVariance([
      blink.confidence,
      stability.confidence,
      quality.confidence,
    ]);

    if (scoreVariance > 0.3) {
      // High variance indicates inconsistency
      penalty += 0.03; // 3% penalty
    }

    // 3. Penalize if quality is high but other scores are low (suspicious)
    if (quality.confidence > 0.8 &&
        (blink.confidence < 0.6 || stability.confidence < 0.6)) {
      penalty += 0.04; // 4% penalty
    }

    // 4. Penalize suspicious temporal patterns
    if (temporal.isValid && temporal.patternNaturalness < 0.3) {
      penalty += 0.03; // 3% penalty for very unnatural patterns
    }

    // 5. Penalize if temporal analysis is invalid
    if (!temporal.isValid) {
      penalty += 0.02; // 2% penalty for invalid temporal patterns
    }

    return penalty;
  }

  double _calculateScoreVariance(List<double> scores) {
    if (scores.isEmpty) return 0.0;

    final mean = scores.reduce((a, b) => a + b) / scores.length;
    final squaredDifferences = scores.map(
      (score) => (score - mean) * (score - mean),
    );
    final variance = squaredDifferences.reduce((a, b) => a + b) / scores.length;

    return variance;
  }

  bool _isFrameQualityGood(Face face) {
    final angleY = face.headEulerAngleY?.abs() ?? LivenessConfig.fallbackAngle;
    final angleZ = face.headEulerAngleZ?.abs() ?? LivenessConfig.fallbackAngle;
    return angleY < LivenessConfig.maxHeadAngleY &&
        angleZ < LivenessConfig.maxHeadAngleZ;
  }

  EyeState _getEyeState(Face face) {
    final left = face.leftEyeOpenProbability;
    final right = face.rightEyeOpenProbability;
    print('left open probability: $left, right open probability: $right');

    if (left == null || right == null) return EyeState.unknown;

    final avg = (left + right) / LivenessConfig.eyeProbabilityDivisor;
    print('average eye probability: $avg');

    if (avg >= LivenessConfig.eyeOpenProbability) {
      print('eye is open');
      return EyeState.open;
    }
    if (avg <= LivenessConfig.eyeClosedProbability) {
      print('eye is closed');
      return EyeState.closed;
    }
    return EyeState.unknown;
  }

  // Quality validation helper methods

  double _calculateFaceSizeScore(
    double faceSize,
    double minSize,
    double maxSize,
  ) {
    if (faceSize < minSize || faceSize > maxSize) return 0.0;

    // Optimal size is in the middle range
    final optimalSize = (minSize + maxSize) / 2;
    final sizeDifference = (faceSize - optimalSize).abs();
    final maxDifference = (maxSize - minSize) / 2;

    // Score decreases as we move away from optimal size
    final score = 1.0 - (sizeDifference / maxDifference);
    return score.clamp(0.0, 1.0);
  }

  double _calculateAspectRatioScore(double aspectRatio) {
    // Ideal aspect ratio is close to 1.0 (square-ish face)
    const idealRatio = 1.0;
    const tolerance = 0.3; // Allow 30% deviation

    final difference = (aspectRatio - idealRatio).abs();
    if (difference <= tolerance) {
      return 1.0; // Perfect aspect ratio
    }

    // Score decreases linearly with deviation
    final score = 1.0 - (difference - tolerance) / tolerance;
    return score.clamp(0.0, 1.0);
  }

  double _calculateHeadAngleScore(double angleY, double angleZ) {
    // Score based on how close angles are to 0 (front-facing)
    final maxAngleY = LivenessConfig.maxHeadAngleY;
    final maxAngleZ = LivenessConfig.maxHeadAngleZ;

    final scoreY = 1.0 - (angleY / maxAngleY);
    final scoreZ = 1.0 - (angleZ / maxAngleZ);

    // Use the worse of the two angles
    final minScore = scoreY < scoreZ ? scoreY : scoreZ;
    return minScore.clamp(0.0, 1.0);
  }

  double _calculatePositionScore(Rect boundingBox, Size? imageSize) {
    if (imageSize == null) return 1.0; // Can't calculate without image size

    // Calculate center of face
    final faceCenterX = boundingBox.left + boundingBox.width / 2;
    final faceCenterY = boundingBox.top + boundingBox.height / 2;

    // Calculate center of image
    final imageCenterX = imageSize.width / 2;
    final imageCenterY = imageSize.height / 2;

    // Calculate distance from center
    final distanceX = (faceCenterX - imageCenterX).abs();
    final distanceY = (faceCenterY - imageCenterY).abs();

    // Normalize by image dimensions
    final normalizedDistanceX = distanceX / imageSize.width;
    final normalizedDistanceY = distanceY / imageSize.height;

    // Score decreases with distance from center
    final maxDistance = 0.3; // Allow 30% deviation from center
    final scoreX = 1.0 - (normalizedDistanceX / maxDistance);
    final scoreY = 1.0 - (normalizedDistanceY / maxDistance);

    // Use the worse of the two dimensions
    final minScore = scoreX < scoreY ? scoreX : scoreY;
    return minScore.clamp(0.0, 1.0);
  }

  double _calculateLightingScore(double lightingQuality) {
    // Simple linear scoring based on lighting quality
    return lightingQuality.clamp(0.0, 1.0);
  }

  double _calculateFrameQualityScore({
    required double faceSizeScore,
    required double aspectRatioScore,
    required double headAngleScore,
    required double positionScore,
    required double lightingScore,
  }) {
    // Weighted combination of all quality factors
    const weights = {
      'faceSize': 0.25,
      'aspectRatio': 0.15,
      'headAngle': 0.30,
      'position': 0.20,
      'lighting': 0.10,
    };

    final weightedScore =
        faceSizeScore * weights['faceSize']! +
        aspectRatioScore * weights['aspectRatio']! +
        headAngleScore * weights['headAngle']! +
        positionScore * weights['position']! +
        lightingScore * weights['lighting']!;

    return weightedScore.clamp(0.0, 1.0);
  }

  // Temporal analysis helper methods

  double _calculateTimingConsistency(List<double> intervals) {
    if (intervals.isEmpty) return 0.0;

    final expectedInterval = LivenessConfig.expectedFrameInterval;
    final consistencyScores = <double>[];

    for (final interval in intervals) {
      final deviation = (interval - expectedInterval).abs() / expectedInterval;
      final score = 1.0 - deviation.clamp(0.0, 1.0);
      consistencyScores.add(score);
    }

    return consistencyScores.reduce((a, b) => a + b) / consistencyScores.length;
  }

  double _calculatePatternNaturalness(List<double> intervals) {
    if (intervals.length < 3) {
      return 1.0; // Not enough data for pattern analysis
    }

    // Check for natural variations (not too uniform, not too erratic)
    final variance = _calculateVariance(intervals);
    final mean = intervals.reduce((a, b) => a + b) / intervals.length;
    final coefficientOfVariation = variance / (mean * mean);

    // Natural patterns have moderate variation (not too perfect, not too chaotic)
    if (coefficientOfVariation < 0.05) {
      return 0.3; // Too uniform (suspicious)
    } else if (coefficientOfVariation > 0.5) {
      return 0.4; // Too erratic (suspicious)
    } else {
      return 1.0; // Natural variation
    }
  }

  double _calculateFrameRateStability(List<double> intervals) {
    if (intervals.isEmpty) return 0.0;

    final expectedInterval = LivenessConfig.expectedFrameInterval;
    final maxVariance =
        expectedInterval * LivenessConfig.maxFrameIntervalVariance;

    // Calculate how many intervals are within acceptable variance
    int stableIntervals = 0;
    for (final interval in intervals) {
      final deviation = (interval - expectedInterval).abs();
      if (deviation <= maxVariance) {
        stableIntervals++;
      }
    }

    return stableIntervals / intervals.length;
  }

  // Multi-factor blink validation helper methods

  double _calculateEyeSymmetry(List<LivenessFrame> frames) {
    if (frames.isEmpty) return 0.0;

    final symmetryScores = <double>[];

    for (final frame in frames) {
      final face = frame.face;
      final leftEye = face.leftEyeOpenProbability;
      final rightEye = face.rightEyeOpenProbability;

      if (leftEye == null || rightEye == null) {
        symmetryScores.add(0.5); // Neutral score for unknown states
        continue;
      }

      // Calculate asymmetry between left and right eye
      final asymmetry = (leftEye - rightEye).abs();
      final symmetry =
          1.0 - (asymmetry / LivenessConfig.maxEyeAsymmetry).clamp(0.0, 1.0);
      symmetryScores.add(symmetry);
    }

    return symmetryScores.reduce((a, b) => a + b) / symmetryScores.length;
  }

  double _calculateMovementNaturalness(
    List<LivenessFrame> frames,
    List<EyeState> eyeStates,
  ) {
    if (frames.length < 3) return 1.0; // Not enough data for movement analysis

    double naturalnessScore = 1.0;
    int transitionCount = 0;

    // Analyze state transitions
    for (int i = 1; i < eyeStates.length; i++) {
      final currentState = eyeStates[i];
      final previousState = eyeStates[i - 1];

      if (currentState != previousState) {
        transitionCount++;

        // Penalize rapid transitions (suspicious)
        if (i > 1) {
          final timeSinceLastTransition =
              frames[i].timestamp
                  .difference(frames[i - 2].timestamp)
                  .inMilliseconds;
          if (timeSinceLastTransition < 200) {
            // Less than 200ms between transitions
            naturalnessScore -= 0.1;
          }
        }
      }
    }

    // Reward natural transition patterns
    if (transitionCount >= 2 && transitionCount <= 4) {
      naturalnessScore += 0.1; // Natural blink pattern
    } else if (transitionCount > 6) {
      naturalnessScore -= 0.2; // Too many transitions (suspicious)
    }

    return naturalnessScore.clamp(0.0, 1.0);
  }

  double _calculateTimingNaturalness(
    List<LivenessFrame> frames,
    List<EyeState> eyeStates,
  ) {
    if (frames.length < 3) return 1.0;

    // Find blink intervals (time between consecutive blinks)
    final blinkIntervals = <int>[];
    int lastBlinkIndex = -1;

    for (int i = 0; i < eyeStates.length; i++) {
      if (eyeStates[i] == EyeState.closed) {
        if (lastBlinkIndex != -1) {
          final interval =
              frames[i].timestamp
                  .difference(frames[lastBlinkIndex].timestamp)
                  .inMilliseconds;
          blinkIntervals.add(interval);
        }
        lastBlinkIndex = i;
      }
    }

    if (blinkIntervals.isEmpty) return 1.0; // No blinks detected

    // Analyze blink timing naturalness
    double naturalnessScore = 1.0;

    // Natural blink intervals are typically between 2-5 seconds
    for (final interval in blinkIntervals) {
      if (interval < 1000) {
        // Less than 1 second
        naturalnessScore -= 0.2; // Too fast (suspicious)
      } else if (interval > 8000) {
        // More than 8 seconds
        naturalnessScore -= 0.1; // Too slow (suspicious)
      } else if (interval >= 2000 && interval <= 5000) {
        naturalnessScore += 0.05; // Natural timing
      }
    }

    return naturalnessScore.clamp(0.0, 1.0);
  }

  double _calculateMultiFactorBlinkQuality({
    required double symmetryScore,
    required double movementNaturalness,
    required double timingNaturalness,
    required double patternQuality,
  }) {
    // Weighted combination of all factors
    const weights = {
      'symmetry': 0.25,
      'movement': 0.25,
      'timing': 0.20,
      'pattern': 0.30,
    };

    final weightedScore =
        symmetryScore * weights['symmetry']! +
        movementNaturalness * weights['movement']! +
        timingNaturalness * weights['timing']! +
        patternQuality * weights['pattern']!;

    return weightedScore.clamp(0.0, 1.0);
  }

  // Adaptive threshold calculation methods

  AdaptiveThresholdResult _calculateAdaptiveThresholds({
    required List<LivenessFrame> frames,
    required double averageLightingQuality,
    required double averageMovement,
    required double averageQuality,
    required double currentConfidence,
  }) {
    final adjustments = <String, double>{};

    // Calculate lighting-based adjustments
    final lightingAdjustment = _calculateLightingAdjustment(
      averageLightingQuality,
    );
    adjustments['lighting'] = lightingAdjustment;

    // Calculate movement-based adjustments
    final movementAdjustment = _calculateMovementAdjustment(averageMovement);
    adjustments['movement'] = movementAdjustment;

    // Calculate quality-based adjustments
    final qualityAdjustment = _calculateQualityAdjustment(averageQuality);
    adjustments['quality'] = qualityAdjustment;

    // Calculate confidence-based adjustments
    final confidenceAdjustment = _calculateConfidenceAdjustment(
      currentConfidence,
    );
    adjustments['confidence'] = confidenceAdjustment;

    // Apply adjustments to base thresholds
    final adjustedLivenessThreshold = _applyThresholdAdjustment(
      LivenessConfig.baseLivenessThreshold,
      adjustments.values.reduce((a, b) => a + b),
      LivenessConfig.minLivenessThreshold,
      LivenessConfig.maxLivenessThreshold,
    );

    final adjustedBlinkSymmetry = _applyThresholdAdjustment(
      LivenessConfig.baseBlinkSymmetry,
      adjustments['lighting']! + adjustments['quality']!,
      LivenessConfig.minBlinkSymmetryThreshold,
      LivenessConfig.maxBlinkSymmetryThreshold,
    );

    final adjustedMovementNaturalness = _applyThresholdAdjustment(
      LivenessConfig.baseMovementNaturalness,
      adjustments['movement']! + adjustments['confidence']!,
      LivenessConfig.minMovementNaturalnessThreshold,
      LivenessConfig.maxMovementNaturalnessThreshold,
    );

    final adjustedTimingNaturalness = _applyThresholdAdjustment(
      LivenessConfig.baseTimingNaturalness,
      adjustments['movement']! + adjustments['confidence']!,
      LivenessConfig.minTimingNaturalnessThreshold,
      LivenessConfig.maxTimingNaturalnessThreshold,
    );

    final adjustedStabilityMovement = _applyThresholdAdjustment(
      LivenessConfig.baseStabilityMovement,
      adjustments['movement']!,
      LivenessConfig.minStabilityMovementThreshold,
      LivenessConfig.maxStabilityMovementThreshold,
    );

    final adjustedQualityThreshold = _applyThresholdAdjustment(
      LivenessConfig.baseQualityThreshold,
      adjustments['lighting']! + adjustments['quality']!,
      LivenessConfig.minQualityThreshold,
      LivenessConfig.maxQualityThreshold,
    );

    return AdaptiveThresholdResult.create(
      adjustedLivenessThreshold: adjustedLivenessThreshold,
      adjustedBlinkSymmetry: adjustedBlinkSymmetry,
      adjustedMovementNaturalness: adjustedMovementNaturalness,
      adjustedTimingNaturalness: adjustedTimingNaturalness,
      adjustedStabilityMovement: adjustedStabilityMovement,
      adjustedQualityThreshold: adjustedQualityThreshold,
      adjustments: adjustments,
    );
  }

  double _calculateLightingAdjustment(double averageLightingQuality) {
    // Adjust thresholds based on lighting conditions
    if (averageLightingQuality < 0.3) {
      // Poor lighting - lower thresholds to be more lenient
      return -LivenessConfig.lightingAdjustmentFactor;
    } else if (averageLightingQuality > 0.8) {
      // Excellent lighting - raise thresholds for higher accuracy
      return LivenessConfig.lightingAdjustmentFactor;
    } else {
      // Good lighting - no adjustment
      return 0.0;
    }
  }

  double _calculateMovementAdjustment(double averageMovement) {
    // Adjust thresholds based on movement patterns
    if (averageMovement < 10.0) {
      // Very stable - raise thresholds for higher accuracy
      return LivenessConfig.movementAdjustmentFactor;
    } else if (averageMovement > 30.0) {
      // High movement - lower thresholds to be more lenient
      return -LivenessConfig.movementAdjustmentFactor;
    } else {
      // Moderate movement - no adjustment
      return 0.0;
    }
  }

  double _calculateQualityAdjustment(double averageQuality) {
    // Adjust thresholds based on overall quality
    if (averageQuality < 0.4) {
      // Poor quality - lower thresholds to be more lenient
      return -LivenessConfig.qualityAdjustmentFactor;
    } else if (averageQuality > 0.8) {
      // High quality - raise thresholds for higher accuracy
      return LivenessConfig.qualityAdjustmentFactor;
    } else {
      // Good quality - no adjustment
      return 0.0;
    }
  }

  double _calculateConfidenceAdjustment(double currentConfidence) {
    // Adjust thresholds based on current confidence level
    if (currentConfidence < 0.3) {
      // Low confidence - lower thresholds to be more lenient
      return -LivenessConfig.confidenceAdjustmentFactor;
    } else if (currentConfidence > 0.7) {
      // High confidence - raise thresholds for higher accuracy
      return LivenessConfig.confidenceAdjustmentFactor;
    } else {
      // Moderate confidence - no adjustment
      return 0.0;
    }
  }

  double _applyThresholdAdjustment(
    double baseThreshold,
    double adjustment,
    double minThreshold,
    double maxThreshold,
  ) {
    // Apply adjustment as a percentage of the base threshold
    final adjustedThreshold = baseThreshold * (1.0 + adjustment);

    // Clamp to min/max bounds
    return adjustedThreshold.clamp(minThreshold, maxThreshold);
  }

  void _logAdaptiveThresholds(AdaptiveThresholdResult result) {
    print('🔧 Adaptive Thresholds Applied:');
    print(
      '  📊 Liveness Threshold: ${result.adjustedLivenessThreshold.toStringAsFixed(3)}',
    );
    print(
      '  👁️  Blink Symmetry: ${result.adjustedBlinkSymmetry.toStringAsFixed(3)}',
    );
    print(
      '  🏃 Movement Naturalness: ${result.adjustedMovementNaturalness.toStringAsFixed(3)}',
    );
    print(
      '  ⏱️  Timing Naturalness: ${result.adjustedTimingNaturalness.toStringAsFixed(3)}',
    );
    print(
      '  🎯 Stability Movement: ${result.adjustedStabilityMovement.toStringAsFixed(3)}',
    );
    print(
      '  ✨ Quality Threshold: ${result.adjustedQualityThreshold.toStringAsFixed(3)}',
    );
    print('  📈 Adjustments: ${result.description}');
  }

  // Helper methods for adaptive threshold calculation

  double _calculateAverageLightingQuality(List<LivenessFrame> frames) {
    if (frames.isEmpty) return 0.5; // Default neutral value

    double totalQuality = 0.0;
    int validFrames = 0;

    for (final frame in frames) {
      final face = frame.face;
      if (face.trackingId != null) {
        // Use face detection confidence as a proxy for lighting quality
        final quality = face.trackingId! > 0 ? 0.8 : 0.4;
        totalQuality += quality;
        validFrames++;
      }
    }

    return validFrames > 0 ? totalQuality / validFrames : 0.5;
  }

  double _calculateAverageMovement(List<LivenessFrame> frames) {
    if (frames.length < 2) return 0.0;

    double totalMovement = 0.0;
    int movementCount = 0;

    for (int i = 1; i < frames.length; i++) {
      final currentFrame = frames[i];
      final previousFrame = frames[i - 1];

      final currentBoundingBox = currentFrame.face.boundingBox;
      final previousBoundingBox = previousFrame.face.boundingBox;

      final movementX =
          (currentBoundingBox.left - previousBoundingBox.left).abs();
      final movementY =
          (currentBoundingBox.top - previousBoundingBox.top).abs();
      final totalFrameMovement = movementX + movementY;

      totalMovement += totalFrameMovement;
      movementCount++;
    }

    return movementCount > 0 ? totalMovement / movementCount : 0.0;
  }

  double _calculateAverageQuality(List<LivenessFrame> frames) {
    if (frames.isEmpty) return 0.5; // Default neutral value

    double totalQuality = 0.0;
    int validFrames = 0;

    for (final frame in frames) {
      final face = frame.face;

      // Calculate quality based on face size and position
      final boundingBox = face.boundingBox;
      final faceSize = boundingBox.width * boundingBox.height;

      // Normalize face size (assuming typical face size range)
      final normalizedSize = (faceSize / (200 * 200)).clamp(0.0, 1.0);

      // Simple quality score based on face size
      final quality = normalizedSize;

      totalQuality += quality;
      validFrames++;
    }

    return validFrames > 0 ? totalQuality / validFrames : 0.5;
  }

  double _calculatePreliminaryConfidence(List<LivenessFrame> frames) {
    if (frames.isEmpty) return 0.0;

    // Calculate a preliminary confidence based on basic frame characteristics
    final averageQuality = _calculateAverageQuality(frames);
    final averageMovement = _calculateAverageMovement(frames);

    // Normalize movement (lower is better)
    final normalizedMovement = (1.0 - (averageMovement / 50.0)).clamp(0.0, 1.0);

    // Simple weighted average
    final preliminaryConfidence =
        (averageQuality * 0.7) + (normalizedMovement * 0.3);

    return preliminaryConfidence.clamp(0.0, 1.0);
  }
}
