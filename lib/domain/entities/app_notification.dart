import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';

part 'app_notification.freezed.dart';

/// Defines the type of status update for styling purposes (color, icon).
enum StatusType { info, success, warning, error }

/// A new, unified notification model for all user-facing feedback.
/// This sealed class allows us to handle different notification types in a structured way.
@freezed
sealed class AppNotification with _$AppNotification {
  /// Represents a transient status update, suitable for an overlay text widget.
  const factory AppNotification.statusUpdate({
    required String message,
    required StatusType type,
  }) = StatusUpdate;

  /// Represents an event that should trigger a SnackBar for user feedback.
  const factory AppNotification.showSnackBar({
    required String title,
    required String message,
    required SnackBarType type,
  }) = ShowSnackBar;

  /// Represents the successful recognition event, triggering a detailed dialog.
  const factory AppNotification.showSuccessDialog({
    required FaceDetectionResult face,
    String? annotatedImage,
  }) = ShowSuccessDialog;

  const AppNotification._();
}
