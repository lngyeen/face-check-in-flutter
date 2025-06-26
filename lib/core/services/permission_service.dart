import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/domain/mappers/permission_mapper.dart';

/// Abstract interface for permission service
abstract class PermissionService {
  /// Request camera permission from the user
  Future<PermissionStatus> requestCameraPermission();

  /// Get current camera permission status without requesting
  Future<PermissionStatus> getCameraPermissionStatus();

  /// Open app settings for manual permission configuration
  Future<bool> openAppSettings();
}

/// Permission service implementation for handling camera permissions
/// Uses permission_handler package for cross-platform permission management
@LazySingleton(as: PermissionService)
class PermissionServiceImpl implements PermissionService {
  /// Get current camera permission status without requesting
  @override
  Future<PermissionStatus> getCameraPermissionStatus() async {
    final status = await ph.Permission.camera.status;
    return PermissionMapper.fromPermissionHandler(status);
  }

  /// Request camera permission from the user
  /// Returns the permission status after user interaction
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    final status = await ph.Permission.camera.request();
    return PermissionMapper.fromPermissionHandler(status);
  }

  /// Open app settings for manual permission configuration
  /// Returns true if settings were opened successfully
  @override
  Future<bool> openAppSettings() {
    return ph.openAppSettings();
  }
}
