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

/// Streaming service errors
class StreamingError extends ConnectionError {
  final StreamingStatus? lastStatus;

  StreamingError(String message, String context, {this.lastStatus})
    : super(message, context, DateTime.now());
}
