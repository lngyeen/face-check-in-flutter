// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'liveness_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LivenessResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double confidence) passed,
    required TResult Function(LivenessFailureReason reason) failed,
    required TResult Function(String? message) error,
    required TResult Function() processing,
    required TResult Function() needMoreFrames,
    required TResult Function() completed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double confidence)? passed,
    TResult? Function(LivenessFailureReason reason)? failed,
    TResult? Function(String? message)? error,
    TResult? Function()? processing,
    TResult? Function()? needMoreFrames,
    TResult? Function()? completed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double confidence)? passed,
    TResult Function(LivenessFailureReason reason)? failed,
    TResult Function(String? message)? error,
    TResult Function()? processing,
    TResult Function()? needMoreFrames,
    TResult Function()? completed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Passed value) passed,
    required TResult Function(Failed value) failed,
    required TResult Function(Error value) error,
    required TResult Function(Processing value) processing,
    required TResult Function(NeedMoreFrames value) needMoreFrames,
    required TResult Function(Completed value) completed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Passed value)? passed,
    TResult? Function(Failed value)? failed,
    TResult? Function(Error value)? error,
    TResult? Function(Processing value)? processing,
    TResult? Function(NeedMoreFrames value)? needMoreFrames,
    TResult? Function(Completed value)? completed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Passed value)? passed,
    TResult Function(Failed value)? failed,
    TResult Function(Error value)? error,
    TResult Function(Processing value)? processing,
    TResult Function(NeedMoreFrames value)? needMoreFrames,
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LivenessResultCopyWith<$Res> {
  factory $LivenessResultCopyWith(
    LivenessResult value,
    $Res Function(LivenessResult) then,
  ) = _$LivenessResultCopyWithImpl<$Res, LivenessResult>;
}

/// @nodoc
class _$LivenessResultCopyWithImpl<$Res, $Val extends LivenessResult>
    implements $LivenessResultCopyWith<$Res> {
  _$LivenessResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PassedImplCopyWith<$Res> {
  factory _$$PassedImplCopyWith(
    _$PassedImpl value,
    $Res Function(_$PassedImpl) then,
  ) = __$$PassedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double confidence});
}

/// @nodoc
class __$$PassedImplCopyWithImpl<$Res>
    extends _$LivenessResultCopyWithImpl<$Res, _$PassedImpl>
    implements _$$PassedImplCopyWith<$Res> {
  __$$PassedImplCopyWithImpl(
    _$PassedImpl _value,
    $Res Function(_$PassedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? confidence = null}) {
    return _then(
      _$PassedImpl(
        confidence:
            null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _$PassedImpl extends Passed {
  const _$PassedImpl({this.confidence = 1.0}) : super._();

  @override
  @JsonKey()
  final double confidence;

  @override
  String toString() {
    return 'LivenessResult.passed(confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassedImpl &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confidence);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PassedImplCopyWith<_$PassedImpl> get copyWith =>
      __$$PassedImplCopyWithImpl<_$PassedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double confidence) passed,
    required TResult Function(LivenessFailureReason reason) failed,
    required TResult Function(String? message) error,
    required TResult Function() processing,
    required TResult Function() needMoreFrames,
    required TResult Function() completed,
  }) {
    return passed(confidence);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double confidence)? passed,
    TResult? Function(LivenessFailureReason reason)? failed,
    TResult? Function(String? message)? error,
    TResult? Function()? processing,
    TResult? Function()? needMoreFrames,
    TResult? Function()? completed,
  }) {
    return passed?.call(confidence);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double confidence)? passed,
    TResult Function(LivenessFailureReason reason)? failed,
    TResult Function(String? message)? error,
    TResult Function()? processing,
    TResult Function()? needMoreFrames,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (passed != null) {
      return passed(confidence);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Passed value) passed,
    required TResult Function(Failed value) failed,
    required TResult Function(Error value) error,
    required TResult Function(Processing value) processing,
    required TResult Function(NeedMoreFrames value) needMoreFrames,
    required TResult Function(Completed value) completed,
  }) {
    return passed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Passed value)? passed,
    TResult? Function(Failed value)? failed,
    TResult? Function(Error value)? error,
    TResult? Function(Processing value)? processing,
    TResult? Function(NeedMoreFrames value)? needMoreFrames,
    TResult? Function(Completed value)? completed,
  }) {
    return passed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Passed value)? passed,
    TResult Function(Failed value)? failed,
    TResult Function(Error value)? error,
    TResult Function(Processing value)? processing,
    TResult Function(NeedMoreFrames value)? needMoreFrames,
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) {
    if (passed != null) {
      return passed(this);
    }
    return orElse();
  }
}

abstract class Passed extends LivenessResult {
  const factory Passed({final double confidence}) = _$PassedImpl;
  const Passed._() : super._();

  double get confidence;

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PassedImplCopyWith<_$PassedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
    _$FailedImpl value,
    $Res Function(_$FailedImpl) then,
  ) = __$$FailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LivenessFailureReason reason});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$LivenessResultCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
    _$FailedImpl _value,
    $Res Function(_$FailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = null}) {
    return _then(
      _$FailedImpl(
        reason:
            null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                    as LivenessFailureReason,
      ),
    );
  }
}

/// @nodoc

class _$FailedImpl extends Failed {
  const _$FailedImpl({required this.reason}) : super._();

  @override
  final LivenessFailureReason reason;

  @override
  String toString() {
    return 'LivenessResult.failed(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double confidence) passed,
    required TResult Function(LivenessFailureReason reason) failed,
    required TResult Function(String? message) error,
    required TResult Function() processing,
    required TResult Function() needMoreFrames,
    required TResult Function() completed,
  }) {
    return failed(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double confidence)? passed,
    TResult? Function(LivenessFailureReason reason)? failed,
    TResult? Function(String? message)? error,
    TResult? Function()? processing,
    TResult? Function()? needMoreFrames,
    TResult? Function()? completed,
  }) {
    return failed?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double confidence)? passed,
    TResult Function(LivenessFailureReason reason)? failed,
    TResult Function(String? message)? error,
    TResult Function()? processing,
    TResult Function()? needMoreFrames,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Passed value) passed,
    required TResult Function(Failed value) failed,
    required TResult Function(Error value) error,
    required TResult Function(Processing value) processing,
    required TResult Function(NeedMoreFrames value) needMoreFrames,
    required TResult Function(Completed value) completed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Passed value)? passed,
    TResult? Function(Failed value)? failed,
    TResult? Function(Error value)? error,
    TResult? Function(Processing value)? processing,
    TResult? Function(NeedMoreFrames value)? needMoreFrames,
    TResult? Function(Completed value)? completed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Passed value)? passed,
    TResult Function(Failed value)? failed,
    TResult Function(Error value)? error,
    TResult Function(Processing value)? processing,
    TResult Function(NeedMoreFrames value)? needMoreFrames,
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class Failed extends LivenessResult {
  const factory Failed({required final LivenessFailureReason reason}) =
      _$FailedImpl;
  const Failed._() : super._();

  LivenessFailureReason get reason;

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$LivenessResultCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$ErrorImpl(
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

class _$ErrorImpl extends Error {
  const _$ErrorImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'LivenessResult.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double confidence) passed,
    required TResult Function(LivenessFailureReason reason) failed,
    required TResult Function(String? message) error,
    required TResult Function() processing,
    required TResult Function() needMoreFrames,
    required TResult Function() completed,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double confidence)? passed,
    TResult? Function(LivenessFailureReason reason)? failed,
    TResult? Function(String? message)? error,
    TResult? Function()? processing,
    TResult? Function()? needMoreFrames,
    TResult? Function()? completed,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double confidence)? passed,
    TResult Function(LivenessFailureReason reason)? failed,
    TResult Function(String? message)? error,
    TResult Function()? processing,
    TResult Function()? needMoreFrames,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Passed value) passed,
    required TResult Function(Failed value) failed,
    required TResult Function(Error value) error,
    required TResult Function(Processing value) processing,
    required TResult Function(NeedMoreFrames value) needMoreFrames,
    required TResult Function(Completed value) completed,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Passed value)? passed,
    TResult? Function(Failed value)? failed,
    TResult? Function(Error value)? error,
    TResult? Function(Processing value)? processing,
    TResult? Function(NeedMoreFrames value)? needMoreFrames,
    TResult? Function(Completed value)? completed,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Passed value)? passed,
    TResult Function(Failed value)? failed,
    TResult Function(Error value)? error,
    TResult Function(Processing value)? processing,
    TResult Function(NeedMoreFrames value)? needMoreFrames,
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error extends LivenessResult {
  const factory Error({final String? message}) = _$ErrorImpl;
  const Error._() : super._();

  String? get message;

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessingImplCopyWith<$Res> {
  factory _$$ProcessingImplCopyWith(
    _$ProcessingImpl value,
    $Res Function(_$ProcessingImpl) then,
  ) = __$$ProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProcessingImplCopyWithImpl<$Res>
    extends _$LivenessResultCopyWithImpl<$Res, _$ProcessingImpl>
    implements _$$ProcessingImplCopyWith<$Res> {
  __$$ProcessingImplCopyWithImpl(
    _$ProcessingImpl _value,
    $Res Function(_$ProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProcessingImpl extends Processing {
  const _$ProcessingImpl() : super._();

  @override
  String toString() {
    return 'LivenessResult.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double confidence) passed,
    required TResult Function(LivenessFailureReason reason) failed,
    required TResult Function(String? message) error,
    required TResult Function() processing,
    required TResult Function() needMoreFrames,
    required TResult Function() completed,
  }) {
    return processing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double confidence)? passed,
    TResult? Function(LivenessFailureReason reason)? failed,
    TResult? Function(String? message)? error,
    TResult? Function()? processing,
    TResult? Function()? needMoreFrames,
    TResult? Function()? completed,
  }) {
    return processing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double confidence)? passed,
    TResult Function(LivenessFailureReason reason)? failed,
    TResult Function(String? message)? error,
    TResult Function()? processing,
    TResult Function()? needMoreFrames,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Passed value) passed,
    required TResult Function(Failed value) failed,
    required TResult Function(Error value) error,
    required TResult Function(Processing value) processing,
    required TResult Function(NeedMoreFrames value) needMoreFrames,
    required TResult Function(Completed value) completed,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Passed value)? passed,
    TResult? Function(Failed value)? failed,
    TResult? Function(Error value)? error,
    TResult? Function(Processing value)? processing,
    TResult? Function(NeedMoreFrames value)? needMoreFrames,
    TResult? Function(Completed value)? completed,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Passed value)? passed,
    TResult Function(Failed value)? failed,
    TResult Function(Error value)? error,
    TResult Function(Processing value)? processing,
    TResult Function(NeedMoreFrames value)? needMoreFrames,
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class Processing extends LivenessResult {
  const factory Processing() = _$ProcessingImpl;
  const Processing._() : super._();
}

/// @nodoc
abstract class _$$NeedMoreFramesImplCopyWith<$Res> {
  factory _$$NeedMoreFramesImplCopyWith(
    _$NeedMoreFramesImpl value,
    $Res Function(_$NeedMoreFramesImpl) then,
  ) = __$$NeedMoreFramesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NeedMoreFramesImplCopyWithImpl<$Res>
    extends _$LivenessResultCopyWithImpl<$Res, _$NeedMoreFramesImpl>
    implements _$$NeedMoreFramesImplCopyWith<$Res> {
  __$$NeedMoreFramesImplCopyWithImpl(
    _$NeedMoreFramesImpl _value,
    $Res Function(_$NeedMoreFramesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NeedMoreFramesImpl extends NeedMoreFrames {
  const _$NeedMoreFramesImpl() : super._();

  @override
  String toString() {
    return 'LivenessResult.needMoreFrames()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NeedMoreFramesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double confidence) passed,
    required TResult Function(LivenessFailureReason reason) failed,
    required TResult Function(String? message) error,
    required TResult Function() processing,
    required TResult Function() needMoreFrames,
    required TResult Function() completed,
  }) {
    return needMoreFrames();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double confidence)? passed,
    TResult? Function(LivenessFailureReason reason)? failed,
    TResult? Function(String? message)? error,
    TResult? Function()? processing,
    TResult? Function()? needMoreFrames,
    TResult? Function()? completed,
  }) {
    return needMoreFrames?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double confidence)? passed,
    TResult Function(LivenessFailureReason reason)? failed,
    TResult Function(String? message)? error,
    TResult Function()? processing,
    TResult Function()? needMoreFrames,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (needMoreFrames != null) {
      return needMoreFrames();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Passed value) passed,
    required TResult Function(Failed value) failed,
    required TResult Function(Error value) error,
    required TResult Function(Processing value) processing,
    required TResult Function(NeedMoreFrames value) needMoreFrames,
    required TResult Function(Completed value) completed,
  }) {
    return needMoreFrames(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Passed value)? passed,
    TResult? Function(Failed value)? failed,
    TResult? Function(Error value)? error,
    TResult? Function(Processing value)? processing,
    TResult? Function(NeedMoreFrames value)? needMoreFrames,
    TResult? Function(Completed value)? completed,
  }) {
    return needMoreFrames?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Passed value)? passed,
    TResult Function(Failed value)? failed,
    TResult Function(Error value)? error,
    TResult Function(Processing value)? processing,
    TResult Function(NeedMoreFrames value)? needMoreFrames,
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) {
    if (needMoreFrames != null) {
      return needMoreFrames(this);
    }
    return orElse();
  }
}

abstract class NeedMoreFrames extends LivenessResult {
  const factory NeedMoreFrames() = _$NeedMoreFramesImpl;
  const NeedMoreFrames._() : super._();
}

/// @nodoc
abstract class _$$CompletedImplCopyWith<$Res> {
  factory _$$CompletedImplCopyWith(
    _$CompletedImpl value,
    $Res Function(_$CompletedImpl) then,
  ) = __$$CompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompletedImplCopyWithImpl<$Res>
    extends _$LivenessResultCopyWithImpl<$Res, _$CompletedImpl>
    implements _$$CompletedImplCopyWith<$Res> {
  __$$CompletedImplCopyWithImpl(
    _$CompletedImpl _value,
    $Res Function(_$CompletedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LivenessResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompletedImpl extends Completed {
  const _$CompletedImpl() : super._();

  @override
  String toString() {
    return 'LivenessResult.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double confidence) passed,
    required TResult Function(LivenessFailureReason reason) failed,
    required TResult Function(String? message) error,
    required TResult Function() processing,
    required TResult Function() needMoreFrames,
    required TResult Function() completed,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double confidence)? passed,
    TResult? Function(LivenessFailureReason reason)? failed,
    TResult? Function(String? message)? error,
    TResult? Function()? processing,
    TResult? Function()? needMoreFrames,
    TResult? Function()? completed,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double confidence)? passed,
    TResult Function(LivenessFailureReason reason)? failed,
    TResult Function(String? message)? error,
    TResult Function()? processing,
    TResult Function()? needMoreFrames,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Passed value) passed,
    required TResult Function(Failed value) failed,
    required TResult Function(Error value) error,
    required TResult Function(Processing value) processing,
    required TResult Function(NeedMoreFrames value) needMoreFrames,
    required TResult Function(Completed value) completed,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Passed value)? passed,
    TResult? Function(Failed value)? failed,
    TResult? Function(Error value)? error,
    TResult? Function(Processing value)? processing,
    TResult? Function(NeedMoreFrames value)? needMoreFrames,
    TResult? Function(Completed value)? completed,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Passed value)? passed,
    TResult Function(Failed value)? failed,
    TResult Function(Error value)? error,
    TResult Function(Processing value)? processing,
    TResult Function(NeedMoreFrames value)? needMoreFrames,
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class Completed extends LivenessResult {
  const factory Completed() = _$CompletedImpl;
  const Completed._() : super._();
}
