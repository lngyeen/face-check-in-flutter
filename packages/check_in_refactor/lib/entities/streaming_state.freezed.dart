// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StreamingState {
  StreamingStatus get status => throw _privateConstructorUsedError;
  int get maxFps => throw _privateConstructorUsedError;
  int get processedFrameCount => throw _privateConstructorUsedError;
  int get droppedFrameCount => throw _privateConstructorUsedError;
  ProcessedFrame? get lastProcessedFrame => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime? get lastFrameTime => throw _privateConstructorUsedError;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamingStateCopyWith<StreamingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingStateCopyWith<$Res> {
  factory $StreamingStateCopyWith(
          StreamingState value, $Res Function(StreamingState) then) =
      _$StreamingStateCopyWithImpl<$Res, StreamingState>;
  @useResult
  $Res call(
      {StreamingStatus status,
      int maxFps,
      int processedFrameCount,
      int droppedFrameCount,
      ProcessedFrame? lastProcessedFrame,
      String? errorMessage,
      DateTime? lastFrameTime});
}

/// @nodoc
class _$StreamingStateCopyWithImpl<$Res, $Val extends StreamingState>
    implements $StreamingStateCopyWith<$Res> {
  _$StreamingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? maxFps = null,
    Object? processedFrameCount = null,
    Object? droppedFrameCount = null,
    Object? lastProcessedFrame = freezed,
    Object? errorMessage = freezed,
    Object? lastFrameTime = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StreamingStatus,
      maxFps: null == maxFps
          ? _value.maxFps
          : maxFps // ignore: cast_nullable_to_non_nullable
              as int,
      processedFrameCount: null == processedFrameCount
          ? _value.processedFrameCount
          : processedFrameCount // ignore: cast_nullable_to_non_nullable
              as int,
      droppedFrameCount: null == droppedFrameCount
          ? _value.droppedFrameCount
          : droppedFrameCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastProcessedFrame: freezed == lastProcessedFrame
          ? _value.lastProcessedFrame
          : lastProcessedFrame // ignore: cast_nullable_to_non_nullable
              as ProcessedFrame?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastFrameTime: freezed == lastFrameTime
          ? _value.lastFrameTime
          : lastFrameTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamingStateImplCopyWith<$Res>
    implements $StreamingStateCopyWith<$Res> {
  factory _$$StreamingStateImplCopyWith(_$StreamingStateImpl value,
          $Res Function(_$StreamingStateImpl) then) =
      __$$StreamingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StreamingStatus status,
      int maxFps,
      int processedFrameCount,
      int droppedFrameCount,
      ProcessedFrame? lastProcessedFrame,
      String? errorMessage,
      DateTime? lastFrameTime});
}

/// @nodoc
class __$$StreamingStateImplCopyWithImpl<$Res>
    extends _$StreamingStateCopyWithImpl<$Res, _$StreamingStateImpl>
    implements _$$StreamingStateImplCopyWith<$Res> {
  __$$StreamingStateImplCopyWithImpl(
      _$StreamingStateImpl _value, $Res Function(_$StreamingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? maxFps = null,
    Object? processedFrameCount = null,
    Object? droppedFrameCount = null,
    Object? lastProcessedFrame = freezed,
    Object? errorMessage = freezed,
    Object? lastFrameTime = freezed,
  }) {
    return _then(_$StreamingStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StreamingStatus,
      maxFps: null == maxFps
          ? _value.maxFps
          : maxFps // ignore: cast_nullable_to_non_nullable
              as int,
      processedFrameCount: null == processedFrameCount
          ? _value.processedFrameCount
          : processedFrameCount // ignore: cast_nullable_to_non_nullable
              as int,
      droppedFrameCount: null == droppedFrameCount
          ? _value.droppedFrameCount
          : droppedFrameCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastProcessedFrame: freezed == lastProcessedFrame
          ? _value.lastProcessedFrame
          : lastProcessedFrame // ignore: cast_nullable_to_non_nullable
              as ProcessedFrame?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastFrameTime: freezed == lastFrameTime
          ? _value.lastFrameTime
          : lastFrameTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$StreamingStateImpl extends _StreamingState {
  const _$StreamingStateImpl(
      {this.status = StreamingStatus.idle,
      this.maxFps = 2,
      this.processedFrameCount = 0,
      this.droppedFrameCount = 0,
      this.lastProcessedFrame,
      this.errorMessage,
      this.lastFrameTime})
      : super._();

  @override
  @JsonKey()
  final StreamingStatus status;
  @override
  @JsonKey()
  final int maxFps;
  @override
  @JsonKey()
  final int processedFrameCount;
  @override
  @JsonKey()
  final int droppedFrameCount;
  @override
  final ProcessedFrame? lastProcessedFrame;
  @override
  final String? errorMessage;
  @override
  final DateTime? lastFrameTime;

  @override
  String toString() {
    return 'StreamingState(status: $status, maxFps: $maxFps, processedFrameCount: $processedFrameCount, droppedFrameCount: $droppedFrameCount, lastProcessedFrame: $lastProcessedFrame, errorMessage: $errorMessage, lastFrameTime: $lastFrameTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.maxFps, maxFps) || other.maxFps == maxFps) &&
            (identical(other.processedFrameCount, processedFrameCount) ||
                other.processedFrameCount == processedFrameCount) &&
            (identical(other.droppedFrameCount, droppedFrameCount) ||
                other.droppedFrameCount == droppedFrameCount) &&
            (identical(other.lastProcessedFrame, lastProcessedFrame) ||
                other.lastProcessedFrame == lastProcessedFrame) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastFrameTime, lastFrameTime) ||
                other.lastFrameTime == lastFrameTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      maxFps,
      processedFrameCount,
      droppedFrameCount,
      lastProcessedFrame,
      errorMessage,
      lastFrameTime);

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingStateImplCopyWith<_$StreamingStateImpl> get copyWith =>
      __$$StreamingStateImplCopyWithImpl<_$StreamingStateImpl>(
          this, _$identity);
}

abstract class _StreamingState extends StreamingState {
  const factory _StreamingState(
      {final StreamingStatus status,
      final int maxFps,
      final int processedFrameCount,
      final int droppedFrameCount,
      final ProcessedFrame? lastProcessedFrame,
      final String? errorMessage,
      final DateTime? lastFrameTime}) = _$StreamingStateImpl;
  const _StreamingState._() : super._();

  @override
  StreamingStatus get status;
  @override
  int get maxFps;
  @override
  int get processedFrameCount;
  @override
  int get droppedFrameCount;
  @override
  ProcessedFrame? get lastProcessedFrame;
  @override
  String? get errorMessage;
  @override
  DateTime? get lastFrameTime;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingStateImplCopyWith<_$StreamingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
