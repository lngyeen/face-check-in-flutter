import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_detection_result.freezed.dart';
part 'face_detection_result.g.dart';

/// Face detection result data from backend
@freezed
class FaceDetectionResult with _$FaceDetectionResult {
  const factory FaceDetectionResult({
    required String id,
    required double confidence,
    required double x,
    required double y,
    required double width,
    required double height,
    String? label,
    Map<String, dynamic>? metadata,
  }) = _FaceDetectionResult;

  factory FaceDetectionResult.fromJson(Map<String, dynamic> json) =>
      _$FaceDetectionResultFromJson(json);
}
