part of 'streaming_bloc_v2.dart';

/// Events for StreamingBlocV2
@freezed
class StreamingEventV2 with _$StreamingEventV2 {
  const factory StreamingEventV2.startStreaming(CameraController controller) =
      _StartStreaming;
  const factory StreamingEventV2.stopStreaming() = _StopStreaming;
  const factory StreamingEventV2.setMaxFps(int fps) = _SetMaxFps;

  // Internal events for state updates from service
  const factory StreamingEventV2.statusChanged(StreamingStatus status) =
      _StatusChanged;
}
