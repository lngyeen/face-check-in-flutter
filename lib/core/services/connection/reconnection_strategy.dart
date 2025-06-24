import 'dart:async';
import 'dart:math';

import '../../../domain/entities/connection_status.dart';

import 'connection_models.dart';

/// Handles reconnection logic with two-phase strategy
class ReconnectionStrategy {
  final ReconnectionConfig _config;

  // Reconnection state tracking
  ReconnectionState _reconnectionState = ReconnectionState.connected;
  Timer? _backgroundMonitoringTimer;
  Timer? _fastRetryTimer;
  int _fastRetryCount = 0;

  // Callbacks for connection operations
  late final Future<void> Function() _performReconnection; // Changed to void
  late final void Function() _onConnectionSuccess;

  // WebSocket status monitoring
  StreamSubscription<WebSocketConnectionStatus>? _webSocketStatusSubscription;

  // Reconnection state stream
  final _reconnectionStateController =
      StreamController<ReconnectionState>.broadcast();
  Stream<ReconnectionState> get reconnectionStateStream =>
      _reconnectionStateController.stream;

  ReconnectionStrategy({ReconnectionConfig? config})
    : _config = config ?? const ReconnectionConfig();

  /// Initialize with required callbacks and WebSocket status stream
  void initialize({
    required Future<void> Function() performReconnection,
    required void Function() onConnectionSuccess,
    required Stream<WebSocketConnectionStatus> webSocketStatusStream,
  }) {
    _performReconnection = performReconnection;
    _onConnectionSuccess = onConnectionSuccess;

    // Listen to WebSocket status changes
    _webSocketStatusSubscription = webSocketStatusStream.listen(
      _handleWebSocketStatusChange,
    );
  }

  /// Handle WebSocket status changes - Core of event-driven architecture
  void _handleWebSocketStatusChange(WebSocketConnectionStatus status) {
    switch (_reconnectionState) {
      case ReconnectionState.fastRetrying:
      case ReconnectionState.backgroundMonitoring:
        // Only react to status changes when we're actively trying to reconnect
        if (status == WebSocketConnectionStatus.connected) {
          // Connection successful - handle success
          handleConnectionSuccess();
        } else if (status == WebSocketConnectionStatus.failed) {
          // Connection failed - continue retry logic based on current state
          _handleReconnectionFailure();
        }
        // Ignore 'connecting' and 'disconnected' states during reconnection
        break;
      case ReconnectionState.connected:
      case ReconnectionState.failed:
        // Not actively reconnecting, ignore status changes
        break;
    }
  }

  /// Handle reconnection failure - called when WebSocket reports failure
  void _handleReconnectionFailure() {
    switch (_reconnectionState) {
      case ReconnectionState.fastRetrying:
        // Continue with fast retry logic (will schedule next attempt)
        break;
      case ReconnectionState.backgroundMonitoring:
        // Stay in background monitoring, next periodic check will retry
        break;
      case ReconnectionState.connected:
      case ReconnectionState.failed:
        // Shouldn't happen, but ignore
        break;
    }
  }

  /// Current reconnection state
  ReconnectionState get currentState => _reconnectionState;

  /// Current retry attempt number (for UI display)
  int get currentRetryAttempt => _fastRetryCount;

  /// Maximum fast retry attempts (for UI display)
  int get maxRetryAttempts => _config.maxFastRetries;

  /// Handle network connectivity loss
  void handleNetworkLost() {
    _startFreshRetryPhase();
  }

  /// Handle network connectivity restored
  void handleNetworkRestored() {
    _startFreshRetryPhase();
  }

  /// Handle connection failure (server down, timeout, etc.)
  void handleConnectionFailure() {
    if (_reconnectionState == ReconnectionState.connected) {
      _startFreshRetryPhase();
    }
  }

  /// Handle successful connection
  void handleConnectionSuccess() {
    _stopReconnectionTimers();
    _resetRetryState();
    _setReconnectionState(ReconnectionState.connected);
    _onConnectionSuccess();
  }

  /// Stop all reconnection attempts
  void stopReconnection() {
    _stopReconnectionTimers();
    _setReconnectionState(ReconnectionState.connected);
  }

  /// Handle manual retry request from user
  Future<bool> requestManualRetry() async {
    // TODO: Enable this function for both current state retrying or backgroundMonitoring
    // Only allow manual retry in background monitoring state
    if (_reconnectionState != ReconnectionState.backgroundMonitoring) {
      return false;
    }

    try {
      // Trigger reconnection attempt - result will be handled via WebSocket status stream
      await _performReconnection();

      // Switch to fast retrying state to properly handle the result
      _startFreshRetryPhase();
      return true; // Always return true as we've triggered the attempt
    } catch (e) {
      // Error during manual retry - restart fresh retry cycle
      _startFreshRetryPhase();
      return false;
    }
  }

  /// Start fresh retry cycle from the beginning
  void _startFreshRetryPhase() {
    _resetRetryState();
    _setReconnectionState(ReconnectionState.fastRetrying);
    _startFastRetryPhase();
  }

  /// Start fast retry cycle with exponential backoff
  void _startFastRetryPhase() {
    if (_reconnectionState != ReconnectionState.fastRetrying) return;

    _fastRetryTimer?.cancel();

    _fastRetryCount++;

    if (_fastRetryCount > _config.maxFastRetries) {
      _switchToBackgroundMonitoring();
      return;
    }

    _attemptReconnectionWithBackoff();
  }

  /// Attempt reconnection with exponential backoff scheduling
  Future<void> _attemptReconnectionWithBackoff() async {
    try {
      // Trigger reconnection attempt - result will be handled via WebSocket status stream
      await _performReconnection();
      // Success/failure will be handled by _handleWebSocketStatusChange
    } catch (e) {
      // Connection attempt failed, continue with retry logic
    }

    // Safety check: Only schedule next retry if still in fastRetrying state
    if (_reconnectionState == ReconnectionState.fastRetrying) {
      final delay = _calculateBackoffDelay(_fastRetryCount);
      _fastRetryTimer = Timer(delay, () {
        // Double check state before retrying
        if (_reconnectionState == ReconnectionState.fastRetrying) {
          _startFastRetryPhase();
        }
      });
    }
  }

  /// Switch to background monitoring after fast retries are exhausted
  void _switchToBackgroundMonitoring() {
    _setReconnectionState(ReconnectionState.backgroundMonitoring);
    _startBackgroundMonitoring();
  }

  /// Start background monitoring with periodic checks
  void _startBackgroundMonitoring() {
    _backgroundMonitoringTimer?.cancel();
    _backgroundMonitoringTimer = Timer.periodic(
      _config.backgroundCheckInterval,
      (_) => _performBackgroundConnectivityCheck(),
    );
  }

  /// Perform background connectivity check
  Future<void> _performBackgroundConnectivityCheck() async {
    // Only check if we're still in background monitoring state
    if (_reconnectionState != ReconnectionState.backgroundMonitoring) {
      return;
    }

    // Attempt a lightweight connection check
    final isServerReachable = await _checkServerReachability();
    if (isServerReachable) {
      _startFreshRetryPhase();
    }
  }

  /// Check server reachability (lightweight ping)
  Future<bool> _checkServerReachability() async {
    try {
      // Trigger connection attempt - we'll get result via WebSocket status stream
      await _performReconnection();
      // Return true to indicate we successfully triggered the attempt
      // Actual result will be handled by _handleWebSocketStatusChange
      return true;
    } catch (e) {
      // Failed to even trigger connection attempt
      return false;
    }
  }

  /// Calculate exponential backoff delay
  Duration _calculateBackoffDelay(int attemptNumber) {
    final exponentialDelay =
        _config.initialDelay.inMilliseconds * pow(2, attemptNumber - 1).round();

    final clampedDelay = min(exponentialDelay, _config.maxDelay.inMilliseconds);
    return Duration(milliseconds: clampedDelay);
  }

  /// Reset retry state for fresh start
  void _resetRetryState() {
    _fastRetryCount = 0;
    _stopReconnectionTimers();
  }

  /// Stop all running timers
  void _stopReconnectionTimers() {
    _fastRetryTimer?.cancel();
    _backgroundMonitoringTimer?.cancel();
  }

  /// Update reconnection state and notify listeners
  void _setReconnectionState(ReconnectionState state) {
    if (_reconnectionState != state) {
      _reconnectionState = state;
      if (!_reconnectionStateController.isClosed) {
        _reconnectionStateController.add(state);
      }
    }
  }

  /// Dispose all resources
  void dispose() {
    _stopReconnectionTimers();
    _webSocketStatusSubscription?.cancel();
    _reconnectionStateController.close();
  }
}
