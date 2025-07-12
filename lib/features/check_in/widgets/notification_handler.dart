import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/di/di.dart';
import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/app_notification.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/services/notification_orchestrator_service.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/success_info_dialog.dart';
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';

class NotificationHandler extends StatelessWidget {
  const NotificationHandler({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamListener<AppNotification>(
      stream: getIt<NotificationOrchestratorService>().eventNotificationStream,
      onData: (notification) => _handleNotification(context, notification),
      child: child,
    );
  }

  void _handleNotification(BuildContext context, AppNotification notification) {
    notification.whenOrNull(
      showSnackBar: (title, message, type) {
        UIHelper.showAppSnackBar(
          context: context,
          title: title,
          message: message,
          type: type,
        );
      },
      showSuccessDialog: (face, annotatedImage) {
        _showSuccessDialog(context, face, annotatedImage);
      },
    );
  }

  void _showSuccessDialog(
    BuildContext context,
    FaceDetectionResult face,
    String? annotatedImage,
  ) {
    // Stop the stream to prevent background processing while dialog is shown
    context.read<StreamingBlocV2>().add(
      const BucketSequentialStreamingEventV2.stopStreaming(),
    );

    SuccessInfoDialog.show(
      context,
      faceId: face.faceId ?? 'Unknown',
      memoryImage: annotatedImage != null ? base64Decode(annotatedImage) : null,
      confidence: face.confidence,
      onDialogClosed: () {
        // Restart the stream when the dialog is closed
        final controller = context.read<CameraBlocV2>().state.controller;
        if (controller != null) {
          context.read<StreamingBlocV2>().add(
            BucketSequentialStreamingEventV2.startStreaming(controller),
          );
        }
      },
    );
  }
}

class StreamListener<T> extends StatefulWidget {
  const StreamListener({
    super.key,
    required this.stream,
    required this.onData,
    required this.child,
  });

  final Stream<T> stream;
  final Function(T data) onData;
  final Widget child;

  @override
  State<StreamListener<T>> createState() => _StreamListenerState<T>();
}

class _StreamListenerState<T> extends State<StreamListener<T>> {
  late StreamSubscription<T> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen((data) {
      if (mounted) {
        widget.onData(data);
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
