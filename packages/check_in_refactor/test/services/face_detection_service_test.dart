import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:check_in_refactor/services/face_detection_service.dart';
import 'package:check_in_refactor/services/image_streaming_service.dart';

// Mock classes for testing
class MockWebSocketService extends Mock implements WebSocketService {}

void main() {
  group('FaceDetectionServiceImpl', () {
    late FaceDetectionServiceImpl faceDetectionService;
    late MockWebSocketService mockWebSocketService;
    late StreamController<dynamic> messageStreamController;
    late StreamController<WebSocketConnectionStatus> connectionStatusController;

    setUp(() {
      mockWebSocketService = MockWebSocketService();
      messageStreamController = StreamController<dynamic>.broadcast();
      connectionStatusController =
          StreamController<WebSocketConnectionStatus>.broadcast();

      when(() => mockWebSocketService.messageStream)
          .thenAnswer((_) => messageStreamController.stream);
      when(() => mockWebSocketService.connectionStatusStream)
          .thenAnswer((_) => connectionStatusController.stream);
      when(() => mockWebSocketService.currentStatus)
          .thenReturn(WebSocketConnectionStatus.connected);

      faceDetectionService = FaceDetectionServiceImpl(mockWebSocketService);
    });

    tearDown(() {
      faceDetectionService.dispose();
      messageStreamController.close();
      connectionStatusController.close();
    });

    group('Initial State', () {
      test('should start with connected status from WebSocket service', () {
        // The service copies status from WebSocketService in constructor
        expect(
          faceDetectionService.currentConnectionStatus,
          WebSocketConnectionStatus.connected,
        );
      });

      test('should provide detection stream', () {
        expect(
          faceDetectionService.detectionStream,
          isA<Stream<FaceDetectionData>>(),
        );
      });
    });

    group('Frame Processing', () {
      test('should send frame to WebSocket when connected', () {
        when(() => mockWebSocketService.currentStatus)
            .thenReturn(WebSocketConnectionStatus.connected);

        final testFrame = ProcessedFrame(
          base64Image: 'test-base64-image',
          width: 640,
          height: 480,
          timestamp: DateTime.now(),
        );

        faceDetectionService.processFrame(testFrame);

        verify(() => mockWebSocketService.sendMessage(any())).called(1);
      });

      test('should not send frame when disconnected', () {
        when(() => mockWebSocketService.currentStatus)
            .thenReturn(WebSocketConnectionStatus.disconnected);

        final testFrame = ProcessedFrame(
          base64Image: 'test-base64-image',
          width: 640,
          height: 480,
          timestamp: DateTime.now(),
        );

        faceDetectionService.processFrame(testFrame);

        verifyNever(() => mockWebSocketService.sendMessage(any()));
      });
    });

    group('Resource Management', () {
      test('dispose should cleanup resources', () {
        expect(() => faceDetectionService.dispose(), returnsNormally);
      });
    });
  });
}
