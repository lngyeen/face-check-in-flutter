import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket_service.freezed.dart';

/// Represents the current WebSocket connection status
enum ConnectionStatus {
  /// Not connected to backend
  disconnected,

  /// Attempting to connect
  connecting,

  /// Successfully connected
  connected,

  /// Connection failed
  failed,

  /// Connection timed out
  timeout,

  /// Retrying to connect
  retrying,
}

@freezed
class WebSocketConfig with _$WebSocketConfig {
  const factory WebSocketConfig({
    required String url,
    @Default(Duration(seconds: 30)) Duration connectionTimeout,
    @Default(3) int maxRetryAttempts,
    @Default(Duration(seconds: 3)) Duration retryDelay,
  }) = _WebSocketConfig;

  static final development = WebSocketConfig(
    url: 'wss://facedetection-ws.owt.vn',
  );
  static final production = WebSocketConfig(
    url: 'wss://your_production_ws_url',
  );
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

  void initialize({WebSocketConfig? config}) {
    _config = config ?? WebSocketConfig.development;
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
        _currentStatus == ConnectionStatus.disconnected) {
      return;
    }
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
