import 'dart:async';

import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/core/config/websocket_config.dart';
import 'package:face_check_in_flutter/core/enums/connection_status.dart';
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

      // Update configuration instead of setUrl
      webSocketService.updateConfig(WebSocketConfig(url: testUrl));

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

      // Collect emitted statuses
      final statusList = <ConnectionStatus>[];
      final subscription = webSocketService.connectionStatus.listen(
        statusList.add,
      );

      final connectionFuture = webSocketService.connect();
      await connectionFuture;

      // Allow for status emissions to complete
      await Future.delayed(Duration(milliseconds: 50));
      await subscription.cancel();

      expect(webSocketService.isConnected, isTrue);
      expect(webSocketService.currentStatus, ConnectionStatus.connected);
      expect(statusList, contains(ConnectionStatus.connecting));
      expect(statusList, contains(ConnectionStatus.connected));
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

      // Collect status changes during disconnect
      final statusList = <ConnectionStatus>[];
      final subscription = webSocketService.connectionStatus.listen(
        statusList.add,
      );

      final disconnectFuture = webSocketService.disconnect();
      await disconnectFuture;

      // Allow for status emissions to complete
      await Future.delayed(Duration(milliseconds: 50));
      await subscription.cancel();

      expect(webSocketService.isConnected, isFalse);
      expect(webSocketService.currentStatus, ConnectionStatus.disconnected);
      expect(statusList, contains(ConnectionStatus.disconnected));
      verify(() => mockWebSocketSink.close()).called(1);
    });

    test('handles connection error and attempts to retry', () async {
      final exception = Exception('Connection failed');
      when(
        () => mockWebSocketChannel.ready,
      ).thenAnswer((_) => Future.error(exception));

      // Collect status changes during failed connection attempts
      final statusList = <ConnectionStatus>[];
      final subscription = webSocketService.connectionStatus.listen(
        statusList.add,
      );

      final connectionFuture = webSocketService.connect();
      final result = await connectionFuture;

      // Allow for retry attempts to complete
      await Future.delayed(Duration(milliseconds: 100));
      await subscription.cancel();

      expect(result, isFalse);
      expect(webSocketService.lastError, isNotNull);

      // Check that we have the expected status transitions
      expect(statusList, contains(ConnectionStatus.connecting));
      expect(statusList, contains(ConnectionStatus.failed));
      expect(statusList, contains(ConnectionStatus.retrying));

      // Final status should be either failed or retrying (both are valid end states)
      expect(
        webSocketService.currentStatus,
        anyOf([ConnectionStatus.failed, ConnectionStatus.retrying]),
      );
    });

    test('handles stream error and attempts to reconnect', () async {
      await webSocketService.connect();
      final error = Exception('Stream error');

      // The service should try to reconnect upon error
      when(
        () => mockWebSocketChannel.ready,
      ).thenAnswer((_) => Future.error(error));

      serverStreamController.addError(error);

      // It should emit failed status for the error
      expect(webSocketService.connectionStatus, emits(ConnectionStatus.failed));
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
      expect(webSocketService.currentStatus, ConnectionStatus.disconnected);
    });

    test('test connection works independently', () async {
      // Create a separate mock for test connection
      final mockTestChannel = MockWebSocketChannel();
      final mockTestSink = MockWebSocketSink();

      when(() => mockTestChannel.sink).thenReturn(mockTestSink);
      when(() => mockTestChannel.ready).thenAnswer((_) => Future.value(null));
      when(() => mockTestSink.close()).thenAnswer((_) async {});

      // Override connector just for this test
      final originalConnector = webSocketService.connector;
      webSocketService.connector = (uri) {
        if (uri.toString() == testUrl) {
          return mockTestChannel;
        }
        return originalConnector(uri);
      };

      final testResult = await webSocketService.testConnection(
        testUrl: testUrl,
      );

      // Restore original connector
      webSocketService.connector = originalConnector;

      expect(testResult, isTrue);
      verify(() => mockTestChannel.ready).called(1);
      verify(() => mockTestSink.close()).called(1);
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

    test('metrics stream provides connection information', () async {
      // Listen to metrics stream
      late ConnectionMetrics receivedMetrics;
      final subscription = webSocketService.metrics.listen((metrics) {
        receivedMetrics = metrics;
      });

      await webSocketService.connect();

      // Allow time for metrics to be emitted
      await Future.delayed(Duration(milliseconds: 100));

      expect(receivedMetrics.isConnected, isTrue);
      expect(receivedMetrics.currentStatus, ConnectionStatus.connected);
      expect(receivedMetrics.url, testUrl);

      await subscription.cancel();
    });
  });
}
