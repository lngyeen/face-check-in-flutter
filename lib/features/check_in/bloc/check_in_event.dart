import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';

part 'check_in_event.freezed.dart';

@freezed
class CheckInEvent with _$CheckInEvent {
  const factory CheckInEvent.initialize() = Initialize;

  const factory CheckInEvent.startCamera() = StartCamera;

  const factory CheckInEvent.stopCamera() = StopCamera;

  const factory CheckInEvent.webSocketMessageReceived(dynamic data) =
      WebSocketMessageReceived;

  const factory CheckInEvent.toggleDebugMode() = ToggleDebugMode;

  const factory CheckInEvent.connectionStateChanged(
    ConnectionState connectionState,
  ) = ConnectionStateChanged;
}
