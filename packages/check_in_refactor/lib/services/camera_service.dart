import 'dart:async';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart'
    as domain;

/// Permission status enum for camera access
enum PermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  unknown,
}

/// Camera status enum representing different states
enum CameraStatus {
  initial,
  initializing,
  ready, // Camera is initialized and ready for streaming
  permissionDenied,
  frontCameraNotAvailable,
  error,
}

/// Camera error class for error handling
class CameraError {
  final String message;
  final Exception? exception;

  const CameraError({
    required this.message,
    this.exception,
  });

  @override
  String toString() => 'CameraError: $message';
}

/// Abstract interface for camera management services
///
/// Provides clean separation of camera concerns from business logic.
/// Handles camera lifecycle, permissions, and hardware access.
abstract class CameraService {
  /// Stream of camera controller instances
  Stream<CameraController?> get controllerStream;

  /// Stream of camera status changes
  Stream<CameraStatus> get statusStream;

  /// Current camera controller (nullable)
  CameraController? get currentController;

  /// Current camera status
  CameraStatus get currentStatus;

  /// Check if camera is currently active
  bool get isCameraActive;

  /// Start camera with proper initialization
  Future<void> start();

  /// Stop camera and dispose resources
  Future<void> stop();

  /// Request camera permissions
  Future<PermissionStatus> requestCameraPermission();

  /// Get current camera permission status
  Future<PermissionStatus> getCameraPermissionStatus();

  /// Dispose service and cleanup resources
  void dispose();
}

/// Implementation of CameraService
///
/// Extracted from StreamServiceImpl to follow Single Responsibility Principle.
/// Manages only camera-related functionality.
@LazySingleton(as: CameraService)
class CameraServiceImpl implements CameraService {
  final PermissionService _permissionService;

  CameraController? _controller;
  bool _isCameraActive = false;

  // Stream controllers for reactive state management
  final _controllerSubject = BehaviorSubject<CameraController?>();
  final _statusSubject =
      BehaviorSubject<CameraStatus>.seeded(CameraStatus.initial);

  // Constructor with dependency injection
  CameraServiceImpl(this._permissionService);

  @override
  Stream<CameraController?> get controllerStream => _controllerSubject.stream;

  @override
  Stream<CameraStatus> get statusStream => _statusSubject.stream;

  @override
  CameraController? get currentController => _controller;

  @override
  CameraStatus get currentStatus => _statusSubject.value;

  @override
  bool get isCameraActive => _isCameraActive;

  @override
  Future<void> start() async {
    if (_isCameraActive) return;

    CameraController? tempController;

    try {
      _statusSubject.add(CameraStatus.initializing);

      // Check permissions first
      final permissionStatus = await getCameraPermissionStatus();
      if (permissionStatus != PermissionStatus.granted) {
        final newStatus = await requestCameraPermission();
        if (newStatus != PermissionStatus.granted) {
          _statusSubject.add(CameraStatus.permissionDenied);
          return;
        }
      }

      // Get available cameras
      final cameras = await availableCameras();
      final frontCameras = cameras
          .where((c) => c.lensDirection == CameraLensDirection.front)
          .toList();

      if (frontCameras.isEmpty) {
        _statusSubject.add(CameraStatus.frontCameraNotAvailable);
        return;
      }

      // Initialize camera controller
      tempController = CameraController(
        frontCameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await tempController.initialize();
      await tempController.setFocusMode(FocusMode.auto);
      await tempController.setExposureMode(ExposureMode.auto);

      // Only set the controller and active state after everything succeeds
      _controller = tempController;
      _isCameraActive = true;
      _controllerSubject.add(_controller);
      _statusSubject.add(CameraStatus.ready); // Changed from opening to ready
    } catch (e) {
      // Cleanup temp controller if initialization failed
      if (tempController != null) {
        try {
          await tempController.dispose();
        } catch (_) {
          // Ignore disposal errors during cleanup
        }
      }

      _statusSubject.add(CameraStatus.error);
      await stop();
      rethrow;
    }
  }

  @override
  Future<void> stop() async {
    if (!_isCameraActive) return;

    _isCameraActive = false;

    try {
      if (_controller != null) {
        await _controller!.dispose();
      }
    } catch (e) {
      // Silent error handling during disposal
    } finally {
      // Always cleanup state regardless of errors
      _controller = null;
      _controllerSubject.add(null);
      _statusSubject.add(CameraStatus.initial);
    }
  }

  @override
  Future<PermissionStatus> requestCameraPermission() async {
    final domainStatus = await _permissionService.requestCameraPermission();
    return _mapDomainPermissionStatus(domainStatus);
  }

  @override
  Future<PermissionStatus> getCameraPermissionStatus() async {
    final domainStatus = await _permissionService.getCameraPermissionStatus();
    return _mapDomainPermissionStatus(domainStatus);
  }

  /// Map domain PermissionStatus to local PermissionStatus
  PermissionStatus _mapDomainPermissionStatus(
      domain.PermissionStatus domainStatus) {
    switch (domainStatus) {
      case domain.PermissionStatus.granted:
        return PermissionStatus.granted;
      case domain.PermissionStatus.denied:
        return PermissionStatus.denied;
      case domain.PermissionStatus.permanentlyDenied:
        return PermissionStatus.permanentlyDenied;
      case domain.PermissionStatus.initial:
        return PermissionStatus.unknown;
    }
  }

  @override
  void dispose() {
    // Make stop() synchronous for dispose to prevent hanging
    if (_isCameraActive && _controller != null) {
      _isCameraActive = false;
      _controller?.dispose().catchError((_) {});
      _controller = null;
    }

    _controllerSubject.close();
    _statusSubject.close();
  }
}
