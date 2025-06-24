import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/connection_error.dart';
import 'package:face_check_in_flutter/domain/entities/connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

part 'connection_state.freezed.dart';

/// Overall connection status for UI
enum AppConnectionStatus {
  /// Initial state - not connected yet
  initial,

  /// Attempting to connect
  connecting,

  /// Successfully connected and operational
  connected,

  /// Network connectivity lost
  networkLost,

  /// Fast retry in progress
  fastRetrying,

  /// Background monitoring - user can tap to retry
  backgroundRetrying,

  /// Connection failed permanently
  failed,

  /// Disposed/cleaned up
  disposed,
}

/// Retry state management
@freezed
class RetryState with _$RetryState {
  /// Not retrying - idle state
  const factory RetryState.idle() = _IdleRetryState;

  /// Fast retry phase with exponential backoff
  const factory RetryState.fastRetrying({
    required int currentAttempt,
    required int maxAttempts,
    required Duration nextRetryIn,
    required DateTime nextRetryAt,
  }) = _FastRetryingState;

  /// Background monitoring phase - periodic checks
  const factory RetryState.backgroundMonitoring({
    required DateTime lastAttemptAt,
    required Duration checkInterval,
    required DateTime nextCheckAt,
  }) = _BackgroundMonitoringState;
}

/// Main connection state
@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState({
    /// Overall app connection status
    @Default(AppConnectionStatus.initial) AppConnectionStatus status,

    /// Network connectivity status
    @Default(false) bool isNetworkConnected,

    /// WebSocket connection status
    @Default(WebSocketConnectionStatus.disconnected)
    WebSocketConnectionStatus webSocketStatus,

    /// Current frame streaming status for UI
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,

    /// Current retry state and info
    @Default(RetryState.idle()) RetryState retryState,

    /// Last connection error (if any)
    ConnectionError? lastError,
  }) = _ConnectionState;

  const ConnectionState._();

  /// Whether the connection is fully operational for streaming
  bool get isConnectionReady =>
      status == AppConnectionStatus.connected &&
      isNetworkConnected &&
      webSocketStatus == WebSocketConnectionStatus.connected;

  /// Whether streaming should be allowed
  bool get canStream =>
      isConnectionReady && streamingStatus == StreamingStatus.active;

  /// Whether manual retry is available
  bool get canManualRetry => retryState.maybeWhen(
    backgroundMonitoring: (_, __, ___) => true,
    orElse: () => false,
  );

  /// Current retry attempt info for UI display
  String get retryDisplayText => retryState.when(
    idle: () => '',
    fastRetrying:
        (attempt, maxAttempts, nextRetryIn, _) =>
            'Retrying $attempt/$maxAttempts... Next retry in ${nextRetryIn.inSeconds}s',
    backgroundMonitoring: (_, __, ___) => 'Connection lost. Tap to retry.',
  );

  /// Status message for UI
  String get statusMessage {
    switch (status) {
      case AppConnectionStatus.initial:
        return 'Initializing...';
      case AppConnectionStatus.connecting:
        return 'Connecting...';
      case AppConnectionStatus.connected:
        return 'Connected';
      case AppConnectionStatus.networkLost:
        return 'No internet connection';
      case AppConnectionStatus.fastRetrying:
        return retryDisplayText;
      case AppConnectionStatus.backgroundRetrying:
        return retryDisplayText;
      case AppConnectionStatus.failed:
        return 'Connection failed';
      case AppConnectionStatus.disposed:
        return 'Disconnected';
    }
  }
}
