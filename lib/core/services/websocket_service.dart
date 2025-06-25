import 'dart:async';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:face_check_in_flutter/core/services/network_connectivity_service.dart';
import 'package:face_check_in_flutter/flavors.dart';

import '../../domain/entities/connection_status.dart';

part 'websocket_service.freezed.dart';

@freezed
class WebSocketConfig with _$WebSocketConfig {
  const factory WebSocketConfig({
    required String url,
    @Default(Duration(seconds: 10)) Duration connectionTimeout,
  }) = _WebSocketConfig;
}

@freezed
class RetryState with _$RetryState {
  /// Not retrying - idle state
  const factory RetryState.idle() = _IdleRetryState;

  /// Fast retry phase with exponential backoff
  const factory RetryState.fastRetrying({
    required int currentAttempt,
    required int maxAttempts,
  }) = _FastRetryingState;

  /// Background monitoring phase - periodic checks
  const factory RetryState.backgroundMonitoring() = _BackgroundMonitoringState;
}

@lazySingleton
class WebSocketService {
  final NetworkConnectivityService _networkService;

  WebSocketService(this._networkService);

  WebSocketChannel? _channel;
  StreamSubscription? _networkSubscription;
  StreamSubscription? _subscription;

  // Timer management for retry logic
  Timer? _retryTimer;
  Timer? _backgroundTimer;
  RetryState _retryState = const RetryState.idle();

  // Retry configuration
  static const _maxFastRetries = 5;
  static const _initialDelay = Duration(seconds: 1);
  static const _maxDelay = Duration(seconds: 30);
  static const _backgroundInterval = Duration(seconds: 30);

  late WebSocketConfig _config;

  final _statusSubject = BehaviorSubject<WebSocketConnectionStatus>.seeded(
    WebSocketConnectionStatus.disconnected,
  );
  Stream<WebSocketConnectionStatus> get connectionStatusStream =>
      _statusSubject.stream;

  final _messageSubject = PublishSubject<dynamic>();
  Stream<dynamic> get messageStream => _messageSubject.stream;

  WebSocketConnectionStatus get currentStatus => _statusSubject.value;
  WebSocketConfig get currentConfig => _config;

  Future<void> initialize({WebSocketConfig? config}) async {
    _config = config ?? WebSocketConfig(url: F.baseWebSocketUrl);

    await _networkService.initialize();
    _networkSubscription = _networkService.connectivityStream.listen((
      isConnected,
    ) async {
      if (isConnected) {
        if (currentStatus == WebSocketConnectionStatus.disconnected ||
            currentStatus == WebSocketConnectionStatus.failed) {
          _resetRetryState();
          connect();
        }
      } else {
        _resetRetryState();
        updateStatus(WebSocketConnectionStatus.disconnected);

        await _cleanupExistingConnection();
      }
    });
  }

  void updateStatus(WebSocketConnectionStatus status) {
    if (_statusSubject.isClosed) return;
    _statusSubject.add(status);
  }

  Future<void> connect() async {
    if (_statusSubject.isClosed ||
        currentStatus == WebSocketConnectionStatus.connected ||
        currentStatus == WebSocketConnectionStatus.connecting) {
      return;
    }

    final completer = Completer<void>();
    await _connectWithCompleter(completer);
    await completer.future.timeout(_config.connectionTimeout);
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

  /// Calculate exponential backoff delay
  Duration _calculateBackoffDelay(int attemptNumber) {
    final exponentialDelay =
        _initialDelay.inMilliseconds * pow(2, attemptNumber - 1).round();
    final clampedDelay = min(exponentialDelay, _maxDelay.inMilliseconds);
    return Duration(milliseconds: clampedDelay);
  }

  /// Schedule retry attempt after delay
  void _scheduleRetry(Duration delay) {
    _retryTimer?.cancel();
    _retryTimer = Timer(delay, () async {
      await connect();
    });
  }

  /// Schedule background connectivity check
  void _scheduleBackgroundCheck() {
    _backgroundTimer?.cancel();
    _backgroundTimer = Timer(_backgroundInterval, () async {
      await _backgroundCheck();
    });
  }

  Future<void> _backgroundCheck() async {
    final isServerReachable = await pingServer();
    if (isServerReachable) {
      _startFastRetryPhase();
    } else {
      _scheduleBackgroundCheck();
    }
  }

  void _startFastRetryPhase() {
    const attempt = 1;
    final delay = _calculateBackoffDelay(attempt);

    _retryState = RetryState.fastRetrying(
      currentAttempt: attempt,
      maxAttempts: _maxFastRetries,
    );

    _scheduleRetry(delay);
  }

  void _continueFastRetryPhase(int currentAttempt) {
    final nextAttempt = currentAttempt + 1;
    final delay = _calculateBackoffDelay(nextAttempt);

    _retryState = RetryState.fastRetrying(
      currentAttempt: nextAttempt,
      maxAttempts: _maxFastRetries,
    );

    _scheduleRetry(delay);
  }

  /// Cancel all timers
  void _cancelAllTimers() {
    _retryTimer?.cancel();
    _retryTimer = null;

    _backgroundTimer?.cancel();
    _backgroundTimer = null;
  }

  /// Properly cleanup existing connection resources
  Future<void> _cleanupExistingConnection() async {
    await _subscription?.cancel();
    _subscription = null;

    await _channel?.sink.close();
    _channel = null;
  }

  Future<void> _connectWithCompleter(Completer<void> completer) async {
    await _cleanupExistingConnection();

    try {
      updateStatus(WebSocketConnectionStatus.connecting);
      final channel = WebSocketChannel.connect(Uri.parse(_config.url));

      _subscription = channel.stream.listen(
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

      channel.ready
          .then((_) {
            _resetRetryState();
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

      _channel = channel;
    } catch (e) {
      handleError(e);
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
    }
  }

  void handleMessage(dynamic message) {
    if (!_messageSubject.isClosed) {
      _messageSubject.add(message);
    }
  }

  void handleError(dynamic error) {
    updateStatus(WebSocketConnectionStatus.failed);

    _retryState.when(
      idle: () => _startFastRetryPhase(),
      fastRetrying: (attempt, maxAttempts) {
        if (attempt < maxAttempts) {
          _continueFastRetryPhase(attempt);
        } else {
          _switchToBackgroundMonitoring();
        }
      },
      backgroundMonitoring: () => _scheduleBackgroundCheck(),
    );
  }

  void _switchToBackgroundMonitoring() {
    _retryState = RetryState.backgroundMonitoring();

    _scheduleBackgroundCheck();
  }

  void _resetRetryState() {
    _retryState = const RetryState.idle();
    _cancelAllTimers();
  }

  void handleDone() {
    if (_statusSubject.isClosed) return;

    switch (currentStatus) {
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
    if (_channel != null &&
        currentStatus == WebSocketConnectionStatus.connected) {
      _channel!.sink.add(message);
    }
  }

  Future<void> disconnect() async {
    await _cleanupExistingConnection();
    if (!_statusSubject.isClosed) {
      updateStatus(WebSocketConnectionStatus.disconnected);
    }
  }

  void dispose() {
    disconnect();
    _networkSubscription?.cancel();
    _statusSubject.close();
    _messageSubject.close();
  }
}
