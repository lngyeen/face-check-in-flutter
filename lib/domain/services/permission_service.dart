import '../entities/permission_status.dart';

abstract class PermissionService {
  Future<PermissionStatus> requestCameraPermission();

  Future<PermissionStatus> getCameraPermissionStatus();

  Future<bool> openAppSettings();
}
