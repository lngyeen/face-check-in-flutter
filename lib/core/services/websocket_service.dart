import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
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

/// WebSocket service for managing real-time connections with automatic retry logic
/// Provides connection status monitoring, message handling, and network-aware reconnection
@lazySingleton
class WebSocketService {
  final NetworkConnectivityService _networkService;

  WebSocketService(this._networkService);

  /// Maximum number of fast retry attempts before switching to background monitoring
  static const _maxFastRetries = 4;

  /// Initial delay for exponential backoff
  static const _initialDelay = Duration(seconds: 1);

  /// Maximum delay for exponential backoff
  static const _maxDelay = Duration(seconds: 30);

  /// Interval for background connectivity checks
  static const _backgroundInterval = Duration(seconds: 30);

  /// WebSocket URL
  late String _url;

  /// Connection timeout configuration
  Duration _connectionTimeout = const Duration(seconds: 10);

  /// Ping timeout configuration
  Duration _pingTimeout = const Duration(seconds: 3);

  /// WebSocket channel instance
  WebSocketChannel? _channel;

  /// Network connectivity subscription
  StreamSubscription? _networkSubscription;

  /// WebSocket stream subscription
  StreamSubscription? _subscription;

  /// Timer for retry attempts
  Timer? _retryTimer;

  /// Timer for background connectivity checks
  Timer? _backgroundTimer;

  /// WebSocket connection status subject
  final _statusSubject = BehaviorSubject<WebSocketConnectionStatus>.seeded(
    WebSocketConnectionStatus.disconnected,
  );

  /// Message stream subject
  final _messageSubject = PublishSubject<dynamic>();

  /// Retry state subject
  final _retryStateSubject = BehaviorSubject<RetryState>.seeded(
    const RetryState.idle(),
  );

  /// Stream of WebSocket connection status changes
  Stream<WebSocketConnectionStatus> get connectionStatusStream =>
      _statusSubject.stream;

  /// Stream of incoming WebSocket messages
  Stream<dynamic> get messageStream => _messageSubject.stream;

  /// Stream of retry state changes
  Stream<RetryState> get retryStateStream => _retryStateSubject.stream;

  /// Stream of network availability changes
  Stream<bool> get isNetworkAvailable => _networkService.connectivityStream;

  /// Computed stream combining network, WebSocket status, and retry state
  Stream<AppConnectionStatus> get appConnectionStatusStream {
    return Rx.combineLatest3<
      bool,
      WebSocketConnectionStatus,
      RetryState,
      AppConnectionStatus
    >(
      isNetworkAvailable,
      connectionStatusStream,
      retryStateStream,
      (isNetworkConnected, wsStatus, retryState) =>
          _computeAppConnectionStatus(isNetworkConnected, wsStatus, retryState),
    ).distinct();
  }

  /// Current WebSocket connection status
  WebSocketConnectionStatus get currentStatus => _statusSubject.value;

  /// Current retry state
  RetryState get currentRetryState => _retryStateSubject.value;

  /// Current computed app connection status
  AppConnectionStatus get currentAppConnectionStatus =>
      _computeAppConnectionStatus(
        _networkService.isConnected,
        currentStatus,
        currentRetryState,
      );

  /// Current connection timeout setting
  Duration get connectionTimeout => _connectionTimeout;

  /// Current ping timeout setting
  Duration get pingTimeout => _pingTimeout;

  /// Initialize WebSocket service with URL and timeout configurations
  Future<void> initialize({
    required String url,
    Duration connectionTimeout = const Duration(seconds: 10),
    Duration pingTimeout = const Duration(seconds: 3),
  }) async {
    _url = url;
    _connectionTimeout = connectionTimeout;
    _pingTimeout = pingTimeout;

    _setupNetworkListeners();
    await _networkService.initialize();
  }

  /// Establish WebSocket connection
  Future<void> connect() async {
    if (_statusSubject.isClosed ||
        currentStatus == WebSocketConnectionStatus.connected ||
        currentStatus == WebSocketConnectionStatus.connecting) {
      return;
    }

    await _cleanupExistingConnection();

    try {
      _updateStatus(WebSocketConnectionStatus.connecting);
      final channel = WebSocketChannel.connect(Uri.parse(_url));
      _channel = channel;

      _subscription = channel.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
        cancelOnError: true,
      );

      // Wait for connection to be ready with timeout
      await channel.ready.timeout(
        _connectionTimeout,
        onTimeout: () {
          throw TimeoutException(
            'WebSocket connection timeout',
            _connectionTimeout,
          );
        },
      );

      // Connection successful
      _resetRetryState();
      _updateStatus(WebSocketConnectionStatus.connected);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Disconnect WebSocket connection
  Future<void> disconnect() async {
    await _cleanupExistingConnection();
    if (!_statusSubject.isClosed) {
      _updateStatus(WebSocketConnectionStatus.disconnected);
    }
  }

  /// Send message through WebSocket
  void sendMessage(dynamic message) {
    final channel = _channel;
    if (channel != null &&
        currentStatus == WebSocketConnectionStatus.connected) {
      try {
        channel.sink.add(message);
      } catch (e) {
        // Silent error handling
      }
    }
  }

  /// Perform lightweight WebSocket connectivity check
  /// Creates a temporary WebSocket connection to test server reachability
  Future<bool> pingServer() async {
    try {
      // Create temporary WebSocket connection with short timeout
      final testChannel = WebSocketChannel.connect(Uri.parse(_url));

      // Wait for connection ready with timeout
      await testChannel.ready.timeout(_pingTimeout);

      // Clean up test connection immediately
      await testChannel.sink.close();

      return true;
    } catch (e) {
      // Fallback to TCP socket check if WebSocket ping fails
      return await _tcpPingServer();
    }
  }

  /// Update connection timeout setting
  void setConnectionTimeout(Duration timeout) {
    _connectionTimeout = timeout;
  }

  /// Update ping timeout setting
  void setPingTimeout(Duration timeout) {
    _pingTimeout = timeout;
  }

  /// Dispose service and cleanup resources
  void dispose() {
    disconnect();
    _networkSubscription?.cancel();
    _statusSubject.close();
    _messageSubject.close();
    _retryStateSubject.close();
  }

  /// Setup network connectivity listeners for automatic reconnection
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
          _updateStatus(WebSocketConnectionStatus.disconnected);
          await _cleanupExistingConnection();
        }
      },
    );
  }

  /// Update WebSocket connection status
  void _updateStatus(WebSocketConnectionStatus status) {
    if (_statusSubject.isClosed) return;
    _statusSubject.add(status);
  }

  /// Properly cleanup existing connection resources
  Future<void> _cleanupExistingConnection() async {
    _cancelAllTimers();

    await _subscription?.cancel();
    _subscription = null;

    await _channel?.sink.close();
    _channel = null;
  }

  /// Handle incoming WebSocket messages
  void _handleMessage(dynamic message) {
    if (!_messageSubject.isClosed) {
      _messageSubject.add(message);
    }
  }

  /// Handle WebSocket connection errors
  void _handleError(dynamic error) {
    _updateStatus(WebSocketConnectionStatus.failed);

    if (_retryTimer != null) {
      return;
    }

    _startRetryProcess();
  }

  void _startRetryProcess() {
    currentRetryState.when(
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

  /// Handle WebSocket connection closure
  void _handleDone() {
    if (_statusSubject.isClosed) return;

    switch (currentStatus) {
      case WebSocketConnectionStatus.connected:
        // Unexpected disconnect from connected state
        _updateStatus(WebSocketConnectionStatus.disconnected);
        _startRetryProcess();
        break;
      case WebSocketConnectionStatus.connecting:
        // Connection failed during handshake
        _updateStatus(WebSocketConnectionStatus.failed);
        break;
      case WebSocketConnectionStatus.disconnected:
      case WebSocketConnectionStatus.failed:
        // Expected states, no action needed
        break;
    }
  }

  /// Update retry state
  void _updateRetryState(RetryState newState) {
    if (_retryStateSubject.isClosed) return;
    _retryStateSubject.add(newState);
  }

  /// Reset retry state to idle and cancel all timers
  void _resetRetryState() {
    _updateRetryState(const RetryState.idle());
    _cancelAllTimers();
  }

  /// Start fast retry phase with exponential backoff
  void _startFastRetryPhase() {
    const attempt = 1;
    final delay = _calculateBackoffDelay(attempt);

    _updateRetryState(
      RetryState.fastRetrying(
        currentAttempt: attempt,
        maxAttempts: _maxFastRetries,
      ),
    );

    _scheduleRetry(delay);
  }

  /// Continue fast retry phase with next attempt
  void _continueFastRetryPhase(int currentAttempt) {
    final nextAttempt = currentAttempt + 1;
    final delay = _calculateBackoffDelay(nextAttempt);

    _updateRetryState(
      RetryState.fastRetrying(
        currentAttempt: nextAttempt,
        maxAttempts: _maxFastRetries,
      ),
    );

    _scheduleRetry(delay);
  }

  /// Switch to background monitoring phase
  void _switchToBackgroundMonitoring() {
    _updateRetryState(const RetryState.backgroundMonitoring());
    _scheduleBackgroundCheck();
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
      _retryTimer = null;
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
      _backgroundTimer = null;
      await _backgroundCheck();
    });
  }

  /// Cancel all active timers
  void _cancelAllTimers() {
    _retryTimer?.cancel();
    _retryTimer = null;

    _backgroundTimer?.cancel();
    _backgroundTimer = null;
  }

  /// Perform background connectivity check
  Future<void> _backgroundCheck() async {
    final isServerReachable = await pingServer();
    if (isServerReachable) {
      _startFastRetryPhase();
    } else {
      _scheduleBackgroundCheck();
    }
  }

  /// Fallback TCP connectivity check
  /// Tests if the server port is reachable without WebSocket handshake
  Future<bool> _tcpPingServer() async {
    try {
      final uri = Uri.parse(_url);
      final host = uri.host;
      final port = uri.port != 0 ? uri.port : (uri.scheme == 'wss' ? 443 : 80);

      // Attempt TCP connection with timeout
      final socket = await Socket.connect(
        host,
        port,
        timeout: const Duration(seconds: 2),
      );

      // Close socket immediately after successful connection
      await socket.close();

      return true;
    } catch (e) {
      return false;
    }
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
