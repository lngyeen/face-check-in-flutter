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
mixin _$RetryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )
    fastRetrying,
    required TResult Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )
    backgroundMonitoring,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )?
    fastRetrying,
    TResult? Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )?
    backgroundMonitoring,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )?
    fastRetrying,
    TResult Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )?
    backgroundMonitoring,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_IdleRetryState value) idle,
    required TResult Function(_FastRetryingState value) fastRetrying,
    required TResult Function(_BackgroundMonitoringState value)
    backgroundMonitoring,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_IdleRetryState value)? idle,
    TResult? Function(_FastRetryingState value)? fastRetrying,
    TResult? Function(_BackgroundMonitoringState value)? backgroundMonitoring,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_IdleRetryState value)? idle,
    TResult Function(_FastRetryingState value)? fastRetrying,
    TResult Function(_BackgroundMonitoringState value)? backgroundMonitoring,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetryStateCopyWith<$Res> {
  factory $RetryStateCopyWith(
    RetryState value,
    $Res Function(RetryState) then,
  ) = _$RetryStateCopyWithImpl<$Res, RetryState>;
}

/// @nodoc
class _$RetryStateCopyWithImpl<$Res, $Val extends RetryState>
    implements $RetryStateCopyWith<$Res> {
  _$RetryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RetryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleRetryStateImplCopyWith<$Res> {
  factory _$$IdleRetryStateImplCopyWith(
    _$IdleRetryStateImpl value,
    $Res Function(_$IdleRetryStateImpl) then,
  ) = __$$IdleRetryStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleRetryStateImplCopyWithImpl<$Res>
    extends _$RetryStateCopyWithImpl<$Res, _$IdleRetryStateImpl>
    implements _$$IdleRetryStateImplCopyWith<$Res> {
  __$$IdleRetryStateImplCopyWithImpl(
    _$IdleRetryStateImpl _value,
    $Res Function(_$IdleRetryStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RetryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleRetryStateImpl implements _IdleRetryState {
  const _$IdleRetryStateImpl();

  @override
  String toString() {
    return 'RetryState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleRetryStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )
    fastRetrying,
    required TResult Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )
    backgroundMonitoring,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )?
    fastRetrying,
    TResult? Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )?
    backgroundMonitoring,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )?
    fastRetrying,
    TResult Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )?
    backgroundMonitoring,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_IdleRetryState value) idle,
    required TResult Function(_FastRetryingState value) fastRetrying,
    required TResult Function(_BackgroundMonitoringState value)
    backgroundMonitoring,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_IdleRetryState value)? idle,
    TResult? Function(_FastRetryingState value)? fastRetrying,
    TResult? Function(_BackgroundMonitoringState value)? backgroundMonitoring,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_IdleRetryState value)? idle,
    TResult Function(_FastRetryingState value)? fastRetrying,
    TResult Function(_BackgroundMonitoringState value)? backgroundMonitoring,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _IdleRetryState implements RetryState {
  const factory _IdleRetryState() = _$IdleRetryStateImpl;
}

/// @nodoc
abstract class _$$FastRetryingStateImplCopyWith<$Res> {
  factory _$$FastRetryingStateImplCopyWith(
    _$FastRetryingStateImpl value,
    $Res Function(_$FastRetryingStateImpl) then,
  ) = __$$FastRetryingStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    int currentAttempt,
    int maxAttempts,
    Duration nextRetryIn,
    DateTime nextRetryAt,
  });
}

/// @nodoc
class __$$FastRetryingStateImplCopyWithImpl<$Res>
    extends _$RetryStateCopyWithImpl<$Res, _$FastRetryingStateImpl>
    implements _$$FastRetryingStateImplCopyWith<$Res> {
  __$$FastRetryingStateImplCopyWithImpl(
    _$FastRetryingStateImpl _value,
    $Res Function(_$FastRetryingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RetryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAttempt = null,
    Object? maxAttempts = null,
    Object? nextRetryIn = null,
    Object? nextRetryAt = null,
  }) {
    return _then(
      _$FastRetryingStateImpl(
        currentAttempt:
            null == currentAttempt
                ? _value.currentAttempt
                : currentAttempt // ignore: cast_nullable_to_non_nullable
                    as int,
        maxAttempts:
            null == maxAttempts
                ? _value.maxAttempts
                : maxAttempts // ignore: cast_nullable_to_non_nullable
                    as int,
        nextRetryIn:
            null == nextRetryIn
                ? _value.nextRetryIn
                : nextRetryIn // ignore: cast_nullable_to_non_nullable
                    as Duration,
        nextRetryAt:
            null == nextRetryAt
                ? _value.nextRetryAt
                : nextRetryAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$FastRetryingStateImpl implements _FastRetryingState {
  const _$FastRetryingStateImpl({
    required this.currentAttempt,
    required this.maxAttempts,
    required this.nextRetryIn,
    required this.nextRetryAt,
  });

  @override
  final int currentAttempt;
  @override
  final int maxAttempts;
  @override
  final Duration nextRetryIn;
  @override
  final DateTime nextRetryAt;

  @override
  String toString() {
    return 'RetryState.fastRetrying(currentAttempt: $currentAttempt, maxAttempts: $maxAttempts, nextRetryIn: $nextRetryIn, nextRetryAt: $nextRetryAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FastRetryingStateImpl &&
            (identical(other.currentAttempt, currentAttempt) ||
                other.currentAttempt == currentAttempt) &&
            (identical(other.maxAttempts, maxAttempts) ||
                other.maxAttempts == maxAttempts) &&
            (identical(other.nextRetryIn, nextRetryIn) ||
                other.nextRetryIn == nextRetryIn) &&
            (identical(other.nextRetryAt, nextRetryAt) ||
                other.nextRetryAt == nextRetryAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentAttempt,
    maxAttempts,
    nextRetryIn,
    nextRetryAt,
  );

  /// Create a copy of RetryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FastRetryingStateImplCopyWith<_$FastRetryingStateImpl> get copyWith =>
      __$$FastRetryingStateImplCopyWithImpl<_$FastRetryingStateImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )
    fastRetrying,
    required TResult Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )
    backgroundMonitoring,
  }) {
    return fastRetrying(currentAttempt, maxAttempts, nextRetryIn, nextRetryAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )?
    fastRetrying,
    TResult? Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )?
    backgroundMonitoring,
  }) {
    return fastRetrying?.call(
      currentAttempt,
      maxAttempts,
      nextRetryIn,
      nextRetryAt,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )?
    fastRetrying,
    TResult Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )?
    backgroundMonitoring,
    required TResult orElse(),
  }) {
    if (fastRetrying != null) {
      return fastRetrying(
        currentAttempt,
        maxAttempts,
        nextRetryIn,
        nextRetryAt,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_IdleRetryState value) idle,
    required TResult Function(_FastRetryingState value) fastRetrying,
    required TResult Function(_BackgroundMonitoringState value)
    backgroundMonitoring,
  }) {
    return fastRetrying(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_IdleRetryState value)? idle,
    TResult? Function(_FastRetryingState value)? fastRetrying,
    TResult? Function(_BackgroundMonitoringState value)? backgroundMonitoring,
  }) {
    return fastRetrying?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_IdleRetryState value)? idle,
    TResult Function(_FastRetryingState value)? fastRetrying,
    TResult Function(_BackgroundMonitoringState value)? backgroundMonitoring,
    required TResult orElse(),
  }) {
    if (fastRetrying != null) {
      return fastRetrying(this);
    }
    return orElse();
  }
}

abstract class _FastRetryingState implements RetryState {
  const factory _FastRetryingState({
    required final int currentAttempt,
    required final int maxAttempts,
    required final Duration nextRetryIn,
    required final DateTime nextRetryAt,
  }) = _$FastRetryingStateImpl;

  int get currentAttempt;
  int get maxAttempts;
  Duration get nextRetryIn;
  DateTime get nextRetryAt;

  /// Create a copy of RetryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FastRetryingStateImplCopyWith<_$FastRetryingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackgroundMonitoringStateImplCopyWith<$Res> {
  factory _$$BackgroundMonitoringStateImplCopyWith(
    _$BackgroundMonitoringStateImpl value,
    $Res Function(_$BackgroundMonitoringStateImpl) then,
  ) = __$$BackgroundMonitoringStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    DateTime lastAttemptAt,
    Duration checkInterval,
    DateTime nextCheckAt,
  });
}

/// @nodoc
class __$$BackgroundMonitoringStateImplCopyWithImpl<$Res>
    extends _$RetryStateCopyWithImpl<$Res, _$BackgroundMonitoringStateImpl>
    implements _$$BackgroundMonitoringStateImplCopyWith<$Res> {
  __$$BackgroundMonitoringStateImplCopyWithImpl(
    _$BackgroundMonitoringStateImpl _value,
    $Res Function(_$BackgroundMonitoringStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RetryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastAttemptAt = null,
    Object? checkInterval = null,
    Object? nextCheckAt = null,
  }) {
    return _then(
      _$BackgroundMonitoringStateImpl(
        lastAttemptAt:
            null == lastAttemptAt
                ? _value.lastAttemptAt
                : lastAttemptAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        checkInterval:
            null == checkInterval
                ? _value.checkInterval
                : checkInterval // ignore: cast_nullable_to_non_nullable
                    as Duration,
        nextCheckAt:
            null == nextCheckAt
                ? _value.nextCheckAt
                : nextCheckAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$BackgroundMonitoringStateImpl implements _BackgroundMonitoringState {
  const _$BackgroundMonitoringStateImpl({
    required this.lastAttemptAt,
    required this.checkInterval,
    required this.nextCheckAt,
  });

  @override
  final DateTime lastAttemptAt;
  @override
  final Duration checkInterval;
  @override
  final DateTime nextCheckAt;

  @override
  String toString() {
    return 'RetryState.backgroundMonitoring(lastAttemptAt: $lastAttemptAt, checkInterval: $checkInterval, nextCheckAt: $nextCheckAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackgroundMonitoringStateImpl &&
            (identical(other.lastAttemptAt, lastAttemptAt) ||
                other.lastAttemptAt == lastAttemptAt) &&
            (identical(other.checkInterval, checkInterval) ||
                other.checkInterval == checkInterval) &&
            (identical(other.nextCheckAt, nextCheckAt) ||
                other.nextCheckAt == nextCheckAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, lastAttemptAt, checkInterval, nextCheckAt);

  /// Create a copy of RetryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BackgroundMonitoringStateImplCopyWith<_$BackgroundMonitoringStateImpl>
  get copyWith => __$$BackgroundMonitoringStateImplCopyWithImpl<
    _$BackgroundMonitoringStateImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )
    fastRetrying,
    required TResult Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )
    backgroundMonitoring,
  }) {
    return backgroundMonitoring(lastAttemptAt, checkInterval, nextCheckAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )?
    fastRetrying,
    TResult? Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )?
    backgroundMonitoring,
  }) {
    return backgroundMonitoring?.call(
      lastAttemptAt,
      checkInterval,
      nextCheckAt,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(
      int currentAttempt,
      int maxAttempts,
      Duration nextRetryIn,
      DateTime nextRetryAt,
    )?
    fastRetrying,
    TResult Function(
      DateTime lastAttemptAt,
      Duration checkInterval,
      DateTime nextCheckAt,
    )?
    backgroundMonitoring,
    required TResult orElse(),
  }) {
    if (backgroundMonitoring != null) {
      return backgroundMonitoring(lastAttemptAt, checkInterval, nextCheckAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_IdleRetryState value) idle,
    required TResult Function(_FastRetryingState value) fastRetrying,
    required TResult Function(_BackgroundMonitoringState value)
    backgroundMonitoring,
  }) {
    return backgroundMonitoring(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_IdleRetryState value)? idle,
    TResult? Function(_FastRetryingState value)? fastRetrying,
    TResult? Function(_BackgroundMonitoringState value)? backgroundMonitoring,
  }) {
    return backgroundMonitoring?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_IdleRetryState value)? idle,
    TResult Function(_FastRetryingState value)? fastRetrying,
    TResult Function(_BackgroundMonitoringState value)? backgroundMonitoring,
    required TResult orElse(),
  }) {
    if (backgroundMonitoring != null) {
      return backgroundMonitoring(this);
    }
    return orElse();
  }
}

abstract class _BackgroundMonitoringState implements RetryState {
  const factory _BackgroundMonitoringState({
    required final DateTime lastAttemptAt,
    required final Duration checkInterval,
    required final DateTime nextCheckAt,
  }) = _$BackgroundMonitoringStateImpl;

  DateTime get lastAttemptAt;
  Duration get checkInterval;
  DateTime get nextCheckAt;

  /// Create a copy of RetryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BackgroundMonitoringStateImplCopyWith<_$BackgroundMonitoringStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

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

  /// Current retry state and info
  RetryState get retryState => throw _privateConstructorUsedError;

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
    RetryState retryState,
    ConnectionError? lastError,
  });

  $RetryStateCopyWith<$Res> get retryState;
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
    Object? retryState = null,
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
            retryState:
                null == retryState
                    ? _value.retryState
                    : retryState // ignore: cast_nullable_to_non_nullable
                        as RetryState,
            lastError:
                freezed == lastError
                    ? _value.lastError
                    : lastError // ignore: cast_nullable_to_non_nullable
                        as ConnectionError?,
          )
          as $Val,
    );
  }

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RetryStateCopyWith<$Res> get retryState {
    return $RetryStateCopyWith<$Res>(_value.retryState, (value) {
      return _then(_value.copyWith(retryState: value) as $Val);
    });
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
    RetryState retryState,
    ConnectionError? lastError,
  });

  @override
  $RetryStateCopyWith<$Res> get retryState;
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
    Object? retryState = null,
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
        retryState:
            null == retryState
                ? _value.retryState
                : retryState // ignore: cast_nullable_to_non_nullable
                    as RetryState,
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
    this.retryState = const RetryState.idle(),
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

  /// Current retry state and info
  @override
  @JsonKey()
  final RetryState retryState;

  /// Last connection error (if any)
  @override
  final ConnectionError? lastError;

  @override
  String toString() {
    return 'ConnectionState(status: $status, isNetworkConnected: $isNetworkConnected, webSocketStatus: $webSocketStatus, streamingStatus: $streamingStatus, retryState: $retryState, lastError: $lastError)';
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
            (identical(other.retryState, retryState) ||
                other.retryState == retryState) &&
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
    retryState,
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
    final RetryState retryState,
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

  /// Current retry state and info
  @override
  RetryState get retryState;

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
