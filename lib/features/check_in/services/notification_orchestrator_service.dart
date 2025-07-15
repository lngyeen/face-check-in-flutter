import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/app_notification.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';
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
        return AppNotification.statusUpdate(
              message: 'Waiting for face detection...',
              type: StatusType.info,
            )
            as StatusUpdate;
      case ProcessingStatus.livenessChecking:
        return AppNotification.statusUpdate(
              message: 'Processing...',
              type: StatusType.info,
            )
            as StatusUpdate;
      case ProcessingStatus.readyForCheckIn:
        return AppNotification.statusUpdate(
              message: 'Ready for check-in!',
              type: StatusType.success,
            )
            as StatusUpdate;
      case ProcessingStatus.error:
        return null;
    }
  }

  AppNotification? _convertCheckInStateToEvent(CheckInStateV2 checkInState) {
    if (checkInState.currentError != null) {
      return AppNotification.showSnackBar(
        title: 'System Error',
        message: checkInState.currentError!.message,
        type: SnackBarType.error,
      );
    }
    if (checkInState.detectedFaces.isNotEmpty) {
      final face = checkInState.detectedFaces.first;
      if (face.isRecognized && face.faceId != null) {
        final annotatedImage = checkInState.annotatedImage;
        return AppNotification.showSuccessDialog(
          face: face,
          annotatedImage: annotatedImage,
        );
      } else {
        return const AppNotification.showSnackBar(
          title: 'Face Not Recognized',
          message:
              'Face detected but not recognized. Ensure good lighting and face the camera directly.',
          type: SnackBarType.warning,
        );
      }
    }
    return null;
  }
}
