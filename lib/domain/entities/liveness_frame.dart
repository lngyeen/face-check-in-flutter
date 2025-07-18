import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class LivenessFrame {
  final Face face;
  final CameraImage? image;

  const LivenessFrame({required this.face, required this.image});

  Size get imageSize =>
      Size(image?.width.toDouble() ?? 0, image?.height.toDouble() ?? 0);
}
