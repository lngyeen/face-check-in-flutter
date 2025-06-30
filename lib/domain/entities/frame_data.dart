import 'package:flutter/foundation.dart';

import 'package:camera/camera.dart';

/// A data class to safely transport camera frame data between isolates.
@immutable
class FrameData {
  final CameraImage image;
  final int sensorOrientation;
  final CameraLensDirection lensDirection;

  const FrameData({
    required this.image,
    required this.sensorOrientation,
    required this.lensDirection,
  });
}
