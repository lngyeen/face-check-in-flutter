import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/image_streaming_service.dart';

part 'streaming_state.freezed.dart';

/// Domain entity representing image streaming state
///
/// Manages the state of image streaming pipeline including frame processing,
/// FPS control, and streaming status.
@freezed
class StreamingState with _$StreamingState {
  const factory StreamingState({
    @Default(StreamingStatus.idle) StreamingStatus status,
    @Default(2) int maxFps,
    @Default(0) int processedFrameCount,
    @Default(0) int droppedFrameCount,
    ProcessedFrame? lastProcessedFrame,
    String? errorMessage,
    DateTime? lastFrameTime,
  }) = _StreamingState;

  const StreamingState._();

  /// Business logic: Check if streaming is active
  bool get isStreaming => status == StreamingStatus.active;

  /// Business logic: Check if streaming has error
  bool get hasError => status == StreamingStatus.error || errorMessage != null;

  /// Business logic: Check if streaming is idle
  bool get isIdle => status == StreamingStatus.idle;

  /// Business logic: Calculate actual FPS from frame processing
  double get actualFps {
    if (lastFrameTime == null || processedFrameCount == 0) {
      return 0.0;
    }

    final now = DateTime.now();
    final durationMs = now.difference(lastFrameTime!).inMilliseconds;

    if (durationMs <= 0) return 0.0;

    return (processedFrameCount * 1000.0) / durationMs;
  }

  /// Business logic: Calculate frame drop ratio
  double get frameDropRatio {
    final totalFrames = processedFrameCount + droppedFrameCount;
    if (totalFrames == 0) return 0.0;

    return droppedFrameCount / totalFrames;
  }

  /// Business logic: Check if performance is good (low drop ratio)
  bool get hasGoodPerformance => frameDropRatio < 0.1; // Less than 10% drops

  /// Business logic: Get display message for current state
  String get displayMessage {
    switch (status) {
      case StreamingStatus.idle:
        return 'Streaming idle';
      case StreamingStatus.active:
        return 'Streaming active (${actualFps.toStringAsFixed(1)} FPS)';
      case StreamingStatus.error:
        return errorMessage ?? 'Streaming error occurred';
    }
  }

  /// Business logic: Get performance summary
  String get performanceSummary {
    if (!isStreaming) return 'Not streaming';

    return 'FPS: $actualFps/${maxFps}, '
        'Frames: $processedFrameCount, '
        'Drops: $droppedFrameCount (${(frameDropRatio * 100).toStringAsFixed(1)}%)';
  }

  /// Create a copy with new processed frame
  StreamingState withNewFrame(ProcessedFrame frame) {
    return copyWith(
      lastProcessedFrame: frame,
      processedFrameCount: processedFrameCount + 1,
      lastFrameTime: DateTime.now(),
      errorMessage: null, // Clear any previous errors
    );
  }

  /// Create a copy with dropped frame count incremented
  StreamingState withDroppedFrame() {
    return copyWith(
      droppedFrameCount: droppedFrameCount + 1,
    );
  }

  /// Create a copy with error information
  StreamingState withError(String message) {
    return copyWith(
      status: StreamingStatus.error,
      errorMessage: message,
    );
  }

  /// Create a copy clearing error information
  StreamingState clearError() {
    return copyWith(
      errorMessage: null,
    );
  }

  /// Reset frame counters
  StreamingState resetCounters() {
    return copyWith(
      processedFrameCount: 0,
      droppedFrameCount: 0,
      lastFrameTime: null,
    );
  }
}
