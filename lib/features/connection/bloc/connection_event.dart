import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/connection_status.dart';

part 'connection_event.freezed.dart';

/// Events for ConnectionBloc - handles all connection-related triggers
@freezed
class ConnectionEvent with _$ConnectionEvent {
  /// Network connectivity changed
  const factory ConnectionEvent.networkStatusChanged({
    required bool isConnected,
  }) = NetworkStatusChanged;

  /// WebSocket connection status changed
  const factory ConnectionEvent.webSocketStatusChanged({
    required WebSocketConnectionStatus status,
  }) = WebSocketStatusChanged;

  /// User requested connection attempt
  const factory ConnectionEvent.connectionRequested() = ConnectionRequested;

  /// User requested manual retry (from background monitoring state)
  const factory ConnectionEvent.manualRetryRequested() = ManualRetryRequested;

  /// Fast retry timer expired - attempt next retry
  const factory ConnectionEvent.fastRetryTimerExpired() = FastRetryTimerExpired;

  /// Background check timer expired - check server reachability
  const factory ConnectionEvent.backgroundCheckTimerExpired() =
      BackgroundCheckTimerExpired;

  /// Initialize connection system
  const factory ConnectionEvent.initialize() = Initialize;

  // Streaming control events
  /// Request to start frame streaming
  const factory ConnectionEvent.startStreaming() = StartStreaming;

  /// Request to stop frame streaming
  const factory ConnectionEvent.stopStreaming() = StopStreaming;

  /// Streaming configuration
  const factory ConnectionEvent.configureStream({required int maxFps}) =
      ConfigureStream;
}
