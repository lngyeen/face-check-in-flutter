import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/image_stream_service_v2.dart'
    as stream_service;
import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/app_notification.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';

@lazySingleton
class NotificationOrchestratorService {
  final CheckInBlocV2 _checkInBloc;
  final StreamingBlocV2 _streamingBloc;

  late final Stream<StatusUpdate> statusNotificationStream;
  late final Stream<AppNotification> eventNotificationStream;

  NotificationOrchestratorService(this._checkInBloc, this._streamingBloc) {
    // Status stream: only statusUpdate from StreamingBlocV2
    statusNotificationStream = _streamingBloc.stream
        .map(_convertStreamingStateToStatusUpdate)
        .where((notification) => notification != null)
        .cast<StatusUpdate>()
        .doOnData((statusUpdate) {
          // Show status update in UI
          print('Status Update: $statusUpdate');
        })
        .distinct((prev, next) => prev.message == next.message)
        //.throttleTime(const Duration(seconds: 1), leading: true)
        .doOnData((statusUpdate) {
          // Show status update in UI
          print('throttleTime Status Update: $statusUpdate');
        })
        .asBroadcastStream(onCancel: (sub) => sub.cancel());

    // Event stream: only showSnackBar/showSuccessDialog from CheckInBlocV2
    eventNotificationStream =
        _checkInBloc.stream
            .map(_convertCheckInStateToEvent)
            .where((notification) => notification != null)
            .cast<AppNotification>()
            .publish()
            .autoConnect();
  }

  // Only statusUpdate for status view
  static StatusUpdate? _convertStreamingStateToStatusUpdate(
    StreamingStateV2 streamingState,
  ) {
    final processingStatus = streamingState.processingStatus;
    switch (processingStatus) {
      case stream_service.ProcessingStatus.waitingForFace:
        return AppNotification.statusUpdate(
              message: 'Waiting for face detection...',
              type: StatusType.info,
            )
            as StatusUpdate;
      case stream_service.ProcessingStatus.livenessChecking:
        return AppNotification.statusUpdate(
              message: 'Processing...',
              type: StatusType.info,
            )
            as StatusUpdate;
      case stream_service.ProcessingStatus.readyForCheckIn:
        final livenessResult = streamingState.livenessResult;
        if (livenessResult != null) {
          if (livenessResult.isPassed) {
            return const AppNotification.statusUpdate(
                  message: 'Liveness check passed!',
                  type: StatusType.success,
                )
                as StatusUpdate;
          }
        }
        break;
      case stream_service.ProcessingStatus.error:
        return null;
    }
    return null;
  }

  // Only showSnackBar/showSuccessDialog for event (snackbar/dialog)
  static AppNotification? _convertCheckInStateToEvent(
    CheckInStateV2 checkInState,
  ) {
    if (checkInState.status == CheckInStatusV2.error &&
        checkInState.currentError != null) {
      return AppNotification.showSnackBar(
        title: 'System Error',
        message: checkInState.currentError!.message,
        type: SnackBarType.error,
      );
    }
    if (checkInState.latestFrameData != null &&
        checkInState.detectedFaces.isNotEmpty) {
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
