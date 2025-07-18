part of 'streaming_bloc_v2.dart';

/// Events for StreamingBlocV2

abstract class StreamingEventV2 {}

@freezed
class BucketSequentialStreamingEventV2 extends StreamingEventV2
    with _$BucketSequentialStreamingEventV2 {
  const factory BucketSequentialStreamingEventV2.startStreaming(
    CameraController controller,
  ) = _StartStreaming;
  const factory BucketSequentialStreamingEventV2.stopStreaming() =
      _StopStreaming;
}

@freezed
class BucketSequentialStreamingStatusEventV2 extends StreamingEventV2
    with _$BucketSequentialStreamingStatusEventV2 {
  const factory BucketSequentialStreamingStatusEventV2.streamingStatusChanged(
    StreamingStatus status,
  ) = _StreamingStatusChanged;
  const factory BucketSequentialStreamingStatusEventV2.processingStatusChanged(
    ProcessingStatus status,
  ) = _ProcessingStatusChanged;
}

@freezed
class SeparatedRestartableStreamingEventV2 extends StreamingEventV2
    with _$SeparatedRestartableStreamingEventV2 {
  const factory SeparatedRestartableStreamingEventV2.processingResultReceived(
    HybridProcessingResult result,
  ) = _ProcessingResultReceived;
  const factory SeparatedRestartableStreamingEventV2.livenessProgressUpdated(
    LivenessProgressViewModel progress,
  ) = _LivenessProgressUpdated;
}
