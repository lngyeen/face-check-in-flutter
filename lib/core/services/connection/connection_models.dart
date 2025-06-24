/// States for the reconnection process
enum ReconnectionState {
  /// Connected and stable
  connected,

  /// Attempting fast reconnection (immediate response to network loss)
  fastRetrying,

  /// Monitoring in background after fast retries failed
  backgroundMonitoring,

  /// Permanently failed (shouldn't happen with our persistent strategy)
  failed,
}

/// Detailed reconnection information when in reconnecting state
class ReconnectionDetails {
  final ReconnectionState state;
  final int currentAttempt;
  final int maxAttempts;
  final Duration? nextRetryDelay;

  const ReconnectionDetails({
    required this.state,
    required this.currentAttempt,
    required this.maxAttempts,
    this.nextRetryDelay,
  });

  /// Get user-friendly reconnection message
  String get message {
    switch (state) {
      case ReconnectionState.connected:
        return 'Connected';
      case ReconnectionState.fastRetrying:
        return 'Reconnecting... (attempt $currentAttempt/$maxAttempts)';
      case ReconnectionState.backgroundMonitoring:
        return 'Connection lost. Tap to retry.';
      case ReconnectionState.failed:
        return 'Connection failed';
    }
  }

  /// Whether manual retry is available
  bool get canManualRetry => state == ReconnectionState.backgroundMonitoring;
}

/// Comprehensive connection status for UI banner system
enum ConnectionState {
  initializing, // App starting up
  connecting, // Attempting connection
  operational, // Ready for streaming
  disconnected, // User disconnected
  networkLost, // No network available
  failed, // Connection failed
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
