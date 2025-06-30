import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_detection_result.freezed.dart';
part 'face_detection_result.g.dart';

/// Face detection result data model for backend responses
@freezed
class FaceDetectionResult with _$FaceDetectionResult {
  const factory FaceDetectionResult({
    required String frameId,
    required DateTime timestamp,
    required List<DetectedFace> faces,
    required FaceDetectionStatus status,
  }) = _FaceDetectionResult;

  factory FaceDetectionResult.fromJson(Map<String, dynamic> json) =>
      _$FaceDetectionResultFromJson(json);
}

/// Individual detected face data
@freezed
class DetectedFace with _$DetectedFace {
  const factory DetectedFace({
    required String faceId,
    @JsonKey(name: 'bbox') required List<double> box, // [x, y, width, height]
    required double confidence,
    required bool isRecognized,
    String? personId,
    String? employeeName,
  }) = _DetectedFace;

  factory DetectedFace.fromJson(Map<String, dynamic> json) =>
      _$DetectedFaceFromJson(json);
}

/// Face detection status enum
enum FaceDetectionStatus {
  @JsonValue('none')
  none,
  @JsonValue('detecting')
  detecting,
  @JsonValue('face_found')
  faceFound,
  @JsonValue('multiple_faces')
  multipleFaces,
  @JsonValue('no_face')
  noFace,
  @JsonValue('error')
  error,
}

/// Recognition statistics tracking
@freezed
class RecognitionStatistics with _$RecognitionStatistics {
  const factory RecognitionStatistics({
    @Default(0) int totalFramesProcessed,
    @Default(0) int totalFacesDetected,
    @Default(0) int successfulRecognitions,
    @Default(0) int failedRecognitions,
    @Default(0.0) double averageConfidence,
    @Default(0.0) double averageProcessingTimeMs,
    DateTime? lastRecognitionTime,
    DateTime? sessionStartTime,
  }) = _RecognitionStatistics;

  factory RecognitionStatistics.fromJson(Map<String, dynamic> json) =>
      _$RecognitionStatisticsFromJson(json);
}
