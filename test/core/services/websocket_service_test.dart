import 'dart:async';
import 'dart:convert';

import 'package:face_check_in_flutter/core/config/websocket_config.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Mocks
class MockWebSocketChannel extends Mock implements WebSocketChannel {}

class MockWebSocketSink extends Mock implements WebSocketSink {}

// A helper function to ensure that scheduled microtasks are executed.
Future<void> pumpEventQueue() => Future.delayed(Duration.zero);

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('ws://fallback.uri'));
  });

  group('WebSocketService with FakeAsync', () {
    late WebSocketService webSocketService;
    late MockWebSocketChannel mockWebSocketChannel;
    late MockWebSocketSink mockWebSocketSink;
    late StreamController<dynamic> serverStreamController;

    const testUrl = 'ws://localhost:1234';

    setUp(() {
      mockWebSocketChannel = MockWebSocketChannel();
      mockWebSocketSink = MockWebSocketSink();
      serverStreamController = StreamController<dynamic>();
      webSocketService = WebSocketService();

      // Configure mocks with default successful behavior
      when(() => mockWebSocketChannel.sink).thenReturn(mockWebSocketSink);
      when(
        () => mockWebSocketChannel.stream,
      ).thenAnswer((_) => serverStreamController.stream);
      when(() => mockWebSocketChannel.ready).thenAnswer((_) async {});
      when(() => mockWebSocketSink.add(any())).thenReturn(null);
      when(() => mockWebSocketSink.close()).thenAnswer((_) async {});

      // Use the mocked connector
      webSocketService.connector = (_) => mockWebSocketChannel;
    });

    tearDown(() {
      webSocketService.dispose();
    });

    test('successfully connects and emits correct states', () {
      fakeAsync((async) {
        // Expect states to be emitted in order
        expect(
          webSocketService.connectionStatus,
          emitsInOrder([
            ConnectionStatus.connecting,
            ConnectionStatus.connected,
          ]),
        );

        // Act
        webSocketService.connect();
        async.flushMicrotasks(); // Process the connection future

        // Assert
        expect(webSocketService.isConnected, isTrue);
      });
    });

    test('disconnects and emits correct state', () {
      fakeAsync((async) {
        // Arrange: connect first
        webSocketService.connect();
        async.flushMicrotasks();

        // Act & Assert
        expect(
          webSocketService.connectionStatus,
          emits(ConnectionStatus.disconnected),
        );

        webSocketService.disconnect();
        async.flushMicrotasks();

        verify(() => mockWebSocketSink.close()).called(1);
        expect(webSocketService.isConnected, isFalse);
      });
    });

    test('handles connection error and retries', () {
      fakeAsync((async) {
        // Arrange
        final error = Exception('Connection failed');
        when(
          () => mockWebSocketChannel.ready,
        ).thenAnswer((_) => Future.error(error));
        webSocketService.updateConfig(
          webSocketService.config.copyWith(
            enableAutoReconnect: true,
            maxRetries: 1,
            retryDelay: const Duration(seconds: 3),
          ),
        );

        // Assert
        expect(
          webSocketService.connectionStatus,
          emitsInOrder([
            ConnectionStatus.connecting,
            ConnectionStatus.failed,
            ConnectionStatus.retrying,
            ConnectionStatus.connecting,
            ConnectionStatus.failed,
          ]),
        );

        // Act
        webSocketService.connect();
        async.flushMicrotasks(); // Initial connection attempt fails

        async.elapse(
          const Duration(seconds: 3),
        ); // Elapse time for the retry timer
        async.flushMicrotasks(); // Second connection attempt also fails
      });
    });

    test('handles stream error and emits [failed, retrying]', () async {
      // Arrange
      await webSocketService.connect();
      expect(webSocketService.isConnected, isTrue);
      // Configure for a quick retry
      webSocketService.updateConfig(
        webSocketService.config.copyWith(
          enableAutoReconnect: true,
          maxRetries: 1,
          retryDelay: Duration.zero,
        ),
      );

      // Assert later for states after the error
      expectLater(
        webSocketService.connectionStatus,
        emitsInOrder([ConnectionStatus.failed, ConnectionStatus.retrying]),
      );

      // Act: Simulate a stream error
      serverStreamController.addError(Exception('Stream error'));
      await pumpEventQueue();
    });

    test('sendMessage sends data when connected', () {
      fakeAsync((async) {
        // Arrange
        webSocketService.connect();
        async.flushMicrotasks();
        expect(webSocketService.isConnected, isTrue);

        // Act
        final message = {'type': 'test', 'data': 'hello'};
        webSocketService.sendMessage(message);

        // Assert
        verify(() => mockWebSocketSink.add(jsonEncode(message))).called(1);
      });
    });

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
      fakeAsync((async) {
        // Act
        webSocketService.sendMessage({'type': 'test'});

        // Assert
        verifyNever(() => mockWebSocketSink.add(any()));
      });
    });

    test('messages stream receives and parses incoming messages', () {
      fakeAsync((async) {
        // Arrange
        final message = {'status': 'ok'};
        expect(webSocketService.messages, emits(message));

        // Act
        webSocketService.connect();
        async.flushMicrotasks();
        serverStreamController.add(jsonEncode(message));
        async.flushMicrotasks();
      });
    });

    test('configuration can be updated', () {
      final newConfig = WebSocketConfig(
        url: 'ws://new-url:8080',
        timeout: Duration(seconds: 60),
        maxRetries: 5,
      );

      webSocketService.updateConfig(newConfig);

      expect(webSocketService.config.url, 'ws://new-url:8080');
      expect(webSocketService.config.timeout, Duration(seconds: 60));
      expect(webSocketService.config.maxRetries, 5);
    });

    test('metrics stream provides connection information', () {
      fakeAsync((async) {
        final expectedUrl =
            webSocketService.config.url; // Use the actual config URL
        expect(
          webSocketService.metrics,
          emits(
            isA<ConnectionMetrics>().having((m) => m.url, 'url', expectedUrl),
          ),
        );

        webSocketService.connect();
        async.flushMicrotasks();
      });
    });
  });
}
