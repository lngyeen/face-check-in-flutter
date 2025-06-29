import 'package:freezed_annotation/freezed_annotation.dart';

part 'retry_state.freezed.dart';

@freezed
class RetryState with _$RetryState {
  /// Not retrying - idle state
  const factory RetryState.idle() = _IdleRetryState;

  /// Fast retry phase with exponential backoff
  const factory RetryState.fastRetrying({
    required int currentAttempt,
    required int maxAttempts,
  }) = _FastRetryingState;

  /// Background monitoring phase - periodic checks
  const factory RetryState.backgroundMonitoring() = _BackgroundMonitoringState;
}
