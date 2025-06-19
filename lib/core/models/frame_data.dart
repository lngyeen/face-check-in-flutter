import 'package:freezed_annotation/freezed_annotation.dart';

part 'frame_data.freezed.dart';

/// Immutable data class representing a captured camera frame
@freezed
class FrameData with _$FrameData {
  const factory FrameData({
    /// Unique identifier for this frame
    required String id,

    /// Base64 encoded frame data
    required String base64Data,

    /// Timestamp when the frame was captured
    required DateTime timestamp,

    /// Width of the frame in pixels
    required int width,

    /// Height of the frame in pixels
    required int height,

    /// Original format of the frame (e.g., 'yuv420', 'nv21')
    required String format,

    /// Size of the original frame data in bytes
    required int originalSize,

    /// Size of the base64 encoded data in bytes
    required int encodedSize,

    /// Processing time in milliseconds for this frame
    int? processingTimeMs,

    /// Quality score (0.0 to 1.0) if applicable
    double? quality,
  }) = _FrameData;

  const FrameData._();

  /// Calculates the compression ratio (encoded size / original size)
  double get compressionRatio => encodedSize / originalSize;

  /// Returns true if this frame was processed within the target time (33ms for 30 FPS)
  bool get isWithinTargetTime =>
      processingTimeMs != null && processingTimeMs! <= 33;

  /// Returns the aspect ratio of the frame
  double get aspectRatio => width / height;

  /// Returns a human-readable size string
  String get sizeString => '${width}x$height';

  /// Returns the age of this frame in milliseconds
  int get ageMs => DateTime.now().difference(timestamp).inMilliseconds;
}

/// Metrics for frame capture performance
@freezed
class FrameCaptureMetrics with _$FrameCaptureMetrics {
  const factory FrameCaptureMetrics({
    /// Total number of frames captured
    @Default(0) int totalFrames,

    /// Number of frames successfully processed
    @Default(0) int successfulFrames,

    /// Number of frames that failed processing
    @Default(0) int failedFrames,

    /// Current frames per second
    @Default(0.0) double currentFps,

    /// Average frames per second over time
    @Default(0.0) double averageFps,

    /// Average processing time per frame in milliseconds
    @Default(0.0) double averageProcessingTimeMs,

    /// Maximum processing time recorded in milliseconds
    @Default(0.0) double maxProcessingTimeMs,

    /// Total data processed in bytes
    @Default(0) int totalBytesProcessed,

    /// Current memory usage in bytes
    @Default(0) int currentMemoryUsage,

    /// Peak memory usage in bytes
    @Default(0) int peakMemoryUsage,

    /// Timestamp of last frame capture
    DateTime? lastFrameTimestamp,

    /// Start time of capture session
    DateTime? sessionStartTime,
  }) = _FrameCaptureMetrics;

  const FrameCaptureMetrics._();

  /// Calculate success rate as a percentage
  double get successRate =>
      totalFrames > 0 ? (successfulFrames / totalFrames) * 100 : 0.0;

  /// Calculate failure rate as a percentage
  double get failureRate =>
      totalFrames > 0 ? (failedFrames / totalFrames) * 100 : 0.0;

  /// Check if current FPS meets the target (30 FPS)
  bool get meetsTargetFps => currentFps >= 29.0; // Allow slight tolerance

  /// Check if average processing time is within target (33ms)
  bool get meetsTargetProcessingTime => averageProcessingTimeMs <= 33.0;

  /// Get session duration in seconds
  int get sessionDurationSeconds {
    if (sessionStartTime == null) return 0;
    return DateTime.now().difference(sessionStartTime!).inSeconds;
  }

  /// Get human readable data throughput
  String get throughputString {
    if (sessionDurationSeconds == 0) return '0 B/s';
    final bytesPerSecond = totalBytesProcessed / sessionDurationSeconds;
    if (bytesPerSecond < 1024) {
      return '${bytesPerSecond.toStringAsFixed(1)} B/s';
    }
    if (bytesPerSecond < 1024 * 1024) {
      return '${(bytesPerSecond / 1024).toStringAsFixed(1)} KB/s';
    }
    return '${(bytesPerSecond / (1024 * 1024)).toStringAsFixed(1)} MB/s';
  }
}
