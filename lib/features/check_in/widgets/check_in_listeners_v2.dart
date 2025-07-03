import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/di/di.dart';
import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/notification_type.dart';
import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/services/check_in_notification_service.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/success_info_dialog.dart';
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';

class CheckInListenersV2 extends StatefulWidget {
  const CheckInListenersV2({super.key, required this.child});

  final Widget child;

  @override
  State<CheckInListenersV2> createState() => _CheckInListenersV2State();
}

class _CheckInListenersV2State extends State<CheckInListenersV2> {
  final _notificationService = getIt<CheckInNotificationService>();
  final _stateSubject = BehaviorSubject<CheckInStateV2>();
  late final StreamSubscription _notificationSubscription;

  static const _throttleDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _setupNotificationStream();
  }

  @override
  void dispose() {
    _notificationSubscription.cancel();
    _stateSubject.close();
    super.dispose();
  }

  void _setupNotificationStream() {
    _notificationSubscription = _stateSubject
        .map((state) => _notificationService.convertStateToNotification(state))
        .where((notification) => notification != null)
        .throttleTime(_throttleDuration)
        .listen((notification) {
          if (mounted) {
            _handleNotification(context, notification!);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckInBlocV2, CheckInStateV2>(
      listener: (context, state) => _stateSubject.add(state),
      child: widget.child,
    );
  }

  void _handleNotification(
    BuildContext context,
    NotificationType notificationType,
  ) {
    notificationType.when(
      recognizedFace: (face) {
        _showSuccessDialog(context, face);
      },
      unrecognized: () {
        _showUnrecognizedFaceMessage(context);
      },
      multipleFaces: (multipleFaces) {
        _showMultipleFacesMessage(context, multipleFaces);
      },
    );
  }

  void _showSuccessDialog(BuildContext context, FaceDetectionResult face) {
    final currentState = _stateSubject.value;

    context.read<StreamingBlocV2>().add(const StreamingEventV2.stopStreaming());

    SuccessInfoDialog.show(
      context,
      faceId: face.faceId ?? 'Unknown',
      memoryImage:
          currentState.annotatedImage != null
              ? base64Decode(currentState.annotatedImage!)
              : null,
      confidence: face.confidence,
      onDialogClosed: () {
        final controller = context.read<CameraBlocV2>().state.controller;
        if (controller != null) {
          context.read<StreamingBlocV2>().add(
            StreamingEventV2.startStreaming(controller),
          );
        }
      },
    );
  }

  void _showUnrecognizedFaceMessage(BuildContext context) {
    UIHelper.showAppSnackBar(
      context: context,
      title: 'Face Not Recognized',
      message:
          'Face detected but not recognized. Ensure good lighting and face the camera directly.',
      type: SnackBarType.warning,
    );
  }

  void _showMultipleFacesMessage(
    BuildContext context,
    List<FaceDetectionResult> faces,
  ) {
    final recognizedCount = faces.where((face) => face.isRecognized).length;
    final unrecognizedCount = faces.length - recognizedCount;

    String message;
    if (recognizedCount == 0) {
      message =
          'Multiple faces detected ($unrecognizedCount unknown). Please ensure only one person is visible.';
    } else if (unrecognizedCount == 0) {
      message =
          'Multiple faces detected ($recognizedCount recognized). Please ensure only one person is visible.';
    } else {
      message =
          'Multiple faces detected ($recognizedCount known, $unrecognizedCount unknown). Please ensure only one person is visible.';
    }

    UIHelper.showAppSnackBar(
      context: context,
      title: 'Multiple Faces Detected',
      message: message,
      type: SnackBarType.info,
    );
  }
}
