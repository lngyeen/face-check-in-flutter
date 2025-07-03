part of 'streaming_bloc_v2.dart';

/// State for StreamingBlocV2
@freezed
class StreamingStateV2 with _$StreamingStateV2 {
  const factory StreamingStateV2({
    @Default(StreamingStatus.idle) StreamingStatus status,
    @Default(2) int maxFps,
    StreamingError? error,
  }) = _StreamingStateV2;

  const StreamingStateV2._();

  bool get isActive => status == StreamingStatus.active;
  bool get hasError => error != null;
  bool get isIdle => status == StreamingStatus.idle;
}
