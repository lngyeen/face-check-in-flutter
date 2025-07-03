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
mixin _$StreamingEventV2 {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraController controller) startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(StreamingStatus status) statusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraController controller)? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(StreamingStatus status)? statusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraController controller)? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int fps)? setMaxFps,
    TResult Function(StreamingStatus status)? statusChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartStreaming value) startStreaming,
    required TResult Function(_StopStreaming value) stopStreaming,
    required TResult Function(_SetMaxFps value) setMaxFps,
    required TResult Function(_StatusChanged value) statusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartStreaming value)? startStreaming,
    TResult? Function(_StopStreaming value)? stopStreaming,
    TResult? Function(_SetMaxFps value)? setMaxFps,
    TResult? Function(_StatusChanged value)? statusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartStreaming value)? startStreaming,
    TResult Function(_StopStreaming value)? stopStreaming,
    TResult Function(_SetMaxFps value)? setMaxFps,
    TResult Function(_StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingEventV2CopyWith<$Res> {
  factory $StreamingEventV2CopyWith(
    StreamingEventV2 value,
    $Res Function(StreamingEventV2) then,
  ) = _$StreamingEventV2CopyWithImpl<$Res, StreamingEventV2>;
}

/// @nodoc
class _$StreamingEventV2CopyWithImpl<$Res, $Val extends StreamingEventV2>
    implements $StreamingEventV2CopyWith<$Res> {
  _$StreamingEventV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamingEventV2
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
    extends _$StreamingEventV2CopyWithImpl<$Res, _$StartStreamingImpl>
    implements _$$StartStreamingImplCopyWith<$Res> {
  __$$StartStreamingImplCopyWithImpl(
    _$StartStreamingImpl _value,
    $Res Function(_$StartStreamingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingEventV2
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
    return 'StreamingEventV2.startStreaming(controller: $controller)';
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

  /// Create a copy of StreamingEventV2
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
    required TResult Function(int fps) setMaxFps,
    required TResult Function(StreamingStatus status) statusChanged,
  }) {
    return startStreaming(controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraController controller)? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(StreamingStatus status)? statusChanged,
  }) {
    return startStreaming?.call(controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraController controller)? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int fps)? setMaxFps,
    TResult Function(StreamingStatus status)? statusChanged,
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
    required TResult Function(_SetMaxFps value) setMaxFps,
    required TResult Function(_StatusChanged value) statusChanged,
  }) {
    return startStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartStreaming value)? startStreaming,
    TResult? Function(_StopStreaming value)? stopStreaming,
    TResult? Function(_SetMaxFps value)? setMaxFps,
    TResult? Function(_StatusChanged value)? statusChanged,
  }) {
    return startStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartStreaming value)? startStreaming,
    TResult Function(_StopStreaming value)? stopStreaming,
    TResult Function(_SetMaxFps value)? setMaxFps,
    TResult Function(_StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (startStreaming != null) {
      return startStreaming(this);
    }
    return orElse();
  }
}

abstract class _StartStreaming implements StreamingEventV2 {
  const factory _StartStreaming(final CameraController controller) =
      _$StartStreamingImpl;

  CameraController get controller;

  /// Create a copy of StreamingEventV2
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
    extends _$StreamingEventV2CopyWithImpl<$Res, _$StopStreamingImpl>
    implements _$$StopStreamingImplCopyWith<$Res> {
  __$$StopStreamingImplCopyWithImpl(
    _$StopStreamingImpl _value,
    $Res Function(_$StopStreamingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopStreamingImpl implements _StopStreaming {
  const _$StopStreamingImpl();

  @override
  String toString() {
    return 'StreamingEventV2.stopStreaming()';
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
    required TResult Function(int fps) setMaxFps,
    required TResult Function(StreamingStatus status) statusChanged,
  }) {
    return stopStreaming();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraController controller)? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(StreamingStatus status)? statusChanged,
  }) {
    return stopStreaming?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraController controller)? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int fps)? setMaxFps,
    TResult Function(StreamingStatus status)? statusChanged,
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
    required TResult Function(_SetMaxFps value) setMaxFps,
    required TResult Function(_StatusChanged value) statusChanged,
  }) {
    return stopStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartStreaming value)? startStreaming,
    TResult? Function(_StopStreaming value)? stopStreaming,
    TResult? Function(_SetMaxFps value)? setMaxFps,
    TResult? Function(_StatusChanged value)? statusChanged,
  }) {
    return stopStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartStreaming value)? startStreaming,
    TResult Function(_StopStreaming value)? stopStreaming,
    TResult Function(_SetMaxFps value)? setMaxFps,
    TResult Function(_StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (stopStreaming != null) {
      return stopStreaming(this);
    }
    return orElse();
  }
}

abstract class _StopStreaming implements StreamingEventV2 {
  const factory _StopStreaming() = _$StopStreamingImpl;
}

/// @nodoc
abstract class _$$SetMaxFpsImplCopyWith<$Res> {
  factory _$$SetMaxFpsImplCopyWith(
    _$SetMaxFpsImpl value,
    $Res Function(_$SetMaxFpsImpl) then,
  ) = __$$SetMaxFpsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int fps});
}

/// @nodoc
class __$$SetMaxFpsImplCopyWithImpl<$Res>
    extends _$StreamingEventV2CopyWithImpl<$Res, _$SetMaxFpsImpl>
    implements _$$SetMaxFpsImplCopyWith<$Res> {
  __$$SetMaxFpsImplCopyWithImpl(
    _$SetMaxFpsImpl _value,
    $Res Function(_$SetMaxFpsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fps = null}) {
    return _then(
      _$SetMaxFpsImpl(
        null == fps
            ? _value.fps
            : fps // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$SetMaxFpsImpl implements _SetMaxFps {
  const _$SetMaxFpsImpl(this.fps);

  @override
  final int fps;

  @override
  String toString() {
    return 'StreamingEventV2.setMaxFps(fps: $fps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetMaxFpsImpl &&
            (identical(other.fps, fps) || other.fps == fps));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fps);

  /// Create a copy of StreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetMaxFpsImplCopyWith<_$SetMaxFpsImpl> get copyWith =>
      __$$SetMaxFpsImplCopyWithImpl<_$SetMaxFpsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraController controller) startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(StreamingStatus status) statusChanged,
  }) {
    return setMaxFps(fps);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraController controller)? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(StreamingStatus status)? statusChanged,
  }) {
    return setMaxFps?.call(fps);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraController controller)? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int fps)? setMaxFps,
    TResult Function(StreamingStatus status)? statusChanged,
    required TResult orElse(),
  }) {
    if (setMaxFps != null) {
      return setMaxFps(fps);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartStreaming value) startStreaming,
    required TResult Function(_StopStreaming value) stopStreaming,
    required TResult Function(_SetMaxFps value) setMaxFps,
    required TResult Function(_StatusChanged value) statusChanged,
  }) {
    return setMaxFps(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartStreaming value)? startStreaming,
    TResult? Function(_StopStreaming value)? stopStreaming,
    TResult? Function(_SetMaxFps value)? setMaxFps,
    TResult? Function(_StatusChanged value)? statusChanged,
  }) {
    return setMaxFps?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartStreaming value)? startStreaming,
    TResult Function(_StopStreaming value)? stopStreaming,
    TResult Function(_SetMaxFps value)? setMaxFps,
    TResult Function(_StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (setMaxFps != null) {
      return setMaxFps(this);
    }
    return orElse();
  }
}

abstract class _SetMaxFps implements StreamingEventV2 {
  const factory _SetMaxFps(final int fps) = _$SetMaxFpsImpl;

  int get fps;

  /// Create a copy of StreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetMaxFpsImplCopyWith<_$SetMaxFpsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusChangedImplCopyWith<$Res> {
  factory _$$StatusChangedImplCopyWith(
    _$StatusChangedImpl value,
    $Res Function(_$StatusChangedImpl) then,
  ) = __$$StatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StreamingStatus status});
}

/// @nodoc
class __$$StatusChangedImplCopyWithImpl<$Res>
    extends _$StreamingEventV2CopyWithImpl<$Res, _$StatusChangedImpl>
    implements _$$StatusChangedImplCopyWith<$Res> {
  __$$StatusChangedImplCopyWithImpl(
    _$StatusChangedImpl _value,
    $Res Function(_$StatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$StatusChangedImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                as StreamingStatus,
      ),
    );
  }
}

/// @nodoc

class _$StatusChangedImpl implements _StatusChanged {
  const _$StatusChangedImpl(this.status);

  @override
  final StreamingStatus status;

  @override
  String toString() {
    return 'StreamingEventV2.statusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of StreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusChangedImplCopyWith<_$StatusChangedImpl> get copyWith =>
      __$$StatusChangedImplCopyWithImpl<_$StatusChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraController controller) startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(StreamingStatus status) statusChanged,
  }) {
    return statusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraController controller)? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(StreamingStatus status)? statusChanged,
  }) {
    return statusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraController controller)? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int fps)? setMaxFps,
    TResult Function(StreamingStatus status)? statusChanged,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartStreaming value) startStreaming,
    required TResult Function(_StopStreaming value) stopStreaming,
    required TResult Function(_SetMaxFps value) setMaxFps,
    required TResult Function(_StatusChanged value) statusChanged,
  }) {
    return statusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartStreaming value)? startStreaming,
    TResult? Function(_StopStreaming value)? stopStreaming,
    TResult? Function(_SetMaxFps value)? setMaxFps,
    TResult? Function(_StatusChanged value)? statusChanged,
  }) {
    return statusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartStreaming value)? startStreaming,
    TResult Function(_StopStreaming value)? stopStreaming,
    TResult Function(_SetMaxFps value)? setMaxFps,
    TResult Function(_StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(this);
    }
    return orElse();
  }
}

abstract class _StatusChanged implements StreamingEventV2 {
  const factory _StatusChanged(final StreamingStatus status) =
      _$StatusChangedImpl;

  StreamingStatus get status;

  /// Create a copy of StreamingEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusChangedImplCopyWith<_$StatusChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StreamingStateV2 {
  StreamingStatus get status => throw _privateConstructorUsedError;
  int get maxFps => throw _privateConstructorUsedError;
  StreamingError? get error => throw _privateConstructorUsedError;

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
  $Res call({StreamingStatus status, int maxFps, StreamingError? error});

  $StreamingErrorCopyWith<$Res>? get error;
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
    Object? status = null,
    Object? maxFps = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as StreamingStatus,
            maxFps:
                null == maxFps
                    ? _value.maxFps
                    : maxFps // ignore: cast_nullable_to_non_nullable
                        as int,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as StreamingError?,
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
  $Res call({StreamingStatus status, int maxFps, StreamingError? error});

  @override
  $StreamingErrorCopyWith<$Res>? get error;
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
    Object? status = null,
    Object? maxFps = null,
    Object? error = freezed,
  }) {
    return _then(
      _$StreamingStateV2Impl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as StreamingStatus,
        maxFps:
            null == maxFps
                ? _value.maxFps
                : maxFps // ignore: cast_nullable_to_non_nullable
                    as int,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as StreamingError?,
      ),
    );
  }
}

/// @nodoc

class _$StreamingStateV2Impl extends _StreamingStateV2 {
  const _$StreamingStateV2Impl({
    this.status = StreamingStatus.idle,
    this.maxFps = 2,
    this.error,
  }) : super._();

  @override
  @JsonKey()
  final StreamingStatus status;
  @override
  @JsonKey()
  final int maxFps;
  @override
  final StreamingError? error;

  @override
  String toString() {
    return 'StreamingStateV2(status: $status, maxFps: $maxFps, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingStateV2Impl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.maxFps, maxFps) || other.maxFps == maxFps) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, maxFps, error);

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
    final StreamingStatus status,
    final int maxFps,
    final StreamingError? error,
  }) = _$StreamingStateV2Impl;
  const _StreamingStateV2._() : super._();

  @override
  StreamingStatus get status;
  @override
  int get maxFps;
  @override
  StreamingError? get error;

  /// Create a copy of StreamingStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingStateV2ImplCopyWith<_$StreamingStateV2Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
