import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/app_notification.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/success_info_dialog.dart';
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';

/// Unified notification handler that processes stream-based notifications
/// with throttling mechanism to prevent duplicate notifications
class NotificationHandler extends StatefulWidget {
  const NotificationHandler({
    super.key,
    required this.child,
    required this.eventNotificationStream,
    this.throttleDuration = const Duration(seconds: 3),
  });

  final Widget child;
  final Stream<AppNotification> eventNotificationStream;
  final Duration throttleDuration;

  @override
  State<NotificationHandler> createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  StreamSubscription<AppNotification>? _subscription;
  final Map<String, DateTime> _lastShownTimes = {};
  Timer? _cleanupTimer;

  @override
  void initState() {
    super.initState();
    _setupStreamSubscription();
    _setupCleanupTimer();
  }

  /// Setup stream subscription with error handling
  void _setupStreamSubscription() {
    _subscription = widget.eventNotificationStream.listen(
      (notification) {
        if (mounted) {
          _handleNotificationWithThrottle(notification);
        }
      },
      onError: (error) {
        // Log error and show fallback notification
        debugPrint('NotificationHandler stream error: $error');
        if (mounted) {
          _showFallbackNotification();
        }
      },
    );
  }

  /// Setup periodic cleanup timer for throttling mechanism
  void _setupCleanupTimer() {
    _cleanupTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _cleanupOldThrottlingEntries();
    });
  }

  /// Cleanup old throttling entries to prevent memory leaks
  void _cleanupOldThrottlingEntries() {
    final cutoff = DateTime.now().subtract(const Duration(minutes: 2));
    _lastShownTimes.removeWhere((key, time) => time.isBefore(cutoff));
  }

  /// Show fallback notification when stream fails
  void _showFallbackNotification() {
    UIHelper.showAppSnackBar(
      context: context,
      title: 'System Notice',
      message: 'Notification system temporarily unavailable',
      type: SnackBarType.warning,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  /// Handle stream-based notifications with throttling
  void _handleNotificationWithThrottle(AppNotification notification) {
    final notificationKey = _getNotificationKey(notification);
    final now = DateTime.now();

    final lastShown = _lastShownTimes[notificationKey];
    final timeSinceLastShown =
        lastShown != null ? now.difference(lastShown) : Duration.zero;

    if (lastShown == null || timeSinceLastShown >= widget.throttleDuration) {
      _lastShownTimes[notificationKey] = now;
      _handleNotification(notification);
    }
  }

  /// Handle individual notification
  void _handleNotification(AppNotification notification) {
    try {
      notification.whenOrNull(
        snackBar: (title, message, type) {
          UIHelper.showAppSnackBar(
            context: context,
            title: title,
            message: message,
            type: type,
          );
        },
        dialog: (face, annotatedImage) {
          _showSuccessDialog(face, annotatedImage);
        },
      );
    } catch (error) {
      debugPrint('Error handling notification: $error');
      _showFallbackNotification();
    }
  }

  /// Show success dialog from stream notification
  void _showSuccessDialog(FaceDetectionResult face, String? annotatedImage) {
    try {
      context.read<StreamingBlocV2>().add(
        const BucketSequentialStreamingEventV2.stopStreaming(),
      );

      SuccessInfoDialog.show(
        context,
        faceId: face.faceId ?? 'Unknown',
        memoryImage:
            annotatedImage != null ? base64Decode(annotatedImage) : null,
        confidence: face.confidence,
        onDialogClosed: () {
          final controller = context.read<CameraBlocV2>().state.controller;
          if (controller != null) {
            context.read<StreamingBlocV2>().add(
              BucketSequentialStreamingEventV2.startStreaming(controller),
            );
          }
        },
      );
    } catch (error) {
      debugPrint('Error showing success dialog: $error');
      _showFallbackNotification();
    }
  }

  /// Generate unique key for notification throttling
  String _getNotificationKey(AppNotification notification) {
    return notification.when(
      snackBar: (title, message, type) => 'snackBar_${type.name}',
      dialog: (face, annotatedImage) => 'showSuccessDialog_${face.faceId}',
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _cleanupTimer?.cancel();
    _lastShownTimes.clear();
    super.dispose();
  }
}
