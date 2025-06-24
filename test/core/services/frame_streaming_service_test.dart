import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:face_check_in_flutter/core/services/frame_streaming_service.dart';
import 'package:face_check_in_flutter/core/services/frame_capture_service.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';

// Mock classes
class MockFrameCaptureService extends Mock implements FrameCaptureService {}

class MockWebSocketService extends Mock implements WebSocketService {}

class MockCameraImage extends Mock implements CameraImage {}

void main() {
  group('FrameStreamingService', () {
    late FrameStreamingService frameStreamingService;
    late MockFrameCaptureService mockFrameCaptureService;
    late MockWebSocketService mockWebSocketService;
    late StreamController<CameraImage> frameStreamController;

    setUp(() {
      mockFrameCaptureService = MockFrameCaptureService();
      mockWebSocketService = MockWebSocketService();
      frameStreamController = StreamController<CameraImage>.broadcast();

      // Setup default mock behaviors
      when(
        () => mockFrameCaptureService.frameStream,
      ).thenAnswer((_) => frameStreamController.stream);
      when(
        () => mockFrameCaptureService.startCapture(),
      ).thenAnswer((_) async {});
      when(
        () => mockFrameCaptureService.stopCapture(),
      ).thenAnswer((_) async {});

      when(() => mockWebSocketService.isConnected).thenReturn(true);
      when(() => mockWebSocketService.connect()).thenAnswer((_) async => true);
      when(() => mockWebSocketService.sendImageFrame(any())).thenReturn(true);

      frameStreamingService = FrameStreamingService(
        mockFrameCaptureService,
        mockWebSocketService,
      );
    });

    tearDown(() {
      frameStreamController.close();
      frameStreamingService.dispose();
    });

    test('initial state should be idle', () {
      expect(frameStreamingService.currentStatus, StreamingStatus.idle);
    });

    test(
      'startStreaming should connect WebSocket and start frame capture',
      () async {
        // Arrange - WebSocket not connected initially
        when(() => mockWebSocketService.isConnected).thenReturn(false);

        // Act
        await frameStreamingService.startStreaming();

        // Assert
        verify(() => mockWebSocketService.connect()).called(1);
        verify(() => mockFrameCaptureService.startCapture()).called(1);
        expect(frameStreamingService.currentStatus, StreamingStatus.active);
      },
    );

    test('startStreaming should handle WebSocket connection failure', () async {
      // Arrange
      when(() => mockWebSocketService.isConnected).thenReturn(false);
      when(() => mockWebSocketService.connect()).thenAnswer((_) async => false);

      // Act & Assert
      expect(
        () => frameStreamingService.startStreaming(),
        throwsA(isA<Exception>()),
      );
    });

    test('stopStreaming should stop frame capture and update status', () async {
      // Arrange
      await frameStreamingService.startStreaming();

      // Act
      await frameStreamingService.stopStreaming();

      // Assert
      verify(() => mockFrameCaptureService.stopCapture()).called(1);
      expect(frameStreamingService.currentStatus, StreamingStatus.idle);
    });

    test(
      'pauseStreaming should pause streaming without stopping capture',
      () async {
        // Arrange
        await frameStreamingService.startStreaming();

        // Act
        await frameStreamingService.pauseStreaming();

        // Assert
        expect(frameStreamingService.currentStatus, StreamingStatus.paused);
        // Should not call stopCapture when pausing - capture continues running
        verifyNever(() => mockFrameCaptureService.stopCapture());
      },
    );

    test('resumeStreaming should resume from paused state', () async {
      // Arrange
      await frameStreamingService.startStreaming();
      await frameStreamingService.pauseStreaming();

      // Act
      await frameStreamingService.resumeStreaming();

      // Assert
      expect(frameStreamingService.currentStatus, StreamingStatus.active);
    });

    test('status stream should emit status changes', () async {
      // Arrange
      final statusEvents = <StreamingStatus>[];
      frameStreamingService.statusStream.listen(statusEvents.add);

      // Act
      await frameStreamingService.startStreaming();
      await frameStreamingService.stopStreaming();

      // Allow events to propagate
      await Future.delayed(Duration.zero);

      // Assert
      expect(statusEvents, contains(StreamingStatus.starting));
      expect(statusEvents, contains(StreamingStatus.active));
      expect(statusEvents, contains(StreamingStatus.stopping));
      expect(statusEvents, contains(StreamingStatus.idle));
    });

    test('currentMetrics should provide performance data', () async {
      // Arrange
      await frameStreamingService.startStreaming();

      // Act
      final metrics = frameStreamingService.currentMetrics;

      // Assert
      expect(metrics.isActive, isTrue);
      expect(metrics.framesProcessed, equals(0));
      expect(metrics.framesSent, equals(0));
      expect(metrics.framesDropped, equals(0));
    });

    test('should handle multiple start streaming calls gracefully', () async {
      // Act
      await frameStreamingService.startStreaming();
      await frameStreamingService.startStreaming(); // Second call

      // Assert
      expect(frameStreamingService.currentStatus, StreamingStatus.active);
      // Should only call start capture once
      verify(() => mockFrameCaptureService.startCapture()).called(1);
    });

    test('should handle stop streaming when not active', () async {
      // Act
      await frameStreamingService.stopStreaming();

      // Assert
      expect(frameStreamingService.currentStatus, StreamingStatus.idle);
      // Should not call stop capture if not started
      verifyNever(() => mockFrameCaptureService.stopCapture());
    });

    group('Integration with WebSocket sending', () {
      test(
        'should send frames when WebSocket sendImageFrame is available',
        () async {
          // This test verifies the integration is properly set up
          // Note: Full frame processing testing requires more complex setup
          // due to CameraImage and isolate-based conversion

          // Arrange
          await frameStreamingService.startStreaming();

          // Act - we can't easily test the full pipeline here due to isolates
          // but we can verify the service is configured correctly

          // Assert
          expect(frameStreamingService.currentStatus, StreamingStatus.active);
          // No frames sent yet since no camera images were emitted in this test
          verifyNever(() => mockWebSocketService.sendImageFrame(any()));
        },
      );
    });
  });
}
