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
mixin _$BackendError {
  String get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of BackendError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BackendErrorCopyWith<BackendError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackendErrorCopyWith<$Res> {
  factory $BackendErrorCopyWith(
    BackendError value,
    $Res Function(BackendError) then,
  ) = _$BackendErrorCopyWithImpl<$Res, BackendError>;
  @useResult
  $Res call({String error, String? message});
}

/// @nodoc
class _$BackendErrorCopyWithImpl<$Res, $Val extends BackendError>
    implements $BackendErrorCopyWith<$Res> {
  _$BackendErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BackendError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? message = freezed}) {
    return _then(
      _value.copyWith(
            error:
                null == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BackendErrorImplCopyWith<$Res>
    implements $BackendErrorCopyWith<$Res> {
  factory _$$BackendErrorImplCopyWith(
    _$BackendErrorImpl value,
    $Res Function(_$BackendErrorImpl) then,
  ) = __$$BackendErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String error, String? message});
}

/// @nodoc
class __$$BackendErrorImplCopyWithImpl<$Res>
    extends _$BackendErrorCopyWithImpl<$Res, _$BackendErrorImpl>
    implements _$$BackendErrorImplCopyWith<$Res> {
  __$$BackendErrorImplCopyWithImpl(
    _$BackendErrorImpl _value,
    $Res Function(_$BackendErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BackendError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? message = freezed}) {
    return _then(
      _$BackendErrorImpl(
        error:
            null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$BackendErrorImpl implements _BackendError {
  const _$BackendErrorImpl({required this.error, this.message});

  @override
  final String error;
  @override
  final String? message;

  @override
  String toString() {
    return 'BackendError(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackendErrorImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  /// Create a copy of BackendError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BackendErrorImplCopyWith<_$BackendErrorImpl> get copyWith =>
      __$$BackendErrorImplCopyWithImpl<_$BackendErrorImpl>(this, _$identity);
}

abstract class _BackendError implements BackendError {
  const factory _BackendError({
    required final String error,
    final String? message,
  }) = _$BackendErrorImpl;

  @override
  String get error;
  @override
  String? get message;

  /// Create a copy of BackendError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BackendErrorImplCopyWith<_$BackendErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CheckInError {
  String get message => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  CheckInErrorType get type => throw _privateConstructorUsedError;

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
  $Res call({String message, String? details, CheckInErrorType type});
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
  $Res call({
    Object? message = null,
    Object? details = freezed,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
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
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as CheckInErrorType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CheckInErrorImplCopyWith<$Res>
    implements $CheckInErrorCopyWith<$Res> {
  factory _$$CheckInErrorImplCopyWith(
    _$CheckInErrorImpl value,
    $Res Function(_$CheckInErrorImpl) then,
  ) = __$$CheckInErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? details, CheckInErrorType type});
}

/// @nodoc
class __$$CheckInErrorImplCopyWithImpl<$Res>
    extends _$CheckInErrorCopyWithImpl<$Res, _$CheckInErrorImpl>
    implements _$$CheckInErrorImplCopyWith<$Res> {
  __$$CheckInErrorImplCopyWithImpl(
    _$CheckInErrorImpl _value,
    $Res Function(_$CheckInErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? details = freezed,
    Object? type = null,
  }) {
    return _then(
      _$CheckInErrorImpl(
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
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as CheckInErrorType,
      ),
    );
  }
}

/// @nodoc

class _$CheckInErrorImpl implements _CheckInError {
  const _$CheckInErrorImpl({
    required this.message,
    this.details,
    this.type = CheckInErrorType.general,
  });

  @override
  final String message;
  @override
  final String? details;
  @override
  @JsonKey()
  final CheckInErrorType type;

  @override
  String toString() {
    return 'CheckInError(message: $message, details: $details, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, details, type);

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInErrorImplCopyWith<_$CheckInErrorImpl> get copyWith =>
      __$$CheckInErrorImplCopyWithImpl<_$CheckInErrorImpl>(this, _$identity);
}

abstract class _CheckInError implements CheckInError {
  const factory _CheckInError({
    required final String message,
    final String? details,
    final CheckInErrorType type,
  }) = _$CheckInErrorImpl;

  @override
  String get message;
  @override
  String? get details;
  @override
  CheckInErrorType get type;

  /// Create a copy of CheckInError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInErrorImplCopyWith<_$CheckInErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
