import 'package:face_check_in_flutter/core/services/liveness_validators.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_challenge.dart';

class ChallengeConfig {
  /// Định nghĩa thứ tự của các thử thách.
  static const List<LivenessChallenge> challengeOrder = [
    LivenessChallenge.positioning,
    LivenessChallenge.blinking,
    LivenessChallenge.completed,
  ];

  /// Ánh xạ mỗi thử thách với (các) validator cần phải vượt qua.
  static const Map<LivenessChallenge, List<Type>> challengeValidators = {
    LivenessChallenge.positioning: [
      // Để qua bước định vị, người dùng phải vượt qua cả 3 validator này.
      QualityValidator,
      StabilityValidator,
      TemporalValidator,
    ],
    LivenessChallenge.blinking: [
      // Để qua bước chớp mắt, chỉ cần vượt qua validator này.
      BlinkValidator,
    ],
  };

  // --- Weights for confidence score ---
  static const Map<Type, double> validatorWeights = {
    BlinkValidator: 0.35,
    QualityValidator: 0.3,
    StabilityValidator: 0.2,
    TemporalValidator: 0.15,
  };
}

// Cấu hình cho luồng xử lý ảnh
class ImageStreamConfig {
  static const int waitingForFaceFps = 1;
  static const int livenessCheckingFps = 8;
  static const int readyForCheckInFps = 1;
}

// Cấu hình cho việc kiểm tra chất lượng frame
class QualityConfig {
  static const double minFaceSizeRatio = 0.2; // ← GIẢM: Từ 0.25 xuống 0.2
  static const double maxFaceSizeRatio = 0.75; // ← TĂNG: Từ 0.65 lên 0.75
  static const double maxHeadAngleY = 25.0; // ← TĂNG: Từ 20.0 lên 25.0
  static const double maxHeadAngleZ = 20.0; // ← TĂNG: Từ 15.0 lên 20.0
}

// Cấu hình cho các bước kiểm tra (validation) liveness
class ValidationConfig {
  // --- Thresholds chung ---
  static const int minFramesForLiveness = ImageStreamConfig.livenessCheckingFps;
  static const int maxFramesForLiveness = minFramesForLiveness + 4;

  static const double livenessThreshold = 0.5; // ← GIẢM: Từ 0.65 xuống 0.5
  static const double minQualityFrameRatio = 0.4; // ← GIẢM: Từ 0.6 xuống 0.4

  // --- Stability Validator ---
  static const double maxStabilityMovement =
      50.0; // ← TĂNG: Từ 30.0 lên 50.0 (px)

  // --- Blink Validator ---
  static const double eyeOpenOrClosedThreshold =
      0.3; // ← GIẢM: Từ 0.4 xuống 0.3 (dễ nhận diện mắt nhắm hơn)
  static const int minOpenFramesBeforeBlink = 1; // ← GIẢM: Từ 3 xuống 1
  static const int minOpenFramesAfterBlink = 1; // ← GIẢM: Từ 2 xuống 1
  static const int idealBlinkDurationMin = 1; // ← GIẢM: Từ 2 xuống 1
  static const int idealBlinkDurationMax = 4; // ← TĂNG: Từ 3 lên 4
  static const int maxBlinkDurationFrames = 6; // ← TĂNG: Từ 5 lên 6

  // --- Temporal Validator ---
  static const double maxFrameIntervalVariance =
      0.8; // ← TĂNG: Từ 0.5 lên 0.8 (80%)
  static const double minTimingConsistency = 0.5; // ← GIẢM: Từ 0.7 xuống 0.5
  static const double minFrameRateStability = 0.6; // ← GIẢM: Từ 0.8 xuống 0.6
}
