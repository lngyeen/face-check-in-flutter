import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:face_check_in_flutter/core/services/liveness_config.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

import 'liveness_validator.dart';

/// Validator for detecting eye blinking patterns
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
