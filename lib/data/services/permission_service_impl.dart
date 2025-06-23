import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import 'package:face_check_in_flutter/domain/services/permission_service.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/domain/mappers/permission_mapper.dart';

@LazySingleton(as: PermissionService)
class PermissionServiceImpl implements PermissionService {
  @override
  Future<PermissionStatus> getCameraPermissionStatus() async {
    final status = await ph.Permission.camera.status;
    return PermissionMapper.fromPermissionHandler(status);
  }

  @override
  Future<PermissionStatus> requestCameraPermission() async {
    final status = await ph.Permission.camera.request();
    return PermissionMapper.fromPermissionHandler(status);
  }

  @override
  Future<bool> openAppSettings() {
    return ph.openAppSettings();
  }
}
