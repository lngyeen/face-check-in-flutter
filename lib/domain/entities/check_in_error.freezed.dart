// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CheckInError {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) camera,
    required TResult Function(String message) permission,
    required TResult Function(String message, String? details) backend,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? camera,
    TResult? Function(String message)? permission,
    TResult? Function(String message, String? details)? backend,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? camera,
    TResult Function(String message)? permission,
    TResult Function(String message, String? details)? backend,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CameraError value) camera,
    required TResult Function(_PermissionError value) permission,
    required TResult Function(_BackendError value) backend,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CameraError value)? camera,
    TResult? Function(_PermissionError value)? permission,
    TResult? Function(_BackendError value)? backend,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CameraError value)? camera,
    TResult Function(_PermissionError value)? permission,
    TResult Function(_BackendError value)? backend,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInErrorCopyWith<CheckInError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInErrorCopyWith<$Res> {
  factory $CheckInErrorCopyWith(
    CheckInError value,
    $Res Function(CheckInError) then,
  ) = _$CheckInErrorCopyWithImpl<$Res, CheckInError>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$CheckInErrorCopyWithImpl<$Res, $Val extends CheckInError>
    implements $CheckInErrorCopyWith<$Res> {
  _$CheckInErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CameraErrorImplCopyWith<$Res>
    implements $CheckInErrorCopyWith<$Res> {
  factory _$$CameraErrorImplCopyWith(
    _$CameraErrorImpl value,
    $Res Function(_$CameraErrorImpl) then,
  ) = __$$CameraErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CameraErrorImplCopyWithImpl<$Res>
    extends _$CheckInErrorCopyWithImpl<$Res, _$CameraErrorImpl>
    implements _$$CameraErrorImplCopyWith<$Res> {
  __$$CameraErrorImplCopyWithImpl(
    _$CameraErrorImpl _value,
    $Res Function(_$CameraErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CameraErrorImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$CameraErrorImpl implements _CameraError {
  const _$CameraErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CheckInError.camera(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraErrorImplCopyWith<_$CameraErrorImpl> get copyWith =>
      __$$CameraErrorImplCopyWithImpl<_$CameraErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) camera,
    required TResult Function(String message) permission,
    required TResult Function(String message, String? details) backend,
  }) {
    return camera(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? camera,
    TResult? Function(String message)? permission,
    TResult? Function(String message, String? details)? backend,
  }) {
    return camera?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? camera,
    TResult Function(String message)? permission,
    TResult Function(String message, String? details)? backend,
    required TResult orElse(),
  }) {
    if (camera != null) {
      return camera(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CameraError value) camera,
    required TResult Function(_PermissionError value) permission,
    required TResult Function(_BackendError value) backend,
  }) {
    return camera(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CameraError value)? camera,
    TResult? Function(_PermissionError value)? permission,
    TResult? Function(_BackendError value)? backend,
  }) {
    return camera?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CameraError value)? camera,
    TResult Function(_PermissionError value)? permission,
    TResult Function(_BackendError value)? backend,
    required TResult orElse(),
  }) {
    if (camera != null) {
      return camera(this);
    }
    return orElse();
  }
}

abstract class _CameraError implements CheckInError {
  const factory _CameraError({required final String message}) =
      _$CameraErrorImpl;

  @override
  String get message;

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraErrorImplCopyWith<_$CameraErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionErrorImplCopyWith<$Res>
    implements $CheckInErrorCopyWith<$Res> {
  factory _$$PermissionErrorImplCopyWith(
    _$PermissionErrorImpl value,
    $Res Function(_$PermissionErrorImpl) then,
  ) = __$$PermissionErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PermissionErrorImplCopyWithImpl<$Res>
    extends _$CheckInErrorCopyWithImpl<$Res, _$PermissionErrorImpl>
    implements _$$PermissionErrorImplCopyWith<$Res> {
  __$$PermissionErrorImplCopyWithImpl(
    _$PermissionErrorImpl _value,
    $Res Function(_$PermissionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$PermissionErrorImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$PermissionErrorImpl implements _PermissionError {
  const _$PermissionErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CheckInError.permission(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionErrorImplCopyWith<_$PermissionErrorImpl> get copyWith =>
      __$$PermissionErrorImplCopyWithImpl<_$PermissionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) camera,
    required TResult Function(String message) permission,
    required TResult Function(String message, String? details) backend,
  }) {
    return permission(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? camera,
    TResult? Function(String message)? permission,
    TResult? Function(String message, String? details)? backend,
  }) {
    return permission?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? camera,
    TResult Function(String message)? permission,
    TResult Function(String message, String? details)? backend,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CameraError value) camera,
    required TResult Function(_PermissionError value) permission,
    required TResult Function(_BackendError value) backend,
  }) {
    return permission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CameraError value)? camera,
    TResult? Function(_PermissionError value)? permission,
    TResult? Function(_BackendError value)? backend,
  }) {
    return permission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CameraError value)? camera,
    TResult Function(_PermissionError value)? permission,
    TResult Function(_BackendError value)? backend,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(this);
    }
    return orElse();
  }
}

abstract class _PermissionError implements CheckInError {
  const factory _PermissionError({required final String message}) =
      _$PermissionErrorImpl;

  @override
  String get message;

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionErrorImplCopyWith<_$PermissionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackendErrorImplCopyWith<$Res>
    implements $CheckInErrorCopyWith<$Res> {
  factory _$$BackendErrorImplCopyWith(
    _$BackendErrorImpl value,
    $Res Function(_$BackendErrorImpl) then,
  ) = __$$BackendErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? details});
}

/// @nodoc
class __$$BackendErrorImplCopyWithImpl<$Res>
    extends _$CheckInErrorCopyWithImpl<$Res, _$BackendErrorImpl>
    implements _$$BackendErrorImplCopyWith<$Res> {
  __$$BackendErrorImplCopyWithImpl(
    _$BackendErrorImpl _value,
    $Res Function(_$BackendErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? details = freezed}) {
    return _then(
      _$BackendErrorImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        details:
            freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$BackendErrorImpl implements _BackendError {
  const _$BackendErrorImpl({required this.message, this.details});

  @override
  final String message;
  @override
  final String? details;

  @override
  String toString() {
    return 'CheckInError.backend(message: $message, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackendErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.details, details) || other.details == details));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, details);

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BackendErrorImplCopyWith<_$BackendErrorImpl> get copyWith =>
      __$$BackendErrorImplCopyWithImpl<_$BackendErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) camera,
    required TResult Function(String message) permission,
    required TResult Function(String message, String? details) backend,
  }) {
    return backend(message, details);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? camera,
    TResult? Function(String message)? permission,
    TResult? Function(String message, String? details)? backend,
  }) {
    return backend?.call(message, details);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? camera,
    TResult Function(String message)? permission,
    TResult Function(String message, String? details)? backend,
    required TResult orElse(),
  }) {
    if (backend != null) {
      return backend(message, details);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CameraError value) camera,
    required TResult Function(_PermissionError value) permission,
    required TResult Function(_BackendError value) backend,
  }) {
    return backend(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CameraError value)? camera,
    TResult? Function(_PermissionError value)? permission,
    TResult? Function(_BackendError value)? backend,
  }) {
    return backend?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CameraError value)? camera,
    TResult Function(_PermissionError value)? permission,
    TResult Function(_BackendError value)? backend,
    required TResult orElse(),
  }) {
    if (backend != null) {
      return backend(this);
    }
    return orElse();
  }
}

abstract class _BackendError implements CheckInError {
  const factory _BackendError({
    required final String message,
    final String? details,
  }) = _$BackendErrorImpl;

  @override
  String get message;
  String? get details;

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BackendErrorImplCopyWith<_$BackendErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
