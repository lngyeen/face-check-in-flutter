// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConnectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() disconnect,
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? disconnect,
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? disconnect,
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(Disconnect value) disconnect,
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(Disconnect value)? disconnect,
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(Disconnect value)? disconnect,
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionEventCopyWith<$Res> {
  factory $ConnectionEventCopyWith(
    ConnectionEvent value,
    $Res Function(ConnectionEvent) then,
  ) = _$ConnectionEventCopyWithImpl<$Res, ConnectionEvent>;
}

/// @nodoc
class _$ConnectionEventCopyWithImpl<$Res, $Val extends ConnectionEvent>
    implements $ConnectionEventCopyWith<$Res> {
  _$ConnectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializeImplCopyWith<$Res> {
  factory _$$InitializeImplCopyWith(
    _$InitializeImpl value,
    $Res Function(_$InitializeImpl) then,
  ) = __$$InitializeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializeImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$InitializeImpl>
    implements _$$InitializeImplCopyWith<$Res> {
  __$$InitializeImplCopyWithImpl(
    _$InitializeImpl _value,
    $Res Function(_$InitializeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitializeImpl implements Initialize {
  const _$InitializeImpl();

  @override
  String toString() {
    return 'ConnectionEvent.initialize()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitializeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() disconnect,
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? disconnect,
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? disconnect,
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(Disconnect value) disconnect,
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(Disconnect value)? disconnect,
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(Disconnect value)? disconnect,
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class Initialize implements ConnectionEvent {
  const factory Initialize() = _$InitializeImpl;
}

/// @nodoc
abstract class _$$RetryConnectionImplCopyWith<$Res> {
  factory _$$RetryConnectionImplCopyWith(
    _$RetryConnectionImpl value,
    $Res Function(_$RetryConnectionImpl) then,
  ) = __$$RetryConnectionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RetryConnectionImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$RetryConnectionImpl>
    implements _$$RetryConnectionImplCopyWith<$Res> {
  __$$RetryConnectionImplCopyWithImpl(
    _$RetryConnectionImpl _value,
    $Res Function(_$RetryConnectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RetryConnectionImpl implements RetryConnection {
  const _$RetryConnectionImpl();

  @override
  String toString() {
    return 'ConnectionEvent.retryConnection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RetryConnectionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() disconnect,
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
  }) {
    return retryConnection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? disconnect,
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
  }) {
    return retryConnection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? disconnect,
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    required TResult orElse(),
  }) {
    if (retryConnection != null) {
      return retryConnection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(Disconnect value) disconnect,
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
  }) {
    return retryConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(Disconnect value)? disconnect,
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
  }) {
    return retryConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(Disconnect value)? disconnect,
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    required TResult orElse(),
  }) {
    if (retryConnection != null) {
      return retryConnection(this);
    }
    return orElse();
  }
}

abstract class RetryConnection implements ConnectionEvent {
  const factory RetryConnection() = _$RetryConnectionImpl;
}

/// @nodoc
abstract class _$$DisconnectImplCopyWith<$Res> {
  factory _$$DisconnectImplCopyWith(
    _$DisconnectImpl value,
    $Res Function(_$DisconnectImpl) then,
  ) = __$$DisconnectImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisconnectImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$DisconnectImpl>
    implements _$$DisconnectImplCopyWith<$Res> {
  __$$DisconnectImplCopyWithImpl(
    _$DisconnectImpl _value,
    $Res Function(_$DisconnectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DisconnectImpl implements Disconnect {
  const _$DisconnectImpl();

  @override
  String toString() {
    return 'ConnectionEvent.disconnect()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisconnectImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() disconnect,
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
  }) {
    return disconnect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? disconnect,
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
  }) {
    return disconnect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? disconnect,
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(Disconnect value) disconnect,
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
  }) {
    return disconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(Disconnect value)? disconnect,
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
  }) {
    return disconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(Disconnect value)? disconnect,
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(this);
    }
    return orElse();
  }
}

abstract class Disconnect implements ConnectionEvent {
  const factory Disconnect() = _$DisconnectImpl;
}

/// @nodoc
abstract class _$$AppConnectionStatusChangedImplCopyWith<$Res> {
  factory _$$AppConnectionStatusChangedImplCopyWith(
    _$AppConnectionStatusChangedImpl value,
    $Res Function(_$AppConnectionStatusChangedImpl) then,
  ) = __$$AppConnectionStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppConnectionStatus status});
}

/// @nodoc
class __$$AppConnectionStatusChangedImplCopyWithImpl<$Res>
    extends
        _$ConnectionEventCopyWithImpl<$Res, _$AppConnectionStatusChangedImpl>
    implements _$$AppConnectionStatusChangedImplCopyWith<$Res> {
  __$$AppConnectionStatusChangedImplCopyWithImpl(
    _$AppConnectionStatusChangedImpl _value,
    $Res Function(_$AppConnectionStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$AppConnectionStatusChangedImpl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as AppConnectionStatus,
      ),
    );
  }
}

/// @nodoc

class _$AppConnectionStatusChangedImpl implements AppConnectionStatusChanged {
  const _$AppConnectionStatusChangedImpl({required this.status});

  @override
  final AppConnectionStatus status;

  @override
  String toString() {
    return 'ConnectionEvent.appConnectionStatusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConnectionStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConnectionStatusChangedImplCopyWith<_$AppConnectionStatusChangedImpl>
  get copyWith => __$$AppConnectionStatusChangedImplCopyWithImpl<
    _$AppConnectionStatusChangedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() disconnect,
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
  }) {
    return appConnectionStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? disconnect,
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
  }) {
    return appConnectionStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? disconnect,
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    required TResult orElse(),
  }) {
    if (appConnectionStatusChanged != null) {
      return appConnectionStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(Disconnect value) disconnect,
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
  }) {
    return appConnectionStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(Disconnect value)? disconnect,
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
  }) {
    return appConnectionStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(Disconnect value)? disconnect,
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    required TResult orElse(),
  }) {
    if (appConnectionStatusChanged != null) {
      return appConnectionStatusChanged(this);
    }
    return orElse();
  }
}

abstract class AppConnectionStatusChanged implements ConnectionEvent {
  const factory AppConnectionStatusChanged({
    required final AppConnectionStatus status,
  }) = _$AppConnectionStatusChangedImpl;

  AppConnectionStatus get status;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConnectionStatusChangedImplCopyWith<_$AppConnectionStatusChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
