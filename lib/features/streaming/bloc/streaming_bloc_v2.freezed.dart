// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_bloc_v2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BucketSequentialStreamingEventV2 {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraController controller) startStreaming,
    required TResult Function() stopStreaming,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraController controller)? startStreaming,
    TResult? Function()? stopStreaming,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraController controller)? startStreaming,
    TResult Function()? stopStreaming,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartStreaming value) startStreaming,
    required TResult Function(_StopStreaming value) stopStreaming,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartStreaming value)? startStreaming,
    TResult? Function(_StopStreaming value)? stopStreaming,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartStreaming value)? startStreaming,
    TResult Function(_StopStreaming value)? stopStreaming,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BucketSequentialStreamingEventV2CopyWith<$Res> {
  factory $BucketSequentialStreamingEventV2CopyWith(
    BucketSequentialStreamingEventV2 value,
    $Res Function(BucketSequentialStreamingEventV2) then,
  ) =
      _$BucketSequentialStreamingEventV2CopyWithImpl<
        $Res,
        BucketSequentialStreamingEventV2
      >;
}

/// @nodoc
class _$BucketSequentialStreamingEventV2CopyWithImpl<
  $Res,
  $Val extends BucketSequentialStreamingEventV2
>
    implements $BucketSequentialStreamingEventV2CopyWith<$Res> {
  _$BucketSequentialStreamingEventV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BucketSequentialStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartStreamingImplCopyWith<$Res> {
  factory _$$StartStreamingImplCopyWith(
    _$StartStreamingImpl value,
    $Res Function(_$StartStreamingImpl) then,
  ) = __$$StartStreamingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CameraController controller});
}

/// @nodoc
class __$$StartStreamingImplCopyWithImpl<$Res>
    extends
        _$BucketSequentialStreamingEventV2CopyWithImpl<
          $Res,
          _$StartStreamingImpl
        >
    implements _$$StartStreamingImplCopyWith<$Res> {
  __$$StartStreamingImplCopyWithImpl(
    _$StartStreamingImpl _value,
    $Res Function(_$StartStreamingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BucketSequentialStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? controller = null}) {
    return _then(
      _$StartStreamingImpl(
        null == controller
            ? _value.controller
            : controller // ignore: cast_nullable_to_non_nullable
                as CameraController,
      ),
    );
  }
}

/// @nodoc

class _$StartStreamingImpl implements _StartStreaming {
  const _$StartStreamingImpl(this.controller);

  @override
  final CameraController controller;

  @override
  String toString() {
    return 'BucketSequentialStreamingEventV2.startStreaming(controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartStreamingImpl &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, controller);

  /// Create a copy of BucketSequentialStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartStreamingImplCopyWith<_$StartStreamingImpl> get copyWith =>
      __$$StartStreamingImplCopyWithImpl<_$StartStreamingImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraController controller) startStreaming,
    required TResult Function() stopStreaming,
  }) {
    return startStreaming(controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraController controller)? startStreaming,
    TResult? Function()? stopStreaming,
  }) {
    return startStreaming?.call(controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraController controller)? startStreaming,
    TResult Function()? stopStreaming,
    required TResult orElse(),
  }) {
    if (startStreaming != null) {
      return startStreaming(controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartStreaming value) startStreaming,
    required TResult Function(_StopStreaming value) stopStreaming,
  }) {
    return startStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartStreaming value)? startStreaming,
    TResult? Function(_StopStreaming value)? stopStreaming,
  }) {
    return startStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartStreaming value)? startStreaming,
    TResult Function(_StopStreaming value)? stopStreaming,
    required TResult orElse(),
  }) {
    if (startStreaming != null) {
      return startStreaming(this);
    }
    return orElse();
  }
}

abstract class _StartStreaming implements BucketSequentialStreamingEventV2 {
  const factory _StartStreaming(final CameraController controller) =
      _$StartStreamingImpl;

  CameraController get controller;

  /// Create a copy of BucketSequentialStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartStreamingImplCopyWith<_$StartStreamingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StopStreamingImplCopyWith<$Res> {
  factory _$$StopStreamingImplCopyWith(
    _$StopStreamingImpl value,
    $Res Function(_$StopStreamingImpl) then,
  ) = __$$StopStreamingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopStreamingImplCopyWithImpl<$Res>
    extends
        _$BucketSequentialStreamingEventV2CopyWithImpl<
          $Res,
          _$StopStreamingImpl
        >
    implements _$$StopStreamingImplCopyWith<$Res> {
  __$$StopStreamingImplCopyWithImpl(
    _$StopStreamingImpl _value,
    $Res Function(_$StopStreamingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BucketSequentialStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopStreamingImpl implements _StopStreaming {
  const _$StopStreamingImpl();

  @override
  String toString() {
    return 'BucketSequentialStreamingEventV2.stopStreaming()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StopStreamingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraController controller) startStreaming,
    required TResult Function() stopStreaming,
  }) {
    return stopStreaming();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraController controller)? startStreaming,
    TResult? Function()? stopStreaming,
  }) {
    return stopStreaming?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraController controller)? startStreaming,
    TResult Function()? stopStreaming,
    required TResult orElse(),
  }) {
    if (stopStreaming != null) {
      return stopStreaming();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartStreaming value) startStreaming,
    required TResult Function(_StopStreaming value) stopStreaming,
  }) {
    return stopStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartStreaming value)? startStreaming,
    TResult? Function(_StopStreaming value)? stopStreaming,
  }) {
    return stopStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartStreaming value)? startStreaming,
    TResult Function(_StopStreaming value)? stopStreaming,
    required TResult orElse(),
  }) {
    if (stopStreaming != null) {
      return stopStreaming(this);
    }
    return orElse();
  }
}

abstract class _StopStreaming implements BucketSequentialStreamingEventV2 {
  const factory _StopStreaming() = _$StopStreamingImpl;
}

/// @nodoc
mixin _$BucketSequentialStreamingStatusEventV2 {
  Enum get status => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function(ProcessingStatus status) processingStatusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function(ProcessingStatus status)? processingStatusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function(ProcessingStatus status)? processingStatusChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(_ProcessingStatusChanged value)
    processingStatusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(_ProcessingStatusChanged value)? processingStatusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(_ProcessingStatusChanged value)? processingStatusChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BucketSequentialStreamingStatusEventV2CopyWith<$Res> {
  factory $BucketSequentialStreamingStatusEventV2CopyWith(
    BucketSequentialStreamingStatusEventV2 value,
    $Res Function(BucketSequentialStreamingStatusEventV2) then,
  ) =
      _$BucketSequentialStreamingStatusEventV2CopyWithImpl<
        $Res,
        BucketSequentialStreamingStatusEventV2
      >;
}

/// @nodoc
class _$BucketSequentialStreamingStatusEventV2CopyWithImpl<
  $Res,
  $Val extends BucketSequentialStreamingStatusEventV2
>
    implements $BucketSequentialStreamingStatusEventV2CopyWith<$Res> {
  _$BucketSequentialStreamingStatusEventV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BucketSequentialStreamingStatusEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StreamingStatusChangedImplCopyWith<$Res> {
  factory _$$StreamingStatusChangedImplCopyWith(
    _$StreamingStatusChangedImpl value,
    $Res Function(_$StreamingStatusChangedImpl) then,
  ) = __$$StreamingStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StreamingStatus status});
}

/// @nodoc
class __$$StreamingStatusChangedImplCopyWithImpl<$Res>
    extends
        _$BucketSequentialStreamingStatusEventV2CopyWithImpl<
          $Res,
          _$StreamingStatusChangedImpl
        >
    implements _$$StreamingStatusChangedImplCopyWith<$Res> {
  __$$StreamingStatusChangedImplCopyWithImpl(
    _$StreamingStatusChangedImpl _value,
    $Res Function(_$StreamingStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BucketSequentialStreamingStatusEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$StreamingStatusChangedImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                as StreamingStatus,
      ),
    );
  }
}

/// @nodoc

class _$StreamingStatusChangedImpl implements _StreamingStatusChanged {
  const _$StreamingStatusChangedImpl(this.status);

  @override
  final StreamingStatus status;

  @override
  String toString() {
    return 'BucketSequentialStreamingStatusEventV2.streamingStatusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of BucketSequentialStreamingStatusEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingStatusChangedImplCopyWith<_$StreamingStatusChangedImpl>
  get copyWith =>
      __$$StreamingStatusChangedImplCopyWithImpl<_$StreamingStatusChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function(ProcessingStatus status) processingStatusChanged,
  }) {
    return streamingStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function(ProcessingStatus status)? processingStatusChanged,
  }) {
    return streamingStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function(ProcessingStatus status)? processingStatusChanged,
    required TResult orElse(),
  }) {
    if (streamingStatusChanged != null) {
      return streamingStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(_ProcessingStatusChanged value)
    processingStatusChanged,
  }) {
    return streamingStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(_ProcessingStatusChanged value)? processingStatusChanged,
  }) {
    return streamingStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(_ProcessingStatusChanged value)? processingStatusChanged,
    required TResult orElse(),
  }) {
    if (streamingStatusChanged != null) {
      return streamingStatusChanged(this);
    }
    return orElse();
  }
}

abstract class _StreamingStatusChanged
    implements BucketSequentialStreamingStatusEventV2 {
  const factory _StreamingStatusChanged(final StreamingStatus status) =
      _$StreamingStatusChangedImpl;

  @override
  StreamingStatus get status;

  /// Create a copy of BucketSequentialStreamingStatusEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingStatusChangedImplCopyWith<_$StreamingStatusChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessingStatusChangedImplCopyWith<$Res> {
  factory _$$ProcessingStatusChangedImplCopyWith(
    _$ProcessingStatusChangedImpl value,
    $Res Function(_$ProcessingStatusChangedImpl) then,
  ) = __$$ProcessingStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProcessingStatus status});
}

/// @nodoc
class __$$ProcessingStatusChangedImplCopyWithImpl<$Res>
    extends
        _$BucketSequentialStreamingStatusEventV2CopyWithImpl<
          $Res,
          _$ProcessingStatusChangedImpl
        >
    implements _$$ProcessingStatusChangedImplCopyWith<$Res> {
  __$$ProcessingStatusChangedImplCopyWithImpl(
    _$ProcessingStatusChangedImpl _value,
    $Res Function(_$ProcessingStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BucketSequentialStreamingStatusEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$ProcessingStatusChangedImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                as ProcessingStatus,
      ),
    );
  }
}

/// @nodoc

class _$ProcessingStatusChangedImpl implements _ProcessingStatusChanged {
  const _$ProcessingStatusChangedImpl(this.status);

  @override
  final ProcessingStatus status;

  @override
  String toString() {
    return 'BucketSequentialStreamingStatusEventV2.processingStatusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessingStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of BucketSequentialStreamingStatusEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessingStatusChangedImplCopyWith<_$ProcessingStatusChangedImpl>
  get copyWith => __$$ProcessingStatusChangedImplCopyWithImpl<
    _$ProcessingStatusChangedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function(ProcessingStatus status) processingStatusChanged,
  }) {
    return processingStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function(ProcessingStatus status)? processingStatusChanged,
  }) {
    return processingStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function(ProcessingStatus status)? processingStatusChanged,
    required TResult orElse(),
  }) {
    if (processingStatusChanged != null) {
      return processingStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(_ProcessingStatusChanged value)
    processingStatusChanged,
  }) {
    return processingStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(_ProcessingStatusChanged value)? processingStatusChanged,
  }) {
    return processingStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(_ProcessingStatusChanged value)? processingStatusChanged,
    required TResult orElse(),
  }) {
    if (processingStatusChanged != null) {
      return processingStatusChanged(this);
    }
    return orElse();
  }
}

abstract class _ProcessingStatusChanged
    implements BucketSequentialStreamingStatusEventV2 {
  const factory _ProcessingStatusChanged(final ProcessingStatus status) =
      _$ProcessingStatusChangedImpl;

  @override
  ProcessingStatus get status;

  /// Create a copy of BucketSequentialStreamingStatusEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessingStatusChangedImplCopyWith<_$ProcessingStatusChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SeparatedRestartableStreamingEventV2 {
  HybridProcessingResult get result => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HybridProcessingResult result)
    processingResultReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(HybridProcessingResult result)? processingResultReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HybridProcessingResult result)? processingResultReceived,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingResultReceived value)
    processingResultReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingResultReceived value)?
    processingResultReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingResultReceived value)? processingResultReceived,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of SeparatedRestartableStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeparatedRestartableStreamingEventV2CopyWith<
    SeparatedRestartableStreamingEventV2
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeparatedRestartableStreamingEventV2CopyWith<$Res> {
  factory $SeparatedRestartableStreamingEventV2CopyWith(
    SeparatedRestartableStreamingEventV2 value,
    $Res Function(SeparatedRestartableStreamingEventV2) then,
  ) =
      _$SeparatedRestartableStreamingEventV2CopyWithImpl<
        $Res,
        SeparatedRestartableStreamingEventV2
      >;
  @useResult
  $Res call({HybridProcessingResult result});
}

/// @nodoc
class _$SeparatedRestartableStreamingEventV2CopyWithImpl<
  $Res,
  $Val extends SeparatedRestartableStreamingEventV2
>
    implements $SeparatedRestartableStreamingEventV2CopyWith<$Res> {
  _$SeparatedRestartableStreamingEventV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeparatedRestartableStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? result = null}) {
    return _then(
      _value.copyWith(
            result:
                null == result
                    ? _value.result
                    : result // ignore: cast_nullable_to_non_nullable
                        as HybridProcessingResult,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProcessingResultReceivedImplCopyWith<$Res>
    implements $SeparatedRestartableStreamingEventV2CopyWith<$Res> {
  factory _$$ProcessingResultReceivedImplCopyWith(
    _$ProcessingResultReceivedImpl value,
    $Res Function(_$ProcessingResultReceivedImpl) then,
  ) = __$$ProcessingResultReceivedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HybridProcessingResult result});
}

/// @nodoc
class __$$ProcessingResultReceivedImplCopyWithImpl<$Res>
    extends
        _$SeparatedRestartableStreamingEventV2CopyWithImpl<
          $Res,
          _$ProcessingResultReceivedImpl
        >
    implements _$$ProcessingResultReceivedImplCopyWith<$Res> {
  __$$ProcessingResultReceivedImplCopyWithImpl(
    _$ProcessingResultReceivedImpl _value,
    $Res Function(_$ProcessingResultReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeparatedRestartableStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? result = null}) {
    return _then(
      _$ProcessingResultReceivedImpl(
        null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                as HybridProcessingResult,
      ),
    );
  }
}

/// @nodoc

class _$ProcessingResultReceivedImpl implements _ProcessingResultReceived {
  const _$ProcessingResultReceivedImpl(this.result);

  @override
  final HybridProcessingResult result;

  @override
  String toString() {
    return 'SeparatedRestartableStreamingEventV2.processingResultReceived(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessingResultReceivedImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  /// Create a copy of SeparatedRestartableStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessingResultReceivedImplCopyWith<_$ProcessingResultReceivedImpl>
  get copyWith => __$$ProcessingResultReceivedImplCopyWithImpl<
    _$ProcessingResultReceivedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HybridProcessingResult result)
    processingResultReceived,
  }) {
    return processingResultReceived(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(HybridProcessingResult result)? processingResultReceived,
  }) {
    return processingResultReceived?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HybridProcessingResult result)? processingResultReceived,
    required TResult orElse(),
  }) {
    if (processingResultReceived != null) {
      return processingResultReceived(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingResultReceived value)
    processingResultReceived,
  }) {
    return processingResultReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingResultReceived value)?
    processingResultReceived,
  }) {
    return processingResultReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingResultReceived value)? processingResultReceived,
    required TResult orElse(),
  }) {
    if (processingResultReceived != null) {
      return processingResultReceived(this);
    }
    return orElse();
  }
}

abstract class _ProcessingResultReceived
    implements SeparatedRestartableStreamingEventV2 {
  const factory _ProcessingResultReceived(final HybridProcessingResult result) =
      _$ProcessingResultReceivedImpl;

  @override
  HybridProcessingResult get result;

  /// Create a copy of SeparatedRestartableStreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessingResultReceivedImplCopyWith<_$ProcessingResultReceivedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StreamingStateV2 {
  StreamingError? get error => throw _privateConstructorUsedError;
  StreamingStatus get streamingStatus => throw _privateConstructorUsedError;
  ProcessingStatus get processingStatus => throw _privateConstructorUsedError;
  LocalFaceDetectionResult? get faceDetectionResult =>
      throw _privateConstructorUsedError;
  LivenessResult? get livenessResult => throw _privateConstructorUsedError;

  /// Create a copy of StreamingStateV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamingStateV2CopyWith<StreamingStateV2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingStateV2CopyWith<$Res> {
  factory $StreamingStateV2CopyWith(
    StreamingStateV2 value,
    $Res Function(StreamingStateV2) then,
  ) = _$StreamingStateV2CopyWithImpl<$Res, StreamingStateV2>;
  @useResult
  $Res call({
    StreamingError? error,
    StreamingStatus streamingStatus,
    ProcessingStatus processingStatus,
    LocalFaceDetectionResult? faceDetectionResult,
    LivenessResult? livenessResult,
  });

  $StreamingErrorCopyWith<$Res>? get error;
  $LocalFaceDetectionResultCopyWith<$Res>? get faceDetectionResult;
}

/// @nodoc
class _$StreamingStateV2CopyWithImpl<$Res, $Val extends StreamingStateV2>
    implements $StreamingStateV2CopyWith<$Res> {
  _$StreamingStateV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamingStateV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? streamingStatus = null,
    Object? processingStatus = null,
    Object? faceDetectionResult = freezed,
    Object? livenessResult = freezed,
  }) {
    return _then(
      _value.copyWith(
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as StreamingError?,
            streamingStatus:
                null == streamingStatus
                    ? _value.streamingStatus
                    : streamingStatus // ignore: cast_nullable_to_non_nullable
                        as StreamingStatus,
            processingStatus:
                null == processingStatus
                    ? _value.processingStatus
                    : processingStatus // ignore: cast_nullable_to_non_nullable
                        as ProcessingStatus,
            faceDetectionResult:
                freezed == faceDetectionResult
                    ? _value.faceDetectionResult
                    : faceDetectionResult // ignore: cast_nullable_to_non_nullable
                        as LocalFaceDetectionResult?,
            livenessResult:
                freezed == livenessResult
                    ? _value.livenessResult
                    : livenessResult // ignore: cast_nullable_to_non_nullable
                        as LivenessResult?,
          )
          as $Val,
    );
  }

  /// Create a copy of StreamingStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamingErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $StreamingErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }

  /// Create a copy of StreamingStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalFaceDetectionResultCopyWith<$Res>? get faceDetectionResult {
    if (_value.faceDetectionResult == null) {
      return null;
    }

    return $LocalFaceDetectionResultCopyWith<$Res>(
      _value.faceDetectionResult!,
      (value) {
        return _then(_value.copyWith(faceDetectionResult: value) as $Val);
      },
    );
  }
}

/// @nodoc
abstract class _$$StreamingStateV2ImplCopyWith<$Res>
    implements $StreamingStateV2CopyWith<$Res> {
  factory _$$StreamingStateV2ImplCopyWith(
    _$StreamingStateV2Impl value,
    $Res Function(_$StreamingStateV2Impl) then,
  ) = __$$StreamingStateV2ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    StreamingError? error,
    StreamingStatus streamingStatus,
    ProcessingStatus processingStatus,
    LocalFaceDetectionResult? faceDetectionResult,
    LivenessResult? livenessResult,
  });

  @override
  $StreamingErrorCopyWith<$Res>? get error;
  @override
  $LocalFaceDetectionResultCopyWith<$Res>? get faceDetectionResult;
}

/// @nodoc
class __$$StreamingStateV2ImplCopyWithImpl<$Res>
    extends _$StreamingStateV2CopyWithImpl<$Res, _$StreamingStateV2Impl>
    implements _$$StreamingStateV2ImplCopyWith<$Res> {
  __$$StreamingStateV2ImplCopyWithImpl(
    _$StreamingStateV2Impl _value,
    $Res Function(_$StreamingStateV2Impl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingStateV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? streamingStatus = null,
    Object? processingStatus = null,
    Object? faceDetectionResult = freezed,
    Object? livenessResult = freezed,
  }) {
    return _then(
      _$StreamingStateV2Impl(
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as StreamingError?,
        streamingStatus:
            null == streamingStatus
                ? _value.streamingStatus
                : streamingStatus // ignore: cast_nullable_to_non_nullable
                    as StreamingStatus,
        processingStatus:
            null == processingStatus
                ? _value.processingStatus
                : processingStatus // ignore: cast_nullable_to_non_nullable
                    as ProcessingStatus,
        faceDetectionResult:
            freezed == faceDetectionResult
                ? _value.faceDetectionResult
                : faceDetectionResult // ignore: cast_nullable_to_non_nullable
                    as LocalFaceDetectionResult?,
        livenessResult:
            freezed == livenessResult
                ? _value.livenessResult
                : livenessResult // ignore: cast_nullable_to_non_nullable
                    as LivenessResult?,
      ),
    );
  }
}

/// @nodoc

class _$StreamingStateV2Impl extends _StreamingStateV2 {
  const _$StreamingStateV2Impl({
    this.error,
    this.streamingStatus = StreamingStatus.idle,
    this.processingStatus = ProcessingStatus.waitingForFace,
    this.faceDetectionResult,
    this.livenessResult,
  }) : super._();

  @override
  final StreamingError? error;
  @override
  @JsonKey()
  final StreamingStatus streamingStatus;
  @override
  @JsonKey()
  final ProcessingStatus processingStatus;
  @override
  final LocalFaceDetectionResult? faceDetectionResult;
  @override
  final LivenessResult? livenessResult;

  @override
  String toString() {
    return 'StreamingStateV2(error: $error, streamingStatus: $streamingStatus, processingStatus: $processingStatus, faceDetectionResult: $faceDetectionResult, livenessResult: $livenessResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingStateV2Impl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.streamingStatus, streamingStatus) ||
                other.streamingStatus == streamingStatus) &&
            (identical(other.processingStatus, processingStatus) ||
                other.processingStatus == processingStatus) &&
            (identical(other.faceDetectionResult, faceDetectionResult) ||
                other.faceDetectionResult == faceDetectionResult) &&
            (identical(other.livenessResult, livenessResult) ||
                other.livenessResult == livenessResult));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    error,
    streamingStatus,
    processingStatus,
    faceDetectionResult,
    livenessResult,
  );

  /// Create a copy of StreamingStateV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingStateV2ImplCopyWith<_$StreamingStateV2Impl> get copyWith =>
      __$$StreamingStateV2ImplCopyWithImpl<_$StreamingStateV2Impl>(
        this,
        _$identity,
      );
}

abstract class _StreamingStateV2 extends StreamingStateV2 {
  const factory _StreamingStateV2({
    final StreamingError? error,
    final StreamingStatus streamingStatus,
    final ProcessingStatus processingStatus,
    final LocalFaceDetectionResult? faceDetectionResult,
    final LivenessResult? livenessResult,
  }) = _$StreamingStateV2Impl;
  const _StreamingStateV2._() : super._();

  @override
  StreamingError? get error;
  @override
  StreamingStatus get streamingStatus;
  @override
  ProcessingStatus get processingStatus;
  @override
  LocalFaceDetectionResult? get faceDetectionResult;
  @override
  LivenessResult? get livenessResult;

  /// Create a copy of StreamingStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingStateV2ImplCopyWith<_$StreamingStateV2Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
