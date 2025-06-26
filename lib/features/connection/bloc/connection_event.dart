import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';

part 'connection_event.freezed.dart';

/// Events for ConnectionBloc - handles all connection-related triggers
@freezed
class ConnectionEvent with _$ConnectionEvent {
  /// App connection status changed (computed from WebSocketService)
  const factory ConnectionEvent.appConnectionStatusChanged({
    required AppConnectionStatus status,
  }) = AppConnectionStatusChanged;

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
