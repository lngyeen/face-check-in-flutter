// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StreamingError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() processingFailed,
    required TResult Function() webSocketFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? processingFailed,
    TResult? Function()? webSocketFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? processingFailed,
    TResult Function()? webSocketFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingFailed value) processingFailed,
    required TResult Function(_WebSocketFailed value) webSocketFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingFailed value)? processingFailed,
    TResult? Function(_WebSocketFailed value)? webSocketFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingFailed value)? processingFailed,
    TResult Function(_WebSocketFailed value)? webSocketFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingErrorCopyWith<$Res> {
  factory $StreamingErrorCopyWith(
    StreamingError value,
    $Res Function(StreamingError) then,
  ) = _$StreamingErrorCopyWithImpl<$Res, StreamingError>;
}

/// @nodoc
class _$StreamingErrorCopyWithImpl<$Res, $Val extends StreamingError>
    implements $StreamingErrorCopyWith<$Res> {
  _$StreamingErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamingError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProcessingFailedImplCopyWith<$Res> {
  factory _$$ProcessingFailedImplCopyWith(
    _$ProcessingFailedImpl value,
    $Res Function(_$ProcessingFailedImpl) then,
  ) = __$$ProcessingFailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProcessingFailedImplCopyWithImpl<$Res>
    extends _$StreamingErrorCopyWithImpl<$Res, _$ProcessingFailedImpl>
    implements _$$ProcessingFailedImplCopyWith<$Res> {
  __$$ProcessingFailedImplCopyWithImpl(
    _$ProcessingFailedImpl _value,
    $Res Function(_$ProcessingFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProcessingFailedImpl implements _ProcessingFailed {
  const _$ProcessingFailedImpl();

  @override
  String toString() {
    return 'StreamingError.processingFailed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProcessingFailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() processingFailed,
    required TResult Function() webSocketFailed,
  }) {
    return processingFailed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? processingFailed,
    TResult? Function()? webSocketFailed,
  }) {
    return processingFailed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? processingFailed,
    TResult Function()? webSocketFailed,
    required TResult orElse(),
  }) {
    if (processingFailed != null) {
      return processingFailed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingFailed value) processingFailed,
    required TResult Function(_WebSocketFailed value) webSocketFailed,
  }) {
    return processingFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingFailed value)? processingFailed,
    TResult? Function(_WebSocketFailed value)? webSocketFailed,
  }) {
    return processingFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingFailed value)? processingFailed,
    TResult Function(_WebSocketFailed value)? webSocketFailed,
    required TResult orElse(),
  }) {
    if (processingFailed != null) {
      return processingFailed(this);
    }
    return orElse();
  }
}

abstract class _ProcessingFailed implements StreamingError {
  const factory _ProcessingFailed() = _$ProcessingFailedImpl;
}

/// @nodoc
abstract class _$$WebSocketFailedImplCopyWith<$Res> {
  factory _$$WebSocketFailedImplCopyWith(
    _$WebSocketFailedImpl value,
    $Res Function(_$WebSocketFailedImpl) then,
  ) = __$$WebSocketFailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WebSocketFailedImplCopyWithImpl<$Res>
    extends _$StreamingErrorCopyWithImpl<$Res, _$WebSocketFailedImpl>
    implements _$$WebSocketFailedImplCopyWith<$Res> {
  __$$WebSocketFailedImplCopyWithImpl(
    _$WebSocketFailedImpl _value,
    $Res Function(_$WebSocketFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WebSocketFailedImpl implements _WebSocketFailed {
  const _$WebSocketFailedImpl();

  @override
  String toString() {
    return 'StreamingError.webSocketFailed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WebSocketFailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() processingFailed,
    required TResult Function() webSocketFailed,
  }) {
    return webSocketFailed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? processingFailed,
    TResult? Function()? webSocketFailed,
  }) {
    return webSocketFailed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? processingFailed,
    TResult Function()? webSocketFailed,
    required TResult orElse(),
  }) {
    if (webSocketFailed != null) {
      return webSocketFailed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingFailed value) processingFailed,
    required TResult Function(_WebSocketFailed value) webSocketFailed,
  }) {
    return webSocketFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingFailed value)? processingFailed,
    TResult? Function(_WebSocketFailed value)? webSocketFailed,
  }) {
    return webSocketFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingFailed value)? processingFailed,
    TResult Function(_WebSocketFailed value)? webSocketFailed,
    required TResult orElse(),
  }) {
    if (webSocketFailed != null) {
      return webSocketFailed(this);
    }
    return orElse();
  }
}

abstract class _WebSocketFailed implements StreamingError {
  const factory _WebSocketFailed() = _$WebSocketFailedImpl;
}
