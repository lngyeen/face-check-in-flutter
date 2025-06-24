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
  /// Current camera status
  CameraStatus get cameraStatus => throw _privateConstructorUsedError;

  /// Current permission status
  PermissionStatus get permissionStatus => throw _privateConstructorUsedError;

  /// Current error, if any
  CheckInError? get currentError => throw _privateConstructorUsedError;

  /// Camera controller instance
  CameraController? get cameraController => throw _privateConstructorUsedError;

  /// Whether debug mode is enabled
  bool get isDebugMode => throw _privateConstructorUsedError;

  /// Face detection status and confidence
  FaceDetectionStatus get faceStatus => throw _privateConstructorUsedError;

  /// Backend error information
  BackendError? get responseError => throw _privateConstructorUsedError;

  /// Connection state
  conn.ConnectionState get connectionState =>
      throw _privateConstructorUsedError;

  /// Latest frame data for full response access - contains faces, annotatedImage, timestamp, etc.
  FaceDetectionData? get latestFrameData => throw _privateConstructorUsedError;

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
    PermissionStatus permissionStatus,
    CheckInError? currentError,
    CameraController? cameraController,
    bool isDebugMode,
    FaceDetectionStatus faceStatus,
    BackendError? responseError,
    conn.ConnectionState connectionState,
    FaceDetectionData? latestFrameData,
  });

  $CheckInErrorCopyWith<$Res>? get currentError;
  $BackendErrorCopyWith<$Res>? get responseError;
  $ConnectionStateCopyWith<$Res> get connectionState;
  $FaceDetectionDataCopyWith<$Res>? get latestFrameData;
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
    Object? permissionStatus = null,
    Object? currentError = freezed,
    Object? cameraController = freezed,
    Object? isDebugMode = null,
    Object? faceStatus = null,
    Object? responseError = freezed,
    Object? connectionState = null,
    Object? latestFrameData = freezed,
  }) {
    return _then(
      _value.copyWith(
            cameraStatus:
                null == cameraStatus
                    ? _value.cameraStatus
                    : cameraStatus // ignore: cast_nullable_to_non_nullable
                        as CameraStatus,
            permissionStatus:
                null == permissionStatus
                    ? _value.permissionStatus
                    : permissionStatus // ignore: cast_nullable_to_non_nullable
                        as PermissionStatus,
            currentError:
                freezed == currentError
                    ? _value.currentError
                    : currentError // ignore: cast_nullable_to_non_nullable
                        as CheckInError?,
            cameraController:
                freezed == cameraController
                    ? _value.cameraController
                    : cameraController // ignore: cast_nullable_to_non_nullable
                        as CameraController?,
            isDebugMode:
                null == isDebugMode
                    ? _value.isDebugMode
                    : isDebugMode // ignore: cast_nullable_to_non_nullable
                        as bool,
            faceStatus:
                null == faceStatus
                    ? _value.faceStatus
                    : faceStatus // ignore: cast_nullable_to_non_nullable
                        as FaceDetectionStatus,
            responseError:
                freezed == responseError
                    ? _value.responseError
                    : responseError // ignore: cast_nullable_to_non_nullable
                        as BackendError?,
            connectionState:
                null == connectionState
                    ? _value.connectionState
                    : connectionState // ignore: cast_nullable_to_non_nullable
                        as conn.ConnectionState,
            latestFrameData:
                freezed == latestFrameData
                    ? _value.latestFrameData
                    : latestFrameData // ignore: cast_nullable_to_non_nullable
                        as FaceDetectionData?,
          )
          as $Val,
    );
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

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BackendErrorCopyWith<$Res>? get responseError {
    if (_value.responseError == null) {
      return null;
    }

    return $BackendErrorCopyWith<$Res>(_value.responseError!, (value) {
      return _then(_value.copyWith(responseError: value) as $Val);
    });
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
    PermissionStatus permissionStatus,
    CheckInError? currentError,
    CameraController? cameraController,
    bool isDebugMode,
    FaceDetectionStatus faceStatus,
    BackendError? responseError,
    conn.ConnectionState connectionState,
    FaceDetectionData? latestFrameData,
  });

  @override
  $CheckInErrorCopyWith<$Res>? get currentError;
  @override
  $BackendErrorCopyWith<$Res>? get responseError;
  @override
  $ConnectionStateCopyWith<$Res> get connectionState;
  @override
  $FaceDetectionDataCopyWith<$Res>? get latestFrameData;
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
    Object? permissionStatus = null,
    Object? currentError = freezed,
    Object? cameraController = freezed,
    Object? isDebugMode = null,
    Object? faceStatus = null,
    Object? responseError = freezed,
    Object? connectionState = null,
    Object? latestFrameData = freezed,
  }) {
    return _then(
      _$CheckInStateImpl(
        cameraStatus:
            null == cameraStatus
                ? _value.cameraStatus
                : cameraStatus // ignore: cast_nullable_to_non_nullable
                    as CameraStatus,
        permissionStatus:
            null == permissionStatus
                ? _value.permissionStatus
                : permissionStatus // ignore: cast_nullable_to_non_nullable
                    as PermissionStatus,
        currentError:
            freezed == currentError
                ? _value.currentError
                : currentError // ignore: cast_nullable_to_non_nullable
                    as CheckInError?,
        cameraController:
            freezed == cameraController
                ? _value.cameraController
                : cameraController // ignore: cast_nullable_to_non_nullable
                    as CameraController?,
        isDebugMode:
            null == isDebugMode
                ? _value.isDebugMode
                : isDebugMode // ignore: cast_nullable_to_non_nullable
                    as bool,
        faceStatus:
            null == faceStatus
                ? _value.faceStatus
                : faceStatus // ignore: cast_nullable_to_non_nullable
                    as FaceDetectionStatus,
        responseError:
            freezed == responseError
                ? _value.responseError
                : responseError // ignore: cast_nullable_to_non_nullable
                    as BackendError?,
        connectionState:
            null == connectionState
                ? _value.connectionState
                : connectionState // ignore: cast_nullable_to_non_nullable
                    as conn.ConnectionState,
        latestFrameData:
            freezed == latestFrameData
                ? _value.latestFrameData
                : latestFrameData // ignore: cast_nullable_to_non_nullable
                    as FaceDetectionData?,
      ),
    );
  }
}

/// @nodoc

class _$CheckInStateImpl extends _CheckInState {
  const _$CheckInStateImpl({
    this.cameraStatus = CameraStatus.initial,
    this.permissionStatus = PermissionStatus.initial,
    this.currentError,
    this.cameraController,
    this.isDebugMode = false,
    this.faceStatus = FaceDetectionStatus.none,
    this.responseError,
    this.connectionState = const ConnectionState(),
    this.latestFrameData,
  }) : super._();

  /// Current camera status
  @override
  @JsonKey()
  final CameraStatus cameraStatus;

  /// Current permission status
  @override
  @JsonKey()
  final PermissionStatus permissionStatus;

  /// Current error, if any
  @override
  final CheckInError? currentError;

  /// Camera controller instance
  @override
  final CameraController? cameraController;

  /// Whether debug mode is enabled
  @override
  @JsonKey()
  final bool isDebugMode;

  /// Face detection status and confidence
  @override
  @JsonKey()
  final FaceDetectionStatus faceStatus;

  /// Backend error information
  @override
  final BackendError? responseError;

  /// Connection state
  @override
  @JsonKey()
  final conn.ConnectionState connectionState;

  /// Latest frame data for full response access - contains faces, annotatedImage, timestamp, etc.
  @override
  final FaceDetectionData? latestFrameData;

  @override
  String toString() {
    return 'CheckInState(cameraStatus: $cameraStatus, permissionStatus: $permissionStatus, currentError: $currentError, cameraController: $cameraController, isDebugMode: $isDebugMode, faceStatus: $faceStatus, responseError: $responseError, connectionState: $connectionState, latestFrameData: $latestFrameData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInStateImpl &&
            (identical(other.cameraStatus, cameraStatus) ||
                other.cameraStatus == cameraStatus) &&
            (identical(other.permissionStatus, permissionStatus) ||
                other.permissionStatus == permissionStatus) &&
            (identical(other.currentError, currentError) ||
                other.currentError == currentError) &&
            (identical(other.cameraController, cameraController) ||
                other.cameraController == cameraController) &&
            (identical(other.isDebugMode, isDebugMode) ||
                other.isDebugMode == isDebugMode) &&
            (identical(other.faceStatus, faceStatus) ||
                other.faceStatus == faceStatus) &&
            (identical(other.responseError, responseError) ||
                other.responseError == responseError) &&
            (identical(other.connectionState, connectionState) ||
                other.connectionState == connectionState) &&
            (identical(other.latestFrameData, latestFrameData) ||
                other.latestFrameData == latestFrameData));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    cameraStatus,
    permissionStatus,
    currentError,
    cameraController,
    isDebugMode,
    faceStatus,
    responseError,
    connectionState,
    latestFrameData,
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
    final PermissionStatus permissionStatus,
    final CheckInError? currentError,
    final CameraController? cameraController,
    final bool isDebugMode,
    final FaceDetectionStatus faceStatus,
    final BackendError? responseError,
    final conn.ConnectionState connectionState,
    final FaceDetectionData? latestFrameData,
  }) = _$CheckInStateImpl;
  const _CheckInState._() : super._();

  /// Current camera status
  @override
  CameraStatus get cameraStatus;

  /// Current permission status
  @override
  PermissionStatus get permissionStatus;

  /// Current error, if any
  @override
  CheckInError? get currentError;

  /// Camera controller instance
  @override
  CameraController? get cameraController;

  /// Whether debug mode is enabled
  @override
  bool get isDebugMode;

  /// Face detection status and confidence
  @override
  FaceDetectionStatus get faceStatus;

  /// Backend error information
  @override
  BackendError? get responseError;

  /// Connection state
  @override
  conn.ConnectionState get connectionState;

  /// Latest frame data for full response access - contains faces, annotatedImage, timestamp, etc.
  @override
  FaceDetectionData? get latestFrameData;

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
