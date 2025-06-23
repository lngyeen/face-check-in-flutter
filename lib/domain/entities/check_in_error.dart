import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_error.freezed.dart';

/// Types of errors that can occur in the check-in feature
enum CheckInErrorType {
  general,
  camera,
  connection,
  permission,
  streaming,
  backend,
}

@freezed
class BackendError with _$BackendError {
  const factory BackendError({required String error, String? message}) =
      _BackendError;
}

/// Unified error model for all types of errors in the check-in feature
@freezed
class CheckInError with _$CheckInError {
  const factory CheckInError({
    required String message,
    String? details,
    @Default(CheckInErrorType.general) CheckInErrorType type,
  }) = _CheckInError;
}
