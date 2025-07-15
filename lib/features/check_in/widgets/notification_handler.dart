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

class NotificationHandler extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return StreamListener<AppNotification>(
      stream: eventNotificationStream,
      onData: (notification) => _handleNotification(context, notification),
      throttleDuration: throttleDuration,
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
    context.read<StreamingBlocV2>().add(
      const BucketSequentialStreamingEventV2.stopStreaming(),
    );

    SuccessInfoDialog.show(
      context,
      faceId: face.faceId ?? 'Unknown',
      memoryImage: annotatedImage != null ? base64Decode(annotatedImage) : null,
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
  }
}

class StreamListener<T> extends StatefulWidget {
  const StreamListener({
    super.key,
    required this.stream,
    required this.onData,
    required this.child,
    this.throttleDuration = const Duration(seconds: 3),
  });

  final Stream<T> stream;
  final Function(T data) onData;
  final Widget child;
  final Duration throttleDuration;

  @override
  State<StreamListener<T>> createState() => _StreamListenerState<T>();
}

class _StreamListenerState<T> extends State<StreamListener<T>> {
  late StreamSubscription<T> _subscription;
  final Map<String, DateTime> _lastShownTimes = {};

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen((data) {
      if (mounted) {
        _handleDataWithThrottle(data);
      }
    });
  }

  void _handleDataWithThrottle(T data) {
    final notificationKey = _getNotificationKey(data);
    final now = DateTime.now();

    final lastShown = _lastShownTimes[notificationKey];
    final timeSinceLastShown =
        lastShown != null ? now.difference(lastShown) : Duration.zero;

    if (lastShown == null || timeSinceLastShown >= widget.throttleDuration) {
      _lastShownTimes[notificationKey] = now;
      widget.onData(data);
    }
  }

  String _getNotificationKey(T notification) {
    if (notification is AppNotification) {
      return notification.when(
        statusUpdate: (message, type) => 'statusUpdate_${type.name}_$message',
        showSnackBar:
            (title, message, type) => 'showSnackBar_${type.name}_$title',
        showSuccessDialog:
            (face, annotatedImage) => 'showSuccessDialog_${face.faceId}',
      );
    }
    return '${notification.runtimeType}_${notification.toString()}';
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
