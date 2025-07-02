import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_event.freezed.dart';

@freezed
class CameraEvent with _$CameraEvent {
  const factory CameraEvent.initialize() = Initialize;
  const factory CameraEvent.start() = Start;
  const factory CameraEvent.stop() = Stop;
  const factory CameraEvent.permissionRequested() = PermissionRequested;
  const factory CameraEvent.statusChanged(dynamic newStatus) = StatusChanged;
}
