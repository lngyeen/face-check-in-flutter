import 'dart:async';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';

/// Abstract interface for camera service
abstract class CameraServiceV2 {
  Stream<CameraController?> get controllerStream;
  Stream<CameraStatus> get statusStream;
  CameraController? get currentController;
  CameraStatus get currentStatus;

  Future<void> startCamera();
  Future<void> stopCamera();
}

/// Camera service implementation for managing camera hardware only
/// Does not handle streaming or frame processing
@LazySingleton(as: CameraServiceV2)
class CameraServiceV2Impl implements CameraServiceV2 {
  final PermissionService _permissionService;

  // Camera Management
  CameraController? _cameraController;

  final _controllerSubject = BehaviorSubject<CameraController?>();
  final _statusSubject = BehaviorSubject<CameraStatus>.seeded(
    CameraStatus.initial,
  );

  @override
  Stream<CameraController?> get controllerStream => _controllerSubject.stream;

  @override
  Stream<CameraStatus> get statusStream => _statusSubject.stream;

  @override
  CameraController? get currentController => _cameraController;

  @override
  CameraStatus get currentStatus => _statusSubject.value;

  CameraServiceV2Impl(this._permissionService);

  @override
  Future<void> startCamera() async {
    if (_cameraController != null) return;

    try {
      _statusSubject.add(CameraStatus.initializing);

      // Check and request camera permission
      final permissionStatus =
          await _permissionService.getCameraPermissionStatus();
      if (permissionStatus != PermissionStatus.granted) {
        final newStatus = await _permissionService.requestCameraPermission();
        if (newStatus != PermissionStatus.granted) {
          _statusSubject.add(CameraStatus.permissionDenied);
          return;
        }
      }

      // Get available cameras
      final cameras = await availableCameras();
      final frontCameras =
          cameras
              .where((c) => c.lensDirection == CameraLensDirection.front)
              .toList();

      if (frontCameras.isEmpty) {
        _statusSubject.add(CameraStatus.frontCameraNotAvailable);
        return;
      }

      // Initialize camera controller
      final cameraController = CameraController(
        frontCameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await cameraController.initialize();
      await cameraController.setFocusMode(FocusMode.auto);
      await cameraController.setExposureMode(ExposureMode.auto);

      _cameraController = cameraController;
      _controllerSubject.add(cameraController);
      _statusSubject.add(CameraStatus.ready);
    } catch (e) {
      _statusSubject.add(CameraStatus.error);
      await stopCamera();
    }
  }

  @override
  Future<void> stopCamera() async {
    if (_cameraController == null) return;

    try {
      await _cameraController?.dispose();
    } catch (e) {
      // Silent error handling
    }

    _cameraController = null;
    _controllerSubject.add(null);
    _statusSubject.add(CameraStatus.initial);
  }

  void closeStreams() {
    _controllerSubject.close();
    _statusSubject.close();
  }
}
