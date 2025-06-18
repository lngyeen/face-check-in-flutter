import 'package:flutter/foundation.dart';

/// WebSocket configuration class for Story 2.1
/// Manages connection settings, retry logic, and environment-specific URLs
@immutable
class WebSocketConfig {
  const WebSocketConfig({
    required this.url,
    this.timeout = const Duration(seconds: 30),
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 3),
    this.enableLogging = true,
    this.enableHeartbeat = false,
    this.heartbeatInterval = const Duration(seconds: 30),
    this.enableAutoReconnect = true,
    this.enableExponentialBackoff = true,
  });

  /// WebSocket server URL
  final String url;

  /// Connection timeout duration (Story 2.1 spec: 30 seconds)
  final Duration timeout;

  /// Maximum number of retry attempts (Story 2.1 spec: 3 attempts)
  final int maxRetries;

  /// Base delay between retry attempts (Story 2.1 spec: 3 seconds)
  final Duration retryDelay;

  /// Whether to enable debug logging
  final bool enableLogging;

  /// Whether to enable heartbeat/ping messages
  final bool enableHeartbeat;

  /// Interval for heartbeat messages
  final Duration heartbeatInterval;

  /// Whether to enable automatic reconnection
  final bool enableAutoReconnect;

  /// Whether to use exponential backoff for retries
  final bool enableExponentialBackoff;

  // Environment-specific configurations

  /// Development environment configuration
  /// Story 2.1 spec: ws://192.168.1.234:3009
  static const WebSocketConfig development = WebSocketConfig(
    url: 'ws://192.168.1.234:3009',
    timeout: Duration(seconds: 30),
    maxRetries: 3,
    retryDelay: Duration(seconds: 3),
    enableLogging: true,
    enableHeartbeat: true,
    enableAutoReconnect: true,
    enableExponentialBackoff: true,
  );

  /// Staging environment configuration
  static const WebSocketConfig staging = WebSocketConfig(
    url: 'ws://staging.facecheck.com:3009',
    timeout: Duration(seconds: 30),
    maxRetries: 3,
    retryDelay: Duration(seconds: 3),
    enableLogging: true,
    enableHeartbeat: true,
    enableAutoReconnect: true,
    enableExponentialBackoff: true,
  );

  /// Production environment configuration
  static const WebSocketConfig production = WebSocketConfig(
    url: 'wss://api.facecheck.com:3009',
    timeout: Duration(seconds: 30),
    maxRetries: 5, // More retries in production
    retryDelay: Duration(seconds: 5), // Longer delay in production
    enableLogging: false, // Disable debug logging in production
    enableHeartbeat: true,
    enableAutoReconnect: true,
    enableExponentialBackoff: true,
  );

  /// Get configuration for current environment
  static WebSocketConfig get current {
    if (kDebugMode) {
      return development;
    } else if (kReleaseMode) {
      return production;
    } else {
      return staging; // Profile mode
    }
  }

  /// Calculate retry delay with exponential backoff
  Duration getRetryDelay(int attemptNumber) {
    if (!enableExponentialBackoff) {
      return retryDelay;
    }

    // Exponential backoff: base * 2^(attempt-1)
    final multiplier = 1 << (attemptNumber - 1); // 2^(attempt-1)
    final delayMs = retryDelay.inMilliseconds * multiplier;

    // Cap at 30 seconds to prevent extremely long delays
    const maxDelayMs = 30000;
    final cappedDelayMs = delayMs > maxDelayMs ? maxDelayMs : delayMs;

    return Duration(milliseconds: cappedDelayMs);
  }

  /// Create a copy with modified parameters
  WebSocketConfig copyWith({
    String? url,
    Duration? timeout,
    int? maxRetries,
    Duration? retryDelay,
    bool? enableLogging,
    bool? enableHeartbeat,
    Duration? heartbeatInterval,
    bool? enableAutoReconnect,
    bool? enableExponentialBackoff,
  }) {
    return WebSocketConfig(
      url: url ?? this.url,
      timeout: timeout ?? this.timeout,
      maxRetries: maxRetries ?? this.maxRetries,
      retryDelay: retryDelay ?? this.retryDelay,
      enableLogging: enableLogging ?? this.enableLogging,
      enableHeartbeat: enableHeartbeat ?? this.enableHeartbeat,
      heartbeatInterval: heartbeatInterval ?? this.heartbeatInterval,
      enableAutoReconnect: enableAutoReconnect ?? this.enableAutoReconnect,
      enableExponentialBackoff:
          enableExponentialBackoff ?? this.enableExponentialBackoff,
    );
  }

  /// Convert to map for debugging/serialization
  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'timeout': timeout.inMilliseconds,
      'maxRetries': maxRetries,
      'retryDelay': retryDelay.inMilliseconds,
      'enableLogging': enableLogging,
      'enableHeartbeat': enableHeartbeat,
      'heartbeatInterval': heartbeatInterval.inMilliseconds,
      'enableAutoReconnect': enableAutoReconnect,
      'enableExponentialBackoff': enableExponentialBackoff,
    };
  }

  @override
  String toString() {
    return 'WebSocketConfig(url: $url, timeout: ${timeout.inSeconds}s, maxRetries: $maxRetries)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WebSocketConfig &&
        other.url == url &&
        other.timeout == timeout &&
        other.maxRetries == maxRetries &&
        other.retryDelay == retryDelay &&
        other.enableLogging == enableLogging &&
        other.enableHeartbeat == enableHeartbeat &&
        other.heartbeatInterval == heartbeatInterval &&
        other.enableAutoReconnect == enableAutoReconnect &&
        other.enableExponentialBackoff == enableExponentialBackoff;
  }

  @override
  int get hashCode {
    return Object.hash(
      url,
      timeout,
      maxRetries,
      retryDelay,
      enableLogging,
      enableHeartbeat,
      heartbeatInterval,
      enableAutoReconnect,
      enableExponentialBackoff,
    );
  }
}
