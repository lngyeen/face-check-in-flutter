import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

/// Mapper class to convert between permission_handler.PermissionStatus and domain PermissionStatus
class PermissionMapper {
  /// Converts permission_handler.PermissionStatus to domain PermissionStatus
  static PermissionStatus fromPermissionHandler(ph.PermissionStatus status) {
    switch (status) {
      case ph.PermissionStatus.granted:
        return PermissionStatus.granted;
      case ph.PermissionStatus.denied:
        return PermissionStatus.denied;
      case ph.PermissionStatus.permanentlyDenied:
        return PermissionStatus.permanentlyDenied;
      case ph.PermissionStatus.restricted:
        // iOS specific: treat as denied
        return PermissionStatus.denied;
      case ph.PermissionStatus.limited:
        // iOS specific: treat as granted for basic functionality
        return PermissionStatus.granted;
      case ph.PermissionStatus.provisional:
        // iOS specific: treat as granted
        return PermissionStatus.granted;
    }
  }

  /// Converts domain PermissionStatus to permission_handler.PermissionStatus
  /// Note: This conversion may lose information as domain enum is simpler
  static ph.PermissionStatus toPermissionHandler(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.initial:
        // For initial state, we consider it as denied
        return ph.PermissionStatus.denied;
      case PermissionStatus.granted:
        return ph.PermissionStatus.granted;
      case PermissionStatus.denied:
        return ph.PermissionStatus.denied;
      case PermissionStatus.permanentlyDenied:
        return ph.PermissionStatus.permanentlyDenied;
    }
  }
}
