part of 'check_in_bloc_v2.dart';

/// Status enum for CheckInBlocV2
enum CheckInStatusV2 { idle, initializing, ready, processing, error }

/// State for CheckInBlocV2 (Orchestrator)
@freezed
class CheckInStateV2 with _$CheckInStateV2 {
  const factory CheckInStateV2({
    @Default(CheckInStatusV2.idle) CheckInStatusV2 status,
    @Default(false) bool isDebugMode,
    @Default(ConnectionState(status: AppConnectionStatus.initial))
    ConnectionState connectionState,
    FaceDetectionData? latestFrameData,
    CheckInError? currentError,
    // Hybrid processing fields
    // stream_service.ProcessingStatus? processingStatus,
    // face_service.FaceDetectionResult? faceDetectionResult,
    // liveness_service.LivenessResult? livenessResult,
  }) = _CheckInStateV2;

  const CheckInStateV2._();

  List<FaceDetectionResult> get detectedFaces => latestFrameData?.faces ?? [];
  String? get annotatedImage => latestFrameData?.annotatedImage;
  bool get hasError => currentError != null;
  bool get isProcessing => status == CheckInStatusV2.processing;

  // Hybrid processing getters
  // bool get isFaceDetected =>
  //     processingStatus == stream_service.ProcessingStatus.faceDetected;
  // bool get isLivenessChecking =>
  //     processingStatus == stream_service.ProcessingStatus.livenessChecking;
  // bool get hasNoValidFace =>
  //     processingStatus == stream_service.ProcessingStatus.waitingForFace;
  // bool get hasProcessingError =>
  //     processingStatus == stream_service.ProcessingStatus.error;
}
