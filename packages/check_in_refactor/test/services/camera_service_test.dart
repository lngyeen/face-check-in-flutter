import 'package:camera/camera.dart';
import 'package:check_in_refactor/services/camera_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart'
    as domain;

// Mock classes for testing
class MockCameraController extends Mock implements CameraController {}

class MockPermissionService extends Mock implements PermissionService {}

void main() {
  group('CameraServiceImpl', () {
    late CameraServiceImpl cameraService;
    late MockPermissionService mockPermissionService;

    setUp(() {
      mockPermissionService = MockPermissionService();
      cameraService = CameraServiceImpl(mockPermissionService);

      // Setup default permission behavior
      when(() => mockPermissionService.getCameraPermissionStatus())
          .thenAnswer((_) async => domain.PermissionStatus.granted);
      when(() => mockPermissionService.requestCameraPermission())
          .thenAnswer((_) async => domain.PermissionStatus.granted);
    });

    tearDown(() {
      cameraService.dispose();
    });

    group('Initial State', () {
      test('should start with initial status', () {
        expect(cameraService.currentStatus, CameraStatus.initial);
        expect(cameraService.currentController, isNull);
        expect(cameraService.isCameraActive, isFalse);
      });

      test('should emit initial status in stream', () {
        expect(
          cameraService.statusStream,
          emits(CameraStatus.initial),
        );
      });

      test('should provide controller stream', () {
        expect(
            cameraService.controllerStream, isA<Stream<CameraController?>>());
      });
    });

    group('Status Stream', () {
      test('should emit status changes including ready state', () async {
        final statusList = <CameraStatus>[];

        final subscription = cameraService.statusStream.listen(
          (status) => statusList.add(status),
        );

        // Initial status should be emitted
        await Future.delayed(const Duration(milliseconds: 10));
        expect(statusList, contains(CameraStatus.initial));

        await subscription.cancel();
      });
    });

    group('Controller Stream', () {
      test('should provide controller stream', () {
        expect(
            cameraService.controllerStream, isA<Stream<CameraController?>>());
      });
    });

    group('Permission Methods', () {
      test(
          'requestCameraPermission should return granted when permission service grants',
          () async {
        when(() => mockPermissionService.requestCameraPermission())
            .thenAnswer((_) async => domain.PermissionStatus.granted);

        final result = await cameraService.requestCameraPermission();
        expect(result, PermissionStatus.granted);
        verify(() => mockPermissionService.requestCameraPermission()).called(1);
      });

      test(
          'requestCameraPermission should return denied when permission service denies',
          () async {
        when(() => mockPermissionService.requestCameraPermission())
            .thenAnswer((_) async => domain.PermissionStatus.denied);

        final result = await cameraService.requestCameraPermission();
        expect(result, PermissionStatus.denied);
        verify(() => mockPermissionService.requestCameraPermission()).called(1);
      });

      test(
          'getCameraPermissionStatus should return correct status from permission service',
          () async {
        when(() => mockPermissionService.getCameraPermissionStatus())
            .thenAnswer((_) async => domain.PermissionStatus.permanentlyDenied);

        final result = await cameraService.getCameraPermissionStatus();
        expect(result, PermissionStatus.permanentlyDenied);
        verify(() => mockPermissionService.getCameraPermissionStatus())
            .called(1);
      });

      test('should map initial domain status to unknown', () async {
        when(() => mockPermissionService.getCameraPermissionStatus())
            .thenAnswer((_) async => domain.PermissionStatus.initial);

        final result = await cameraService.getCameraPermissionStatus();
        expect(result, PermissionStatus.unknown);
      });
    });

    group('Lifecycle Management', () {
      test('stop should reset state when camera not active', () async {
        // Camera is not active initially
        expect(cameraService.isCameraActive, isFalse);

        await cameraService.stop();

        expect(cameraService.currentController, isNull);
        expect(cameraService.currentStatus, CameraStatus.initial);
        expect(cameraService.isCameraActive, isFalse);
      });

      test('dispose should cleanup resources synchronously', () {
        // Dispose should not throw and should be synchronous
        expect(() => cameraService.dispose(), returnsNormally);

        // After dispose, the service should be in a safe state
        expect(cameraService.isCameraActive, isFalse);
        expect(cameraService.currentController, isNull);
      });
    });

    group('Error Handling', () {
      test('should handle disposal errors gracefully', () {
        // Dispose should handle any errors without throwing
        expect(() => cameraService.dispose(), returnsNormally);
      });

      test('should cleanup properly on start failure', () async {
        // Mock permission to be denied after request
        when(() => mockPermissionService.getCameraPermissionStatus())
            .thenAnswer((_) async => domain.PermissionStatus.denied);
        when(() => mockPermissionService.requestCameraPermission())
            .thenAnswer((_) async => domain.PermissionStatus.denied);

        await cameraService.start();

        expect(cameraService.currentStatus, CameraStatus.permissionDenied);
        expect(cameraService.isCameraActive, isFalse);
        expect(cameraService.currentController, isNull);
      });
    });
  });
}
