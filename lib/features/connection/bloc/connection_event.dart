import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';

part 'connection_event.freezed.dart';

@freezed
class ConnectionEvent with _$ConnectionEvent {
  const factory ConnectionEvent.appConnectionStatusChanged({
    required AppConnectionStatus status,
  }) = AppConnectionStatusChanged;

  const factory ConnectionEvent.initialize() = Initialize;

  const factory ConnectionEvent.retryConnection() = RetryConnection;

  const factory ConnectionEvent.startStreaming() = StartStreaming;

  const factory ConnectionEvent.stopStreaming() = StopStreaming;

  const factory ConnectionEvent.configureStream({required int maxFps}) =
      ConfigureStream;

  const factory ConnectionEvent.disconnect() = Disconnect;
}
