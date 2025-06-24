import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
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

  final _statusController =
      StreamController<WebSocketConnectionStatus>.broadcast();
  Stream<WebSocketConnectionStatus> get connectionStatusStream =>
      _statusController.stream;

  final _messageController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get messageStream => _messageController.stream;

  WebSocketConnectionStatus _currentStatus =
      WebSocketConnectionStatus.disconnected;
  WebSocketConnectionStatus get currentStatus => _currentStatus;
  WebSocketConfig get currentConfig => _config;

  void initialize({WebSocketConfig? config}) {
    _config = config ?? WebSocketConfig.development;
    updateStatus(WebSocketConnectionStatus.disconnected);
  }

  void updateStatus(WebSocketConnectionStatus status) {
    if (_statusController.isClosed) return;
    _currentStatus = status;
    _statusController.add(status);
  }

  Future<void> connect() async {
    if (_statusController.isClosed ||
        _currentStatus == WebSocketConnectionStatus.connected ||
        _currentStatus == WebSocketConnectionStatus.connecting) {
      return;
    }

    updateStatus(WebSocketConnectionStatus.connecting);

    final completer = Completer<void>();

    try {
      await _connectWithCompleter(completer);
      await completer.future.timeout(_config.connectionTimeout);
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Perform lightweight server reachability check using HTTP ping
  Future<bool> pingServer() async {
    try {
      // Get WebSocket URL and convert to HTTP for lightweight check
      final wsUrl = currentConfig.url;
      final httpUrl = wsUrl
          .replaceFirst('wss://', 'https://')
          .replaceFirst('ws://', 'http://');

      // Perform HTTP HEAD request with timeout
      final response = await http
          .head(Uri.parse(httpUrl))
          .timeout(const Duration(seconds: 5));

      // Any response < 500 means server is reachable
      return response.statusCode < 500;
    } catch (e) {
      return false;
    }
  }

  /// Properly cleanup existing connection resources
  Future<void> _cleanupExistingConnection() async {
    if (subscription != null) {
      await subscription!.cancel();
      subscription = null;
    }
    if (channel != null) {
      await channel!.sink.close();
      channel = null;
    }
  }

  Future<void> _connectWithCompleter(Completer<void> completer) async {
    await _cleanupExistingConnection();

    try {
      channel = WebSocketChannel.connect(Uri.parse(_config.url));
      updateStatus(WebSocketConnectionStatus.connecting);

      subscription = channel!.stream.listen(
        handleMessage,
        onError: (error) {
          handleError(error);
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        },
        onDone: handleDone,
        cancelOnError: true,
      );

      channel!.ready
          .then((_) {
            updateStatus(WebSocketConnectionStatus.connected);
            if (!completer.isCompleted) {
              completer.complete();
            }
          })
          .catchError((error) {
            handleError(error);
            if (!completer.isCompleted) {
              completer.completeError(error);
            }
            return null;
          });
    } catch (e) {
      handleError(e);
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
    }
  }

  void handleMessage(dynamic message) {
    if (!_messageController.isClosed) {
      _messageController.add(message);
    }
  }

  void handleError(dynamic error) {
    if (_statusController.isClosed) return;

    updateStatus(WebSocketConnectionStatus.failed);
  }

  void handleDone() {
    if (_statusController.isClosed) return;

    switch (_currentStatus) {
      case WebSocketConnectionStatus.connected:
        // Unexpected disconnect from connected state
        updateStatus(WebSocketConnectionStatus.disconnected);
        break;
      case WebSocketConnectionStatus.connecting:
        // Connection failed during handshake
        updateStatus(WebSocketConnectionStatus.failed);
        break;
      case WebSocketConnectionStatus.disconnected:
      case WebSocketConnectionStatus.failed:
        // Expected states, no action needed
        break;
    }
  }

  void sendMessage(dynamic message) {
    if (channel != null &&
        _currentStatus == WebSocketConnectionStatus.connected) {
      channel!.sink.add(message);
    }
  }

  Future<void> disconnect() async {
    await _cleanupExistingConnection();
    if (!_statusController.isClosed) {
      updateStatus(WebSocketConnectionStatus.disconnected);
    }
  }

  void dispose() {
    disconnect();
    _statusController.close();
    _messageController.close();
  }
}
