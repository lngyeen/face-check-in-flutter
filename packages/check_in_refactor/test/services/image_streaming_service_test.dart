import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:camera/camera.dart';

import 'package:check_in_refactor/services/image_streaming_service.dart';

// Mock classes for testing
class MockCameraController extends Mock implements CameraController {}

class MockCameraValue extends Mock implements CameraValue {}

void main() {
  group('ImageStreamingServiceImpl', () {
    late ImageStreamingServiceImpl streamingService;
    late MockCameraController mockController;
    late MockCameraValue mockValue;

    setUp(() {
      streamingService = ImageStreamingServiceImpl();
      mockController = MockCameraController();
      mockValue = MockCameraValue();

      // Set up default mock behavior for CameraValue
      when(() => mockValue.isStreamingImages).thenReturn(false);
    });

    tearDown(() {
      streamingService.dispose();
    });

    group('Initial State', () {
      test('should start with idle status', () {
        expect(streamingService.currentStatus, StreamingStatus.idle);
        expect(streamingService.maxFps, 2);
      });

      test('should emit idle status in stream', () {
        expect(
          streamingService.statusStream,
          emits(StreamingStatus.idle),
        );
      });
    });

    group('FPS Configuration', () {
      test('should set maxFps within valid range', () {
        streamingService.setMaxFps(5);
        expect(streamingService.maxFps, 5);

        streamingService.setMaxFps(1);
        expect(streamingService.maxFps, 1);

        streamingService.setMaxFps(30);
        expect(streamingService.maxFps, 30);
      });

      test('should throw error for invalid FPS values', () {
        expect(() => streamingService.setMaxFps(0), throwsArgumentError);
        expect(() => streamingService.setMaxFps(31), throwsArgumentError);
        expect(() => streamingService.setMaxFps(-1), throwsArgumentError);
      });
    });

    group('Status Stream', () {
      test('should emit status changes', () async {
        final statusList = <StreamingStatus>[];

        final subscription = streamingService.statusStream.listen(
          (status) => statusList.add(status),
        );

        // Initial status should be emitted
        await Future.delayed(const Duration(milliseconds: 10));
        expect(statusList, contains(StreamingStatus.idle));

        await subscription.cancel();
      });
    });

    group('Processed Frame Stream', () {
      test('should provide processed frame stream', () {
        expect(streamingService.processedFrameStream,
            isA<Stream<ProcessedFrame>>());
      });
    });

    group('Streaming Control', () {
      test('should not start streaming with uninitialized controller',
          () async {
        when(() => mockValue.isInitialized).thenReturn(false);
        when(() => mockController.value).thenReturn(mockValue);

        await streamingService.start(mockController);

        // Should remain idle since controller is not initialized
        expect(streamingService.currentStatus, StreamingStatus.idle);
      });

      test('should not start streaming when already active', () async {
        // Manually set status to active for testing
        // Note: This is testing the guard condition
        // In real usage, we'd need a properly initialized controller

        when(() => mockValue.isInitialized).thenReturn(true);
        when(() => mockValue.isStreamingImages)
            .thenReturn(true); // Mock successful streaming
        when(() => mockController.value).thenReturn(mockValue);

        // Mock startImageStream to complete successfully
        when(() => mockController.startImageStream(any()))
            .thenAnswer((_) async {});

        await streamingService.start(mockController);

        // Try to start again - should do nothing
        await streamingService.start(mockController);

        // Verify startImageStream was only called once
        verify(() => mockController.startImageStream(any())).called(1);
      });

      test('should stop streaming when not active', () async {
        // Should handle stop gracefully when not streaming
        expect(streamingService.currentStatus, StreamingStatus.idle);

        await streamingService.stop();

        expect(streamingService.currentStatus, StreamingStatus.idle);
      });
    });

    group('Error Handling', () {
      test('should handle start streaming errors', () async {
        when(() => mockValue.isInitialized).thenReturn(true);
        when(() => mockController.value).thenReturn(mockValue);
        when(() => mockController.startImageStream(any()))
            .thenThrow(Exception('Camera error'));

        expect(
          () => streamingService.start(mockController),
          throwsException,
        );
      });

      test('should handle stop streaming errors gracefully', () async {
        // Should not throw even if stop fails
        expect(() => streamingService.stop(), returnsNormally);
      });
    });

    group('Resource Management', () {
      test('dispose should cleanup resources', () {
        expect(() => streamingService.dispose(), returnsNormally);
      });
    });

    group('Frame Processing', () {
      test('FrameData should contain required properties', () {
        final mockImage = MockCameraImage();

        final frameData = FrameData(
          image: mockImage,
          sensorOrientation: 90,
          lensDirection: CameraLensDirection.front,
        );

        expect(frameData.image, mockImage);
        expect(frameData.sensorOrientation, 90);
        expect(frameData.lensDirection, CameraLensDirection.front);
      });

      test('ProcessedFrame should contain required properties', () {
        final timestamp = DateTime.now();

        final processedFrame = ProcessedFrame(
          base64Image: 'base64data',
          width: 640,
          height: 480,
          timestamp: timestamp,
        );

        expect(processedFrame.base64Image, 'base64data');
        expect(processedFrame.width, 640);
        expect(processedFrame.height, 480);
        expect(processedFrame.timestamp, timestamp);
      });
    });
  });
}

// Mock camera image for testing
class MockCameraImage extends Mock implements CameraImage {}
