import 'dart:async';

import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Mocks
class MockWebSocketChannel extends Mock implements WebSocketChannel {}

class MockWebSocketSink extends Mock implements WebSocketSink {}

void main() {
  group('WebSocketService', () {
    late WebSocketService webSocketService;
    late MockWebSocketChannel mockWebSocketChannel;
    late MockWebSocketSink mockWebSocketSink;
    late StreamController<dynamic> serverStreamController;

    const testUrl = 'ws://localhost:1234';

    setUp(() {
      webSocketService = WebSocketService();
      mockWebSocketChannel = MockWebSocketChannel();
      mockWebSocketSink = MockWebSocketSink();
      serverStreamController = StreamController<dynamic>.broadcast();

      // Set up the mock connector
      webSocketService.connector = (uri) {
        expect(uri.toString(), testUrl);
        return mockWebSocketChannel;
      };
      webSocketService.setUrl(testUrl);

      // Default mock behaviors
      when(() => mockWebSocketChannel.sink).thenReturn(mockWebSocketSink);
      when(
        () => mockWebSocketChannel.stream,
      ).thenAnswer((_) => serverStreamController.stream);
      when(() => mockWebSocketSink.close()).thenAnswer((_) async {});
      when(
        () => mockWebSocketChannel.ready,
      ).thenAnswer((_) => Future.value(null));
      when(() => mockWebSocketSink.add(any())).thenAnswer((_) {});
    });

    tearDown(() {
      webSocketService.dispose();
      serverStreamController.close();
    });

    test('successfully connects and updates status', () async {
      expect(webSocketService.isConnected, isFalse);

      final connectionFuture = webSocketService.connect();

      expect(webSocketService.connectionStatus, emitsInOrder([true]));

      await connectionFuture;

      expect(webSocketService.isConnected, isTrue);
    });

    test(
      'sendMessage sends JSON encoded message to sink when connected',
      () async {
        await webSocketService.connect();
        final message = {'type': 'test', 'data': 'hello'};
        final jsonMessage = '{"type":"test","data":"hello"}';

        final result = webSocketService.sendMessage(message);

        expect(result, isTrue);
        verify(() => mockWebSocketSink.add(jsonMessage)).called(1);
      },
    );

    test('sendImageFrame sends correct message format', () async {
      await webSocketService.connect();
      const frame = 'base64string';

      final result = webSocketService.sendImageFrame(frame);
      expect(result, isTrue);

      final verificationResult = verify(
        () => mockWebSocketSink.add(captureAny()),
      );
      verificationResult.called(1);

      final captured = verificationResult.captured.first as String;
      expect(captured, contains('"type":"frame"'));
      expect(captured, contains('"data":"$frame"'));
      expect(captured, contains('"timestamp"'));
    });

    test('does not send message when not connected', () {
      final result = webSocketService.sendMessage({'type': 'test'});
      expect(result, isFalse);
      verifyNever(() => mockWebSocketSink.add(any()));
    });

    test('messages stream receives and parses incoming messages', () async {
      await webSocketService.connect();

      const message = '{"type":"response","status":"ok"}';
      final expectedMap = {'type': 'response', 'status': 'ok'};

      expect(webSocketService.messages, emits(expectedMap));

      serverStreamController.add(message);
    });

    test('disconnect closes the sink and updates status', () async {
      await webSocketService.connect();
      expect(webSocketService.isConnected, isTrue);

      final disconnectFuture = webSocketService.disconnect();

      expect(webSocketService.connectionStatus, emitsInOrder([false]));

      await disconnectFuture;

      expect(webSocketService.isConnected, isFalse);
      verify(() => mockWebSocketSink.close()).called(1);
    });

    test('handles connection error and attempts to retry', () async {
      final exception = Exception('Connection failed');
      when(
        () => mockWebSocketChannel.ready,
      ).thenAnswer((_) => Future.error(exception));

      final connectionFuture = webSocketService.connect();

      // Expect it to fail eventually after retries
      expect(
        webSocketService.connectionStatus,
        emitsInOrder([false, false, false, false]),
      );

      final result = await connectionFuture;
      expect(result, isFalse);

      final stats = webSocketService.getConnectionStats();
      expect(stats['retryCount'], 3);
    });

    test('handles stream error and attempts to reconnect', () async {
      await webSocketService.connect();
      final error = Exception('Stream error');

      // The service should try to reconnect upon error
      when(
        () => mockWebSocketChannel.ready,
      ).thenAnswer((_) => Future.error(error));

      serverStreamController.addError(error);

      // It should emit false for the disconnection
      expect(webSocketService.connectionStatus, emits(false));
    });

    test('handles disconnection by server and updates status', () async {
      await webSocketService.connect();
      expect(webSocketService.isConnected, isTrue);

      // Simulate server closing the connection
      await serverStreamController.close();

      // Allow microtasks to complete
      await Future.delayed(Duration.zero);

      // Verify the status is updated
      expect(webSocketService.isConnected, isFalse);
    });
  });
}
