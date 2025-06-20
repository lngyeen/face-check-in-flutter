import 'dart:async';

import 'package:face_check_in_flutter/core/services/frame_capture_service.dart';
import 'package:face_check_in_flutter/domain/services/camera_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:camera/camera.dart';

import 'camera_related_services_test.mocks.dart';

// Generate mocks for CameraService and CameraController
@GenerateMocks([CameraService, CameraController, CameraImage])
void main() {
  late MockCameraService mockCameraService;
  late FrameCaptureService frameCaptureService;

  setUp(() {
    mockCameraService = MockCameraService();
    frameCaptureService = FrameCaptureService(mockCameraService);
  });

  tearDown(() {
    frameCaptureService.dispose();
  });

  group('FrameCaptureService', () {
    test('startCapture starts listening to the camera image stream', () async {
      // Arrange
      final imageStreamController = StreamController<CameraImage>();
      when(
        mockCameraService.imageStream,
      ).thenAnswer((_) => imageStreamController.stream);
      when(mockCameraService.startImageStream()).thenAnswer((_) async {});

      // Act
      await frameCaptureService.startCapture();

      // Assert
      verify(mockCameraService.startImageStream()).called(1);
      expect(frameCaptureService.frameStream, isA<Stream<CameraImage>>());

      // Clean up
      imageStreamController.close();
    });

    test('stopCapture stops listening to the camera image stream', () async {
      // Arrange
      when(mockCameraService.stopImageStream()).thenAnswer((_) async {});

      // Act
      await frameCaptureService.stopCapture();

      // Assert
      verify(mockCameraService.stopImageStream()).called(1);
    });

    test('frames from camera service are passed to frameStream', () async {
      // Arrange
      final mockCameraImage = MockCameraImage();
      final imageStreamController = StreamController<CameraImage>();
      when(
        mockCameraService.imageStream,
      ).thenAnswer((_) => imageStreamController.stream);
      when(mockCameraService.startImageStream()).thenAnswer((_) async {});

      // Act
      await frameCaptureService.startCapture();

      // Assert
      expectLater(frameCaptureService.frameStream, emits(mockCameraImage));

      // Add an image to the stream
      imageStreamController.add(mockCameraImage);

      // Clean up
      await imageStreamController.close();
    });

    test('dispose cancels subscription and closes stream', () {
      // Arrange
      when(mockCameraService.stopImageStream()).thenAnswer((_) async {});

      // Act
      frameCaptureService.dispose();

      // Assert
      // The verification for stopImageStream is implicitly handled by the tearDown,
      // but we can be explicit for this test's clarity.
      verify(mockCameraService.stopImageStream()).called(1);
    });
  });
}
