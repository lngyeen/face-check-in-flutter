import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_detection_response.freezed.dart';
part 'face_detection_response.g.dart';

@freezed
class FaceDetectionResponse with _$FaceDetectionResponse {
  const factory FaceDetectionResponse({
    required String type, // "frameResult"
    required List<FaceDetectionResult> faces,
    String? frameId,
    DateTime? timestamp,
  }) = _FaceDetectionResponse;

  factory FaceDetectionResponse.fromJson(Map<String, dynamic> json) =>
      _$FaceDetectionResponseFromJson(json);
}

@freezed
class FaceDetectionResult with _$FaceDetectionResult {
  const factory FaceDetectionResult({
    required double x,
    required double y,
    required double width,
    required double height,
    required double confidence,
    String? personId,
    String? personName,
  }) = _FaceDetectionResult;

  factory FaceDetectionResult.fromJson(Map<String, dynamic> json) =>
      _$FaceDetectionResultFromJson(json);
}
