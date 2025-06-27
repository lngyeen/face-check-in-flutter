import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_error.freezed.dart';

/// Types of errors that can occur in the check-in feature
enum CheckInErrorType { camera, permission, backend }

/// Unified error model for all types of errors in the check-in feature
@freezed
class CheckInError with _$CheckInError {
  const factory CheckInError({
    required String message,
    String? details,
    required CheckInErrorType type,
  }) = _CheckInError;
}
