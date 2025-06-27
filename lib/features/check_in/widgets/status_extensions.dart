import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

/// Extensions for displaying status information in the UI
/// These extensions provide consistent display formatting for status enums

extension AppConnectionStatusX on AppConnectionStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case AppConnectionStatus.initial:
        return Colors.grey;
      case AppConnectionStatus.connected:
        return Colors.green;
      case AppConnectionStatus.networkLost:
      case AppConnectionStatus.failed:
        return Colors.red;
      case AppConnectionStatus.connecting:
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        return Colors.orange;
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
