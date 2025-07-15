import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

part 'local_face_detection_result.freezed.dart';

@freezed
class LocalFaceDetectionResult with _$LocalFaceDetectionResult {
  const LocalFaceDetectionResult._();

  const factory LocalFaceDetectionResult.skip() = _Skip;
  const factory LocalFaceDetectionResult.noFaceDetected() = _NoFaceDetected;
  const factory LocalFaceDetectionResult.singleFaceDetected({
    required Face face,
  }) = _SingleFaceDetected;
  const factory LocalFaceDetectionResult.multipleFacesDetected({
    required List<Face> faces,
  }) = _MultipleFacesDetected;
  const factory LocalFaceDetectionResult.faceTooSmall({required Face face}) =
      _FaceTooSmall;
  const factory LocalFaceDetectionResult.error({required String message}) =
      _Error;

  /// Returns true if a single, valid face was detected.
  bool get isSingleValidFace => maybeWhen(
    singleFaceDetected: (face) => true,
    skip: () => true,
    orElse: () => false,
  );

  Face? get face => maybeWhen(
    singleFaceDetected: (face) => face,
    faceTooSmall: (face) => face,
    multipleFacesDetected: (faces) => faces.first,
    orElse: () => null,
  );
}
