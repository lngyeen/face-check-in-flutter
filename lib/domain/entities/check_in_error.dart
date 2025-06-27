import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_error.freezed.dart';

enum CheckInErrorType { camera, permission, backend }

@freezed
class CheckInError with _$CheckInError {
  const factory CheckInError({
    required String message,
    String? details,
    required CheckInErrorType type,
  }) = _CheckInError;
}
