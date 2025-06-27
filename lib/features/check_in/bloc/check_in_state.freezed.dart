// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CheckInState {
  CameraStatus get cameraStatus => throw _privateConstructorUsedError;
  CameraController? get cameraController => throw _privateConstructorUsedError;
  ConnectionState get connectionState => throw _privateConstructorUsedError;
  FaceDetectionData? get latestFrameData => throw _privateConstructorUsedError;
  CheckInError? get currentError => throw _privateConstructorUsedError;
  bool get isDebugMode => throw _privateConstructorUsedError;

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInStateCopyWith<CheckInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInStateCopyWith<$Res> {
  factory $CheckInStateCopyWith(
    CheckInState value,
    $Res Function(CheckInState) then,
  ) = _$CheckInStateCopyWithImpl<$Res, CheckInState>;
  @useResult
  $Res call({
    CameraStatus cameraStatus,
    CameraController? cameraController,
    ConnectionState connectionState,
    FaceDetectionData? latestFrameData,
    CheckInError? currentError,
    bool isDebugMode,
  });

  $ConnectionStateCopyWith<$Res> get connectionState;
  $FaceDetectionDataCopyWith<$Res>? get latestFrameData;
  $CheckInErrorCopyWith<$Res>? get currentError;
}

/// @nodoc
class _$CheckInStateCopyWithImpl<$Res, $Val extends CheckInState>
    implements $CheckInStateCopyWith<$Res> {
  _$CheckInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraStatus = null,
    Object? cameraController = freezed,
    Object? connectionState = null,
    Object? latestFrameData = freezed,
    Object? currentError = freezed,
    Object? isDebugMode = null,
  }) {
    return _then(
      _value.copyWith(
            cameraStatus:
                null == cameraStatus
                    ? _value.cameraStatus
                    : cameraStatus // ignore: cast_nullable_to_non_nullable
                        as CameraStatus,
            cameraController:
                freezed == cameraController
                    ? _value.cameraController
                    : cameraController // ignore: cast_nullable_to_non_nullable
                        as CameraController?,
            connectionState:
                null == connectionState
                    ? _value.connectionState
                    : connectionState // ignore: cast_nullable_to_non_nullable
                        as ConnectionState,
            latestFrameData:
                freezed == latestFrameData
                    ? _value.latestFrameData
                    : latestFrameData // ignore: cast_nullable_to_non_nullable
                        as FaceDetectionData?,
            currentError:
                freezed == currentError
                    ? _value.currentError
                    : currentError // ignore: cast_nullable_to_non_nullable
                        as CheckInError?,
            isDebugMode:
                null == isDebugMode
                    ? _value.isDebugMode
                    : isDebugMode // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionStateCopyWith<$Res> get connectionState {
    return $ConnectionStateCopyWith<$Res>(_value.connectionState, (value) {
      return _then(_value.copyWith(connectionState: value) as $Val);
    });
  }

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FaceDetectionDataCopyWith<$Res>? get latestFrameData {
    if (_value.latestFrameData == null) {
      return null;
    }

    return $FaceDetectionDataCopyWith<$Res>(_value.latestFrameData!, (value) {
      return _then(_value.copyWith(latestFrameData: value) as $Val);
    });
  }

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CheckInErrorCopyWith<$Res>? get currentError {
    if (_value.currentError == null) {
      return null;
    }

    return $CheckInErrorCopyWith<$Res>(_value.currentError!, (value) {
      return _then(_value.copyWith(currentError: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckInStateImplCopyWith<$Res>
    implements $CheckInStateCopyWith<$Res> {
  factory _$$CheckInStateImplCopyWith(
    _$CheckInStateImpl value,
    $Res Function(_$CheckInStateImpl) then,
  ) = __$$CheckInStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CameraStatus cameraStatus,
    CameraController? cameraController,
    ConnectionState connectionState,
    FaceDetectionData? latestFrameData,
    CheckInError? currentError,
    bool isDebugMode,
  });

  @override
  $ConnectionStateCopyWith<$Res> get connectionState;
  @override
  $FaceDetectionDataCopyWith<$Res>? get latestFrameData;
  @override
  $CheckInErrorCopyWith<$Res>? get currentError;
}

/// @nodoc
class __$$CheckInStateImplCopyWithImpl<$Res>
    extends _$CheckInStateCopyWithImpl<$Res, _$CheckInStateImpl>
    implements _$$CheckInStateImplCopyWith<$Res> {
  __$$CheckInStateImplCopyWithImpl(
    _$CheckInStateImpl _value,
    $Res Function(_$CheckInStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraStatus = null,
    Object? cameraController = freezed,
    Object? connectionState = null,
    Object? latestFrameData = freezed,
    Object? currentError = freezed,
    Object? isDebugMode = null,
  }) {
    return _then(
      _$CheckInStateImpl(
        cameraStatus:
            null == cameraStatus
                ? _value.cameraStatus
                : cameraStatus // ignore: cast_nullable_to_non_nullable
                    as CameraStatus,
        cameraController:
            freezed == cameraController
                ? _value.cameraController
                : cameraController // ignore: cast_nullable_to_non_nullable
                    as CameraController?,
        connectionState:
            null == connectionState
                ? _value.connectionState
                : connectionState // ignore: cast_nullable_to_non_nullable
                    as ConnectionState,
        latestFrameData:
            freezed == latestFrameData
                ? _value.latestFrameData
                : latestFrameData // ignore: cast_nullable_to_non_nullable
                    as FaceDetectionData?,
        currentError:
            freezed == currentError
                ? _value.currentError
                : currentError // ignore: cast_nullable_to_non_nullable
                    as CheckInError?,
        isDebugMode:
            null == isDebugMode
                ? _value.isDebugMode
                : isDebugMode // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$CheckInStateImpl extends _CheckInState {
  const _$CheckInStateImpl({
    this.cameraStatus = CameraStatus.initial,
    this.cameraController,
    this.connectionState = const ConnectionState(),
    this.latestFrameData,
    this.currentError,
    this.isDebugMode = false,
  }) : super._();

  @override
  @JsonKey()
  final CameraStatus cameraStatus;
  @override
  final CameraController? cameraController;
  @override
  @JsonKey()
  final ConnectionState connectionState;
  @override
  final FaceDetectionData? latestFrameData;
  @override
  final CheckInError? currentError;
  @override
  @JsonKey()
  final bool isDebugMode;

  @override
  String toString() {
    return 'CheckInState(cameraStatus: $cameraStatus, cameraController: $cameraController, connectionState: $connectionState, latestFrameData: $latestFrameData, currentError: $currentError, isDebugMode: $isDebugMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInStateImpl &&
            (identical(other.cameraStatus, cameraStatus) ||
                other.cameraStatus == cameraStatus) &&
            (identical(other.cameraController, cameraController) ||
                other.cameraController == cameraController) &&
            (identical(other.connectionState, connectionState) ||
                other.connectionState == connectionState) &&
            (identical(other.latestFrameData, latestFrameData) ||
                other.latestFrameData == latestFrameData) &&
            (identical(other.currentError, currentError) ||
                other.currentError == currentError) &&
            (identical(other.isDebugMode, isDebugMode) ||
                other.isDebugMode == isDebugMode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    cameraStatus,
    cameraController,
    connectionState,
    latestFrameData,
    currentError,
    isDebugMode,
  );

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      __$$CheckInStateImplCopyWithImpl<_$CheckInStateImpl>(this, _$identity);
}

abstract class _CheckInState extends CheckInState {
  const factory _CheckInState({
    final CameraStatus cameraStatus,
    final CameraController? cameraController,
    final ConnectionState connectionState,
    final FaceDetectionData? latestFrameData,
    final CheckInError? currentError,
    final bool isDebugMode,
  }) = _$CheckInStateImpl;
  const _CheckInState._() : super._();

  @override
  CameraStatus get cameraStatus;
  @override
  CameraController? get cameraController;
  @override
  ConnectionState get connectionState;
  @override
  FaceDetectionData? get latestFrameData;
  @override
  CheckInError? get currentError;
  @override
  bool get isDebugMode;

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
