import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

extension AppConnectionStatusX on AppConnectionStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case AppConnectionStatus.connected:
        return Colors.green;
      case AppConnectionStatus.connecting:
        return Colors.orange;
      case AppConnectionStatus.initial:
        return Colors.grey;
      case AppConnectionStatus.networkLost:
      case AppConnectionStatus.failed:
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        return Colors.red;
    }
  }
}

extension CameraStatusX on CameraStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case CameraStatus.ready:
        return Colors.green;
      case CameraStatus.initializing:
        return Colors.orange;
      case CameraStatus.initial:
        return Colors.grey;
      case CameraStatus.permissionDenied:
      case CameraStatus.frontCameraNotAvailable:
      case CameraStatus.error:
        return Colors.red;
    }
  }
}

extension StreamingStatusX on StreamingStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case StreamingStatus.active:
        return Colors.green;
      case StreamingStatus.idle:
        return Colors.grey;
      case StreamingStatus.error:
        return Colors.red;
    }
  }
}
