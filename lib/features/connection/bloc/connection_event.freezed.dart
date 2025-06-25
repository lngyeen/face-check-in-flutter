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
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
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
abstract class _$$NetworkStatusChangedImplCopyWith<$Res> {
  factory _$$NetworkStatusChangedImplCopyWith(
    _$NetworkStatusChangedImpl value,
    $Res Function(_$NetworkStatusChangedImpl) then,
  ) = __$$NetworkStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isConnected});
}

/// @nodoc
class __$$NetworkStatusChangedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$NetworkStatusChangedImpl>
    implements _$$NetworkStatusChangedImplCopyWith<$Res> {
  __$$NetworkStatusChangedImplCopyWithImpl(
    _$NetworkStatusChangedImpl _value,
    $Res Function(_$NetworkStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isConnected = null}) {
    return _then(
      _$NetworkStatusChangedImpl(
        isConnected:
            null == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$NetworkStatusChangedImpl implements NetworkStatusChanged {
  const _$NetworkStatusChangedImpl({required this.isConnected});

  @override
  final bool isConnected;

  @override
  String toString() {
    return 'ConnectionEvent.networkStatusChanged(isConnected: $isConnected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkStatusChangedImpl &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isConnected);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkStatusChangedImplCopyWith<_$NetworkStatusChangedImpl>
  get copyWith =>
      __$$NetworkStatusChangedImplCopyWithImpl<_$NetworkStatusChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) {
    return networkStatusChanged(isConnected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) {
    return networkStatusChanged?.call(isConnected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    required TResult orElse(),
  }) {
    if (networkStatusChanged != null) {
      return networkStatusChanged(isConnected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) {
    return networkStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) {
    return networkStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    required TResult orElse(),
  }) {
    if (networkStatusChanged != null) {
      return networkStatusChanged(this);
    }
    return orElse();
  }
}

abstract class NetworkStatusChanged implements ConnectionEvent {
  const factory NetworkStatusChanged({required final bool isConnected}) =
      _$NetworkStatusChangedImpl;

  bool get isConnected;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkStatusChangedImplCopyWith<_$NetworkStatusChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketStatusChangedImplCopyWith<$Res> {
  factory _$$WebSocketStatusChangedImplCopyWith(
    _$WebSocketStatusChangedImpl value,
    $Res Function(_$WebSocketStatusChangedImpl) then,
  ) = __$$WebSocketStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WebSocketConnectionStatus status});
}

/// @nodoc
class __$$WebSocketStatusChangedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$WebSocketStatusChangedImpl>
    implements _$$WebSocketStatusChangedImplCopyWith<$Res> {
  __$$WebSocketStatusChangedImplCopyWithImpl(
    _$WebSocketStatusChangedImpl _value,
    $Res Function(_$WebSocketStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$WebSocketStatusChangedImpl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as WebSocketConnectionStatus,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketStatusChangedImpl implements WebSocketStatusChanged {
  const _$WebSocketStatusChangedImpl({required this.status});

  @override
  final WebSocketConnectionStatus status;

  @override
  String toString() {
    return 'ConnectionEvent.webSocketStatusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketStatusChangedImplCopyWith<_$WebSocketStatusChangedImpl>
  get copyWith =>
      __$$WebSocketStatusChangedImplCopyWithImpl<_$WebSocketStatusChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) {
    return webSocketStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) {
    return webSocketStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    required TResult orElse(),
  }) {
    if (webSocketStatusChanged != null) {
      return webSocketStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) {
    return webSocketStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) {
    return webSocketStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    required TResult orElse(),
  }) {
    if (webSocketStatusChanged != null) {
      return webSocketStatusChanged(this);
    }
    return orElse();
  }
}

abstract class WebSocketStatusChanged implements ConnectionEvent {
  const factory WebSocketStatusChanged({
    required final WebSocketConnectionStatus status,
  }) = _$WebSocketStatusChangedImpl;

  WebSocketConnectionStatus get status;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketStatusChangedImplCopyWith<_$WebSocketStatusChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionRequestedImplCopyWith<$Res> {
  factory _$$ConnectionRequestedImplCopyWith(
    _$ConnectionRequestedImpl value,
    $Res Function(_$ConnectionRequestedImpl) then,
  ) = __$$ConnectionRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionRequestedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionRequestedImpl>
    implements _$$ConnectionRequestedImplCopyWith<$Res> {
  __$$ConnectionRequestedImplCopyWithImpl(
    _$ConnectionRequestedImpl _value,
    $Res Function(_$ConnectionRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionRequestedImpl implements ConnectionRequested {
  const _$ConnectionRequestedImpl();

  @override
  String toString() {
    return 'ConnectionEvent.connectionRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) {
    return connectionRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) {
    return connectionRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    required TResult orElse(),
  }) {
    if (connectionRequested != null) {
      return connectionRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) {
    return connectionRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) {
    return connectionRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    required TResult orElse(),
  }) {
    if (connectionRequested != null) {
      return connectionRequested(this);
    }
    return orElse();
  }
}

abstract class ConnectionRequested implements ConnectionEvent {
  const factory ConnectionRequested() = _$ConnectionRequestedImpl;
}

/// @nodoc
abstract class _$$ManualRetryRequestedImplCopyWith<$Res> {
  factory _$$ManualRetryRequestedImplCopyWith(
    _$ManualRetryRequestedImpl value,
    $Res Function(_$ManualRetryRequestedImpl) then,
  ) = __$$ManualRetryRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ManualRetryRequestedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ManualRetryRequestedImpl>
    implements _$$ManualRetryRequestedImplCopyWith<$Res> {
  __$$ManualRetryRequestedImplCopyWithImpl(
    _$ManualRetryRequestedImpl _value,
    $Res Function(_$ManualRetryRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ManualRetryRequestedImpl implements ManualRetryRequested {
  const _$ManualRetryRequestedImpl();

  @override
  String toString() {
    return 'ConnectionEvent.manualRetryRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManualRetryRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) {
    return manualRetryRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) {
    return manualRetryRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    required TResult orElse(),
  }) {
    if (manualRetryRequested != null) {
      return manualRetryRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) {
    return manualRetryRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) {
    return manualRetryRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    required TResult orElse(),
  }) {
    if (manualRetryRequested != null) {
      return manualRetryRequested(this);
    }
    return orElse();
  }
}

abstract class ManualRetryRequested implements ConnectionEvent {
  const factory ManualRetryRequested() = _$ManualRetryRequestedImpl;
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
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
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
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
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
abstract class _$$StartStreamingImplCopyWith<$Res> {
  factory _$$StartStreamingImplCopyWith(
    _$StartStreamingImpl value,
    $Res Function(_$StartStreamingImpl) then,
  ) = __$$StartStreamingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartStreamingImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$StartStreamingImpl>
    implements _$$StartStreamingImplCopyWith<$Res> {
  __$$StartStreamingImplCopyWithImpl(
    _$StartStreamingImpl _value,
    $Res Function(_$StartStreamingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartStreamingImpl implements StartStreaming {
  const _$StartStreamingImpl();

  @override
  String toString() {
    return 'ConnectionEvent.startStreaming()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartStreamingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) {
    return startStreaming();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) {
    return startStreaming?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    required TResult orElse(),
  }) {
    if (startStreaming != null) {
      return startStreaming();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) {
    return startStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) {
    return startStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    required TResult orElse(),
  }) {
    if (startStreaming != null) {
      return startStreaming(this);
    }
    return orElse();
  }
}

abstract class StartStreaming implements ConnectionEvent {
  const factory StartStreaming() = _$StartStreamingImpl;
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
    extends _$ConnectionEventCopyWithImpl<$Res, _$StopStreamingImpl>
    implements _$$StopStreamingImplCopyWith<$Res> {
  __$$StopStreamingImplCopyWithImpl(
    _$StopStreamingImpl _value,
    $Res Function(_$StopStreamingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopStreamingImpl implements StopStreaming {
  const _$StopStreamingImpl();

  @override
  String toString() {
    return 'ConnectionEvent.stopStreaming()';
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
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) {
    return stopStreaming();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) {
    return stopStreaming?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
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
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) {
    return stopStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) {
    return stopStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    required TResult orElse(),
  }) {
    if (stopStreaming != null) {
      return stopStreaming(this);
    }
    return orElse();
  }
}

abstract class StopStreaming implements ConnectionEvent {
  const factory StopStreaming() = _$StopStreamingImpl;
}

/// @nodoc
abstract class _$$ConfigureStreamImplCopyWith<$Res> {
  factory _$$ConfigureStreamImplCopyWith(
    _$ConfigureStreamImpl value,
    $Res Function(_$ConfigureStreamImpl) then,
  ) = __$$ConfigureStreamImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int maxFps});
}

/// @nodoc
class __$$ConfigureStreamImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConfigureStreamImpl>
    implements _$$ConfigureStreamImplCopyWith<$Res> {
  __$$ConfigureStreamImplCopyWithImpl(
    _$ConfigureStreamImpl _value,
    $Res Function(_$ConfigureStreamImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? maxFps = null}) {
    return _then(
      _$ConfigureStreamImpl(
        maxFps:
            null == maxFps
                ? _value.maxFps
                : maxFps // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$ConfigureStreamImpl implements ConfigureStream {
  const _$ConfigureStreamImpl({required this.maxFps});

  @override
  final int maxFps;

  @override
  String toString() {
    return 'ConnectionEvent.configureStream(maxFps: $maxFps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigureStreamImpl &&
            (identical(other.maxFps, maxFps) || other.maxFps == maxFps));
  }

  @override
  int get hashCode => Object.hash(runtimeType, maxFps);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigureStreamImplCopyWith<_$ConfigureStreamImpl> get copyWith =>
      __$$ConfigureStreamImplCopyWithImpl<_$ConfigureStreamImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isConnected) networkStatusChanged,
    required TResult Function(WebSocketConnectionStatus status)
    webSocketStatusChanged,
    required TResult Function() connectionRequested,
    required TResult Function() manualRetryRequested,
    required TResult Function() initialize,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
  }) {
    return configureStream(maxFps);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? networkStatusChanged,
    TResult? Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult? Function()? connectionRequested,
    TResult? Function()? manualRetryRequested,
    TResult? Function()? initialize,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
  }) {
    return configureStream?.call(maxFps);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? networkStatusChanged,
    TResult Function(WebSocketConnectionStatus status)? webSocketStatusChanged,
    TResult Function()? connectionRequested,
    TResult Function()? manualRetryRequested,
    TResult Function()? initialize,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    required TResult orElse(),
  }) {
    if (configureStream != null) {
      return configureStream(maxFps);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkStatusChanged value) networkStatusChanged,
    required TResult Function(WebSocketStatusChanged value)
    webSocketStatusChanged,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ManualRetryRequested value) manualRetryRequested,
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
  }) {
    return configureStream(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult? Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ManualRetryRequested value)? manualRetryRequested,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
  }) {
    return configureStream?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkStatusChanged value)? networkStatusChanged,
    TResult Function(WebSocketStatusChanged value)? webSocketStatusChanged,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ManualRetryRequested value)? manualRetryRequested,
    TResult Function(Initialize value)? initialize,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    required TResult orElse(),
  }) {
    if (configureStream != null) {
      return configureStream(this);
    }
    return orElse();
  }
}

abstract class ConfigureStream implements ConnectionEvent {
  const factory ConfigureStream({required final int maxFps}) =
      _$ConfigureStreamImpl;

  int get maxFps;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigureStreamImplCopyWith<_$ConfigureStreamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
