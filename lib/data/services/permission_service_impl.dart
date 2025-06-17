import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import 'package:face_check_in_flutter/domain/services/permission_service.dart';

@LazySingleton(as: PermissionService)
class PermissionServiceImpl implements PermissionService {
  @override
  Future<PermissionStatus> getCameraPermissionStatus() {
    return ph.Permission.camera.status;
  }

  @override
  Future<PermissionStatus> requestCameraPermission() {
    return ph.Permission.camera.request();
  }

  @override
  Future<bool> openAppSettings() {
    return ph.openAppSettings();
  }
}
