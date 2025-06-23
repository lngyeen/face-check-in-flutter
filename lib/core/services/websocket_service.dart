import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/entities/connection_status.dart';

part 'websocket_service.freezed.dart';

@freezed
class WebSocketConfig with _$WebSocketConfig {
  const factory WebSocketConfig({
    required String url,
    @Default(Duration(seconds: 10)) Duration connectionTimeout,
    @Default(false)
    bool
    enableInternalRetry, // Disable internal retry to let ReconnectionManager handle it
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
    _connect();
  }

  void _connect() {
    channel?.sink.close();

    try {
      channel = WebSocketChannel.connect(Uri.parse(_config.url));
      updateStatus(ConnectionStatus.connecting);

      subscription = channel!.stream.listen(
        handleMessage,
        onError: handleError,
        onDone: handleDone,
        cancelOnError: true,
      );

      channel!.ready
          .then((_) {
            updateStatus(ConnectionStatus.connected);
          })
          .catchError((error) {
            handleError(error);
            return null;
          });
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
    if (_statusController.isClosed) return;

    updateStatus(ConnectionStatus.failed);
  }

  void handleDone() {
    if (_statusController.isClosed ||
        _currentStatus == ConnectionStatus.disconnected) {
      return;
    }
    if (_currentStatus == ConnectionStatus.connected) {
      handleError('Connection closed unexpectedly');
    }
  }

  void sendMessage(dynamic message) {
    if (channel != null && _currentStatus == ConnectionStatus.connected) {
      channel!.sink.add(message);
    }
  }

  Future<void> disconnect() async {
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
