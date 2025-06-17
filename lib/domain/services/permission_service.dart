import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart'
    show PermissionStatus;

abstract class PermissionService {
  Future<PermissionStatus> requestCameraPermission();

  Future<PermissionStatus> getCameraPermissionStatus();

  Future<bool> openAppSettings();
}
