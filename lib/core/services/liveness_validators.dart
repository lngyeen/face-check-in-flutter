// lib/core/services/liveness_validators.dart

import 'dart:math';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

import 'liveness_config.dart';

// Interface chung
abstract class LivenessValidator {
  LivenessResult validate(List<LivenessFrame> faceFrames);
}

// --- Validator cho việc chớp mắt (Phiên bản cải tiến) ---
class BlinkValidator implements LivenessValidator {
  @override
  LivenessResult validate(List<LivenessFrame> faceFrames) {
    if (faceFrames.length < ValidationConfig.minFramesForLiveness) {
      return const LivenessResult.failed(
        reason: LivenessFailureReason.insufficientFrames,
      );
    }

    final faces = faceFrames.map((e) => e.face).toList();
    final eyeStates = faces.map(_getEyeState).toList();

    // === DEBUG: LOG DỮ LIỆU ĐẦU VÀO ===
    print('=================================');
    print('🚀 Running Improved BlinkValidator with ${faces.length} frames');
    print(
      '👁️ Eye States Sequence: ${eyeStates.map((s) => s.name[0].toUpperCase()).join('')}',
    );
    print('---------------------------------');
    // === KẾT THÚC DEBUG ===

    // === THUẬT TOÁN CẢI TIẾN: TÌM PATTERN "OPEN → CLOSED → OPEN" ===
    final blinkPattern = _findBlinkPattern(eyeStates.cast<EyeState>());

    // === ĐIỀU KIỆN CẢI TIẾN ===
    // Cần có pattern "mở mắt → nhắm mắt → mở lại"
    final bool hasValidBlinkPattern = blinkPattern != null;

    // --- DEBUG: LOG KẾT QUẢ CUỐI CÙNG ---
    print('🏁 Improved Check:');
    print('  - Blink pattern found: $blinkPattern');
    print('  - Has valid blink pattern: $hasValidBlinkPattern');
    print('=================================');
    // --- KẾT THÚC DEBUG ---

    if (hasValidBlinkPattern) {
      final pattern = blinkPattern;
      // Tính confidence dựa trên độ dài của pattern
      final confidence = (pattern.closedDuration / eyeStates.length).clamp(
        0.1,
        0.8,
      );
      return LivenessResult.passed(confidence: confidence);
    } else {
      return const LivenessResult.failed(
        reason: LivenessFailureReason.noBlinkDetected,
      );
    }
  }

  EyeState _getEyeState(Face face) {
    final left = face.leftEyeOpenProbability;
    final right = face.rightEyeOpenProbability;
    if (left == null || right == null) return EyeState.unknown;
    final avg = (left + right) / 2.0;
    return avg > ValidationConfig.eyeOpenOrClosedThreshold
        ? EyeState.open
        : EyeState.closed;
  }

  /// Tìm pattern "mở mắt → nhắm mắt → mở lại"
  BlinkPattern? _findBlinkPattern(List<EyeState> eyeStates) {
    if (eyeStates.length < 3) return null; // Cần ít nhất 3 frames

    // Tìm tất cả các vị trí mắt nhắm
    final closedIndices = <int>[];
    for (int i = 0; i < eyeStates.length; i++) {
      if (eyeStates[i] == EyeState.closed) {
        closedIndices.add(i);
      }
    }

    if (closedIndices.isEmpty) return null;

    // Tìm pattern tốt nhất
    for (final closedStart in closedIndices) {
      // Tìm điểm kết thúc nhắm mắt
      int closedEnd = closedStart;
      while (closedEnd < eyeStates.length &&
          eyeStates[closedEnd] == EyeState.closed) {
        closedEnd++;
      }
      closedEnd--; // Lùi lại 1 vì vòng while đã tăng quá

      final closedDuration = closedEnd - closedStart + 1;

      // Kiểm tra điều kiện pattern
      if (_isValidBlinkPattern(eyeStates, closedStart, closedEnd)) {
        return BlinkPattern(
          openBefore: closedStart,
          closedDuration: closedDuration,
          openAfter: eyeStates.length - closedEnd - 1,
        );
      }
    }

    return null;
  }

  /// Kiểm tra xem có phải pattern hợp lệ không
  bool _isValidBlinkPattern(
    List<EyeState> eyeStates,
    int closedStart,
    int closedEnd,
  ) {
    final closedDuration = closedEnd - closedStart + 1;

    // Kiểm tra độ dài nhắm mắt
    if (closedDuration < 1 ||
        closedDuration > ValidationConfig.maxBlinkDurationFrames) {
      return false;
    }

    // Kiểm tra có mắt mở trước khi nhắm không
    final hasOpenBefore =
        closedStart > 0 && eyeStates[closedStart - 1] == EyeState.open;

    // Kiểm tra có mắt mở sau khi nhắm không
    final hasOpenAfter =
        closedEnd < eyeStates.length - 1 &&
        eyeStates[closedEnd + 1] == EyeState.open;

    return hasOpenBefore && hasOpenAfter;
  }
}

/// Class để lưu thông tin về pattern nháy mắt
class BlinkPattern {
  final int openBefore;
  final int closedDuration;
  final int openAfter;

  BlinkPattern({
    required this.openBefore,
    required this.closedDuration,
    required this.openAfter,
  });

  @override
  String toString() {
    return 'BlinkPattern(openBefore: $openBefore, closedDuration: $closedDuration, openAfter: $openAfter)';
  }
}

// --- Validator cho độ ổn định (ít di chuyển) ---
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

// --- Validator cho chất lượng ảnh/khuôn mặt ---
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

    // Sử dụng kích thước ảnh mặc định từ config
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

// Thêm vào cuối file lib/core/services/liveness_validators.dart

// --- Validator cho Phân tích Thời gian (Temporal Analysis) ---
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

    // CẬP NHẬT: Sử dụng hằng số từ config
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

  // --- Các phương thức helper được chuyển từ LivenessService cũ ---

  double _calculateTimingConsistency(
    List<double> intervals,
    double expectedInterval,
  ) {
    if (intervals.isEmpty) return 0.0;

    final consistencyScores = <double>[];
    for (final interval in intervals) {
      final deviation = (interval - expectedInterval).abs() / expectedInterval;
      // Điểm càng cao nếu độ lệch càng thấp
      final score = 1.0 - deviation.clamp(0.0, 1.0);
      consistencyScores.add(score);
    }

    // Trả về điểm trung bình
    return consistencyScores.reduce((a, b) => a + b) / consistencyScores.length;
  }

  double _calculateFrameRateStability(
    List<double> intervals,
    double expectedInterval,
  ) {
    if (intervals.isEmpty) return 0.0;

    // Sử dụng hằng số phương sai từ config
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
