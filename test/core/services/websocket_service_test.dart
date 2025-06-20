import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:face_check_in_flutter/core/services/websocket_service.dart';

// Mocks created with mocktail
class MockWebSocketChannel extends Mock implements WebSocketChannel {}

class MockWebSocketSink extends Mock implements WebSocketSink {}

void main() {
  late WebSocketService webSocketService;
  late MockWebSocketChannel mockWebSocketChannel;
  late MockWebSocketSink mockWebSocketSink;

  final config = WebSocketConfig(
    url: 'ws://test.server',
    connectionTimeout: Duration(seconds: 1),
    maxRetryAttempts: 2,
    retryDelay: Duration(milliseconds: 10),
  );

  setUp(() {
    mockWebSocketChannel = MockWebSocketChannel();
    mockWebSocketSink = MockWebSocketSink();
    webSocketService = WebSocketService();
    webSocketService.initialize(config: config);

    // Mock the sink and stream
    when(() => mockWebSocketChannel.sink).thenReturn(mockWebSocketSink);
    when(
      () => mockWebSocketChannel.stream,
    ).thenAnswer((_) => Stream.fromIterable([]));
  });

  tearDown(() {
    webSocketService.dispose();
  });

  group('WebSocketService', () {
    test('initial status is disconnected', () {
      expect(webSocketService.currentStatus, ConnectionStatus.disconnected);
    });
  });
}
