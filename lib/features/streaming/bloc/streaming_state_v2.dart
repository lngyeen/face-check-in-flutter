part of 'streaming_bloc_v2.dart';

/// State for StreamingBlocV2
@freezed
class StreamingStateV2 with _$StreamingStateV2 {
  const factory StreamingStateV2({
    StreamingError? error,
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,
    @Default(ProcessingStatus.waitingForFace) ProcessingStatus processingStatus,
    LocalFaceDetectionResult? faceDetectionResult,
    LivenessResult? livenessResult,
    LivenessProgressViewModel? livenessProgress, // Thêm field mới
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

  // Getter cho liveness progress
  bool get hasLivenessProgress => livenessProgress != null;
}
