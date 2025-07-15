import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

extension FaceExtension on Face {
  String generateFaceId() {
    final buffer = StringBuffer();
    buffer.write('${boundingBox.left.toInt()}_${boundingBox.top.toInt()}_');
    buffer.write('${boundingBox.width.toInt()}_${boundingBox.height.toInt()}');

    final keyLandmarkTypes = [
      FaceLandmarkType.noseBase,
      FaceLandmarkType.leftEye,
      FaceLandmarkType.rightEye,
      FaceLandmarkType.leftMouth,
      FaceLandmarkType.rightMouth,
    ];

    for (final landmarkType in keyLandmarkTypes) {
      final landmark = landmarks[landmarkType];
      if (landmark != null) {
        final pos = landmark.position;
        buffer.write('_${pos.x.toInt()}_${pos.y.toInt()}');
      }
    }

    return buffer.toString();
  }
}
