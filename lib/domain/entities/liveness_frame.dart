import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class LivenessFrame {
  final Face face;
  final CameraImage? image;
  final DateTime timestamp;

  const LivenessFrame({
    required this.face,
    required this.image,
    required this.timestamp,
  });
}
