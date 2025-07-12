part of 'check_in_bloc_v2.dart';

/// Events for CheckInBlocV2 (Orchestrator)
abstract class CheckInEventV2 {}

@freezed
class BucketSequentialFlowCheckInEventV2 extends CheckInEventV2
    with _$BucketSequentialFlowCheckInEventV2 {
  const factory BucketSequentialFlowCheckInEventV2.start() = _Start;
  const factory BucketSequentialFlowCheckInEventV2.stop() = _Stop;
}

@freezed
class BucketSequentialStateCheckInEventV2 extends CheckInEventV2
    with _$BucketSequentialStateCheckInEventV2 {
  const factory BucketSequentialStateCheckInEventV2.connectionStateChanged(
    ConnectionState connectionState,
  ) = _ConnectionStateChanged;
  const factory BucketSequentialStateCheckInEventV2.cameraStateChanged(
    CameraStateV2 cameraState,
  ) = _CameraStateChanged;
  // const factory BucketSequentialStateCheckInEventV2.streamingStateChanged(
  //   StreamingStateV2 streamingState,
  // ) = _StreamingStateChanged;
}

@freezed
class SeparatedRestartableCheckInEventV2 extends CheckInEventV2
    with _$SeparatedRestartableCheckInEventV2 {
  const factory SeparatedRestartableCheckInEventV2.webSocketMessageReceived(
    dynamic data,
  ) = _WebSocketMessageReceived;
}

@freezed
class ConcurrentCheckInEventV2 extends CheckInEventV2
    with _$ConcurrentCheckInEventV2 {
  const factory ConcurrentCheckInEventV2.toggleDebugMode() = _ToggleDebugMode;
  const factory ConcurrentCheckInEventV2.setMaxFps(int fps) = _SetMaxFps;
}
