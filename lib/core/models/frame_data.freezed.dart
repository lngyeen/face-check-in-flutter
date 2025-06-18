// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FrameData {
  /// Unique identifier for this frame
  String get id => throw _privateConstructorUsedError;

  /// Base64 encoded frame data
  String get base64Data => throw _privateConstructorUsedError;

  /// Timestamp when the frame was captured
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Width of the frame in pixels
  int get width => throw _privateConstructorUsedError;

  /// Height of the frame in pixels
  int get height => throw _privateConstructorUsedError;

  /// Original format of the frame (e.g., 'yuv420', 'nv21')
  String get format => throw _privateConstructorUsedError;

  /// Size of the original frame data in bytes
  int get originalSize => throw _privateConstructorUsedError;

  /// Size of the base64 encoded data in bytes
  int get encodedSize => throw _privateConstructorUsedError;

  /// Processing time in milliseconds for this frame
  int? get processingTimeMs => throw _privateConstructorUsedError;

  /// Quality score (0.0 to 1.0) if applicable
  double? get quality => throw _privateConstructorUsedError;

  /// Create a copy of FrameData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrameDataCopyWith<FrameData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameDataCopyWith<$Res> {
  factory $FrameDataCopyWith(FrameData value, $Res Function(FrameData) then) =
      _$FrameDataCopyWithImpl<$Res, FrameData>;
  @useResult
  $Res call({
    String id,
    String base64Data,
    DateTime timestamp,
    int width,
    int height,
    String format,
    int originalSize,
    int encodedSize,
    int? processingTimeMs,
    double? quality,
  });
}

/// @nodoc
class _$FrameDataCopyWithImpl<$Res, $Val extends FrameData>
    implements $FrameDataCopyWith<$Res> {
  _$FrameDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrameData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? base64Data = null,
    Object? timestamp = null,
    Object? width = null,
    Object? height = null,
    Object? format = null,
    Object? originalSize = null,
    Object? encodedSize = null,
    Object? processingTimeMs = freezed,
    Object? quality = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            base64Data:
                null == base64Data
                    ? _value.base64Data
                    : base64Data // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            width:
                null == width
                    ? _value.width
                    : width // ignore: cast_nullable_to_non_nullable
                        as int,
            height:
                null == height
                    ? _value.height
                    : height // ignore: cast_nullable_to_non_nullable
                        as int,
            format:
                null == format
                    ? _value.format
                    : format // ignore: cast_nullable_to_non_nullable
                        as String,
            originalSize:
                null == originalSize
                    ? _value.originalSize
                    : originalSize // ignore: cast_nullable_to_non_nullable
                        as int,
            encodedSize:
                null == encodedSize
                    ? _value.encodedSize
                    : encodedSize // ignore: cast_nullable_to_non_nullable
                        as int,
            processingTimeMs:
                freezed == processingTimeMs
                    ? _value.processingTimeMs
                    : processingTimeMs // ignore: cast_nullable_to_non_nullable
                        as int?,
            quality:
                freezed == quality
                    ? _value.quality
                    : quality // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FrameDataImplCopyWith<$Res>
    implements $FrameDataCopyWith<$Res> {
  factory _$$FrameDataImplCopyWith(
    _$FrameDataImpl value,
    $Res Function(_$FrameDataImpl) then,
  ) = __$$FrameDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String base64Data,
    DateTime timestamp,
    int width,
    int height,
    String format,
    int originalSize,
    int encodedSize,
    int? processingTimeMs,
    double? quality,
  });
}

/// @nodoc
class __$$FrameDataImplCopyWithImpl<$Res>
    extends _$FrameDataCopyWithImpl<$Res, _$FrameDataImpl>
    implements _$$FrameDataImplCopyWith<$Res> {
  __$$FrameDataImplCopyWithImpl(
    _$FrameDataImpl _value,
    $Res Function(_$FrameDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FrameData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? base64Data = null,
    Object? timestamp = null,
    Object? width = null,
    Object? height = null,
    Object? format = null,
    Object? originalSize = null,
    Object? encodedSize = null,
    Object? processingTimeMs = freezed,
    Object? quality = freezed,
  }) {
    return _then(
      _$FrameDataImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        base64Data:
            null == base64Data
                ? _value.base64Data
                : base64Data // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        width:
            null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                    as int,
        height:
            null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                    as int,
        format:
            null == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                    as String,
        originalSize:
            null == originalSize
                ? _value.originalSize
                : originalSize // ignore: cast_nullable_to_non_nullable
                    as int,
        encodedSize:
            null == encodedSize
                ? _value.encodedSize
                : encodedSize // ignore: cast_nullable_to_non_nullable
                    as int,
        processingTimeMs:
            freezed == processingTimeMs
                ? _value.processingTimeMs
                : processingTimeMs // ignore: cast_nullable_to_non_nullable
                    as int?,
        quality:
            freezed == quality
                ? _value.quality
                : quality // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc

class _$FrameDataImpl extends _FrameData {
  const _$FrameDataImpl({
    required this.id,
    required this.base64Data,
    required this.timestamp,
    required this.width,
    required this.height,
    required this.format,
    required this.originalSize,
    required this.encodedSize,
    this.processingTimeMs,
    this.quality,
  }) : super._();

  /// Unique identifier for this frame
  @override
  final String id;

  /// Base64 encoded frame data
  @override
  final String base64Data;

  /// Timestamp when the frame was captured
  @override
  final DateTime timestamp;

  /// Width of the frame in pixels
  @override
  final int width;

  /// Height of the frame in pixels
  @override
  final int height;

  /// Original format of the frame (e.g., 'yuv420', 'nv21')
  @override
  final String format;

  /// Size of the original frame data in bytes
  @override
  final int originalSize;

  /// Size of the base64 encoded data in bytes
  @override
  final int encodedSize;

  /// Processing time in milliseconds for this frame
  @override
  final int? processingTimeMs;

  /// Quality score (0.0 to 1.0) if applicable
  @override
  final double? quality;

  @override
  String toString() {
    return 'FrameData(id: $id, base64Data: $base64Data, timestamp: $timestamp, width: $width, height: $height, format: $format, originalSize: $originalSize, encodedSize: $encodedSize, processingTimeMs: $processingTimeMs, quality: $quality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrameDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.base64Data, base64Data) ||
                other.base64Data == base64Data) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.originalSize, originalSize) ||
                other.originalSize == originalSize) &&
            (identical(other.encodedSize, encodedSize) ||
                other.encodedSize == encodedSize) &&
            (identical(other.processingTimeMs, processingTimeMs) ||
                other.processingTimeMs == processingTimeMs) &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    base64Data,
    timestamp,
    width,
    height,
    format,
    originalSize,
    encodedSize,
    processingTimeMs,
    quality,
  );

  /// Create a copy of FrameData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrameDataImplCopyWith<_$FrameDataImpl> get copyWith =>
      __$$FrameDataImplCopyWithImpl<_$FrameDataImpl>(this, _$identity);
}

abstract class _FrameData extends FrameData {
  const factory _FrameData({
    required final String id,
    required final String base64Data,
    required final DateTime timestamp,
    required final int width,
    required final int height,
    required final String format,
    required final int originalSize,
    required final int encodedSize,
    final int? processingTimeMs,
    final double? quality,
  }) = _$FrameDataImpl;
  const _FrameData._() : super._();

  /// Unique identifier for this frame
  @override
  String get id;

  /// Base64 encoded frame data
  @override
  String get base64Data;

  /// Timestamp when the frame was captured
  @override
  DateTime get timestamp;

  /// Width of the frame in pixels
  @override
  int get width;

  /// Height of the frame in pixels
  @override
  int get height;

  /// Original format of the frame (e.g., 'yuv420', 'nv21')
  @override
  String get format;

  /// Size of the original frame data in bytes
  @override
  int get originalSize;

  /// Size of the base64 encoded data in bytes
  @override
  int get encodedSize;

  /// Processing time in milliseconds for this frame
  @override
  int? get processingTimeMs;

  /// Quality score (0.0 to 1.0) if applicable
  @override
  double? get quality;

  /// Create a copy of FrameData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrameDataImplCopyWith<_$FrameDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FrameCaptureMetrics {
  /// Total number of frames captured
  int get totalFrames => throw _privateConstructorUsedError;

  /// Number of frames successfully processed
  int get successfulFrames => throw _privateConstructorUsedError;

  /// Number of frames that failed processing
  int get failedFrames => throw _privateConstructorUsedError;

  /// Current frames per second
  double get currentFps => throw _privateConstructorUsedError;

  /// Average frames per second over time
  double get averageFps => throw _privateConstructorUsedError;

  /// Average processing time per frame in milliseconds
  double get averageProcessingTimeMs => throw _privateConstructorUsedError;

  /// Maximum processing time recorded in milliseconds
  double get maxProcessingTimeMs => throw _privateConstructorUsedError;

  /// Total data processed in bytes
  int get totalBytesProcessed => throw _privateConstructorUsedError;

  /// Current memory usage in bytes
  int get currentMemoryUsage => throw _privateConstructorUsedError;

  /// Peak memory usage in bytes
  int get peakMemoryUsage => throw _privateConstructorUsedError;

  /// Timestamp of last frame capture
  DateTime? get lastFrameTimestamp => throw _privateConstructorUsedError;

  /// Start time of capture session
  DateTime? get sessionStartTime => throw _privateConstructorUsedError;

  /// Create a copy of FrameCaptureMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrameCaptureMetricsCopyWith<FrameCaptureMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameCaptureMetricsCopyWith<$Res> {
  factory $FrameCaptureMetricsCopyWith(
    FrameCaptureMetrics value,
    $Res Function(FrameCaptureMetrics) then,
  ) = _$FrameCaptureMetricsCopyWithImpl<$Res, FrameCaptureMetrics>;
  @useResult
  $Res call({
    int totalFrames,
    int successfulFrames,
    int failedFrames,
    double currentFps,
    double averageFps,
    double averageProcessingTimeMs,
    double maxProcessingTimeMs,
    int totalBytesProcessed,
    int currentMemoryUsage,
    int peakMemoryUsage,
    DateTime? lastFrameTimestamp,
    DateTime? sessionStartTime,
  });
}

/// @nodoc
class _$FrameCaptureMetricsCopyWithImpl<$Res, $Val extends FrameCaptureMetrics>
    implements $FrameCaptureMetricsCopyWith<$Res> {
  _$FrameCaptureMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrameCaptureMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalFrames = null,
    Object? successfulFrames = null,
    Object? failedFrames = null,
    Object? currentFps = null,
    Object? averageFps = null,
    Object? averageProcessingTimeMs = null,
    Object? maxProcessingTimeMs = null,
    Object? totalBytesProcessed = null,
    Object? currentMemoryUsage = null,
    Object? peakMemoryUsage = null,
    Object? lastFrameTimestamp = freezed,
    Object? sessionStartTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            totalFrames:
                null == totalFrames
                    ? _value.totalFrames
                    : totalFrames // ignore: cast_nullable_to_non_nullable
                        as int,
            successfulFrames:
                null == successfulFrames
                    ? _value.successfulFrames
                    : successfulFrames // ignore: cast_nullable_to_non_nullable
                        as int,
            failedFrames:
                null == failedFrames
                    ? _value.failedFrames
                    : failedFrames // ignore: cast_nullable_to_non_nullable
                        as int,
            currentFps:
                null == currentFps
                    ? _value.currentFps
                    : currentFps // ignore: cast_nullable_to_non_nullable
                        as double,
            averageFps:
                null == averageFps
                    ? _value.averageFps
                    : averageFps // ignore: cast_nullable_to_non_nullable
                        as double,
            averageProcessingTimeMs:
                null == averageProcessingTimeMs
                    ? _value.averageProcessingTimeMs
                    : averageProcessingTimeMs // ignore: cast_nullable_to_non_nullable
                        as double,
            maxProcessingTimeMs:
                null == maxProcessingTimeMs
                    ? _value.maxProcessingTimeMs
                    : maxProcessingTimeMs // ignore: cast_nullable_to_non_nullable
                        as double,
            totalBytesProcessed:
                null == totalBytesProcessed
                    ? _value.totalBytesProcessed
                    : totalBytesProcessed // ignore: cast_nullable_to_non_nullable
                        as int,
            currentMemoryUsage:
                null == currentMemoryUsage
                    ? _value.currentMemoryUsage
                    : currentMemoryUsage // ignore: cast_nullable_to_non_nullable
                        as int,
            peakMemoryUsage:
                null == peakMemoryUsage
                    ? _value.peakMemoryUsage
                    : peakMemoryUsage // ignore: cast_nullable_to_non_nullable
                        as int,
            lastFrameTimestamp:
                freezed == lastFrameTimestamp
                    ? _value.lastFrameTimestamp
                    : lastFrameTimestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            sessionStartTime:
                freezed == sessionStartTime
                    ? _value.sessionStartTime
                    : sessionStartTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FrameCaptureMetricsImplCopyWith<$Res>
    implements $FrameCaptureMetricsCopyWith<$Res> {
  factory _$$FrameCaptureMetricsImplCopyWith(
    _$FrameCaptureMetricsImpl value,
    $Res Function(_$FrameCaptureMetricsImpl) then,
  ) = __$$FrameCaptureMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalFrames,
    int successfulFrames,
    int failedFrames,
    double currentFps,
    double averageFps,
    double averageProcessingTimeMs,
    double maxProcessingTimeMs,
    int totalBytesProcessed,
    int currentMemoryUsage,
    int peakMemoryUsage,
    DateTime? lastFrameTimestamp,
    DateTime? sessionStartTime,
  });
}

/// @nodoc
class __$$FrameCaptureMetricsImplCopyWithImpl<$Res>
    extends _$FrameCaptureMetricsCopyWithImpl<$Res, _$FrameCaptureMetricsImpl>
    implements _$$FrameCaptureMetricsImplCopyWith<$Res> {
  __$$FrameCaptureMetricsImplCopyWithImpl(
    _$FrameCaptureMetricsImpl _value,
    $Res Function(_$FrameCaptureMetricsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FrameCaptureMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalFrames = null,
    Object? successfulFrames = null,
    Object? failedFrames = null,
    Object? currentFps = null,
    Object? averageFps = null,
    Object? averageProcessingTimeMs = null,
    Object? maxProcessingTimeMs = null,
    Object? totalBytesProcessed = null,
    Object? currentMemoryUsage = null,
    Object? peakMemoryUsage = null,
    Object? lastFrameTimestamp = freezed,
    Object? sessionStartTime = freezed,
  }) {
    return _then(
      _$FrameCaptureMetricsImpl(
        totalFrames:
            null == totalFrames
                ? _value.totalFrames
                : totalFrames // ignore: cast_nullable_to_non_nullable
                    as int,
        successfulFrames:
            null == successfulFrames
                ? _value.successfulFrames
                : successfulFrames // ignore: cast_nullable_to_non_nullable
                    as int,
        failedFrames:
            null == failedFrames
                ? _value.failedFrames
                : failedFrames // ignore: cast_nullable_to_non_nullable
                    as int,
        currentFps:
            null == currentFps
                ? _value.currentFps
                : currentFps // ignore: cast_nullable_to_non_nullable
                    as double,
        averageFps:
            null == averageFps
                ? _value.averageFps
                : averageFps // ignore: cast_nullable_to_non_nullable
                    as double,
        averageProcessingTimeMs:
            null == averageProcessingTimeMs
                ? _value.averageProcessingTimeMs
                : averageProcessingTimeMs // ignore: cast_nullable_to_non_nullable
                    as double,
        maxProcessingTimeMs:
            null == maxProcessingTimeMs
                ? _value.maxProcessingTimeMs
                : maxProcessingTimeMs // ignore: cast_nullable_to_non_nullable
                    as double,
        totalBytesProcessed:
            null == totalBytesProcessed
                ? _value.totalBytesProcessed
                : totalBytesProcessed // ignore: cast_nullable_to_non_nullable
                    as int,
        currentMemoryUsage:
            null == currentMemoryUsage
                ? _value.currentMemoryUsage
                : currentMemoryUsage // ignore: cast_nullable_to_non_nullable
                    as int,
        peakMemoryUsage:
            null == peakMemoryUsage
                ? _value.peakMemoryUsage
                : peakMemoryUsage // ignore: cast_nullable_to_non_nullable
                    as int,
        lastFrameTimestamp:
            freezed == lastFrameTimestamp
                ? _value.lastFrameTimestamp
                : lastFrameTimestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        sessionStartTime:
            freezed == sessionStartTime
                ? _value.sessionStartTime
                : sessionStartTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$FrameCaptureMetricsImpl extends _FrameCaptureMetrics {
  const _$FrameCaptureMetricsImpl({
    this.totalFrames = 0,
    this.successfulFrames = 0,
    this.failedFrames = 0,
    this.currentFps = 0.0,
    this.averageFps = 0.0,
    this.averageProcessingTimeMs = 0.0,
    this.maxProcessingTimeMs = 0.0,
    this.totalBytesProcessed = 0,
    this.currentMemoryUsage = 0,
    this.peakMemoryUsage = 0,
    this.lastFrameTimestamp,
    this.sessionStartTime,
  }) : super._();

  /// Total number of frames captured
  @override
  @JsonKey()
  final int totalFrames;

  /// Number of frames successfully processed
  @override
  @JsonKey()
  final int successfulFrames;

  /// Number of frames that failed processing
  @override
  @JsonKey()
  final int failedFrames;

  /// Current frames per second
  @override
  @JsonKey()
  final double currentFps;

  /// Average frames per second over time
  @override
  @JsonKey()
  final double averageFps;

  /// Average processing time per frame in milliseconds
  @override
  @JsonKey()
  final double averageProcessingTimeMs;

  /// Maximum processing time recorded in milliseconds
  @override
  @JsonKey()
  final double maxProcessingTimeMs;

  /// Total data processed in bytes
  @override
  @JsonKey()
  final int totalBytesProcessed;

  /// Current memory usage in bytes
  @override
  @JsonKey()
  final int currentMemoryUsage;

  /// Peak memory usage in bytes
  @override
  @JsonKey()
  final int peakMemoryUsage;

  /// Timestamp of last frame capture
  @override
  final DateTime? lastFrameTimestamp;

  /// Start time of capture session
  @override
  final DateTime? sessionStartTime;

  @override
  String toString() {
    return 'FrameCaptureMetrics(totalFrames: $totalFrames, successfulFrames: $successfulFrames, failedFrames: $failedFrames, currentFps: $currentFps, averageFps: $averageFps, averageProcessingTimeMs: $averageProcessingTimeMs, maxProcessingTimeMs: $maxProcessingTimeMs, totalBytesProcessed: $totalBytesProcessed, currentMemoryUsage: $currentMemoryUsage, peakMemoryUsage: $peakMemoryUsage, lastFrameTimestamp: $lastFrameTimestamp, sessionStartTime: $sessionStartTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrameCaptureMetricsImpl &&
            (identical(other.totalFrames, totalFrames) ||
                other.totalFrames == totalFrames) &&
            (identical(other.successfulFrames, successfulFrames) ||
                other.successfulFrames == successfulFrames) &&
            (identical(other.failedFrames, failedFrames) ||
                other.failedFrames == failedFrames) &&
            (identical(other.currentFps, currentFps) ||
                other.currentFps == currentFps) &&
            (identical(other.averageFps, averageFps) ||
                other.averageFps == averageFps) &&
            (identical(
                  other.averageProcessingTimeMs,
                  averageProcessingTimeMs,
                ) ||
                other.averageProcessingTimeMs == averageProcessingTimeMs) &&
            (identical(other.maxProcessingTimeMs, maxProcessingTimeMs) ||
                other.maxProcessingTimeMs == maxProcessingTimeMs) &&
            (identical(other.totalBytesProcessed, totalBytesProcessed) ||
                other.totalBytesProcessed == totalBytesProcessed) &&
            (identical(other.currentMemoryUsage, currentMemoryUsage) ||
                other.currentMemoryUsage == currentMemoryUsage) &&
            (identical(other.peakMemoryUsage, peakMemoryUsage) ||
                other.peakMemoryUsage == peakMemoryUsage) &&
            (identical(other.lastFrameTimestamp, lastFrameTimestamp) ||
                other.lastFrameTimestamp == lastFrameTimestamp) &&
            (identical(other.sessionStartTime, sessionStartTime) ||
                other.sessionStartTime == sessionStartTime));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalFrames,
    successfulFrames,
    failedFrames,
    currentFps,
    averageFps,
    averageProcessingTimeMs,
    maxProcessingTimeMs,
    totalBytesProcessed,
    currentMemoryUsage,
    peakMemoryUsage,
    lastFrameTimestamp,
    sessionStartTime,
  );

  /// Create a copy of FrameCaptureMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrameCaptureMetricsImplCopyWith<_$FrameCaptureMetricsImpl> get copyWith =>
      __$$FrameCaptureMetricsImplCopyWithImpl<_$FrameCaptureMetricsImpl>(
        this,
        _$identity,
      );
}

abstract class _FrameCaptureMetrics extends FrameCaptureMetrics {
  const factory _FrameCaptureMetrics({
    final int totalFrames,
    final int successfulFrames,
    final int failedFrames,
    final double currentFps,
    final double averageFps,
    final double averageProcessingTimeMs,
    final double maxProcessingTimeMs,
    final int totalBytesProcessed,
    final int currentMemoryUsage,
    final int peakMemoryUsage,
    final DateTime? lastFrameTimestamp,
    final DateTime? sessionStartTime,
  }) = _$FrameCaptureMetricsImpl;
  const _FrameCaptureMetrics._() : super._();

  /// Total number of frames captured
  @override
  int get totalFrames;

  /// Number of frames successfully processed
  @override
  int get successfulFrames;

  /// Number of frames that failed processing
  @override
  int get failedFrames;

  /// Current frames per second
  @override
  double get currentFps;

  /// Average frames per second over time
  @override
  double get averageFps;

  /// Average processing time per frame in milliseconds
  @override
  double get averageProcessingTimeMs;

  /// Maximum processing time recorded in milliseconds
  @override
  double get maxProcessingTimeMs;

  /// Total data processed in bytes
  @override
  int get totalBytesProcessed;

  /// Current memory usage in bytes
  @override
  int get currentMemoryUsage;

  /// Peak memory usage in bytes
  @override
  int get peakMemoryUsage;

  /// Timestamp of last frame capture
  @override
  DateTime? get lastFrameTimestamp;

  /// Start time of capture session
  @override
  DateTime? get sessionStartTime;

  /// Create a copy of FrameCaptureMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrameCaptureMetricsImplCopyWith<_$FrameCaptureMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
