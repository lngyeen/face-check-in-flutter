part of 'check_in_bloc_v2.dart';

/// Events for CheckInBlocV2 (Orchestrator)
@freezed
class CheckInEventV2 with _$CheckInEventV2 {
  const factory CheckInEventV2.start() = CheckInStart;
  const factory CheckInEventV2.stop() = CheckInStop;
  const factory CheckInEventV2.toggleDebugMode() = CheckInToggleDebugMode;
  const factory CheckInEventV2.setMaxFps(int fps) = CheckInSetMaxFps;
  const factory CheckInEventV2.webSocketMessageReceived(dynamic data) =
      CheckInWebSocketMessageReceived;
  const factory CheckInEventV2.connectionStateChanged(
    ConnectionState connectionState,
  ) = CheckInConnectionStateChanged;
  const factory CheckInEventV2.cameraStateChanged(CameraStateV2 cameraState) =
      _CameraStateChanged;
  const factory CheckInEventV2.streamingStateChanged(
    StreamingStateV2 streamingState,
  ) = _StreamingStateChanged;
}
