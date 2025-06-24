import 'dart:async';

import 'package:camera/camera.dart';

/// Abstract service for camera operations.
///
/// Defines the interface for camera-related operations like initialization,
/// starting/stopping image streams, and managing the camera controller.
abstract class CameraService {
  /// The camera controller instance.
  CameraController? get controller;

  /// Stream of camera images from the image stream.
  Stream<CameraImage> get imageStream;

  /// Initializes the camera.
  Future<void> initialize();

  /// Starts the image stream from the camera.
  Future<void> startImageStream();

  /// Stops the image stream from the camera.
  Future<void> stopImageStream();

  /// Disposes the camera resources.
  void dispose();
} 