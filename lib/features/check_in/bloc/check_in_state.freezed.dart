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

  /// Current WebSocket connection status
  ConnectionStatus get connectionStatus => throw _privateConstructorUsedError;

  /// Current frame streaming status
  StreamingStatus get streamingStatus => throw _privateConstructorUsedError;

  /// Whether the app is in a loading state
  bool get isLoading => throw _privateConstructorUsedError;

  /// Current error message, if any
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Current toast notification status
  ToastStatus get toastStatus => throw _privateConstructorUsedError;

  /// Message to display in toast notification
  String? get toastMessage => throw _privateConstructorUsedError;

  /// Whether debug mode is enabled
  bool get isDebugMode => throw _privateConstructorUsedError;

  /// Last recognition result timestamp
  DateTime? get lastRecognitionTime => throw _privateConstructorUsedError;

  /// Number of frames processed
  int get framesProcessed => throw _privateConstructorUsedError;

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
    ConnectionStatus connectionStatus,
    StreamingStatus streamingStatus,
    bool isLoading,
    String? errorMessage,
    ToastStatus toastStatus,
    String? toastMessage,
    bool isDebugMode,
    DateTime? lastRecognitionTime,
    int framesProcessed,
  });
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
    Object? connectionStatus = null,
    Object? streamingStatus = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? toastStatus = null,
    Object? toastMessage = freezed,
    Object? isDebugMode = null,
    Object? lastRecognitionTime = freezed,
    Object? framesProcessed = null,
  }) {
    return _then(
      _value.copyWith(
            cameraStatus:
                null == cameraStatus
                    ? _value.cameraStatus
                    : cameraStatus // ignore: cast_nullable_to_non_nullable
                        as CameraStatus,
            connectionStatus:
                null == connectionStatus
                    ? _value.connectionStatus
                    : connectionStatus // ignore: cast_nullable_to_non_nullable
                        as ConnectionStatus,
            streamingStatus:
                null == streamingStatus
                    ? _value.streamingStatus
                    : streamingStatus // ignore: cast_nullable_to_non_nullable
                        as StreamingStatus,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            toastStatus:
                null == toastStatus
                    ? _value.toastStatus
                    : toastStatus // ignore: cast_nullable_to_non_nullable
                        as ToastStatus,
            toastMessage:
                freezed == toastMessage
                    ? _value.toastMessage
                    : toastMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            isDebugMode:
                null == isDebugMode
                    ? _value.isDebugMode
                    : isDebugMode // ignore: cast_nullable_to_non_nullable
                        as bool,
            lastRecognitionTime:
                freezed == lastRecognitionTime
                    ? _value.lastRecognitionTime
                    : lastRecognitionTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            framesProcessed:
                null == framesProcessed
                    ? _value.framesProcessed
                    : framesProcessed // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
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
    ConnectionStatus connectionStatus,
    StreamingStatus streamingStatus,
    bool isLoading,
    String? errorMessage,
    ToastStatus toastStatus,
    String? toastMessage,
    bool isDebugMode,
    DateTime? lastRecognitionTime,
    int framesProcessed,
  });
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
    Object? connectionStatus = null,
    Object? streamingStatus = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? toastStatus = null,
    Object? toastMessage = freezed,
    Object? isDebugMode = null,
    Object? lastRecognitionTime = freezed,
    Object? framesProcessed = null,
  }) {
    return _then(
      _$CheckInStateImpl(
        cameraStatus:
            null == cameraStatus
                ? _value.cameraStatus
                : cameraStatus // ignore: cast_nullable_to_non_nullable
                    as CameraStatus,
        connectionStatus:
            null == connectionStatus
                ? _value.connectionStatus
                : connectionStatus // ignore: cast_nullable_to_non_nullable
                    as ConnectionStatus,
        streamingStatus:
            null == streamingStatus
                ? _value.streamingStatus
                : streamingStatus // ignore: cast_nullable_to_non_nullable
                    as StreamingStatus,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        toastStatus:
            null == toastStatus
                ? _value.toastStatus
                : toastStatus // ignore: cast_nullable_to_non_nullable
                    as ToastStatus,
        toastMessage:
            freezed == toastMessage
                ? _value.toastMessage
                : toastMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        isDebugMode:
            null == isDebugMode
                ? _value.isDebugMode
                : isDebugMode // ignore: cast_nullable_to_non_nullable
                    as bool,
        lastRecognitionTime:
            freezed == lastRecognitionTime
                ? _value.lastRecognitionTime
                : lastRecognitionTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        framesProcessed:
            null == framesProcessed
                ? _value.framesProcessed
                : framesProcessed // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$CheckInStateImpl implements _CheckInState {
  const _$CheckInStateImpl({
    this.cameraStatus = CameraStatus.initial,
    this.connectionStatus = ConnectionStatus.disconnected,
    this.streamingStatus = StreamingStatus.idle,
    this.isLoading = false,
    this.errorMessage,
    this.toastStatus = ToastStatus.none,
    this.toastMessage,
    this.isDebugMode = false,
    this.lastRecognitionTime,
    this.framesProcessed = 0,
  });

  /// Current camera status
  @override
  @JsonKey()
  final CameraStatus cameraStatus;

  /// Current WebSocket connection status
  @override
  @JsonKey()
  final ConnectionStatus connectionStatus;

  /// Current frame streaming status
  @override
  @JsonKey()
  final StreamingStatus streamingStatus;

  /// Whether the app is in a loading state
  @override
  @JsonKey()
  final bool isLoading;

  /// Current error message, if any
  @override
  final String? errorMessage;

  /// Current toast notification status
  @override
  @JsonKey()
  final ToastStatus toastStatus;

  /// Message to display in toast notification
  @override
  final String? toastMessage;

  /// Whether debug mode is enabled
  @override
  @JsonKey()
  final bool isDebugMode;

  /// Last recognition result timestamp
  @override
  final DateTime? lastRecognitionTime;

  /// Number of frames processed
  @override
  @JsonKey()
  final int framesProcessed;

  @override
  String toString() {
    return 'CheckInState(cameraStatus: $cameraStatus, connectionStatus: $connectionStatus, streamingStatus: $streamingStatus, isLoading: $isLoading, errorMessage: $errorMessage, toastStatus: $toastStatus, toastMessage: $toastMessage, isDebugMode: $isDebugMode, lastRecognitionTime: $lastRecognitionTime, framesProcessed: $framesProcessed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInStateImpl &&
            (identical(other.cameraStatus, cameraStatus) ||
                other.cameraStatus == cameraStatus) &&
            (identical(other.connectionStatus, connectionStatus) ||
                other.connectionStatus == connectionStatus) &&
            (identical(other.streamingStatus, streamingStatus) ||
                other.streamingStatus == streamingStatus) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.toastStatus, toastStatus) ||
                other.toastStatus == toastStatus) &&
            (identical(other.toastMessage, toastMessage) ||
                other.toastMessage == toastMessage) &&
            (identical(other.isDebugMode, isDebugMode) ||
                other.isDebugMode == isDebugMode) &&
            (identical(other.lastRecognitionTime, lastRecognitionTime) ||
                other.lastRecognitionTime == lastRecognitionTime) &&
            (identical(other.framesProcessed, framesProcessed) ||
                other.framesProcessed == framesProcessed));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    cameraStatus,
    connectionStatus,
    streamingStatus,
    isLoading,
    errorMessage,
    toastStatus,
    toastMessage,
    isDebugMode,
    lastRecognitionTime,
    framesProcessed,
  );

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      __$$CheckInStateImplCopyWithImpl<_$CheckInStateImpl>(this, _$identity);
}

abstract class _CheckInState implements CheckInState {
  const factory _CheckInState({
    final CameraStatus cameraStatus,
    final ConnectionStatus connectionStatus,
    final StreamingStatus streamingStatus,
    final bool isLoading,
    final String? errorMessage,
    final ToastStatus toastStatus,
    final String? toastMessage,
    final bool isDebugMode,
    final DateTime? lastRecognitionTime,
    final int framesProcessed,
  }) = _$CheckInStateImpl;

  /// Current camera status
  @override
  CameraStatus get cameraStatus;

  /// Current WebSocket connection status
  @override
  ConnectionStatus get connectionStatus;

  /// Current frame streaming status
  @override
  StreamingStatus get streamingStatus;

  /// Whether the app is in a loading state
  @override
  bool get isLoading;

  /// Current error message, if any
  @override
  String? get errorMessage;

  /// Current toast notification status
  @override
  ToastStatus get toastStatus;

  /// Message to display in toast notification
  @override
  String? get toastMessage;

  /// Whether debug mode is enabled
  @override
  bool get isDebugMode;

  /// Last recognition result timestamp
  @override
  DateTime? get lastRecognitionTime;

  /// Number of frames processed
  @override
  int get framesProcessed;

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
