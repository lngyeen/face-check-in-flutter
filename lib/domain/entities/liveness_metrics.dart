// lib/domain/entities/liveness_metrics.dart

import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

// Class chứa dữ liệu thô, được tính toán bởi LivenessStateTracker.
class LivenessMetrics {
  /// Tỷ lệ hoàn thành batch (0.0 -> 1.0)
  final double processingProgress;

  /// Điểm chất lượng trung bình của các frame trong batch (0.0 -> 1.0)
  final double qualityScore;

  /// Các vấn đề hiện tại được phát hiện (để cung cấp feedback).
  final Set<LivenessFailureReason> issues;

  const LivenessMetrics({
    this.processingProgress = 0.0,
    this.qualityScore = 0.0,
    this.issues = const {},
  });

  // Const constructor cho trạng thái khởi tạo
  const LivenessMetrics.initial()
    : processingProgress = 0.0,
      qualityScore = 0.0,
      issues = const {LivenessFailureReason.waitingForFace};
}
