// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_bloc_v2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CameraEventV2 {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(CameraStatus status) statusChanged,
    required TResult Function(CameraController? controller) controllerChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(CameraStatus status)? statusChanged,
    TResult? Function(CameraController? controller)? controllerChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(CameraStatus status)? statusChanged,
    TResult Function(CameraController? controller)? controllerChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(CameraStatusChanged value) statusChanged,
    required TResult Function(CameraControllerChanged value) controllerChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(CameraStatusChanged value)? statusChanged,
    TResult? Function(CameraControllerChanged value)? controllerChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(CameraStatusChanged value)? statusChanged,
    TResult Function(CameraControllerChanged value)? controllerChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraEventV2CopyWith<$Res> {
  factory $CameraEventV2CopyWith(
    CameraEventV2 value,
    $Res Function(CameraEventV2) then,
  ) = _$CameraEventV2CopyWithImpl<$Res, CameraEventV2>;
}

/// @nodoc
class _$CameraEventV2CopyWithImpl<$Res, $Val extends CameraEventV2>
    implements $CameraEventV2CopyWith<$Res> {
  _$CameraEventV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartCameraImplCopyWith<$Res> {
  factory _$$StartCameraImplCopyWith(
    _$StartCameraImpl value,
    $Res Function(_$StartCameraImpl) then,
  ) = __$$StartCameraImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartCameraImplCopyWithImpl<$Res>
    extends _$CameraEventV2CopyWithImpl<$Res, _$StartCameraImpl>
    implements _$$StartCameraImplCopyWith<$Res> {
  __$$StartCameraImplCopyWithImpl(
    _$StartCameraImpl _value,
    $Res Function(_$StartCameraImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartCameraImpl implements StartCamera {
  const _$StartCameraImpl();

  @override
  String toString() {
    return 'CameraEventV2.startCamera()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartCameraImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(CameraStatus status) statusChanged,
    required TResult Function(CameraController? controller) controllerChanged,
  }) {
    return startCamera();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(CameraStatus status)? statusChanged,
    TResult? Function(CameraController? controller)? controllerChanged,
  }) {
    return startCamera?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(CameraStatus status)? statusChanged,
    TResult Function(CameraController? controller)? controllerChanged,
    required TResult orElse(),
  }) {
    if (startCamera != null) {
      return startCamera();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(CameraStatusChanged value) statusChanged,
    required TResult Function(CameraControllerChanged value) controllerChanged,
  }) {
    return startCamera(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(CameraStatusChanged value)? statusChanged,
    TResult? Function(CameraControllerChanged value)? controllerChanged,
  }) {
    return startCamera?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(CameraStatusChanged value)? statusChanged,
    TResult Function(CameraControllerChanged value)? controllerChanged,
    required TResult orElse(),
  }) {
    if (startCamera != null) {
      return startCamera(this);
    }
    return orElse();
  }
}

abstract class StartCamera implements CameraEventV2 {
  const factory StartCamera() = _$StartCameraImpl;
}

/// @nodoc
abstract class _$$StopCameraImplCopyWith<$Res> {
  factory _$$StopCameraImplCopyWith(
    _$StopCameraImpl value,
    $Res Function(_$StopCameraImpl) then,
  ) = __$$StopCameraImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopCameraImplCopyWithImpl<$Res>
    extends _$CameraEventV2CopyWithImpl<$Res, _$StopCameraImpl>
    implements _$$StopCameraImplCopyWith<$Res> {
  __$$StopCameraImplCopyWithImpl(
    _$StopCameraImpl _value,
    $Res Function(_$StopCameraImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopCameraImpl implements StopCamera {
  const _$StopCameraImpl();

  @override
  String toString() {
    return 'CameraEventV2.stopCamera()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StopCameraImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(CameraStatus status) statusChanged,
    required TResult Function(CameraController? controller) controllerChanged,
  }) {
    return stopCamera();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(CameraStatus status)? statusChanged,
    TResult? Function(CameraController? controller)? controllerChanged,
  }) {
    return stopCamera?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(CameraStatus status)? statusChanged,
    TResult Function(CameraController? controller)? controllerChanged,
    required TResult orElse(),
  }) {
    if (stopCamera != null) {
      return stopCamera();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(CameraStatusChanged value) statusChanged,
    required TResult Function(CameraControllerChanged value) controllerChanged,
  }) {
    return stopCamera(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(CameraStatusChanged value)? statusChanged,
    TResult? Function(CameraControllerChanged value)? controllerChanged,
  }) {
    return stopCamera?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(CameraStatusChanged value)? statusChanged,
    TResult Function(CameraControllerChanged value)? controllerChanged,
    required TResult orElse(),
  }) {
    if (stopCamera != null) {
      return stopCamera(this);
    }
    return orElse();
  }
}

abstract class StopCamera implements CameraEventV2 {
  const factory StopCamera() = _$StopCameraImpl;
}

/// @nodoc
abstract class _$$CameraStatusChangedImplCopyWith<$Res> {
  factory _$$CameraStatusChangedImplCopyWith(
    _$CameraStatusChangedImpl value,
    $Res Function(_$CameraStatusChangedImpl) then,
  ) = __$$CameraStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CameraStatus status});
}

/// @nodoc
class __$$CameraStatusChangedImplCopyWithImpl<$Res>
    extends _$CameraEventV2CopyWithImpl<$Res, _$CameraStatusChangedImpl>
    implements _$$CameraStatusChangedImplCopyWith<$Res> {
  __$$CameraStatusChangedImplCopyWithImpl(
    _$CameraStatusChangedImpl _value,
    $Res Function(_$CameraStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$CameraStatusChangedImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                as CameraStatus,
      ),
    );
  }
}

/// @nodoc

class _$CameraStatusChangedImpl implements CameraStatusChanged {
  const _$CameraStatusChangedImpl(this.status);

  @override
  final CameraStatus status;

  @override
  String toString() {
    return 'CameraEventV2.statusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraStatusChangedImplCopyWith<_$CameraStatusChangedImpl> get copyWith =>
      __$$CameraStatusChangedImplCopyWithImpl<_$CameraStatusChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(CameraStatus status) statusChanged,
    required TResult Function(CameraController? controller) controllerChanged,
  }) {
    return statusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(CameraStatus status)? statusChanged,
    TResult? Function(CameraController? controller)? controllerChanged,
  }) {
    return statusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(CameraStatus status)? statusChanged,
    TResult Function(CameraController? controller)? controllerChanged,
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
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(CameraStatusChanged value) statusChanged,
    required TResult Function(CameraControllerChanged value) controllerChanged,
  }) {
    return statusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(CameraStatusChanged value)? statusChanged,
    TResult? Function(CameraControllerChanged value)? controllerChanged,
  }) {
    return statusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(CameraStatusChanged value)? statusChanged,
    TResult Function(CameraControllerChanged value)? controllerChanged,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(this);
    }
    return orElse();
  }
}

abstract class CameraStatusChanged implements CameraEventV2 {
  const factory CameraStatusChanged(final CameraStatus status) =
      _$CameraStatusChangedImpl;

  CameraStatus get status;

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraStatusChangedImplCopyWith<_$CameraStatusChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraControllerChangedImplCopyWith<$Res> {
  factory _$$CameraControllerChangedImplCopyWith(
    _$CameraControllerChangedImpl value,
    $Res Function(_$CameraControllerChangedImpl) then,
  ) = __$$CameraControllerChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CameraController? controller});
}

/// @nodoc
class __$$CameraControllerChangedImplCopyWithImpl<$Res>
    extends _$CameraEventV2CopyWithImpl<$Res, _$CameraControllerChangedImpl>
    implements _$$CameraControllerChangedImplCopyWith<$Res> {
  __$$CameraControllerChangedImplCopyWithImpl(
    _$CameraControllerChangedImpl _value,
    $Res Function(_$CameraControllerChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? controller = freezed}) {
    return _then(
      _$CameraControllerChangedImpl(
        freezed == controller
            ? _value.controller
            : controller // ignore: cast_nullable_to_non_nullable
                as CameraController?,
      ),
    );
  }
}

/// @nodoc

class _$CameraControllerChangedImpl implements CameraControllerChanged {
  const _$CameraControllerChangedImpl(this.controller);

  @override
  final CameraController? controller;

  @override
  String toString() {
    return 'CameraEventV2.controllerChanged(controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraControllerChangedImpl &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, controller);

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraControllerChangedImplCopyWith<_$CameraControllerChangedImpl>
  get copyWith => __$$CameraControllerChangedImplCopyWithImpl<
    _$CameraControllerChangedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(CameraStatus status) statusChanged,
    required TResult Function(CameraController? controller) controllerChanged,
  }) {
    return controllerChanged(controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(CameraStatus status)? statusChanged,
    TResult? Function(CameraController? controller)? controllerChanged,
  }) {
    return controllerChanged?.call(controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(CameraStatus status)? statusChanged,
    TResult Function(CameraController? controller)? controllerChanged,
    required TResult orElse(),
  }) {
    if (controllerChanged != null) {
      return controllerChanged(controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(CameraStatusChanged value) statusChanged,
    required TResult Function(CameraControllerChanged value) controllerChanged,
  }) {
    return controllerChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(CameraStatusChanged value)? statusChanged,
    TResult? Function(CameraControllerChanged value)? controllerChanged,
  }) {
    return controllerChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(CameraStatusChanged value)? statusChanged,
    TResult Function(CameraControllerChanged value)? controllerChanged,
    required TResult orElse(),
  }) {
    if (controllerChanged != null) {
      return controllerChanged(this);
    }
    return orElse();
  }
}

abstract class CameraControllerChanged implements CameraEventV2 {
  const factory CameraControllerChanged(final CameraController? controller) =
      _$CameraControllerChangedImpl;

  CameraController? get controller;

  /// Create a copy of CameraEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraControllerChangedImplCopyWith<_$CameraControllerChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CameraStateV2 {
  CameraController? get controller => throw _privateConstructorUsedError;
  CameraStatus get status => throw _privateConstructorUsedError;
  CameraError? get error => throw _privateConstructorUsedError;

  /// Create a copy of CameraStateV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CameraStateV2CopyWith<CameraStateV2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraStateV2CopyWith<$Res> {
  factory $CameraStateV2CopyWith(
    CameraStateV2 value,
    $Res Function(CameraStateV2) then,
  ) = _$CameraStateV2CopyWithImpl<$Res, CameraStateV2>;
  @useResult
  $Res call({
    CameraController? controller,
    CameraStatus status,
    CameraError? error,
  });

  $CameraErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$CameraStateV2CopyWithImpl<$Res, $Val extends CameraStateV2>
    implements $CameraStateV2CopyWith<$Res> {
  _$CameraStateV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CameraStateV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
    Object? status = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            controller:
                freezed == controller
                    ? _value.controller
                    : controller // ignore: cast_nullable_to_non_nullable
                        as CameraController?,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as CameraStatus,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as CameraError?,
          )
          as $Val,
    );
  }

  /// Create a copy of CameraStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CameraErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $CameraErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CameraStateV2ImplCopyWith<$Res>
    implements $CameraStateV2CopyWith<$Res> {
  factory _$$CameraStateV2ImplCopyWith(
    _$CameraStateV2Impl value,
    $Res Function(_$CameraStateV2Impl) then,
  ) = __$$CameraStateV2ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CameraController? controller,
    CameraStatus status,
    CameraError? error,
  });

  @override
  $CameraErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$CameraStateV2ImplCopyWithImpl<$Res>
    extends _$CameraStateV2CopyWithImpl<$Res, _$CameraStateV2Impl>
    implements _$$CameraStateV2ImplCopyWith<$Res> {
  __$$CameraStateV2ImplCopyWithImpl(
    _$CameraStateV2Impl _value,
    $Res Function(_$CameraStateV2Impl) _then,
  ) : super(_value, _then);

  /// Create a copy of CameraStateV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
    Object? status = null,
    Object? error = freezed,
  }) {
    return _then(
      _$CameraStateV2Impl(
        controller:
            freezed == controller
                ? _value.controller
                : controller // ignore: cast_nullable_to_non_nullable
                    as CameraController?,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as CameraStatus,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as CameraError?,
      ),
    );
  }
}

/// @nodoc

class _$CameraStateV2Impl extends _CameraStateV2 {
  const _$CameraStateV2Impl({
    this.controller,
    this.status = CameraStatus.initial,
    this.error,
  }) : super._();

  @override
  final CameraController? controller;
  @override
  @JsonKey()
  final CameraStatus status;
  @override
  final CameraError? error;

  @override
  String toString() {
    return 'CameraStateV2(controller: $controller, status: $status, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraStateV2Impl &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, controller, status, error);

  /// Create a copy of CameraStateV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraStateV2ImplCopyWith<_$CameraStateV2Impl> get copyWith =>
      __$$CameraStateV2ImplCopyWithImpl<_$CameraStateV2Impl>(this, _$identity);
}

abstract class _CameraStateV2 extends CameraStateV2 {
  const factory _CameraStateV2({
    final CameraController? controller,
    final CameraStatus status,
    final CameraError? error,
  }) = _$CameraStateV2Impl;
  const _CameraStateV2._() : super._();

  @override
  CameraController? get controller;
  @override
  CameraStatus get status;
  @override
  CameraError? get error;

  /// Create a copy of CameraStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraStateV2ImplCopyWith<_$CameraStateV2Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
