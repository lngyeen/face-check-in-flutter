import 'package:freezed_annotation/freezed_annotation.dart';

import '../../services/face_detection_service.dart';

part 'face_detection_event.freezed.dart';

@freezed
class FaceDetectionEvent with _$FaceDetectionEvent {
  const factory FaceDetectionEvent.detectionReceived(
      FaceDetectionData faceDetectionData) = DetectionReceived;
  const factory FaceDetectionEvent.connectionStatusChanged(dynamic newStatus) =
      ConnectionStatusChanged;
  const factory FaceDetectionEvent.clearResults() = ClearResults;
  const factory FaceDetectionEvent.startProcessing() = StartProcessing;
  const factory FaceDetectionEvent.stopProcessing() = StopProcessing;
}
