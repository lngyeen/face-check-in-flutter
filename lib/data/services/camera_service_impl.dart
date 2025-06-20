import 'dart:async';

import 'package:camera/camera.dart';
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

  /// Initializes the camera by finding the first available back camera,
  /// creating a controller with medium resolution, and initializing it.
  @override
  Future<void> initialize() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    controller = CameraController(
      backCamera,
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
