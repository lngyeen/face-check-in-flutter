import 'package:camera/camera.dart';

import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';
import 'package:face_check_in_flutter/domain/entities/processed_frame.dart';

class FramePipelineData {
  final CameraImage image;
  final CameraDescription camera;

  LocalFaceDetectionResult? faceResult;
  LivenessResult? livenessResult;
  ProcessedFrame? processedFrame;
  String? error;

  FramePipelineData(this.image, this.camera);
}
