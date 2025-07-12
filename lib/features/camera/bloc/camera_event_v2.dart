part of 'camera_bloc_v2.dart';

/// Events for CameraBlocV2

abstract class CameraEventV2 {}

@freezed
class BucketSequentialCameraEventV2 extends CameraEventV2
    with _$BucketSequentialCameraEventV2 {
  const factory BucketSequentialCameraEventV2.startCamera() = StartCamera;
  const factory BucketSequentialCameraEventV2.stopCamera() = StopCamera;
}

@freezed
class ConcurrentCameraEventV2 extends CameraEventV2
    with _$ConcurrentCameraEventV2 {
  const factory ConcurrentCameraEventV2.statusChanged(CameraStatus status) =
      CameraStatusChanged;
  const factory ConcurrentCameraEventV2.controllerChanged(
    CameraController? controller,
  ) = CameraControllerChanged;
}
