import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:face_check_in_flutter/core/services/network_connectivity_service.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/network_status.dart';
import 'package:face_check_in_flutter/domain/entities/retry_state.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

abstract class WebSocketService {
  Stream<WebSocketConnectionStatus> get connectionStatusStream;
  Stream<dynamic> get messageStream;
  Stream<RetryState> get retryStateStream;
  Stream<NetworkStatus> get networkStatusStream;
  Stream<AppConnectionStatus> get appConnectionStatusStream;

  WebSocketConnectionStatus get currentStatus;
  RetryState get currentRetryState;
  AppConnectionStatus get currentAppConnectionStatus;
  Duration get connectionTimeout;
  Duration get pingTimeout;

  Future<void> initialize({
    required String url,
    required String apiKey,
    Duration connectionTimeout = const Duration(seconds: 3),
    Duration pingTimeout = const Duration(seconds: 1),
  });

  Future<void> connect();
  Future<void> disconnect();
  void sendMessage(dynamic message);
  void setConnectionTimeout(Duration timeout);
  void setPingTimeout(Duration timeout);
  void dispose();
}

/// WebSocket service for managing real-time connections with automatic retry logic
/// Provides connection status monitoring, message handling, and network-aware reconnection
@LazySingleton(as: WebSocketService)
class WebSocketServiceImpl implements WebSocketService {
  final NetworkConnectivityService _networkService;

  WebSocketServiceImpl(this._networkService);

  /// Maximum number of fast retry attempts before switching to background monitoring
  static const _maxFastRetries = 4;

  /// Initial delay for exponential backoff
  static const _initialDelay = Duration(seconds: 1);

  /// Maximum delay for exponential backoff
  static const _maxDelay = Duration(seconds: 30);

  /// Interval for background connectivity checks
  static const _backgroundInterval = Duration(seconds: 30);

  late String _url;
  late String _apiKey;
  Duration _connectionTimeout = const Duration(seconds: 3);
  Duration _pingTimeout = const Duration(seconds: 1);
  WebSocketChannel? _channel;
  StreamSubscription? _networkSubscription;
  StreamSubscription? _subscription;
  Timer? _retryTimer;
  Timer? _backgroundTimer;

  final _statusSubject = BehaviorSubject<WebSocketConnectionStatus>.seeded(
    WebSocketConnectionStatus.disconnected,
  );

  final _messageSubject = PublishSubject<dynamic>();

  final _retryStateSubject = BehaviorSubject<RetryState>.seeded(
    const RetryState.idle(),
  );

  @override
  Stream<WebSocketConnectionStatus> get connectionStatusStream =>
      _statusSubject.stream;
  @override
  Stream<dynamic> get messageStream => _messageSubject.stream;
  @override
  Stream<RetryState> get retryStateStream => _retryStateSubject.stream;
  @override
  Stream<NetworkStatus> get networkStatusStream =>
      _networkService.connectivityStream;

  /// Computed stream combining network, WebSocket status, and retry state
  @override
  Stream<AppConnectionStatus> get appConnectionStatusStream {
    return Rx.combineLatest3<
      NetworkStatus,
      WebSocketConnectionStatus,
      RetryState,
      AppConnectionStatus
    >(
      networkStatusStream,
      connectionStatusStream,
      retryStateStream,
      (networkStatus, wsStatus, retryState) =>
          _computeAppConnectionStatus(networkStatus, wsStatus, retryState),
    ).distinct();
  }

  @override
  WebSocketConnectionStatus get currentStatus => _statusSubject.value;
  @override
  RetryState get currentRetryState => _retryStateSubject.value;
  @override
  AppConnectionStatus get currentAppConnectionStatus =>
      _computeAppConnectionStatus(
        _networkService.currentStatus,
        currentStatus,
        currentRetryState,
      );
  @override
  Duration get connectionTimeout => _connectionTimeout;
  @override
  Duration get pingTimeout => _pingTimeout;

  /// Initialize WebSocket service with URL and timeout configurations
  @override
  Future<void> initialize({
    required String url,
    required String apiKey,
    Duration connectionTimeout = const Duration(seconds: 3),
    Duration pingTimeout = const Duration(seconds: 1),
  }) async {
    _url = url;
    _apiKey = apiKey;
    _connectionTimeout = connectionTimeout;
    _pingTimeout = pingTimeout;

    _setupNetworkListeners();
    await _networkService.initialize();
  }

  /// Establish WebSocket connection
  @override
  Future<void> connect() async {
    if (_statusSubject.isClosed ||
        currentStatus == WebSocketConnectionStatus.connected ||
        currentStatus == WebSocketConnectionStatus.connecting) {
      return;
    }

    // Do not attempt to connect if the network is definitively disconnected.
    if (_networkService.currentStatus == NetworkStatus.disconnected) {
      _updateStatus(WebSocketConnectionStatus.failed);
      _startRetryProcess();
      return;
    }

    await _cleanupExistingConnection();

    try {
      _updateStatus(WebSocketConnectionStatus.connecting);
      final channel = WebSocketChannel.connect(_webSocketUri);

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
      _channel = channel;
    } catch (e) {
      _handleError(e);
    }
  }

  /// Disconnect WebSocket connection
  @override
  Future<void> disconnect() async {
    _resetRetryState();
    await _cleanupExistingConnection();
    if (!_statusSubject.isClosed) {
      _updateStatus(WebSocketConnectionStatus.disconnected);
    }
  }

  /// Send message through WebSocket
  @override
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

  Uri get _webSocketUri {
    return Uri.parse('$_url?apiKey=$_apiKey');
  }

  /// Perform lightweight WebSocket connectivity check
  /// Creates a temporary WebSocket connection to test server reachability
  Future<bool> _pingServer() async {
    try {
      final testChannel = WebSocketChannel.connect(_webSocketUri);

      await testChannel.ready.timeout(
        _pingTimeout,
        onTimeout: () {
          throw TimeoutException(
            'WebSocket connection timeout',
            _connectionTimeout,
          );
        },
      );
      await testChannel.sink.close();
      return true;
    } catch (e) {
      return await _tcpPingServer();
    }
  }

  /// Update connection timeout setting
  @override
  void setConnectionTimeout(Duration timeout) {
    _connectionTimeout = timeout;
  }

  /// Update ping timeout setting
  @override
  void setPingTimeout(Duration timeout) {
    _pingTimeout = timeout;
  }

  /// Dispose service and cleanup resources
  @override
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
    _networkSubscription = _networkService.connectivityStream.distinct().listen((
      networkStatus,
    ) async {
      switch (networkStatus) {
        case NetworkStatus.connected:
          // If we were previously disconnected, try reconnecting now.
          if (currentStatus == WebSocketConnectionStatus.disconnected ||
              currentStatus == WebSocketConnectionStatus.failed) {
            _resetRetryState();
            await connect();
          }
          break;
        case NetworkStatus.disconnected:
          // When network is lost, await the disconnect to ensure all cleanup is complete.
          await disconnect();
          break;
        case NetworkStatus.initial:
          // Do nothing, wait for a definitive status.
          break;
      }
    });
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

    final channelToClose = _channel;
    _channel = null;

    if (channelToClose != null) {
      try {
        await channelToClose.sink.close().timeout(const Duration(seconds: 1));
      } catch (e) {
        // Safe to ignore.
      }
    }
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
    final isServerReachable = await _pingServer();
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
      final uri = _webSocketUri;
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
    NetworkStatus networkStatus,
    WebSocketConnectionStatus wsStatus,
    RetryState retryState,
  ) {
    switch (networkStatus) {
      case NetworkStatus.initial:
        return AppConnectionStatus.initial;
      case NetworkStatus.disconnected:
        return AppConnectionStatus.networkLost;
      case NetworkStatus.connected:
        // Network is fine, so the status depends on the WebSocket state.
        switch (wsStatus) {
          case WebSocketConnectionStatus.connected:
            return AppConnectionStatus.connected;
          case WebSocketConnectionStatus.connecting:
            return AppConnectionStatus.connecting;
          case WebSocketConnectionStatus.disconnected:
            return retryState.when(
              idle: () => AppConnectionStatus.initial,
              fastRetrying: (_, __) => AppConnectionStatus.fastRetrying,
              backgroundMonitoring:
                  () => AppConnectionStatus.backgroundRetrying,
            );
          case WebSocketConnectionStatus.failed:
            return retryState.when(
              idle: () => AppConnectionStatus.failed,
              fastRetrying: (_, __) => AppConnectionStatus.fastRetrying,
              backgroundMonitoring:
                  () => AppConnectionStatus.backgroundRetrying,
            );
        }
    }
  }
}
