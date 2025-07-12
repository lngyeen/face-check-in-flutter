part of 'streaming_bloc_v2.dart';

/// State for StreamingBlocV2
@freezed
class StreamingStateV2 with _$StreamingStateV2 {
  const factory StreamingStateV2({
    @Default(2) int maxFps,
    StreamingError? error,
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,
    @Default(ProcessingStatus.waitingForFace) ProcessingStatus processingStatus,
    FaceDetectionResult? faceDetectionResult,
    LivenessResult? livenessResult,
  }) = _StreamingStateV2;

  const StreamingStateV2._();

  bool get hasError => error != null;

  // Hybrid processing getters
  bool get isReadyForCheckIn =>
      processingStatus == ProcessingStatus.readyForCheckIn;
  bool get isLivenessChecking =>
      processingStatus == ProcessingStatus.livenessChecking;
  bool get hasNoValidFace =>
      processingStatus == ProcessingStatus.waitingForFace;
  bool get hasProcessingError => processingStatus == ProcessingStatus.error;
}
