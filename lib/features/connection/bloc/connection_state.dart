import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

part 'connection_state.freezed.dart';

@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState({
    @Default(AppConnectionStatus.initial) AppConnectionStatus status,
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,
  }) = _ConnectionState;

  const ConnectionState._();

  bool get hasConnection => status == AppConnectionStatus.connected;

  bool get isActiveStreaming =>
      hasConnection && streamingStatus == StreamingStatus.active;
}
