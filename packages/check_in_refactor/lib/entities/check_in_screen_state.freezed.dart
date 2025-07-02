// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckInScreenState {
  CameraState get cameraState => throw _privateConstructorUsedError;
  StreamingState get streamingState => throw _privateConstructorUsedError;
  FaceDetectionState get faceDetectionState =>
      throw _privateConstructorUsedError;
  bool get isDebugMode => throw _privateConstructorUsedError;
  bool get showAnnotatedImage => throw _privateConstructorUsedError;
  bool get isCheckingIn => throw _privateConstructorUsedError;
  String? get checkInMessage => throw _privateConstructorUsedError;
  String? get globalError => throw _privateConstructorUsedError;
  DateTime? get lastActivityTime => throw _privateConstructorUsedError;
  NotificationData? get pendingNotification =>
      throw _privateConstructorUsedError;
  bool get isFullScreen => throw _privateConstructorUsedError;

  /// Create a copy of CheckInScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInScreenStateCopyWith<CheckInScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInScreenStateCopyWith<$Res> {
  factory $CheckInScreenStateCopyWith(
          CheckInScreenState value, $Res Function(CheckInScreenState) then) =
      _$CheckInScreenStateCopyWithImpl<$Res, CheckInScreenState>;
  @useResult
  $Res call(
      {CameraState cameraState,
      StreamingState streamingState,
      FaceDetectionState faceDetectionState,
      bool isDebugMode,
      bool showAnnotatedImage,
      bool isCheckingIn,
      String? checkInMessage,
      String? globalError,
      DateTime? lastActivityTime,
      NotificationData? pendingNotification,
      bool isFullScreen});

  $CameraStateCopyWith<$Res> get cameraState;
  $StreamingStateCopyWith<$Res> get streamingState;
  $FaceDetectionStateCopyWith<$Res> get faceDetectionState;
}

/// @nodoc
class _$CheckInScreenStateCopyWithImpl<$Res, $Val extends CheckInScreenState>
    implements $CheckInScreenStateCopyWith<$Res> {
  _$CheckInScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraState = null,
    Object? streamingState = null,
    Object? faceDetectionState = null,
    Object? isDebugMode = null,
    Object? showAnnotatedImage = null,
    Object? isCheckingIn = null,
    Object? checkInMessage = freezed,
    Object? globalError = freezed,
    Object? lastActivityTime = freezed,
    Object? pendingNotification = freezed,
    Object? isFullScreen = null,
  }) {
    return _then(_value.copyWith(
      cameraState: null == cameraState
          ? _value.cameraState
          : cameraState // ignore: cast_nullable_to_non_nullable
              as CameraState,
      streamingState: null == streamingState
          ? _value.streamingState
          : streamingState // ignore: cast_nullable_to_non_nullable
              as StreamingState,
      faceDetectionState: null == faceDetectionState
          ? _value.faceDetectionState
          : faceDetectionState // ignore: cast_nullable_to_non_nullable
              as FaceDetectionState,
      isDebugMode: null == isDebugMode
          ? _value.isDebugMode
          : isDebugMode // ignore: cast_nullable_to_non_nullable
              as bool,
      showAnnotatedImage: null == showAnnotatedImage
          ? _value.showAnnotatedImage
          : showAnnotatedImage // ignore: cast_nullable_to_non_nullable
              as bool,
      isCheckingIn: null == isCheckingIn
          ? _value.isCheckingIn
          : isCheckingIn // ignore: cast_nullable_to_non_nullable
              as bool,
      checkInMessage: freezed == checkInMessage
          ? _value.checkInMessage
          : checkInMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      globalError: freezed == globalError
          ? _value.globalError
          : globalError // ignore: cast_nullable_to_non_nullable
              as String?,
      lastActivityTime: freezed == lastActivityTime
          ? _value.lastActivityTime
          : lastActivityTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pendingNotification: freezed == pendingNotification
          ? _value.pendingNotification
          : pendingNotification // ignore: cast_nullable_to_non_nullable
              as NotificationData?,
      isFullScreen: null == isFullScreen
          ? _value.isFullScreen
          : isFullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of CheckInScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CameraStateCopyWith<$Res> get cameraState {
    return $CameraStateCopyWith<$Res>(_value.cameraState, (value) {
      return _then(_value.copyWith(cameraState: value) as $Val);
    });
  }

  /// Create a copy of CheckInScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamingStateCopyWith<$Res> get streamingState {
    return $StreamingStateCopyWith<$Res>(_value.streamingState, (value) {
      return _then(_value.copyWith(streamingState: value) as $Val);
    });
  }

  /// Create a copy of CheckInScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FaceDetectionStateCopyWith<$Res> get faceDetectionState {
    return $FaceDetectionStateCopyWith<$Res>(_value.faceDetectionState,
        (value) {
      return _then(_value.copyWith(faceDetectionState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckInScreenStateImplCopyWith<$Res>
    implements $CheckInScreenStateCopyWith<$Res> {
  factory _$$CheckInScreenStateImplCopyWith(_$CheckInScreenStateImpl value,
          $Res Function(_$CheckInScreenStateImpl) then) =
      __$$CheckInScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CameraState cameraState,
      StreamingState streamingState,
      FaceDetectionState faceDetectionState,
      bool isDebugMode,
      bool showAnnotatedImage,
      bool isCheckingIn,
      String? checkInMessage,
      String? globalError,
      DateTime? lastActivityTime,
      NotificationData? pendingNotification,
      bool isFullScreen});

  @override
  $CameraStateCopyWith<$Res> get cameraState;
  @override
  $StreamingStateCopyWith<$Res> get streamingState;
  @override
  $FaceDetectionStateCopyWith<$Res> get faceDetectionState;
}

/// @nodoc
class __$$CheckInScreenStateImplCopyWithImpl<$Res>
    extends _$CheckInScreenStateCopyWithImpl<$Res, _$CheckInScreenStateImpl>
    implements _$$CheckInScreenStateImplCopyWith<$Res> {
  __$$CheckInScreenStateImplCopyWithImpl(_$CheckInScreenStateImpl _value,
      $Res Function(_$CheckInScreenStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckInScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraState = null,
    Object? streamingState = null,
    Object? faceDetectionState = null,
    Object? isDebugMode = null,
    Object? showAnnotatedImage = null,
    Object? isCheckingIn = null,
    Object? checkInMessage = freezed,
    Object? globalError = freezed,
    Object? lastActivityTime = freezed,
    Object? pendingNotification = freezed,
    Object? isFullScreen = null,
  }) {
    return _then(_$CheckInScreenStateImpl(
      cameraState: null == cameraState
          ? _value.cameraState
          : cameraState // ignore: cast_nullable_to_non_nullable
              as CameraState,
      streamingState: null == streamingState
          ? _value.streamingState
          : streamingState // ignore: cast_nullable_to_non_nullable
              as StreamingState,
      faceDetectionState: null == faceDetectionState
          ? _value.faceDetectionState
          : faceDetectionState // ignore: cast_nullable_to_non_nullable
              as FaceDetectionState,
      isDebugMode: null == isDebugMode
          ? _value.isDebugMode
          : isDebugMode // ignore: cast_nullable_to_non_nullable
              as bool,
      showAnnotatedImage: null == showAnnotatedImage
          ? _value.showAnnotatedImage
          : showAnnotatedImage // ignore: cast_nullable_to_non_nullable
              as bool,
      isCheckingIn: null == isCheckingIn
          ? _value.isCheckingIn
          : isCheckingIn // ignore: cast_nullable_to_non_nullable
              as bool,
      checkInMessage: freezed == checkInMessage
          ? _value.checkInMessage
          : checkInMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      globalError: freezed == globalError
          ? _value.globalError
          : globalError // ignore: cast_nullable_to_non_nullable
              as String?,
      lastActivityTime: freezed == lastActivityTime
          ? _value.lastActivityTime
          : lastActivityTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pendingNotification: freezed == pendingNotification
          ? _value.pendingNotification
          : pendingNotification // ignore: cast_nullable_to_non_nullable
              as NotificationData?,
      isFullScreen: null == isFullScreen
          ? _value.isFullScreen
          : isFullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CheckInScreenStateImpl extends _CheckInScreenState {
  const _$CheckInScreenStateImpl(
      {this.cameraState = const CameraState(),
      this.streamingState = const StreamingState(),
      this.faceDetectionState = const FaceDetectionState(),
      this.isDebugMode = false,
      this.showAnnotatedImage = false,
      this.isCheckingIn = false,
      this.checkInMessage,
      this.globalError,
      this.lastActivityTime,
      this.pendingNotification,
      this.isFullScreen = false})
      : super._();

  @override
  @JsonKey()
  final CameraState cameraState;
  @override
  @JsonKey()
  final StreamingState streamingState;
  @override
  @JsonKey()
  final FaceDetectionState faceDetectionState;
  @override
  @JsonKey()
  final bool isDebugMode;
  @override
  @JsonKey()
  final bool showAnnotatedImage;
  @override
  @JsonKey()
  final bool isCheckingIn;
  @override
  final String? checkInMessage;
  @override
  final String? globalError;
  @override
  final DateTime? lastActivityTime;
  @override
  final NotificationData? pendingNotification;
  @override
  @JsonKey()
  final bool isFullScreen;

  @override
  String toString() {
    return 'CheckInScreenState(cameraState: $cameraState, streamingState: $streamingState, faceDetectionState: $faceDetectionState, isDebugMode: $isDebugMode, showAnnotatedImage: $showAnnotatedImage, isCheckingIn: $isCheckingIn, checkInMessage: $checkInMessage, globalError: $globalError, lastActivityTime: $lastActivityTime, pendingNotification: $pendingNotification, isFullScreen: $isFullScreen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInScreenStateImpl &&
            (identical(other.cameraState, cameraState) ||
                other.cameraState == cameraState) &&
            (identical(other.streamingState, streamingState) ||
                other.streamingState == streamingState) &&
            (identical(other.faceDetectionState, faceDetectionState) ||
                other.faceDetectionState == faceDetectionState) &&
            (identical(other.isDebugMode, isDebugMode) ||
                other.isDebugMode == isDebugMode) &&
            (identical(other.showAnnotatedImage, showAnnotatedImage) ||
                other.showAnnotatedImage == showAnnotatedImage) &&
            (identical(other.isCheckingIn, isCheckingIn) ||
                other.isCheckingIn == isCheckingIn) &&
            (identical(other.checkInMessage, checkInMessage) ||
                other.checkInMessage == checkInMessage) &&
            (identical(other.globalError, globalError) ||
                other.globalError == globalError) &&
            (identical(other.lastActivityTime, lastActivityTime) ||
                other.lastActivityTime == lastActivityTime) &&
            (identical(other.pendingNotification, pendingNotification) ||
                other.pendingNotification == pendingNotification) &&
            (identical(other.isFullScreen, isFullScreen) ||
                other.isFullScreen == isFullScreen));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      cameraState,
      streamingState,
      faceDetectionState,
      isDebugMode,
      showAnnotatedImage,
      isCheckingIn,
      checkInMessage,
      globalError,
      lastActivityTime,
      pendingNotification,
      isFullScreen);

  /// Create a copy of CheckInScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInScreenStateImplCopyWith<_$CheckInScreenStateImpl> get copyWith =>
      __$$CheckInScreenStateImplCopyWithImpl<_$CheckInScreenStateImpl>(
          this, _$identity);
}

abstract class _CheckInScreenState extends CheckInScreenState {
  const factory _CheckInScreenState(
      {final CameraState cameraState,
      final StreamingState streamingState,
      final FaceDetectionState faceDetectionState,
      final bool isDebugMode,
      final bool showAnnotatedImage,
      final bool isCheckingIn,
      final String? checkInMessage,
      final String? globalError,
      final DateTime? lastActivityTime,
      final NotificationData? pendingNotification,
      final bool isFullScreen}) = _$CheckInScreenStateImpl;
  const _CheckInScreenState._() : super._();

  @override
  CameraState get cameraState;
  @override
  StreamingState get streamingState;
  @override
  FaceDetectionState get faceDetectionState;
  @override
  bool get isDebugMode;
  @override
  bool get showAnnotatedImage;
  @override
  bool get isCheckingIn;
  @override
  String? get checkInMessage;
  @override
  String? get globalError;
  @override
  DateTime? get lastActivityTime;
  @override
  NotificationData? get pendingNotification;
  @override
  bool get isFullScreen;

  /// Create a copy of CheckInScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInScreenStateImplCopyWith<_$CheckInScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
