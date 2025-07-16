import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';

part 'app_notification.freezed.dart';

/// A unified notification model for event-based user feedback.
/// This sealed class allows us to handle different notification types in a structured way.
@freezed
sealed class AppNotification with _$AppNotification {
  /// Represents an event that should trigger a SnackBar for user feedback.
  const factory AppNotification.snackBar({
    required String title,
    required String message,
    required SnackBarType type,
  }) = ShowSnackBar;

  /// Represents the successful recognition event, triggering a detailed dialog.
  const factory AppNotification.dialog({
    required FaceDetectionResult face,
    String? annotatedImage,
  }) = ShowSuccessDialog;

  const AppNotification._();
}
