import 'dart:async';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketConfig {
  final String url;
  final Duration connectionTimeout;
  final int maxRetryAttempts;
  final Duration retryDelay;

  const WebSocketConfig({
    required this.url,
    this.connectionTimeout = const Duration(seconds: 30),
    this.maxRetryAttempts = 3,
    this.retryDelay = const Duration(seconds: 3),
  });

  static final development = WebSocketConfig(url: 'ws://192.168.1.234:3009');
  // Add other environments if needed (staging, production)
}

@lazySingleton
class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  WebSocketChannel? channel;
  StreamSubscription? subscription;
  Timer? _timeoutTimer;
  Timer? _retryTimer;
  int _retryAttempts = 0;

  late WebSocketConfig _config;

  final _statusController = StreamController<ConnectionStatus>.broadcast();
  Stream<ConnectionStatus> get connectionStatusStream =>
      _statusController.stream;

  final _messageController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get messageStream => _messageController.stream;

  ConnectionStatus _currentStatus = ConnectionStatus.disconnected;
  ConnectionStatus get currentStatus => _currentStatus;

  void initialize({
    WebSocketConfig config = const WebSocketConfig(
      url: 'ws://192.168.1.234:3009',
    ),
  }) {
    _config = config;
    updateStatus(ConnectionStatus.disconnected);
  }

  void updateStatus(ConnectionStatus status) {
    if (_statusController.isClosed) return;
    _currentStatus = status;
    _statusController.add(status);
  }

  Future<void> connect() async {
    if (_statusController.isClosed ||
        (channel != null && _currentStatus == ConnectionStatus.connected)) {
      return;
    }

    updateStatus(ConnectionStatus.connecting);
    _retryAttempts = 0;
    _connect();
  }

  void _connect() {
    _timeoutTimer?.cancel();
    channel?.sink.close();

    try {
      channel = WebSocketChannel.connect(Uri.parse(_config.url));
      updateStatus(ConnectionStatus.connecting);

      _timeoutTimer = Timer(_config.connectionTimeout, handleTimeout);

      subscription = channel!.stream.listen(
        handleMessage,
        onError: handleError,
        onDone: handleDone,
        cancelOnError: true,
      );

      channel!.ready
          .then((_) {
            _timeoutTimer?.cancel();
            updateStatus(ConnectionStatus.connected);
            _retryAttempts = 0;
          })
          .catchError(handleError);
    } catch (e) {
      handleError(e);
    }
  }

  void handleMessage(dynamic message) {
    if (!_messageController.isClosed) {
      _messageController.add(message);
    }
  }

  void handleError(dynamic error) {
    _timeoutTimer?.cancel();
    if (_statusController.isClosed) return;

    if (_retryAttempts < _config.maxRetryAttempts) {
      _retryAttempts++;
      updateStatus(ConnectionStatus.retrying);
      _retryTimer?.cancel();
      _retryTimer = Timer(_config.retryDelay, _connect);
    } else {
      updateStatus(ConnectionStatus.failed);
    }
  }

  void handleDone() {
    _timeoutTimer?.cancel();
    if (_statusController.isClosed ||
        _currentStatus == ConnectionStatus.disconnected)
      return;
    // If it was connected, try to reconnect.
    if (_currentStatus == ConnectionStatus.connected) {
      handleError('Connection closed unexpectedly');
    }
  }

  void handleTimeout() {
    if (_statusController.isClosed) return;
    updateStatus(ConnectionStatus.timeout);
    handleError('Connection Timeout');
  }

  void sendMessage(dynamic message) {
    if (channel != null && _currentStatus == ConnectionStatus.connected) {
      channel!.sink.add(message);
    }
  }

  Future<void> disconnect() async {
    _retryTimer?.cancel();
    _timeoutTimer?.cancel();
    await subscription?.cancel();
    await channel?.sink.close();
    channel = null;
    if (!_statusController.isClosed) {
      updateStatus(ConnectionStatus.disconnected);
    }
  }

  void dispose() {
    disconnect();
    _statusController.close();
    _messageController.close();
  }
}
