import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/domain/entities/notification_type.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';

abstract class CheckInNotificationService {
  NotificationType? convertStateToNotification(CheckInStateV2 state);
}

@Injectable(as: CheckInNotificationService)
class CheckInNotificationServiceImpl implements CheckInNotificationService {
  @override
  NotificationType? convertStateToNotification(CheckInStateV2 state) {
    final faces = state.detectedFaces;

    if (faces.isEmpty) {
      return null;
    }

    if (faces.length == 1) {
      final face = faces.first;

      if (face.isRecognized && face.faceId != null) {
        return NotificationType.recognizedFace(face);
      } else {
        return NotificationType.unrecognized();
      }
    } else {
      return NotificationType.multipleFaces(faces);
    }
  }
}
