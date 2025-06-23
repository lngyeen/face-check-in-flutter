import 'dart:async';
import 'dart:math';

import 'package:injectable/injectable.dart';

/// States for the reconnection process
enum ReconnectionState {
  /// Connected and stable
  connected,

  /// Attempting fast reconnection (immediate response to network loss)
  fastRetrying,

  /// Monitoring in background after fast retries failed
  backgroundMonitoring,

  /// Manual retry is available (optional state)
  manualRetryAvailable,

  /// Permanently failed (shouldn't happen with our persistent strategy)
  failed,
}

/// Configuration for reconnection behavior
class ReconnectionConfig {
  /// Maximum number of fast retry attempts
  final int maxFastRetries;

  /// Initial delay for first retry
  final Duration initialDelay;

  /// Maximum delay between retries
  final Duration maxDelay;

  /// Background monitoring check interval
  final Duration backgroundCheckInterval;

  const ReconnectionConfig({
    this.maxFastRetries = 5,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
    this.backgroundCheckInterval = const Duration(seconds: 30),
  });
}

/// Manager for intelligent reconnection with two-phase approach
@singleton
class ReconnectionManager {
  final ReconnectionConfig _config = const ReconnectionConfig();

  StreamController<ReconnectionState>? _stateController;

  Timer? _backgroundMonitoringTimer;
  Timer? _fastRetryTimer;

  int _fastRetryCount = 0;
  bool _isInitialized = false;
  ReconnectionState _currentState = ReconnectionState.connected;

  /// Initialize the manager
  void initialize() {
    if (_isInitialized) return;

    _stateController = StreamController<ReconnectionState>.broadcast();
    _isInitialized = true;
  }

  /// Stream of reconnection state changes
  Stream<ReconnectionState> get stateStream {
    if (!_isInitialized) {
      throw StateError('ReconnectionManager not initialized');
    }
    return _stateController!.stream;
  }

  /// Current reconnection state
  ReconnectionState get currentState => _currentState;

  /// Current retry attempt number (for UI display)
  int get currentRetryAttempt => _fastRetryCount;

  /// Maximum fast retry attempts (for UI display)
  int get maxRetryAttempts => _config.maxFastRetries;

  /// Handle network connectivity loss
  void handleNetworkLost() {
    _resetRetryState();
    _setState(ReconnectionState.fastRetrying);
  }

  /// Handle connection failure (server down, timeout, etc.)
  void handleConnectionFailure() {
    if (_currentState == ReconnectionState.connected) {
      _resetRetryState();
      _setState(ReconnectionState.fastRetrying);
    }
  }

  /// Handle successful connection
  void handleConnectionSuccess() {
    _stopAllTimers();
    _resetRetryState();
    _setState(ReconnectionState.connected);
  }

  /// Stop all reconnection attempts
  void stopReconnection() {
    _stopAllTimers();
    _setState(ReconnectionState.connected); // Reset to neutral state
  }

  /// Handle network connectivity restored
  Future<void> handleNetworkRestored() async {
    // Wait for network to stabilize
    await Future.delayed(const Duration(milliseconds: 100));

    // Reset and start fresh retry cycle
    _resetRetryState();
    _setState(ReconnectionState.fastRetrying);
  }

  /// Handle manual retry request from user
  /// Returns true if retry was initiated, false if conditions not met
  Future<bool> requestManualRetry(
    Future<bool> Function() reconnectFunction,
  ) async {
    // Only allow manual retry in background monitoring state
    if (_currentState != ReconnectionState.backgroundMonitoring) {
      return false;
    }

    // Set to manual retry available state briefly
    _setState(ReconnectionState.manualRetryAvailable);

    try {
      // Attempt reconnection
      final success = await reconnectFunction();

      if (success) {
        // Success - handle as normal connection success
        handleConnectionSuccess();
        return true;
      } else {
        // Failed - restart fresh retry cycle
        _resetRetryState();
        _setState(ReconnectionState.fastRetrying);
        return false;
      }
    } catch (e) {
      // Error during manual retry - restart fresh retry cycle
      _resetRetryState();
      _setState(ReconnectionState.fastRetrying);
      return false;
    }
  }

  /// Start fast retry cycle with exponential backoff
  Future<void> startFastRetryPhase(
    Future<bool> Function() reconnectFunction,
  ) async {
    if (_currentState != ReconnectionState.fastRetrying) return;

    _fastRetryCount++;

    if (_fastRetryCount > _config.maxFastRetries) {
      _switchToBackgroundMonitoring();
      return;
    }

    try {
      final success = await reconnectFunction();
      if (success) {
        _handleReconnectionSuccess();
        return;
      }
    } catch (e) {
      // Connection attempt failed, continue with retry logic
    }

    // Schedule next retry with exponential backoff
    final delay = _calculateBackoffDelay(_fastRetryCount);
    _fastRetryTimer = Timer(delay, () {
      startFastRetryPhase(reconnectFunction);
    });
  }

  /// Switch to background monitoring after fast retries are exhausted
  void _switchToBackgroundMonitoring() {
    _setState(ReconnectionState.backgroundMonitoring);

    // Optional: Start periodic background checks
    _startBackgroundMonitoring();
  }

  /// Start background monitoring with periodic checks
  void _startBackgroundMonitoring() {
    _backgroundMonitoringTimer?.cancel();
    _backgroundMonitoringTimer = Timer.periodic(
      _config.backgroundCheckInterval,
      (_) {}, // Silent monitoring
    );
  }

  /// Handle successful reconnection
  void _handleReconnectionSuccess() {
    _stopAllTimers();
    _resetRetryState();
    _setState(ReconnectionState.connected);
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
    _stopAllTimers();
  }

  /// Stop all running timers
  void _stopAllTimers() {
    _fastRetryTimer?.cancel();
    _backgroundMonitoringTimer?.cancel();
  }

  /// Update state and notify listeners
  void _setState(ReconnectionState state) {
    if (_currentState != state) {
      _currentState = state;
      _stateController?.add(state);
    }
  }

  /// Dispose the manager
  void dispose() {
    _stopAllTimers();
    _stateController?.close();
    _isInitialized = false;
  }
}
