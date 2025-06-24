import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:face_check_in_flutter/domain/services/camera_service.dart';
import 'package:injectable/injectable.dart';

/// The concrete implementation of the `CameraService`.
///
/// This class handles the actual camera hardware interaction using the `camera` package.
@LazySingleton(as: CameraService)
class CameraServiceImpl implements CameraService {
  @override
  CameraController? controller;

  final StreamController<CameraImage> _imageStreamController =
      StreamController.broadcast();

  @override
  Stream<CameraImage> get imageStream => _imageStreamController.stream;

  /// Initializes the camera by finding the first available front camera,
  /// creating a controller with medium resolution, and initializing it.
  @override
  Future<void> initialize() async {
    final cameras = await availableCameras();

    // Debug: Log all available cameras
    debugPrint('🎥 Available cameras:');
    for (int i = 0; i < cameras.length; i++) {
      debugPrint(
        '  Camera $i: ${cameras[i].lensDirection} - ${cameras[i].name}',
      );
    }

    CameraDescription selectedCamera;

    // Try to find front camera first
    final frontCameras =
        cameras
            .where(
              (camera) => camera.lensDirection == CameraLensDirection.front,
            )
            .toList();

    if (frontCameras.isNotEmpty) {
      selectedCamera = frontCameras.first;
      debugPrint(
        '📱 Selected front camera: ${selectedCamera.lensDirection} - ${selectedCamera.name}',
      );
    } else {
      // If no front camera, try to find back camera
      final backCameras =
          cameras
              .where(
                (camera) => camera.lensDirection == CameraLensDirection.back,
              )
              .toList();

      if (backCameras.isNotEmpty) {
        selectedCamera = backCameras.first;
        debugPrint(
          '⚠️ No front camera found, using back camera: ${selectedCamera.lensDirection} - ${selectedCamera.name}',
        );
      } else {
        // Fallback to first available camera
        selectedCamera = cameras.first;
        debugPrint(
          '⚠️ No front or back camera found, using first available: ${selectedCamera.lensDirection} - ${selectedCamera.name}',
        );
      }
    }

    controller = CameraController(
      selectedCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller?.initialize();
  }

  /// Starts the image stream from the camera controller.
  ///
  /// Throws an exception if the controller is not initialized.
  @override
  Future<void> startImageStream() async {
    if (controller == null) {
      throw Exception('Camera not initialized');
    }
    if (controller!.value.isStreamingImages) {
      return; // Stream is already running
    }
    await controller?.startImageStream((image) {
      if (!_imageStreamController.isClosed) {
        _imageStreamController.add(image);
      }
    });
  }

  /// Stops the image stream from the camera controller.
  @override
  Future<void> stopImageStream() async {
    if (controller?.value.isStreamingImages ?? false) {
      await controller?.stopImageStream();
    }
  }

  /// Disposes the camera controller and stream controller to release resources.
  @override
  void dispose() {
    stopImageStream();
    controller?.dispose();
    _imageStreamController.close();
  }
}
