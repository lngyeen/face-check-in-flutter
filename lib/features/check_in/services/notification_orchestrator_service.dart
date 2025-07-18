// lib/services/notification_orchestrator_service.dart

import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/liveness_progress_view_model.dart';
import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/app_notification.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';
import 'package:face_check_in_flutter/domain/entities/status_update.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';

@lazySingleton
class NotificationOrchestratorService {
  final CheckInBlocV2 _checkInBloc;
  final StreamingBlocV2 _streamingBloc;

  late final Stream<StatusUpdate> statusNotificationStream;
  late final Stream<AppNotification> eventNotificationStream;

  NotificationOrchestratorService(this._checkInBloc, this._streamingBloc) {
    statusNotificationStream = _streamingBloc.stream
        // Lọc các state giống nhau liên tiếp để tránh update không cần thiết
        .distinct(
          (prev, next) =>
              prev.processingStatus == next.processingStatus &&
              prev.livenessProgress == next.livenessProgress,
        )
        .map(_convertStreamingStateToStatusUpdate)
        .where((notification) => notification != null)
        .cast<StatusUpdate>()
        .shareReplay(maxSize: 1);

    eventNotificationStream = _checkInBloc.stream
        .distinct()
        .map(_convertCheckInStateToEvent)
        .where((notification) => notification != null)
        .cast<AppNotification>()
        .shareReplay(maxSize: 1);
  }

  StatusUpdate? _convertStreamingStateToStatusUpdate(StreamingStateV2 state) {
    // Ưu tiên hiển thị feedback từ liveness check nếu có
    if (state.processingStatus == ProcessingStatus.livenessChecking &&
        state.livenessProgress != null) {
      return _convertLivenessViewModelToStatusUpdate(state.livenessProgress!);
    }

    // Fallback về các trạng thái chung
    return switch (state.processingStatus) {
      ProcessingStatus.waitingForFace => const StatusUpdate(
        message: 'Đưa khuôn mặt vào trong khung hình',
        type: StatusType.info,
      ),
      ProcessingStatus.livenessChecking => const StatusUpdate(
        message: 'Đang kiểm tra...',
        type: StatusType.info,
      ),
      ProcessingStatus.readyForCheckIn => const StatusUpdate(
        message: 'Sẵn sàng check-in!',
        type: StatusType.success,
      ),
      ProcessingStatus.completed => const StatusUpdate(
        message: 'Đã hoàn thành xác thực!',
        type: StatusType.success,
      ),
      ProcessingStatus.error => null,
    };
  }

  // Logic được đơn giản hóa rất nhiều nhờ ViewModel
  StatusUpdate? _convertLivenessViewModelToStatusUpdate(
    LivenessProgressViewModel viewModel,
  ) {
    // ViewModel đã chuẩn bị sẵn gợi ý quan trọng nhất
    if (viewModel.primarySuggestion != null) {
      final issue = viewModel.currentIssues.firstWhere(
        (e) => e.suggestion == viewModel.primarySuggestion,
        orElse: () => LivenessFailureReason.processingError,
      );

      // Xác định loại thông báo dựa trên mức độ nghiêm trọng của lỗi
      final type =
          (issue == LivenessFailureReason.insufficientFrames ||
                  issue == LivenessFailureReason.waitingForFace)
              ? StatusType.info
              : StatusType.warning;

      return StatusUpdate(message: viewModel.primarySuggestion!, type: type);
    }

    // Nếu không có gợi ý nào, nghĩa là đã sẵn sàng hoặc thành công
    // (trong trường hợp này, trạng thái chung `readyForCheckIn` sẽ được hiển thị)
    return const StatusUpdate(
      message: 'Đã xác thực, sẵn sàng check-in!',
      type: StatusType.success,
    );
  }

  // ---- Các phương thức dưới đây không thay đổi ----

  AppNotification? _convertCheckInStateToEvent(CheckInStateV2 checkInState) {
    if (checkInState.currentError != null) {
      return AppNotification.snackBar(
        title: 'Lỗi Hệ Thống',
        message: checkInState.currentError!.message,
        type: SnackBarType.error,
      );
    }

    final faces = checkInState.detectedFaces;
    if (faces.isEmpty) {
      return null;
    }

    if (faces.length > 1) {
      return _createMultipleFacesNotification(faces);
    }

    final face = faces.first;
    if (face.isRecognized && face.faceId != null) {
      final annotatedImage = checkInState.annotatedImage;
      return AppNotification.dialog(face: face, annotatedImage: annotatedImage);
    } else {
      return const AppNotification.snackBar(
        title: 'Không Nhận Dạng Được',
        message: 'Hãy đảm bảo đủ sáng và nhìn thẳng vào camera.',
        type: SnackBarType.warning,
      );
    }
  }

  AppNotification _createMultipleFacesNotification(
    List<FaceDetectionResult> faces,
  ) {
    final recognizedCount = faces.where((face) => face.isRecognized).length;

    String message;
    if (recognizedCount == 0) {
      message =
          'Phát hiện nhiều khuôn mặt lạ. Vui lòng đảm bảo chỉ có một người trong khung hình.';
    } else {
      message =
          'Phát hiện nhiều khuôn mặt. Vui lòng đảm bảo chỉ có một người trong khung hình.';
    }

    return AppNotification.snackBar(
      title: 'Phát Hiện Nhiều Khuôn Mặt',
      message: message,
      type: SnackBarType.info,
    );
  }
}
