import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/connection_error.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

part 'connection_state.freezed.dart';

/// Main connection state
@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState({
    /// Overall app connection status (inferred from WebSocketService)
    @Default(AppConnectionStatus.initial) AppConnectionStatus status,

    /// Current frame streaming status for UI
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,

    /// Last connection error (if any)
    ConnectionError? lastError,
  }) = _ConnectionState;

  const ConnectionState._();

  /// Whether the connection is fully operational for streaming
  bool get isConnectionReady => status == AppConnectionStatus.connected;

  /// Whether streaming should be allowed
  bool get isActiveStreaming =>
      isConnectionReady && streamingStatus == StreamingStatus.active;
}
