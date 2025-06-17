import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

// Add a type definition for the connector function for clarity and ease of use.
typedef WebSocketConnector = WebSocketChannel Function(Uri uri);

/// WebSocket service for backend communication
/// Handles connection, reconnection, and message exchange with face recognition backend
class WebSocketService {
  static const String _defaultUrl = 'ws://192.168.1.234:3009';
  static const int _maxRetryAttempts = 3;
  static const Duration _retryDelay = Duration(seconds: 3);

  WebSocketChannel? _channel;
  String _url = _defaultUrl;
  bool _isConnected = false;
  int _retryCount = 0;
  bool _isDisposed = false;

  // Stream controllers for connection status and messages
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();

  // Expose a way to override the connector for testing purposes.
  // In a real app, this would likely be handled by a proper DI framework.
  @visibleForTesting
  WebSocketConnector connector = WebSocketChannel.connect;

  /// Stream of connection status changes
  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  /// Stream of incoming messages from backend
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  /// Current connection status
  bool get isConnected => _isConnected;

  /// Current WebSocket URL
  String get url => _url;

  /// Set custom WebSocket URL (for different environments)
  void setUrl(String newUrl) {
    _url = newUrl;
    debugPrint('🌐 WebSocketService: URL updated to $_url');
  }

  /// Test WebSocket connection without establishing persistent connection
  /// Returns true if connection is successful, false otherwise
  Future<bool> testConnection({String? testUrl}) async {
    final urlToTest = testUrl ?? _url;
    debugPrint('🧪 WebSocketService: Testing connection to $urlToTest');

    try {
      final testChannel = WebSocketChannel.connect(Uri.parse(urlToTest));

      // Wait for connection with timeout
      await testChannel.ready.timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException('Connection timeout'),
      );

      // Send test message
      testChannel.sink.add('{"type": "test", "message": "connection_test"}');

      // Wait briefly for any response
      await Future.delayed(const Duration(milliseconds: 500));

      // Clean up test connection
      await testChannel.sink.close();

      debugPrint('✅ WebSocketService: Connection test successful');
      return true;
    } catch (e) {
      debugPrint('❌ WebSocketService: Connection test failed: $e');
      return false;
    }
  }

  /// Connect to WebSocket backend
  Future<bool> connect({String? customUrl}) async {
    if (_isConnected) {
      debugPrint('⚠️ WebSocketService: Already connected');
      return true;
    }

    if (_isDisposed) {
      debugPrint('⚠️ WebSocketService: Cannot connect, service is disposed.');
      return false;
    }

    final urlToConnect = customUrl ?? _url;
    debugPrint('🌐 WebSocketService: Connecting to $urlToConnect');

    try {
      _channel = connector(Uri.parse(urlToConnect));

      // Wait for connection with timeout
      await _channel!.ready.timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('Connection timeout'),
      );

      _isConnected = true;
      _retryCount = 0;
      if (!_isDisposed) _connectionStatusController.add(true);

      // Listen for incoming messages
      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnection,
      );

      debugPrint('✅ WebSocketService: Connected successfully');
      return true;
    } catch (e) {
      debugPrint('❌ WebSocketService: Connection failed: $e');
      _isConnected = false;
      if (!_isDisposed) _connectionStatusController.add(false);

      // Attempt retry if within retry limit
      if (_retryCount < _maxRetryAttempts) {
        _retryCount++;
        debugPrint(
          '🔄 WebSocketService: Retrying connection (attempt $_retryCount/$_maxRetryAttempts)',
        );

        await Future.delayed(_retryDelay);
        return await connect(customUrl: customUrl);
      }

      return false;
    }
  }

  /// Disconnect from WebSocket backend
  Future<void> disconnect() async {
    if (!_isConnected) {
      debugPrint('⚠️ WebSocketService: Already disconnected');
      return;
    }

    debugPrint('🌐 WebSocketService: Disconnecting...');

    _isConnected = false;
    _retryCount = 0;

    try {
      await _channel?.sink.close();
    } catch (e) {
      debugPrint('⚠️ WebSocketService: Error during disconnect: $e');
    }

    _channel = null;
    if (!_isDisposed) _connectionStatusController.add(false);

    debugPrint('✅ WebSocketService: Disconnected');
  }

  /// Send message to backend
  /// Returns true if message was sent successfully
  bool sendMessage(Map<String, dynamic> message) {
    if (!_isConnected || _channel == null) {
      debugPrint('❌ WebSocketService: Cannot send message - not connected');
      return false;
    }

    try {
      final jsonMessage = jsonEncode(message);
      _channel!.sink.add(jsonMessage);
      debugPrint(
        '📤 WebSocketService: Message sent: ${message['type'] ?? 'unknown'}',
      );
      return true;
    } catch (e) {
      debugPrint('❌ WebSocketService: Failed to send message: $e');
      return false;
    }
  }

  /// Send base64 encoded image frame to backend
  /// This is the primary method for face recognition
  bool sendImageFrame(String base64Image) {
    return sendMessage({
      'type': 'frame',
      'data': base64Image,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  /// Handle incoming messages from backend
  void _handleMessage(dynamic message) {
    if (_isDisposed) return;
    try {
      final Map<String, dynamic> parsedMessage = jsonDecode(message.toString());
      debugPrint(
        '📥 WebSocketService: Message received: ${parsedMessage['type'] ?? 'unknown'}',
      );

      _messageController.add(parsedMessage);
    } catch (e) {
      debugPrint('❌ WebSocketService: Failed to parse message: $e');
    }
  }

  /// Handle WebSocket errors
  void _handleError(dynamic error) {
    if (_isDisposed) return;
    debugPrint('❌ WebSocketService: WebSocket error: $error');

    _isConnected = false;
    _connectionStatusController.add(false);

    // Attempt reconnection if within retry limit
    if (_retryCount < _maxRetryAttempts) {
      _retryCount++;
      debugPrint(
        '🔄 WebSocketService: Attempting reconnection due to error (attempt $_retryCount/$_maxRetryAttempts)',
      );

      Future.delayed(_retryDelay, () => connect());
    }
  }

  /// Handle WebSocket disconnection
  void _handleDisconnection() {
    if (_isDisposed) return;
    debugPrint('🔴 WebSocketService: WebSocket disconnected');

    _isConnected = false;
    _channel = null;
    _connectionStatusController.add(false);
  }

  /// Get connection statistics
  Map<String, dynamic> getConnectionStats() {
    return {
      'isConnected': _isConnected,
      'url': _url,
      'retryCount': _retryCount,
      'maxRetryAttempts': _maxRetryAttempts,
    };
  }

  /// Dispose of the service and clean up resources
  void dispose() {
    debugPrint('🔴 WebSocketService: Disposing...');
    _isDisposed = true;
    disconnect();
    _connectionStatusController.close();
    _messageController.close();
  }
}
