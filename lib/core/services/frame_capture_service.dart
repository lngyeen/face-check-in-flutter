import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:face_check_in_flutter/domain/services/camera_service.dart';
import 'package:injectable/injectable.dart';

/// A service to manage capturing frames from the camera.
///
/// This service is responsible for starting and stopping frame streams
/// from the `CameraService` and providing the stream of `CameraImage`
/// to other parts of the application.
@lazySingleton
class FrameCaptureService {
  final CameraService _cameraService;
  StreamSubscription<CameraImage>? _frameSubscription;
  final StreamController<CameraImage> _frameStreamController =
      StreamController.broadcast();

  FrameCaptureService(this._cameraService);

  /// A stream of camera frames.
  ///
  /// Consumers can listen to this stream to receive `CameraImage` objects
  /// as they are captured.
  Stream<CameraImage> get frameStream => _frameStreamController.stream;

  /// Starts capturing frames from the camera.
  ///
  /// It subscribes to the camera's image stream and forwards the frames
  /// to its own `frameStream`.
  Future<void> startCapture() async {
    await stopCapture(); // Ensure any existing capture is stopped.
    try {
      // The CameraService now manages the stream internally.
      // We just need to listen to its stream.
      _frameSubscription = _cameraService.imageStream?.listen((image) {
        if (!_frameStreamController.isClosed) {
          _frameStreamController.add(image);
        }
      });
      // We also need to tell the camera service to start producing images.
      await _cameraService.startImageStream();
    } catch (e) {
      // TODO: Add proper error handling/logging
      debugPrint('Error starting frame capture: $e');
    }
  }

  /// Stops capturing frames from the camera.
  ///
  /// Cancels the subscription to the camera's image stream and tells
  /// the camera service to stop producing images.
  Future<void> stopCapture() async {
    await _cameraService.stopImageStream();
    await _frameSubscription?.cancel();
    _frameSubscription = null;
  }

  /// Disposes the service and closes the stream controller.
  void dispose() {
    stopCapture();
    _frameStreamController.close();
  }
}
