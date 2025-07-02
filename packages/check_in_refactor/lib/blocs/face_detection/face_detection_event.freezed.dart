// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_detection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FaceDetectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionData faceDetectionData)
        detectionReceived,
    required TResult Function(dynamic newStatus) connectionStatusChanged,
    required TResult Function() clearResults,
    required TResult Function() startProcessing,
    required TResult Function() stopProcessing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult? Function(dynamic newStatus)? connectionStatusChanged,
    TResult? Function()? clearResults,
    TResult? Function()? startProcessing,
    TResult? Function()? stopProcessing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult Function(dynamic newStatus)? connectionStatusChanged,
    TResult Function()? clearResults,
    TResult Function()? startProcessing,
    TResult Function()? stopProcessing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DetectionReceived value) detectionReceived,
    required TResult Function(ConnectionStatusChanged value)
        connectionStatusChanged,
    required TResult Function(ClearResults value) clearResults,
    required TResult Function(StartProcessing value) startProcessing,
    required TResult Function(StopProcessing value) stopProcessing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DetectionReceived value)? detectionReceived,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(ClearResults value)? clearResults,
    TResult? Function(StartProcessing value)? startProcessing,
    TResult? Function(StopProcessing value)? stopProcessing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DetectionReceived value)? detectionReceived,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(ClearResults value)? clearResults,
    TResult Function(StartProcessing value)? startProcessing,
    TResult Function(StopProcessing value)? stopProcessing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceDetectionEventCopyWith<$Res> {
  factory $FaceDetectionEventCopyWith(
          FaceDetectionEvent value, $Res Function(FaceDetectionEvent) then) =
      _$FaceDetectionEventCopyWithImpl<$Res, FaceDetectionEvent>;
}

/// @nodoc
class _$FaceDetectionEventCopyWithImpl<$Res, $Val extends FaceDetectionEvent>
    implements $FaceDetectionEventCopyWith<$Res> {
  _$FaceDetectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DetectionReceivedImplCopyWith<$Res> {
  factory _$$DetectionReceivedImplCopyWith(_$DetectionReceivedImpl value,
          $Res Function(_$DetectionReceivedImpl) then) =
      __$$DetectionReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FaceDetectionData faceDetectionData});
}

/// @nodoc
class __$$DetectionReceivedImplCopyWithImpl<$Res>
    extends _$FaceDetectionEventCopyWithImpl<$Res, _$DetectionReceivedImpl>
    implements _$$DetectionReceivedImplCopyWith<$Res> {
  __$$DetectionReceivedImplCopyWithImpl(_$DetectionReceivedImpl _value,
      $Res Function(_$DetectionReceivedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faceDetectionData = null,
  }) {
    return _then(_$DetectionReceivedImpl(
      null == faceDetectionData
          ? _value.faceDetectionData
          : faceDetectionData // ignore: cast_nullable_to_non_nullable
              as FaceDetectionData,
    ));
  }
}

/// @nodoc

class _$DetectionReceivedImpl implements DetectionReceived {
  const _$DetectionReceivedImpl(this.faceDetectionData);

  @override
  final FaceDetectionData faceDetectionData;

  @override
  String toString() {
    return 'FaceDetectionEvent.detectionReceived(faceDetectionData: $faceDetectionData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetectionReceivedImpl &&
            (identical(other.faceDetectionData, faceDetectionData) ||
                other.faceDetectionData == faceDetectionData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, faceDetectionData);

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetectionReceivedImplCopyWith<_$DetectionReceivedImpl> get copyWith =>
      __$$DetectionReceivedImplCopyWithImpl<_$DetectionReceivedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionData faceDetectionData)
        detectionReceived,
    required TResult Function(dynamic newStatus) connectionStatusChanged,
    required TResult Function() clearResults,
    required TResult Function() startProcessing,
    required TResult Function() stopProcessing,
  }) {
    return detectionReceived(faceDetectionData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult? Function(dynamic newStatus)? connectionStatusChanged,
    TResult? Function()? clearResults,
    TResult? Function()? startProcessing,
    TResult? Function()? stopProcessing,
  }) {
    return detectionReceived?.call(faceDetectionData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult Function(dynamic newStatus)? connectionStatusChanged,
    TResult Function()? clearResults,
    TResult Function()? startProcessing,
    TResult Function()? stopProcessing,
    required TResult orElse(),
  }) {
    if (detectionReceived != null) {
      return detectionReceived(faceDetectionData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DetectionReceived value) detectionReceived,
    required TResult Function(ConnectionStatusChanged value)
        connectionStatusChanged,
    required TResult Function(ClearResults value) clearResults,
    required TResult Function(StartProcessing value) startProcessing,
    required TResult Function(StopProcessing value) stopProcessing,
  }) {
    return detectionReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DetectionReceived value)? detectionReceived,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(ClearResults value)? clearResults,
    TResult? Function(StartProcessing value)? startProcessing,
    TResult? Function(StopProcessing value)? stopProcessing,
  }) {
    return detectionReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DetectionReceived value)? detectionReceived,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(ClearResults value)? clearResults,
    TResult Function(StartProcessing value)? startProcessing,
    TResult Function(StopProcessing value)? stopProcessing,
    required TResult orElse(),
  }) {
    if (detectionReceived != null) {
      return detectionReceived(this);
    }
    return orElse();
  }
}

abstract class DetectionReceived implements FaceDetectionEvent {
  const factory DetectionReceived(final FaceDetectionData faceDetectionData) =
      _$DetectionReceivedImpl;

  FaceDetectionData get faceDetectionData;

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetectionReceivedImplCopyWith<_$DetectionReceivedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionStatusChangedImplCopyWith<$Res> {
  factory _$$ConnectionStatusChangedImplCopyWith(
          _$ConnectionStatusChangedImpl value,
          $Res Function(_$ConnectionStatusChangedImpl) then) =
      __$$ConnectionStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic newStatus});
}

/// @nodoc
class __$$ConnectionStatusChangedImplCopyWithImpl<$Res>
    extends _$FaceDetectionEventCopyWithImpl<$Res,
        _$ConnectionStatusChangedImpl>
    implements _$$ConnectionStatusChangedImplCopyWith<$Res> {
  __$$ConnectionStatusChangedImplCopyWithImpl(
      _$ConnectionStatusChangedImpl _value,
      $Res Function(_$ConnectionStatusChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newStatus = freezed,
  }) {
    return _then(_$ConnectionStatusChangedImpl(
      freezed == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$ConnectionStatusChangedImpl implements ConnectionStatusChanged {
  const _$ConnectionStatusChangedImpl(this.newStatus);

  @override
  final dynamic newStatus;

  @override
  String toString() {
    return 'FaceDetectionEvent.connectionStatusChanged(newStatus: $newStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionStatusChangedImpl &&
            const DeepCollectionEquality().equals(other.newStatus, newStatus));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(newStatus));

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionStatusChangedImplCopyWith<_$ConnectionStatusChangedImpl>
      get copyWith => __$$ConnectionStatusChangedImplCopyWithImpl<
          _$ConnectionStatusChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionData faceDetectionData)
        detectionReceived,
    required TResult Function(dynamic newStatus) connectionStatusChanged,
    required TResult Function() clearResults,
    required TResult Function() startProcessing,
    required TResult Function() stopProcessing,
  }) {
    return connectionStatusChanged(newStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult? Function(dynamic newStatus)? connectionStatusChanged,
    TResult? Function()? clearResults,
    TResult? Function()? startProcessing,
    TResult? Function()? stopProcessing,
  }) {
    return connectionStatusChanged?.call(newStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult Function(dynamic newStatus)? connectionStatusChanged,
    TResult Function()? clearResults,
    TResult Function()? startProcessing,
    TResult Function()? stopProcessing,
    required TResult orElse(),
  }) {
    if (connectionStatusChanged != null) {
      return connectionStatusChanged(newStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DetectionReceived value) detectionReceived,
    required TResult Function(ConnectionStatusChanged value)
        connectionStatusChanged,
    required TResult Function(ClearResults value) clearResults,
    required TResult Function(StartProcessing value) startProcessing,
    required TResult Function(StopProcessing value) stopProcessing,
  }) {
    return connectionStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DetectionReceived value)? detectionReceived,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(ClearResults value)? clearResults,
    TResult? Function(StartProcessing value)? startProcessing,
    TResult? Function(StopProcessing value)? stopProcessing,
  }) {
    return connectionStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DetectionReceived value)? detectionReceived,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(ClearResults value)? clearResults,
    TResult Function(StartProcessing value)? startProcessing,
    TResult Function(StopProcessing value)? stopProcessing,
    required TResult orElse(),
  }) {
    if (connectionStatusChanged != null) {
      return connectionStatusChanged(this);
    }
    return orElse();
  }
}

abstract class ConnectionStatusChanged implements FaceDetectionEvent {
  const factory ConnectionStatusChanged(final dynamic newStatus) =
      _$ConnectionStatusChangedImpl;

  dynamic get newStatus;

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionStatusChangedImplCopyWith<_$ConnectionStatusChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearResultsImplCopyWith<$Res> {
  factory _$$ClearResultsImplCopyWith(
          _$ClearResultsImpl value, $Res Function(_$ClearResultsImpl) then) =
      __$$ClearResultsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearResultsImplCopyWithImpl<$Res>
    extends _$FaceDetectionEventCopyWithImpl<$Res, _$ClearResultsImpl>
    implements _$$ClearResultsImplCopyWith<$Res> {
  __$$ClearResultsImplCopyWithImpl(
      _$ClearResultsImpl _value, $Res Function(_$ClearResultsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearResultsImpl implements ClearResults {
  const _$ClearResultsImpl();

  @override
  String toString() {
    return 'FaceDetectionEvent.clearResults()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearResultsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionData faceDetectionData)
        detectionReceived,
    required TResult Function(dynamic newStatus) connectionStatusChanged,
    required TResult Function() clearResults,
    required TResult Function() startProcessing,
    required TResult Function() stopProcessing,
  }) {
    return clearResults();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult? Function(dynamic newStatus)? connectionStatusChanged,
    TResult? Function()? clearResults,
    TResult? Function()? startProcessing,
    TResult? Function()? stopProcessing,
  }) {
    return clearResults?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult Function(dynamic newStatus)? connectionStatusChanged,
    TResult Function()? clearResults,
    TResult Function()? startProcessing,
    TResult Function()? stopProcessing,
    required TResult orElse(),
  }) {
    if (clearResults != null) {
      return clearResults();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DetectionReceived value) detectionReceived,
    required TResult Function(ConnectionStatusChanged value)
        connectionStatusChanged,
    required TResult Function(ClearResults value) clearResults,
    required TResult Function(StartProcessing value) startProcessing,
    required TResult Function(StopProcessing value) stopProcessing,
  }) {
    return clearResults(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DetectionReceived value)? detectionReceived,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(ClearResults value)? clearResults,
    TResult? Function(StartProcessing value)? startProcessing,
    TResult? Function(StopProcessing value)? stopProcessing,
  }) {
    return clearResults?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DetectionReceived value)? detectionReceived,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(ClearResults value)? clearResults,
    TResult Function(StartProcessing value)? startProcessing,
    TResult Function(StopProcessing value)? stopProcessing,
    required TResult orElse(),
  }) {
    if (clearResults != null) {
      return clearResults(this);
    }
    return orElse();
  }
}

abstract class ClearResults implements FaceDetectionEvent {
  const factory ClearResults() = _$ClearResultsImpl;
}

/// @nodoc
abstract class _$$StartProcessingImplCopyWith<$Res> {
  factory _$$StartProcessingImplCopyWith(_$StartProcessingImpl value,
          $Res Function(_$StartProcessingImpl) then) =
      __$$StartProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartProcessingImplCopyWithImpl<$Res>
    extends _$FaceDetectionEventCopyWithImpl<$Res, _$StartProcessingImpl>
    implements _$$StartProcessingImplCopyWith<$Res> {
  __$$StartProcessingImplCopyWithImpl(
      _$StartProcessingImpl _value, $Res Function(_$StartProcessingImpl) _then)
      : super(_value, _then);

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartProcessingImpl implements StartProcessing {
  const _$StartProcessingImpl();

  @override
  String toString() {
    return 'FaceDetectionEvent.startProcessing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionData faceDetectionData)
        detectionReceived,
    required TResult Function(dynamic newStatus) connectionStatusChanged,
    required TResult Function() clearResults,
    required TResult Function() startProcessing,
    required TResult Function() stopProcessing,
  }) {
    return startProcessing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult? Function(dynamic newStatus)? connectionStatusChanged,
    TResult? Function()? clearResults,
    TResult? Function()? startProcessing,
    TResult? Function()? stopProcessing,
  }) {
    return startProcessing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult Function(dynamic newStatus)? connectionStatusChanged,
    TResult Function()? clearResults,
    TResult Function()? startProcessing,
    TResult Function()? stopProcessing,
    required TResult orElse(),
  }) {
    if (startProcessing != null) {
      return startProcessing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DetectionReceived value) detectionReceived,
    required TResult Function(ConnectionStatusChanged value)
        connectionStatusChanged,
    required TResult Function(ClearResults value) clearResults,
    required TResult Function(StartProcessing value) startProcessing,
    required TResult Function(StopProcessing value) stopProcessing,
  }) {
    return startProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DetectionReceived value)? detectionReceived,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(ClearResults value)? clearResults,
    TResult? Function(StartProcessing value)? startProcessing,
    TResult? Function(StopProcessing value)? stopProcessing,
  }) {
    return startProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DetectionReceived value)? detectionReceived,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(ClearResults value)? clearResults,
    TResult Function(StartProcessing value)? startProcessing,
    TResult Function(StopProcessing value)? stopProcessing,
    required TResult orElse(),
  }) {
    if (startProcessing != null) {
      return startProcessing(this);
    }
    return orElse();
  }
}

abstract class StartProcessing implements FaceDetectionEvent {
  const factory StartProcessing() = _$StartProcessingImpl;
}

/// @nodoc
abstract class _$$StopProcessingImplCopyWith<$Res> {
  factory _$$StopProcessingImplCopyWith(_$StopProcessingImpl value,
          $Res Function(_$StopProcessingImpl) then) =
      __$$StopProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopProcessingImplCopyWithImpl<$Res>
    extends _$FaceDetectionEventCopyWithImpl<$Res, _$StopProcessingImpl>
    implements _$$StopProcessingImplCopyWith<$Res> {
  __$$StopProcessingImplCopyWithImpl(
      _$StopProcessingImpl _value, $Res Function(_$StopProcessingImpl) _then)
      : super(_value, _then);

  /// Create a copy of FaceDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopProcessingImpl implements StopProcessing {
  const _$StopProcessingImpl();

  @override
  String toString() {
    return 'FaceDetectionEvent.stopProcessing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StopProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionData faceDetectionData)
        detectionReceived,
    required TResult Function(dynamic newStatus) connectionStatusChanged,
    required TResult Function() clearResults,
    required TResult Function() startProcessing,
    required TResult Function() stopProcessing,
  }) {
    return stopProcessing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult? Function(dynamic newStatus)? connectionStatusChanged,
    TResult? Function()? clearResults,
    TResult? Function()? startProcessing,
    TResult? Function()? stopProcessing,
  }) {
    return stopProcessing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionData faceDetectionData)? detectionReceived,
    TResult Function(dynamic newStatus)? connectionStatusChanged,
    TResult Function()? clearResults,
    TResult Function()? startProcessing,
    TResult Function()? stopProcessing,
    required TResult orElse(),
  }) {
    if (stopProcessing != null) {
      return stopProcessing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DetectionReceived value) detectionReceived,
    required TResult Function(ConnectionStatusChanged value)
        connectionStatusChanged,
    required TResult Function(ClearResults value) clearResults,
    required TResult Function(StartProcessing value) startProcessing,
    required TResult Function(StopProcessing value) stopProcessing,
  }) {
    return stopProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DetectionReceived value)? detectionReceived,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(ClearResults value)? clearResults,
    TResult? Function(StartProcessing value)? startProcessing,
    TResult? Function(StopProcessing value)? stopProcessing,
  }) {
    return stopProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DetectionReceived value)? detectionReceived,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(ClearResults value)? clearResults,
    TResult Function(StartProcessing value)? startProcessing,
    TResult Function(StopProcessing value)? stopProcessing,
    required TResult orElse(),
  }) {
    if (stopProcessing != null) {
      return stopProcessing(this);
    }
    return orElse();
  }
}

abstract class StopProcessing implements FaceDetectionEvent {
  const factory StopProcessing() = _$StopProcessingImpl;
}
