import 'package:flutter/material.dart';
import '../widgets/toast_widget.dart';

/// Service for managing toast notifications throughout the app
class ToastService {
  ToastService._();
  static final ToastService _instance = ToastService._();
  static ToastService get instance => _instance;

  /// Show success toast with user name
  void showSuccess(
    BuildContext context,
    String userName, {
    Duration? duration,
    VoidCallback? onDismissed,
  }) {
    debugPrint('🍞 ToastService: Showing success toast for $userName');
    ToastWidget.showSuccess(
      context,
      userName,
      duration: duration,
      onDismissed: onDismissed,
    );
  }

  /// Show failure toast with optional custom message
  void showFailure(
    BuildContext context, {
    String? customMessage,
    Duration? duration,
    VoidCallback? onDismissed,
  }) {
    debugPrint(
      '🍞 ToastService: Showing failure toast - ${customMessage ?? "default"}',
    );
    ToastWidget.showFailure(
      context,
      customMessage: customMessage,
      duration: duration,
      onDismissed: onDismissed,
    );
  }

  /// Show success toast for face detection check-in
  void showCheckInSuccess(
    BuildContext context,
    String userName,
    double confidence, {
    VoidCallback? onDismissed,
  }) {
    final message =
        confidence > 0.9
            ? 'Welcome, $userName!'
            : 'Welcome, $userName! (${(confidence * 100).toStringAsFixed(0)}%)';

    debugPrint(
      '🍞 ToastService: Check-in success for $userName with ${(confidence * 100).toStringAsFixed(1)}% confidence',
    );

    ToastWidget.showSuccess(context, userName, onDismissed: onDismissed);
  }

  /// Show failure toast for specific face detection scenarios
  void showFaceDetectionFailure(
    BuildContext context,
    String reason, {
    VoidCallback? onDismissed,
  }) {
    String message;

    switch (reason.toLowerCase()) {
      case 'no_face':
      case 'noface':
        message =
            'No face detected. Please position yourself in front of the camera.';
        break;
      case 'multiple_faces':
      case 'multiplefaces':
        message =
            'Multiple faces detected. Please ensure only one person in frame.';
        break;
      case 'low_confidence':
        message = 'Face detected but not recognized. Please try again.';
        break;
      case 'processing_error':
      case 'error':
        message = 'Processing error. Please try again.';
        break;
      default:
        message = 'Recognition failed. Please try again.';
    }

    debugPrint('🍞 ToastService: Face detection failure - $reason');

    ToastWidget.showFailure(
      context,
      customMessage: message,
      onDismissed: onDismissed,
    );
  }

  /// Show toast based on recognition statistics
  void showRecognitionStatsToast(
    BuildContext context,
    int successfulRecognitions,
    int totalFrames, {
    VoidCallback? onDismissed,
  }) {
    if (totalFrames == 0) return;

    final successRate = (successfulRecognitions / totalFrames * 100)
        .toStringAsFixed(0);
    final message =
        'Recognition rate: $successRate% ($successfulRecognitions/$totalFrames)';

    debugPrint(
      '🍞 ToastService: Recognition stats - $successRate% success rate',
    );

    ToastWidget.showSuccess(
      context,
      'Stats: $successRate%',
      duration: const Duration(seconds: 2),
      onDismissed: onDismissed,
    );
  }
}

/// Extension to make ToastService easily accessible from BuildContext
extension ToastServiceExtension on BuildContext {
  ToastService get toast => ToastService.instance;
}
