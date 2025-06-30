import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

part 'connection_state.freezed.dart';

@freezed
class ConnectionState with _$ConnectionState {
  const ConnectionState._();

  const factory ConnectionState({required AppConnectionStatus status}) =
      _ConnectionState;

  bool get hasConnection => status == AppConnectionStatus.connected;
}
