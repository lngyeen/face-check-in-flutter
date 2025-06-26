// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_service.dart';

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
    required TResult Function(int currentAttempt, int maxAttempts) fastRetrying,
    required TResult Function() backgroundMonitoring,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(int currentAttempt, int maxAttempts)? fastRetrying,
    TResult? Function()? backgroundMonitoring,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(int currentAttempt, int maxAttempts)? fastRetrying,
    TResult Function()? backgroundMonitoring,
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
    required TResult Function(int currentAttempt, int maxAttempts) fastRetrying,
    required TResult Function() backgroundMonitoring,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(int currentAttempt, int maxAttempts)? fastRetrying,
    TResult? Function()? backgroundMonitoring,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(int currentAttempt, int maxAttempts)? fastRetrying,
    TResult Function()? backgroundMonitoring,
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
  $Res call({int currentAttempt, int maxAttempts});
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
  $Res call({Object? currentAttempt = null, Object? maxAttempts = null}) {
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
      ),
    );
  }
}

/// @nodoc

class _$FastRetryingStateImpl implements _FastRetryingState {
  const _$FastRetryingStateImpl({
    required this.currentAttempt,
    required this.maxAttempts,
  });

  @override
  final int currentAttempt;
  @override
  final int maxAttempts;

  @override
  String toString() {
    return 'RetryState.fastRetrying(currentAttempt: $currentAttempt, maxAttempts: $maxAttempts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FastRetryingStateImpl &&
            (identical(other.currentAttempt, currentAttempt) ||
                other.currentAttempt == currentAttempt) &&
            (identical(other.maxAttempts, maxAttempts) ||
                other.maxAttempts == maxAttempts));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentAttempt, maxAttempts);

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
    required TResult Function(int currentAttempt, int maxAttempts) fastRetrying,
    required TResult Function() backgroundMonitoring,
  }) {
    return fastRetrying(currentAttempt, maxAttempts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(int currentAttempt, int maxAttempts)? fastRetrying,
    TResult? Function()? backgroundMonitoring,
  }) {
    return fastRetrying?.call(currentAttempt, maxAttempts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(int currentAttempt, int maxAttempts)? fastRetrying,
    TResult Function()? backgroundMonitoring,
    required TResult orElse(),
  }) {
    if (fastRetrying != null) {
      return fastRetrying(currentAttempt, maxAttempts);
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
  }) = _$FastRetryingStateImpl;

  int get currentAttempt;
  int get maxAttempts;

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
}

/// @nodoc

class _$BackgroundMonitoringStateImpl implements _BackgroundMonitoringState {
  const _$BackgroundMonitoringStateImpl();

  @override
  String toString() {
    return 'RetryState.backgroundMonitoring()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackgroundMonitoringStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(int currentAttempt, int maxAttempts) fastRetrying,
    required TResult Function() backgroundMonitoring,
  }) {
    return backgroundMonitoring();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(int currentAttempt, int maxAttempts)? fastRetrying,
    TResult? Function()? backgroundMonitoring,
  }) {
    return backgroundMonitoring?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(int currentAttempt, int maxAttempts)? fastRetrying,
    TResult Function()? backgroundMonitoring,
    required TResult orElse(),
  }) {
    if (backgroundMonitoring != null) {
      return backgroundMonitoring();
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
  const factory _BackgroundMonitoringState() = _$BackgroundMonitoringStateImpl;
}
