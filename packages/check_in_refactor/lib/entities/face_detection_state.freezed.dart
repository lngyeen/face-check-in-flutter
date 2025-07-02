// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_detection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FaceDetectionState {
  List<FaceDetectionResult> get detectedFaces =>
      throw _privateConstructorUsedError;
  WebSocketConnectionStatus get connectionStatus =>
      throw _privateConstructorUsedError;
  String? get annotatedImage => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime? get lastDetectionTime => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  int get totalDetectedFrames => throw _privateConstructorUsedError;
  int get recognizedFacesCount => throw _privateConstructorUsedError;

  /// Create a copy of FaceDetectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaceDetectionStateCopyWith<FaceDetectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceDetectionStateCopyWith<$Res> {
  factory $FaceDetectionStateCopyWith(
          FaceDetectionState value, $Res Function(FaceDetectionState) then) =
      _$FaceDetectionStateCopyWithImpl<$Res, FaceDetectionState>;
  @useResult
  $Res call(
      {List<FaceDetectionResult> detectedFaces,
      WebSocketConnectionStatus connectionStatus,
      String? annotatedImage,
      String? errorMessage,
      DateTime? lastDetectionTime,
      bool isProcessing,
      int totalDetectedFrames,
      int recognizedFacesCount});
}

/// @nodoc
class _$FaceDetectionStateCopyWithImpl<$Res, $Val extends FaceDetectionState>
    implements $FaceDetectionStateCopyWith<$Res> {
  _$FaceDetectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaceDetectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detectedFaces = null,
    Object? connectionStatus = null,
    Object? annotatedImage = freezed,
    Object? errorMessage = freezed,
    Object? lastDetectionTime = freezed,
    Object? isProcessing = null,
    Object? totalDetectedFrames = null,
    Object? recognizedFacesCount = null,
  }) {
    return _then(_value.copyWith(
      detectedFaces: null == detectedFaces
          ? _value.detectedFaces
          : detectedFaces // ignore: cast_nullable_to_non_nullable
              as List<FaceDetectionResult>,
      connectionStatus: null == connectionStatus
          ? _value.connectionStatus
          : connectionStatus // ignore: cast_nullable_to_non_nullable
              as WebSocketConnectionStatus,
      annotatedImage: freezed == annotatedImage
          ? _value.annotatedImage
          : annotatedImage // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastDetectionTime: freezed == lastDetectionTime
          ? _value.lastDetectionTime
          : lastDetectionTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      totalDetectedFrames: null == totalDetectedFrames
          ? _value.totalDetectedFrames
          : totalDetectedFrames // ignore: cast_nullable_to_non_nullable
              as int,
      recognizedFacesCount: null == recognizedFacesCount
          ? _value.recognizedFacesCount
          : recognizedFacesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FaceDetectionStateImplCopyWith<$Res>
    implements $FaceDetectionStateCopyWith<$Res> {
  factory _$$FaceDetectionStateImplCopyWith(_$FaceDetectionStateImpl value,
          $Res Function(_$FaceDetectionStateImpl) then) =
      __$$FaceDetectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FaceDetectionResult> detectedFaces,
      WebSocketConnectionStatus connectionStatus,
      String? annotatedImage,
      String? errorMessage,
      DateTime? lastDetectionTime,
      bool isProcessing,
      int totalDetectedFrames,
      int recognizedFacesCount});
}

/// @nodoc
class __$$FaceDetectionStateImplCopyWithImpl<$Res>
    extends _$FaceDetectionStateCopyWithImpl<$Res, _$FaceDetectionStateImpl>
    implements _$$FaceDetectionStateImplCopyWith<$Res> {
  __$$FaceDetectionStateImplCopyWithImpl(_$FaceDetectionStateImpl _value,
      $Res Function(_$FaceDetectionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FaceDetectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detectedFaces = null,
    Object? connectionStatus = null,
    Object? annotatedImage = freezed,
    Object? errorMessage = freezed,
    Object? lastDetectionTime = freezed,
    Object? isProcessing = null,
    Object? totalDetectedFrames = null,
    Object? recognizedFacesCount = null,
  }) {
    return _then(_$FaceDetectionStateImpl(
      detectedFaces: null == detectedFaces
          ? _value._detectedFaces
          : detectedFaces // ignore: cast_nullable_to_non_nullable
              as List<FaceDetectionResult>,
      connectionStatus: null == connectionStatus
          ? _value.connectionStatus
          : connectionStatus // ignore: cast_nullable_to_non_nullable
              as WebSocketConnectionStatus,
      annotatedImage: freezed == annotatedImage
          ? _value.annotatedImage
          : annotatedImage // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastDetectionTime: freezed == lastDetectionTime
          ? _value.lastDetectionTime
          : lastDetectionTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      totalDetectedFrames: null == totalDetectedFrames
          ? _value.totalDetectedFrames
          : totalDetectedFrames // ignore: cast_nullable_to_non_nullable
              as int,
      recognizedFacesCount: null == recognizedFacesCount
          ? _value.recognizedFacesCount
          : recognizedFacesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FaceDetectionStateImpl extends _FaceDetectionState {
  const _$FaceDetectionStateImpl(
      {final List<FaceDetectionResult> detectedFaces = const [],
      this.connectionStatus = WebSocketConnectionStatus.disconnected,
      this.annotatedImage,
      this.errorMessage,
      this.lastDetectionTime,
      this.isProcessing = false,
      this.totalDetectedFrames = 0,
      this.recognizedFacesCount = 0})
      : _detectedFaces = detectedFaces,
        super._();

  final List<FaceDetectionResult> _detectedFaces;
  @override
  @JsonKey()
  List<FaceDetectionResult> get detectedFaces {
    if (_detectedFaces is EqualUnmodifiableListView) return _detectedFaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_detectedFaces);
  }

  @override
  @JsonKey()
  final WebSocketConnectionStatus connectionStatus;
  @override
  final String? annotatedImage;
  @override
  final String? errorMessage;
  @override
  final DateTime? lastDetectionTime;
  @override
  @JsonKey()
  final bool isProcessing;
  @override
  @JsonKey()
  final int totalDetectedFrames;
  @override
  @JsonKey()
  final int recognizedFacesCount;

  @override
  String toString() {
    return 'FaceDetectionState(detectedFaces: $detectedFaces, connectionStatus: $connectionStatus, annotatedImage: $annotatedImage, errorMessage: $errorMessage, lastDetectionTime: $lastDetectionTime, isProcessing: $isProcessing, totalDetectedFrames: $totalDetectedFrames, recognizedFacesCount: $recognizedFacesCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceDetectionStateImpl &&
            const DeepCollectionEquality()
                .equals(other._detectedFaces, _detectedFaces) &&
            (identical(other.connectionStatus, connectionStatus) ||
                other.connectionStatus == connectionStatus) &&
            (identical(other.annotatedImage, annotatedImage) ||
                other.annotatedImage == annotatedImage) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastDetectionTime, lastDetectionTime) ||
                other.lastDetectionTime == lastDetectionTime) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.totalDetectedFrames, totalDetectedFrames) ||
                other.totalDetectedFrames == totalDetectedFrames) &&
            (identical(other.recognizedFacesCount, recognizedFacesCount) ||
                other.recognizedFacesCount == recognizedFacesCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_detectedFaces),
      connectionStatus,
      annotatedImage,
      errorMessage,
      lastDetectionTime,
      isProcessing,
      totalDetectedFrames,
      recognizedFacesCount);

  /// Create a copy of FaceDetectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceDetectionStateImplCopyWith<_$FaceDetectionStateImpl> get copyWith =>
      __$$FaceDetectionStateImplCopyWithImpl<_$FaceDetectionStateImpl>(
          this, _$identity);
}

abstract class _FaceDetectionState extends FaceDetectionState {
  const factory _FaceDetectionState(
      {final List<FaceDetectionResult> detectedFaces,
      final WebSocketConnectionStatus connectionStatus,
      final String? annotatedImage,
      final String? errorMessage,
      final DateTime? lastDetectionTime,
      final bool isProcessing,
      final int totalDetectedFrames,
      final int recognizedFacesCount}) = _$FaceDetectionStateImpl;
  const _FaceDetectionState._() : super._();

  @override
  List<FaceDetectionResult> get detectedFaces;
  @override
  WebSocketConnectionStatus get connectionStatus;
  @override
  String? get annotatedImage;
  @override
  String? get errorMessage;
  @override
  DateTime? get lastDetectionTime;
  @override
  bool get isProcessing;
  @override
  int get totalDetectedFrames;
  @override
  int get recognizedFacesCount;

  /// Create a copy of FaceDetectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceDetectionStateImplCopyWith<_$FaceDetectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
