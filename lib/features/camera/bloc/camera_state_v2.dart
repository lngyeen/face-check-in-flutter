part of 'camera_bloc_v2.dart';

/// State for CameraBlocV2
@freezed
class CameraStateV2 with _$CameraStateV2 {
  const factory CameraStateV2({
    CameraController? controller,
    @Default(CameraStatus.initial) CameraStatus status,
    CameraError? error,
  }) = _CameraStateV2;

  const CameraStateV2._();

  bool get isReady => status == CameraStatus.ready && controller != null;
  bool get hasError => error != null;
  bool get isInitializing => status == CameraStatus.initializing;
}
