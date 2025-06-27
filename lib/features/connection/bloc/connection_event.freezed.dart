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
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
    required TResult Function() disconnect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
    TResult? Function()? disconnect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    TResult Function()? disconnect,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
    required TResult Function(Disconnect value) disconnect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
    TResult? Function(Disconnect value)? disconnect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    TResult Function(Disconnect value)? disconnect,
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
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
    required TResult Function() disconnect,
  }) {
    return appConnectionStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
    TResult? Function()? disconnect,
  }) {
    return appConnectionStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    TResult Function()? disconnect,
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
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
    required TResult Function(Disconnect value) disconnect,
  }) {
    return appConnectionStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
    TResult? Function(Disconnect value)? disconnect,
  }) {
    return appConnectionStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    TResult Function(Disconnect value)? disconnect,
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
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
    required TResult Function() disconnect,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
    TResult? Function()? disconnect,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    TResult Function()? disconnect,
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
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
    required TResult Function(Disconnect value) disconnect,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
    TResult? Function(Disconnect value)? disconnect,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    TResult Function(Disconnect value)? disconnect,
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
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
    required TResult Function() disconnect,
  }) {
    return retryConnection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
    TResult? Function()? disconnect,
  }) {
    return retryConnection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    TResult Function()? disconnect,
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
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
    required TResult Function(Disconnect value) disconnect,
  }) {
    return retryConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
    TResult? Function(Disconnect value)? disconnect,
  }) {
    return retryConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    TResult Function(Disconnect value)? disconnect,
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
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
    required TResult Function() disconnect,
  }) {
    return startStreaming();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
    TResult? Function()? disconnect,
  }) {
    return startStreaming?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    TResult Function()? disconnect,
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
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
    required TResult Function(Disconnect value) disconnect,
  }) {
    return startStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
    TResult? Function(Disconnect value)? disconnect,
  }) {
    return startStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    TResult Function(Disconnect value)? disconnect,
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
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
    required TResult Function() disconnect,
  }) {
    return stopStreaming();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
    TResult? Function()? disconnect,
  }) {
    return stopStreaming?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    TResult Function()? disconnect,
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
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
    required TResult Function(Disconnect value) disconnect,
  }) {
    return stopStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
    TResult? Function(Disconnect value)? disconnect,
  }) {
    return stopStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    TResult Function(Disconnect value)? disconnect,
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
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
    required TResult Function() disconnect,
  }) {
    return configureStream(maxFps);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
    TResult? Function()? disconnect,
  }) {
    return configureStream?.call(maxFps);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    TResult Function()? disconnect,
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
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
    required TResult Function(Disconnect value) disconnect,
  }) {
    return configureStream(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
    TResult? Function(Disconnect value)? disconnect,
  }) {
    return configureStream?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    TResult Function(Disconnect value)? disconnect,
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
    required TResult Function(AppConnectionStatus status)
    appConnectionStatusChanged,
    required TResult Function() initialize,
    required TResult Function() retryConnection,
    required TResult Function() startStreaming,
    required TResult Function() stopStreaming,
    required TResult Function(int maxFps) configureStream,
    required TResult Function() disconnect,
  }) {
    return disconnect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult? Function()? initialize,
    TResult? Function()? retryConnection,
    TResult? Function()? startStreaming,
    TResult? Function()? stopStreaming,
    TResult? Function(int maxFps)? configureStream,
    TResult? Function()? disconnect,
  }) {
    return disconnect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppConnectionStatus status)? appConnectionStatusChanged,
    TResult Function()? initialize,
    TResult Function()? retryConnection,
    TResult Function()? startStreaming,
    TResult Function()? stopStreaming,
    TResult Function(int maxFps)? configureStream,
    TResult Function()? disconnect,
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
    required TResult Function(AppConnectionStatusChanged value)
    appConnectionStatusChanged,
    required TResult Function(Initialize value) initialize,
    required TResult Function(RetryConnection value) retryConnection,
    required TResult Function(StartStreaming value) startStreaming,
    required TResult Function(StopStreaming value) stopStreaming,
    required TResult Function(ConfigureStream value) configureStream,
    required TResult Function(Disconnect value) disconnect,
  }) {
    return disconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult? Function(Initialize value)? initialize,
    TResult? Function(RetryConnection value)? retryConnection,
    TResult? Function(StartStreaming value)? startStreaming,
    TResult? Function(StopStreaming value)? stopStreaming,
    TResult? Function(ConfigureStream value)? configureStream,
    TResult? Function(Disconnect value)? disconnect,
  }) {
    return disconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConnectionStatusChanged value)?
    appConnectionStatusChanged,
    TResult Function(Initialize value)? initialize,
    TResult Function(RetryConnection value)? retryConnection,
    TResult Function(StartStreaming value)? startStreaming,
    TResult Function(StopStreaming value)? stopStreaming,
    TResult Function(ConfigureStream value)? configureStream,
    TResult Function(Disconnect value)? disconnect,
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
