import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_type.freezed.dart';

@freezed
class NotificationType with _$NotificationType {
  const factory NotificationType.recognizedFace(FaceDetectionResult face) =
      _RecognizedFace;

  const factory NotificationType.unrecognized() = _Unrecognized;

  const factory NotificationType.multipleFaces(
    List<FaceDetectionResult> faces,
  ) = _MultipleFaces;
}
