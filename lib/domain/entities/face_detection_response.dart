import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_detection_response.freezed.dart';
part 'face_detection_response.g.dart';

@freezed
class FaceDetectionResponse with _$FaceDetectionResponse {
  const factory FaceDetectionResponse({
    required String type,
    required FaceDetectionData data,
  }) = _FaceDetectionResponse;

  factory FaceDetectionResponse.fromJson(Map<String, dynamic> json) =>
      _$FaceDetectionResponseFromJson(json);
}

@freezed
class FaceDetectionData with _$FaceDetectionData {
  const factory FaceDetectionData({
    required List<FaceDetectionResult> faces,
    @Default('') String faceImagePath,
    @Default('') String cameraId,
    required String timestamp,
    @Default(0) int processingTime,
    @Default(false) bool isCheckinSent,
    String? annotatedImage, // Base64 encoded annotated image
  }) = _FaceDetectionData;

  factory FaceDetectionData.fromJson(Map<String, dynamic> json) =>
      _$FaceDetectionDataFromJson(json);
}

@freezed
class FaceDetectionResult with _$FaceDetectionResult {
  const FaceDetectionResult._();

  const factory FaceDetectionResult({
    String? faceId,
    @Default(false) bool isRecognized,
    @Default(0.0) double confidence,
    String? gender,
    int? age,
    @Default(false) bool mask,
    @Default([]) List<int> bbox, // [x, y, width, height]
  }) = _FaceDetectionResult;

  factory FaceDetectionResult.fromJson(Map<String, dynamic> json) =>
      _$FaceDetectionResultFromJson(json);

  BoundingBox get boundingBox {
    if (bbox.length == 4) {
      return BoundingBox(
        x: bbox[0].toDouble(),
        y: bbox[1].toDouble(),
        width: bbox[2].toDouble(),
        height: bbox[3].toDouble(),
      );
    }

    return BoundingBox(x: 0.0, y: 0.0, width: 0.0, height: 0.0);
  }
}

@freezed
class ImageSize with _$ImageSize {
  const factory ImageSize({required int width, required int height}) =
      _ImageSize;

  factory ImageSize.fromJson(Map<String, dynamic> json) =>
      _$ImageSizeFromJson(json);
}

@freezed
class BoundingBox with _$BoundingBox {
  const factory BoundingBox({
    required double x,
    required double y,
    required double width,
    required double height,
  }) = _BoundingBox;

  factory BoundingBox.fromJson(Map<String, dynamic> json) =>
      _$BoundingBoxFromJson(json);
}
