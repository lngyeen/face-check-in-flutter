// lib/presentation/viewmodels/liveness_progress_view_model.dart

import 'package:face_check_in_flutter/domain/entities/liveness_metrics.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

// Class này nhận LivenessMetrics và chuyển đổi nó thành dữ liệu mà UI có thể hiển thị trực tiếp.
class LivenessProgressViewModel {
  /// Dữ liệu metrics gốc
  final LivenessMetrics metrics;

  /// Tiến trình tổng thể để hiển thị trên UI (0.0 -> 1.0)
  final double overallProgress;

  /// Gợi ý chính, quan trọng nhất để hiển thị cho người dùng.
  final String? primarySuggestion;

  /// Tiêu đề chính cho feedback.
  final String? primaryTitle;

  /// Danh sách các vấn đề hiện tại.
  final Set<LivenessFailureReason> currentIssues;

  LivenessProgressViewModel(this.metrics)
    : overallProgress = _calculateOverallProgress(metrics),
      primarySuggestion = _getPrimaryFeedback(metrics.issues)?.suggestion,
      primaryTitle = _getPrimaryFeedback(metrics.issues)?.title,
      currentIssues = metrics.issues;

  static double _calculateOverallProgress(LivenessMetrics metrics) {
    // Khi đang chờ đủ frame, progress chính là tiến trình thu thập.
    if (metrics.issues.contains(LivenessFailureReason.insufficientFrames) ||
        metrics.issues.contains(LivenessFailureReason.waitingForFace)) {
      return metrics.processingProgress;
    }
    // Khi đã đủ frame, có thể dựa trên yếu tố khác, hoặc là 1.0 để cho thấy sẵn sàng xử lý.
    return 1.0;
  }

  static LivenessFailureReason? _getPrimaryFeedback(
    Set<LivenessFailureReason> issues,
  ) {
    if (issues.isEmpty) return null;

    // Logic ưu tiên để chọn gợi ý quan trọng nhất để hiển thị.
    // Ví dụ: Vấn đề về vị trí khuôn mặt quan trọng hơn ánh sáng.
    const priorityOrder = [
      LivenessFailureReason.waitingForFace,
      LivenessFailureReason.faceTooSmall,
      LivenessFailureReason.faceTooLarge,
      LivenessFailureReason.faceNotCentered,
      LivenessFailureReason.headTurnedTooMuch,
      LivenessFailureReason.poorLighting,
      LivenessFailureReason.tooBlurry,
      LivenessFailureReason.insufficientFrames,
    ];

    for (final reason in priorityOrder) {
      if (issues.contains(reason)) {
        return reason;
      }
    }

    // Trả về lỗi đầu tiên nếu không có trong danh sách ưu tiên.
    return issues.first;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LivenessProgressViewModel &&
        other.overallProgress == overallProgress &&
        other.primarySuggestion == primarySuggestion &&
        other.primaryTitle == primaryTitle;
  }

  @override
  int get hashCode =>
      overallProgress.hashCode ^
      primarySuggestion.hashCode ^
      primaryTitle.hashCode;
}
