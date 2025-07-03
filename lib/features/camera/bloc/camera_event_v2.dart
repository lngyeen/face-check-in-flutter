part of 'camera_bloc_v2.dart';

/// Events for CameraBlocV2
@freezed
class CameraEventV2 with _$CameraEventV2 {
  const factory CameraEventV2.startCamera() = StartCamera;
  const factory CameraEventV2.stopCamera() = StopCamera;
  const factory CameraEventV2.statusChanged(CameraStatus status) =
      CameraStatusChanged;
  const factory CameraEventV2.controllerChanged(CameraController? controller) =
      CameraControllerChanged;
}
