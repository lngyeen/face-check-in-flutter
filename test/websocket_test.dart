import 'package:flutter_test/flutter_test.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';

void main() {
  group('WebSocket Service Tests', () {
    late WebSocketService webSocketService;

    setUp(() {
      webSocketService = WebSocketService();
    });

    tearDown(() {
      webSocketService.dispose();
    });

    test('should initialize with default URL', () {
      expect(webSocketService.url, equals('ws://192.168.1.234:3009'));
      expect(webSocketService.isConnected, isFalse);
    });

    test('should update URL correctly', () {
      const newUrl = 'ws://localhost:8080';
      webSocketService.setUrl(newUrl);
      expect(webSocketService.url, equals(newUrl));
    });

    test('should return connection statistics', () {
      final stats = webSocketService.getConnectionStats();
      expect(stats['isConnected'], isFalse);
      expect(stats['url'], equals('ws://192.168.1.234:3009'));
      expect(stats['retryCount'], equals(0));
      expect(stats['maxRetryAttempts'], equals(3));
    });

    test('should handle sendMessage when not connected', () {
      final result = webSocketService.sendMessage({'type': 'test'});
      expect(result, isFalse);
    });

    test('should handle sendImageFrame when not connected', () {
      final result = webSocketService.sendImageFrame('base64data');
      expect(result, isFalse);
    });
  });
}
