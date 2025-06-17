import 'package:face_check_in_flutter/data/services/permission_service_impl.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPermissionHandlerPlatform
    with MockPlatformInterfaceMixin
    implements PermissionHandlerPlatform {
  PermissionStatus? _status;
  PermissionStatus? _requestStatus;

  void akgnsPermissionStatus(PermissionStatus status) {
    _status = status;
  }

  void akgnsRequestPermissionStatus(PermissionStatus status) {
    _requestStatus = status;
  }

  @override
  Future<PermissionStatus> checkPermissionStatus(Permission permission) async {
    return _status ?? PermissionStatus.denied;
  }

  @override
  Future<Map<Permission, PermissionStatus>> requestPermissions(
    List<Permission> permissions,
  ) async {
    return {
      for (var p in permissions) p: _requestStatus ?? PermissionStatus.denied,
    };
  }

  @override
  Future<bool> openAppSettings() {
    throw UnimplementedError();
  }

  @override
  Future<ServiceStatus> checkServiceStatus(Permission permission) {
    throw UnimplementedError();
  }

  @override
  Future<bool> shouldShowRequestPermissionRationale(Permission permission) {
    throw UnimplementedError();
  }
}

void main() {
  late PermissionService permissionService;
  late MockPermissionHandlerPlatform mockPermissionHandlerPlatform;

  setUp(() {
    mockPermissionHandlerPlatform = MockPermissionHandlerPlatform();
    PermissionHandlerPlatform.instance = mockPermissionHandlerPlatform;
    permissionService = PermissionServiceImpl();
  });

  group('PermissionServiceImpl', () {
    group('getCameraPermissionStatus', () {
      test('should return camera permission status', () async {
        // arrange
        mockPermissionHandlerPlatform.akgnsPermissionStatus(
          PermissionStatus.granted,
        );
        // act
        final result = await permissionService.getCameraPermissionStatus();
        // assert
        expect(result, PermissionStatus.granted);
      });
    });

    group('requestCameraPermission', () {
      test('should return requested camera permission status', () async {
        // arrange
        mockPermissionHandlerPlatform.akgnsRequestPermissionStatus(
          PermissionStatus.granted,
        );
        // act
        final result = await permissionService.requestCameraPermission();
        // assert
        expect(result, PermissionStatus.granted);
      });

      test('should return denied if permission is denied', () async {
        // arrange
        mockPermissionHandlerPlatform.akgnsRequestPermissionStatus(
          PermissionStatus.denied,
        );
        // act
        final result = await permissionService.requestCameraPermission();
        // assert
        expect(result, PermissionStatus.denied);
      });
    });
  });
}
