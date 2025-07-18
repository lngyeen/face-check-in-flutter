// lib/core/services/liveness_service_v2.dart

import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

import 'liveness_config.dart';
import 'liveness_validators.dart';

/// Abstract class định nghĩa hợp đồng cho LivenessService.
abstract class LivenessServiceV2 {
  /// Xử lý một danh sách các frame khuôn mặt và trả về kết quả liveness.
  Future<LivenessResult> processFaceList(List<LivenessFrame> faceFrames);
}

@LazySingleton(as: LivenessServiceV2)
class LivenessServiceV2Impl implements LivenessServiceV2 {
  final List<LivenessValidator> _validators;

  LivenessServiceV2Impl()
    : _validators = [
        BlinkValidator(),
        StabilityValidator(),
        QualityValidator(),
        TemporalValidator(),
      ];

  @override
  Future<LivenessResult> processFaceList(List<LivenessFrame> faceFrames) async {
    // Chạy tất cả các validator và thu thập kết quả.
    final results = Map<Type, LivenessResult>.fromEntries(
      _validators.map((validator) {
        final result = validator.validate(faceFrames);
        return MapEntry(validator.runtimeType, result);
      }),
    );

    // Logic "Fail-Fast": Nếu có bất kỳ validator nào thất bại,
    // trả về ngay lập tức lý do thất bại đầu tiên tìm thấy.
    for (final result in results.values) {
      if (result is Failed) {
        _logResults(results, result);
        return result;
      }
    }

    // Nếu tất cả các validator đều trả về .passed(), tính điểm tin cậy tổng hợp.
    final overallConfidence = _calculateOverallConfidence(results);

    // So sánh điểm cuối cùng với ngưỡng để đưa ra quyết định.
    final finalResult =
        overallConfidence >= ValidationConfig.livenessThreshold
            ? LivenessResult.passed(confidence: overallConfidence)
            // Nếu điểm không đủ, coi như thất bại do một lý do chung chung nhất.
            : const LivenessResult.failed(
              reason: LivenessFailureReason.noBlinkDetected,
            );

    _logResults(results, finalResult, overallConfidence: overallConfidence);
    return finalResult;
  }

  /// Tính toán điểm tin cậy tổng hợp dựa trên trọng số của từng validator.
  double _calculateOverallConfidence(Map<Type, LivenessResult> results) {
    double totalConfidence = 0.0;
    double totalWeight = 0.0;

    results.forEach((validatorType, result) {
      final weight = ChallengeConfig.validatorWeights[validatorType] ?? 0;
      if (weight > 0) {
        // Chỉ lấy điểm tin cậy từ các kết quả .passed()
        final confidence = result.maybeWhen(
          passed: (c) => c,
          // Các trạng thái khác không đóng góp vào điểm tin cậy
          orElse: () => 0.0,
        );
        totalConfidence += confidence * weight;
        totalWeight += weight;
      }
    });

    if (totalWeight == 0) return 0.0;
    // Chuẩn hóa điểm tin cậy để đảm bảo nó nằm trong khoảng [0, 1]
    return (totalConfidence / totalWeight).clamp(0.0, 1.0);
  }

  /// Phương thức helper để in log chi tiết ra console cho mục đích debug.
  void _logResults(
    Map<Type, LivenessResult> results,
    LivenessResult finalResult, {
    double? overallConfidence,
  }) {
    print('=================================');
    print('--- LIVENESS DETECTION RESULT ---');
    results.forEach((type, result) {
      final status = result.maybeWhen(
        passed: (c) => "${(c * 100).round()}% - Passed",
        failed: (r) => "0% - Failed: ${r.name}",
        orElse: () => "N/A - Not Applicable",
      );
      print('📊 ${type.toString()}: $status');
    });
    print('---------------------------------');
    if (overallConfidence != null) {
      print(
        '📊 Final Confidence: ${(overallConfidence * 100).round()}% vs Threshold: ${(ValidationConfig.livenessThreshold * 100).round()}%',
      );
    }
    print(
      '📊 Final Decision: ${finalResult.isPassed ? 'ALIVE ✅' : 'NOT ALIVE ❌'}',
    );
    print('=================================');
  }
}
