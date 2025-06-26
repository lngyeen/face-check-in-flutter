import 'dart:async';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:face_check_in_flutter/core/services/network_connectivity_service.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

part 'websocket_service.freezed.dart';

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

  late String _url;

  final _statusSubject = BehaviorSubject<WebSocketConnectionStatus>.seeded(
    WebSocketConnectionStatus.disconnected,
  );
  Stream<WebSocketConnectionStatus> get connectionStatusStream =>
      _statusSubject.stream;

  final _messageSubject = PublishSubject<dynamic>();
  Stream<dynamic> get messageStream => _messageSubject.stream;

  // Add network availability stream
  Stream<bool> get isNetworkAvailable => _networkService.connectivityStream;

  // Add computed stream for AppConnectionStatus
  Stream<AppConnectionStatus> get appConnectionStatusStream {
    return Rx.combineLatest2<
      bool,
      WebSocketConnectionStatus,
      AppConnectionStatus
    >(
      isNetworkAvailable,
      connectionStatusStream,
      (isNetworkConnected, wsStatus) => _computeAppConnectionStatus(
        isNetworkConnected,
        wsStatus,
        _retryState,
      ),
    ).distinct(); // Only emit when status actually changes
  }

  // Current computed app connection status
  AppConnectionStatus get currentAppConnectionStatus =>
      _computeAppConnectionStatus(
        _networkService.isConnected,
        currentStatus,
        _retryState,
      );

  WebSocketConnectionStatus get currentStatus => _statusSubject.value;

  Future<void> initialize({required String url}) async {
    _url = url;

    await _networkService.initialize();

    _setupNetworkListeners();
  }

  void _setupNetworkListeners() {
    _networkSubscription?.cancel();
    _networkSubscription = _networkService.connectivityStream.distinct().listen(
      (isConnected) async {
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
      },
    );
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

    await _cleanupExistingConnection();

    try {
      updateStatus(WebSocketConnectionStatus.connecting);
      final channel = WebSocketChannel.connect(Uri.parse(_url));

      _subscription = channel.stream.listen(
        handleMessage,
        onError: (error) {
          handleError(error);
        },
        onDone: handleDone,
        cancelOnError: true,
      );

      channel.ready
          .then((_) {
            _resetRetryState();
            updateStatus(WebSocketConnectionStatus.connected);
          })
          .catchError((error) {
            handleError(error);
            return null;
          });

      _channel = channel;
    } catch (e) {
      handleError(e);
    }
  }

  /// Perform lightweight server reachability check using HTTP ping
  Future<bool> pingServer() async {
    try {
      // Get WebSocket URL and convert to HTTP for lightweight check
      final wsUrl = _url;
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
      _retryTimer = null; // Clear timer reference when done
      await connect();
    });
  }

  /// Schedule background connectivity check
  void _scheduleBackgroundCheck() {
    // Prevent multiple background checks
    if (_backgroundTimer != null) {
      return;
    }

    _backgroundTimer?.cancel();
    _backgroundTimer = Timer(_backgroundInterval, () async {
      _backgroundTimer = null; // Clear timer reference when done
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

  void handleMessage(dynamic message) {
    if (!_messageSubject.isClosed) {
      _messageSubject.add(message);
    }
  }

  void handleError(dynamic error) {
    updateStatus(WebSocketConnectionStatus.failed);

    // Prevent multiple retry schedules - only process if not already scheduled
    if (_retryTimer != null) {
      print('Retry already scheduled, ignoring additional error: $error');
      return;
    }

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

  /// Compute AppConnectionStatus from network + websocket + retry state
  AppConnectionStatus _computeAppConnectionStatus(
    bool isNetworkConnected,
    WebSocketConnectionStatus wsStatus,
    RetryState retryState,
  ) {
    // No network = network lost
    if (!isNetworkConnected) {
      return AppConnectionStatus.networkLost;
    }

    // Network available, check WebSocket status
    switch (wsStatus) {
      case WebSocketConnectionStatus.connected:
        return AppConnectionStatus.connected;

      case WebSocketConnectionStatus.connecting:
        return AppConnectionStatus.connecting;

      case WebSocketConnectionStatus.disconnected:
        // Check if we're in initial state or retrying
        return retryState.when(
          idle: () => AppConnectionStatus.initial,
          fastRetrying: (_, __) => AppConnectionStatus.fastRetrying,
          backgroundMonitoring: () => AppConnectionStatus.backgroundRetrying,
        );

      case WebSocketConnectionStatus.failed:
        // Check retry state to determine if fast retrying or background
        return retryState.when(
          idle: () => AppConnectionStatus.failed,
          fastRetrying: (_, __) => AppConnectionStatus.fastRetrying,
          backgroundMonitoring: () => AppConnectionStatus.backgroundRetrying,
        );
    }
  }
}
