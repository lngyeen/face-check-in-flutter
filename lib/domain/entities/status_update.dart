import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_update.freezed.dart';

/// Defines the type of status update for styling purposes (color, icon).
enum StatusType { info, success, warning, error }

/// Represents a transient status update, suitable for an overlay text widget.
/// This is separate from AppNotification to provide better type safety and separation of concerns.
@freezed
class StatusUpdate with _$StatusUpdate {
  const factory StatusUpdate({
    required String message,
    required StatusType type,
    Duration? duration,
    bool? dismissible,
  }) = _StatusUpdate;

  const StatusUpdate._();
}
