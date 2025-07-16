// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StatusUpdate {
  String get message => throw _privateConstructorUsedError;
  StatusType get type => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError;
  bool? get dismissible => throw _privateConstructorUsedError;

  /// Create a copy of StatusUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusUpdateCopyWith<StatusUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusUpdateCopyWith<$Res> {
  factory $StatusUpdateCopyWith(
    StatusUpdate value,
    $Res Function(StatusUpdate) then,
  ) = _$StatusUpdateCopyWithImpl<$Res, StatusUpdate>;
  @useResult
  $Res call({
    String message,
    StatusType type,
    Duration? duration,
    bool? dismissible,
  });
}

/// @nodoc
class _$StatusUpdateCopyWithImpl<$Res, $Val extends StatusUpdate>
    implements $StatusUpdateCopyWith<$Res> {
  _$StatusUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? duration = freezed,
    Object? dismissible = freezed,
  }) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as StatusType,
            duration:
                freezed == duration
                    ? _value.duration
                    : duration // ignore: cast_nullable_to_non_nullable
                        as Duration?,
            dismissible:
                freezed == dismissible
                    ? _value.dismissible
                    : dismissible // ignore: cast_nullable_to_non_nullable
                        as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StatusUpdateImplCopyWith<$Res>
    implements $StatusUpdateCopyWith<$Res> {
  factory _$$StatusUpdateImplCopyWith(
    _$StatusUpdateImpl value,
    $Res Function(_$StatusUpdateImpl) then,
  ) = __$$StatusUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    StatusType type,
    Duration? duration,
    bool? dismissible,
  });
}

/// @nodoc
class __$$StatusUpdateImplCopyWithImpl<$Res>
    extends _$StatusUpdateCopyWithImpl<$Res, _$StatusUpdateImpl>
    implements _$$StatusUpdateImplCopyWith<$Res> {
  __$$StatusUpdateImplCopyWithImpl(
    _$StatusUpdateImpl _value,
    $Res Function(_$StatusUpdateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatusUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? duration = freezed,
    Object? dismissible = freezed,
  }) {
    return _then(
      _$StatusUpdateImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as StatusType,
        duration:
            freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                    as Duration?,
        dismissible:
            freezed == dismissible
                ? _value.dismissible
                : dismissible // ignore: cast_nullable_to_non_nullable
                    as bool?,
      ),
    );
  }
}

/// @nodoc

class _$StatusUpdateImpl extends _StatusUpdate {
  const _$StatusUpdateImpl({
    required this.message,
    required this.type,
    this.duration,
    this.dismissible,
  }) : super._();

  @override
  final String message;
  @override
  final StatusType type;
  @override
  final Duration? duration;
  @override
  final bool? dismissible;

  @override
  String toString() {
    return 'StatusUpdate(message: $message, type: $type, duration: $duration, dismissible: $dismissible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusUpdateImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.dismissible, dismissible) ||
                other.dismissible == dismissible));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, type, duration, dismissible);

  /// Create a copy of StatusUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusUpdateImplCopyWith<_$StatusUpdateImpl> get copyWith =>
      __$$StatusUpdateImplCopyWithImpl<_$StatusUpdateImpl>(this, _$identity);
}

abstract class _StatusUpdate extends StatusUpdate {
  const factory _StatusUpdate({
    required final String message,
    required final StatusType type,
    final Duration? duration,
    final bool? dismissible,
  }) = _$StatusUpdateImpl;
  const _StatusUpdate._() : super._();

  @override
  String get message;
  @override
  StatusType get type;
  @override
  Duration? get duration;
  @override
  bool? get dismissible;

  /// Create a copy of StatusUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusUpdateImplCopyWith<_$StatusUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
