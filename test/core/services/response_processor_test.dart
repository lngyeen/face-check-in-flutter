import 'dart:convert';
import 'package:test/test.dart';
import 'package:face_check_in_flutter/core/services/response_processor.dart';
import 'package:face_check_in_flutter/core/models/face_detection_result.dart';

void main() {
  group('ResponseProcessor', () {
    late ResponseProcessor responseProcessor;

    setUp(() {
      responseProcessor = ResponseProcessor();
    });

    group('processMessage', () {
      test('parses valid face detection response correctly', () {
        final message = jsonEncode({
          'type': 'frameResult',
          'frameId': 'frame_123',
          'timestamp': '2025-06-19T10:00:00.000Z',
          'faces': [
            {
              'id': 'face_1',
              'x': 100.0,
              'y': 150.0,
              'width': 200.0,
              'height': 250.0,
              'confidence': 0.95,
            },
          ],
          'confidence': 0.95,
          'processingTime': 45.5,
        });

        final result = responseProcessor.processMessage(message);

        expect(result, isNotNull);
        expect(result!.type, ResponseMessageType.frameResult);
        expect(result.frameId, 'frame_123');
        expect(result.faces, hasLength(1));
        expect(result.faces.first.confidence, 0.95);
        expect(result.overallConfidence, 0.95);
        expect(result.isSuccess, isTrue);
        expect(result.faceCount, 1);
      });

      test('handles error response correctly', () {
        final message = jsonEncode({
          'type': 'error',
          'frameId': 'frame_456',
          'error': 'Face detection failed',
          'timestamp': '2025-06-19T10:00:00.000Z',
        });

        final result = responseProcessor.processMessage(message);

        expect(result, isNotNull);
        expect(result!.type, ResponseMessageType.error);
        expect(result.frameId, 'frame_456');
        expect(result.error, 'Face detection failed');
        expect(result.faces, isEmpty);
        expect(result.isSuccess, isFalse);
      });

      test('handles heartbeat response correctly', () {
        final message = jsonEncode({
          'type': 'heartbeat',
          'timestamp': '2025-06-19T10:00:00.000Z',
        });

        final result = responseProcessor.processMessage(message);

        expect(result, isNotNull);
        expect(result!.type, ResponseMessageType.heartbeat);
        expect(result.faces, isEmpty);
      });

      test('handles unknown message type', () {
        final message = jsonEncode({
          'type': 'unknown_type',
          'timestamp': '2025-06-19T10:00:00.000Z',
        });

        final result = responseProcessor.processMessage(message);

        expect(result, isNotNull);
        expect(result!.type, ResponseMessageType.unknown);
      });

      test('handles malformed JSON gracefully', () {
        const malformedJson = '{"type": "frameResult", "faces": [invalid json}';

        expect(
          () => responseProcessor.processMessage(malformedJson),
          throwsA(isA<ResponseProcessingException>()),
        );
      });

      test('handles empty message', () {
        final result = responseProcessor.processMessage('');
        expect(result, isNull);
      });

      test('handles null message', () {
        final result = responseProcessor.processMessage(null);
        expect(result, isNull);
      });

      test('handles Map input correctly', () {
        final messageMap = {
          'type': 'frameResult',
          'frameId': 'frame_789',
          'faces': [],
          'confidence': 0.0,
        };

        final result = responseProcessor.processMessage(messageMap);

        expect(result, isNotNull);
        expect(result!.type, ResponseMessageType.frameResult);
        expect(result.frameId, 'frame_789');
        expect(result.faces, isEmpty);
      });

      test('handles multiple faces correctly', () {
        final message = jsonEncode({
          'type': 'frameResult',
          'frameId': 'frame_multi',
          'faces': [
            {
              'id': 'face_1',
              'x': 100.0,
              'y': 150.0,
              'width': 200.0,
              'height': 250.0,
              'confidence': 0.85,
            },
            {
              'id': 'face_2',
              'x': 300.0,
              'y': 150.0,
              'width': 200.0,
              'height': 250.0,
              'confidence': 0.92,
            },
          ],
        });

        final result = responseProcessor.processMessage(message);

        expect(result, isNotNull);
        expect(result!.faceCount, 2);
        expect(result.hasMultipleFaces, isTrue);
        expect(result.overallConfidence, 0.92); // Max confidence
        expect(result.primaryFace!.confidence, 0.92);
      });

      test('handles missing fields gracefully', () {
        final message = jsonEncode({
          'type': 'frameResult',
          // Missing required fields
        });

        final result = responseProcessor.processMessage(message);

        expect(result, isNotNull);
        expect(result!.type, ResponseMessageType.frameResult);
        expect(result.faces, isEmpty);
        expect(result.frameId, isNull);
      });
    });

    group('FaceDetectionResponse', () {
      test('calculates overall confidence correctly', () {
        final faces = [
          const FaceDetectionResult(
            id: 'face_1',
            x: 0,
            y: 0,
            width: 100,
            height: 100,
            confidence: 0.85,
          ),
          const FaceDetectionResult(
            id: 'face_2',
            x: 0,
            y: 0,
            width: 100,
            height: 100,
            confidence: 0.95,
          ),
        ];

        final response = FaceDetectionResponse(
          type: ResponseMessageType.frameResult,
          faces: faces,
        );

        expect(response.overallConfidence, 0.95);
        expect(response.primaryFace!.confidence, 0.95);
      });

      test('handles empty faces list', () {
        final response = FaceDetectionResponse(
          type: ResponseMessageType.frameResult,
          faces: [],
        );

        expect(response.overallConfidence, 0.0);
        expect(response.primaryFace, isNull);
        expect(response.faceCount, 0);
        expect(response.hasMultipleFaces, isFalse);
      });

      test('serializes to JSON correctly', () {
        final faces = [
          const FaceDetectionResult(
            id: 'face_1',
            x: 100,
            y: 150,
            width: 200,
            height: 250,
            confidence: 0.95,
          ),
        ];

        final response = FaceDetectionResponse(
          type: ResponseMessageType.frameResult,
          faces: faces,
          frameId: 'frame_123',
          timestamp: DateTime.parse('2025-06-19T10:00:00.000Z'),
          confidence: 0.95,
          processingTime: 45.5,
        );

        final json = response.toJson();

        expect(json['type'], 'frameResult');
        expect(json['frameId'], 'frame_123');
        expect(json['faces'], hasLength(1));
        expect(json['confidence'], 0.95);
        expect(json['processingTime'], 45.5);
      });
    });

    group('ResponseProcessingException', () {
      test('creates exception with message only', () {
        const exception = ResponseProcessingException('Test error');
        expect(exception.message, 'Test error');
        expect(exception.cause, isNull);
        expect(exception.toString(), 'ResponseProcessingException: Test error');
      });

      test('creates exception with message and cause', () {
        final originalError = Exception('Original error');
        final exception = ResponseProcessingException(
          'Test error',
          originalError,
        );

        expect(exception.message, 'Test error');
        expect(exception.cause, originalError);
        expect(exception.toString(), contains('Test error'));
        expect(exception.toString(), contains('Original error'));
      });
    });
  });
}
