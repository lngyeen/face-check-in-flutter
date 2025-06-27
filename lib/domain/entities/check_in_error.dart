import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_error.freezed.dart';

@freezed
class CheckInError with _$CheckInError {
  const factory CheckInError.camera({required String message}) = _CameraError;

  const factory CheckInError.permission({required String message}) =
      _PermissionError;

  const factory CheckInError.backend({
    required String message,
    String? details,
  }) = _BackendError;
}
