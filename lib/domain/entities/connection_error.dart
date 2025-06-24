import 'package:face_check_in_flutter/domain/entities/connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

/// Abstract base class for all connection-related errors
abstract class ConnectionError {
  final String message;
  final DateTime timestamp;
  final String context;

  const ConnectionError(this.message, this.context, this.timestamp);

  @override
  String toString() => '$runtimeType: $message (context: $context)';
}

/// Network-related errors (HTTP, connectivity)
class NetworkError extends ConnectionError {
  final String? host;
  final int? statusCode;

  NetworkError(String message, String context, {this.host, this.statusCode})
    : super(message, context, DateTime.now());
}

/// WebSocket connection errors
class WebSocketError extends ConnectionError {
  final WebSocketConnectionStatus? lastStatus;
  final Duration? connectionDuration;

  WebSocketError(
    String message,
    String context, {
    this.lastStatus,
    this.connectionDuration,
  }) : super(message, context, DateTime.now());
}

/// Streaming service errors
class StreamingError extends ConnectionError {
  final StreamingStatus? lastStatus;

  StreamingError(String message, String context, {this.lastStatus})
    : super(message, context, DateTime.now());
}

/// State transition validation errors
class StateTransitionError extends ConnectionError {
  final String fromStatus;
  final String toStatus;

  StateTransitionError(this.fromStatus, this.toStatus, String context)
    : super(
        'Invalid transition: $fromStatus → $toStatus',
        context,
        DateTime.now(),
      );
}

/// Timeout-related errors
class TimeoutError extends ConnectionError {
  final Duration timeoutDuration;
  final String operation;

  TimeoutError(
    String message,
    String context,
    this.operation,
    this.timeoutDuration,
  ) : super(message, context, DateTime.now());
}

/// Configuration or setup errors
class ConfigurationError extends ConnectionError {
  final String configKey;
  final dynamic configValue;

  ConfigurationError(
    String message,
    String context,
    this.configKey,
    this.configValue,
  ) : super(message, context, DateTime.now());
}
