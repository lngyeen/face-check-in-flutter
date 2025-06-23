import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/domain/entities/connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_status.dart';

/// Extensions for displaying status information in the UI
/// These extensions provide consistent display formatting for status enums

extension FaceDetectionStatusX on FaceDetectionStatus {
  Color get displayColor {
    switch (this) {
      case FaceDetectionStatus.faceFound:
        return Colors.green;
      case FaceDetectionStatus.faceUnrecognized:
      case FaceDetectionStatus.noFace:
        return Colors.orange;
      case FaceDetectionStatus.multipleFaces:
      case FaceDetectionStatus.error:
        return Colors.red;
      case FaceDetectionStatus.none:
        return Colors.grey;
    }
  }
}

extension ConnectionStatusX on ConnectionStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.failed:
      case ConnectionStatus.timeout:
        return Colors.red;
      case ConnectionStatus.connecting:
      case ConnectionStatus.retrying:
        return Colors.orange;
      case ConnectionStatus.disconnected:
        return Colors.grey;
    }
  }
}
