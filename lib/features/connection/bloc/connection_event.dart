import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';

part 'connection_event.freezed.dart';

@freezed
class ConnectionEvent with _$ConnectionEvent {
  const factory ConnectionEvent.initialize() = Initialize;
  const factory ConnectionEvent.retryConnection() = RetryConnection;
  const factory ConnectionEvent.disconnect() = Disconnect;

  const factory ConnectionEvent.appConnectionStatusChanged({
    required AppConnectionStatus status,
  }) = AppConnectionStatusChanged;
}
