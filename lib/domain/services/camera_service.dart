import 'package:camera/camera.dart';

/// An abstract service for handling camera operations.
///
/// This includes initializing the camera, starting/stopping the image stream,
/// and providing the `CameraController`.
abstract class CameraService {
  /// The controller for the camera.
  ///
  /// This can be null if the camera has not been initialized.
  CameraController? get controller;

  /// A stream of images from the camera.
  ///
  /// This can be null if the camera is not streaming.
  Stream<CameraImage>? get imageStream;

  /// Initializes the camera.
  ///
  /// It finds an available camera, creates and initializes a `CameraController`,
  /// and prepares it for use.
  Future<void> initialize();

  /// Starts the camera image stream.
  ///
  /// The frames will be available on the `imageStream`.
  Future<void> startImageStream();

  /// Stops the camera image stream.
  Future<void> stopImageStream();

  /// Disposes the camera controller.
  ///
  /// This should be called when the camera is no longer needed to release resources.
  void dispose();
}
