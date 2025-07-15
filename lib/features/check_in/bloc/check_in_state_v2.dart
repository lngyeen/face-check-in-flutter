part of 'check_in_bloc_v2.dart';

/// State for CheckInBlocV2 (Orchestrator)
@freezed
class CheckInStateV2 with _$CheckInStateV2 {
  const factory CheckInStateV2({
    @Default(false) bool isDebugMode,
    FaceDetectionData? latestFrameData,
    CheckInError? currentError,
  }) = _CheckInStateV2;

  const CheckInStateV2._();

  List<FaceDetectionResult> get detectedFaces => latestFrameData?.faces ?? [];
  String? get annotatedImage => latestFrameData?.annotatedImage;
  bool get hasError => currentError != null;
}
