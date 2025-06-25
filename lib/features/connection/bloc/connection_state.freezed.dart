// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConnectionState {
  /// Overall app connection status
  AppConnectionStatus get status => throw _privateConstructorUsedError;

  /// Network connectivity status
  bool get isNetworkConnected => throw _privateConstructorUsedError;

  /// WebSocket connection status
  WebSocketConnectionStatus get webSocketStatus =>
      throw _privateConstructorUsedError;

  /// Current frame streaming status for UI
  StreamingStatus get streamingStatus => throw _privateConstructorUsedError;

  /// Last connection error (if any)
  ConnectionError? get lastError => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionStateCopyWith<ConnectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionStateCopyWith<$Res> {
  factory $ConnectionStateCopyWith(
    ConnectionState value,
    $Res Function(ConnectionState) then,
  ) = _$ConnectionStateCopyWithImpl<$Res, ConnectionState>;
  @useResult
  $Res call({
    AppConnectionStatus status,
    bool isNetworkConnected,
    WebSocketConnectionStatus webSocketStatus,
    StreamingStatus streamingStatus,
    ConnectionError? lastError,
  });
}

/// @nodoc
class _$ConnectionStateCopyWithImpl<$Res, $Val extends ConnectionState>
    implements $ConnectionStateCopyWith<$Res> {
  _$ConnectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? isNetworkConnected = null,
    Object? webSocketStatus = null,
    Object? streamingStatus = null,
    Object? lastError = freezed,
  }) {
    return _then(
      _value.copyWith(
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as AppConnectionStatus,
            isNetworkConnected:
                null == isNetworkConnected
                    ? _value.isNetworkConnected
                    : isNetworkConnected // ignore: cast_nullable_to_non_nullable
                        as bool,
            webSocketStatus:
                null == webSocketStatus
                    ? _value.webSocketStatus
                    : webSocketStatus // ignore: cast_nullable_to_non_nullable
                        as WebSocketConnectionStatus,
            streamingStatus:
                null == streamingStatus
                    ? _value.streamingStatus
                    : streamingStatus // ignore: cast_nullable_to_non_nullable
                        as StreamingStatus,
            lastError:
                freezed == lastError
                    ? _value.lastError
                    : lastError // ignore: cast_nullable_to_non_nullable
                        as ConnectionError?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionStateImplCopyWith<$Res>
    implements $ConnectionStateCopyWith<$Res> {
  factory _$$ConnectionStateImplCopyWith(
    _$ConnectionStateImpl value,
    $Res Function(_$ConnectionStateImpl) then,
  ) = __$$ConnectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AppConnectionStatus status,
    bool isNetworkConnected,
    WebSocketConnectionStatus webSocketStatus,
    StreamingStatus streamingStatus,
    ConnectionError? lastError,
  });
}

/// @nodoc
class __$$ConnectionStateImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionStateImpl>
    implements _$$ConnectionStateImplCopyWith<$Res> {
  __$$ConnectionStateImplCopyWithImpl(
    _$ConnectionStateImpl _value,
    $Res Function(_$ConnectionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? isNetworkConnected = null,
    Object? webSocketStatus = null,
    Object? streamingStatus = null,
    Object? lastError = freezed,
  }) {
    return _then(
      _$ConnectionStateImpl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as AppConnectionStatus,
        isNetworkConnected:
            null == isNetworkConnected
                ? _value.isNetworkConnected
                : isNetworkConnected // ignore: cast_nullable_to_non_nullable
                    as bool,
        webSocketStatus:
            null == webSocketStatus
                ? _value.webSocketStatus
                : webSocketStatus // ignore: cast_nullable_to_non_nullable
                    as WebSocketConnectionStatus,
        streamingStatus:
            null == streamingStatus
                ? _value.streamingStatus
                : streamingStatus // ignore: cast_nullable_to_non_nullable
                    as StreamingStatus,
        lastError:
            freezed == lastError
                ? _value.lastError
                : lastError // ignore: cast_nullable_to_non_nullable
                    as ConnectionError?,
      ),
    );
  }
}

/// @nodoc

class _$ConnectionStateImpl extends _ConnectionState {
  const _$ConnectionStateImpl({
    this.status = AppConnectionStatus.initial,
    this.isNetworkConnected = false,
    this.webSocketStatus = WebSocketConnectionStatus.disconnected,
    this.streamingStatus = StreamingStatus.idle,
    this.lastError,
  }) : super._();

  /// Overall app connection status
  @override
  @JsonKey()
  final AppConnectionStatus status;

  /// Network connectivity status
  @override
  @JsonKey()
  final bool isNetworkConnected;

  /// WebSocket connection status
  @override
  @JsonKey()
  final WebSocketConnectionStatus webSocketStatus;

  /// Current frame streaming status for UI
  @override
  @JsonKey()
  final StreamingStatus streamingStatus;

  /// Last connection error (if any)
  @override
  final ConnectionError? lastError;

  @override
  String toString() {
    return 'ConnectionState(status: $status, isNetworkConnected: $isNetworkConnected, webSocketStatus: $webSocketStatus, streamingStatus: $streamingStatus, lastError: $lastError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isNetworkConnected, isNetworkConnected) ||
                other.isNetworkConnected == isNetworkConnected) &&
            (identical(other.webSocketStatus, webSocketStatus) ||
                other.webSocketStatus == webSocketStatus) &&
            (identical(other.streamingStatus, streamingStatus) ||
                other.streamingStatus == streamingStatus) &&
            (identical(other.lastError, lastError) ||
                other.lastError == lastError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    isNetworkConnected,
    webSocketStatus,
    streamingStatus,
    lastError,
  );

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionStateImplCopyWith<_$ConnectionStateImpl> get copyWith =>
      __$$ConnectionStateImplCopyWithImpl<_$ConnectionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ConnectionState extends ConnectionState {
  const factory _ConnectionState({
    final AppConnectionStatus status,
    final bool isNetworkConnected,
    final WebSocketConnectionStatus webSocketStatus,
    final StreamingStatus streamingStatus,
    final ConnectionError? lastError,
  }) = _$ConnectionStateImpl;
  const _ConnectionState._() : super._();

  /// Overall app connection status
  @override
  AppConnectionStatus get status;

  /// Network connectivity status
  @override
  bool get isNetworkConnected;

  /// WebSocket connection status
  @override
  WebSocketConnectionStatus get webSocketStatus;

  /// Current frame streaming status for UI
  @override
  StreamingStatus get streamingStatus;

  /// Last connection error (if any)
  @override
  ConnectionError? get lastError;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionStateImplCopyWith<_$ConnectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
