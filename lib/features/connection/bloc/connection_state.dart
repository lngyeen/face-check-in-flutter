import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/connection_error.dart';
import 'package:face_check_in_flutter/domain/entities/connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

part 'connection_state.freezed.dart';

// TODO: Try to infer the connection status from the WebSocket service
// and network connectivity service instead of manually setting it
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

    /// Last connection error (if any)
    ConnectionError? lastError,
  }) = _ConnectionState;

  const ConnectionState._();

  /// Whether the connection is fully operational for streaming
  bool get isConnectionReady =>
      webSocketStatus == WebSocketConnectionStatus.connected;

  /// Whether streaming should be allowed
  bool get canStream =>
      isConnectionReady && streamingStatus == StreamingStatus.active;
}
