import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/app_notification.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
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
        .map(_convertStreamStateToStatusUpdate)
        .where((notification) => notification != null)
        .cast<StatusUpdate>()
        .shareReplay(maxSize: 1);

    eventNotificationStream = _checkInBloc.stream
        .map(_convertCheckInStateToEvent)
        .where((notification) => notification != null)
        .cast<AppNotification>()
        .shareReplay(maxSize: 1);
  }

  StatusUpdate? _convertStreamStateToStatusUpdate(StreamingStateV2 state) {
    switch (state.processingStatus) {
      case ProcessingStatus.waitingForFace:
        return StatusUpdate(
          message: 'Waiting for face detection...',
          type: StatusType.info,
        );
      case ProcessingStatus.livenessChecking:
        return StatusUpdate(message: 'Processing...', type: StatusType.info);
      case ProcessingStatus.readyForCheckIn:
        return StatusUpdate(
          message: 'Ready for check-in!',
          type: StatusType.success,
        );
      case ProcessingStatus.error:
        return null;
    }
  }

  AppNotification? _convertCheckInStateToEvent(CheckInStateV2 checkInState) {
    if (checkInState.currentError != null) {
      return AppNotification.snackBar(
        title: 'System Error',
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
      return AppNotification.snackBar(
        title: 'Face Not Recognized',
        message:
            'Face detected but not recognized. Ensure good lighting and face the camera directly.',
        type: SnackBarType.warning,
      );
    }
  }

  AppNotification _createMultipleFacesNotification(
    List<FaceDetectionResult> faces,
  ) {
    final recognizedCount =
        faces.where((face) => face.isRecognized == true).length;
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

    return AppNotification.snackBar(
      title: 'Multiple Faces Detected',
      message: message,
      type: SnackBarType.info,
    );
  }
}
