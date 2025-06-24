// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_detection_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FaceDetectionResult _$FaceDetectionResultFromJson(Map<String, dynamic> json) {
  return _FaceDetectionResult.fromJson(json);
}

/// @nodoc
mixin _$FaceDetectionResult {
  String get frameId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<DetectedFace> get faces => throw _privateConstructorUsedError;
  FaceDetectionStatus get status => throw _privateConstructorUsedError;

  /// Serializes this FaceDetectionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FaceDetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaceDetectionResultCopyWith<FaceDetectionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceDetectionResultCopyWith<$Res> {
  factory $FaceDetectionResultCopyWith(
    FaceDetectionResult value,
    $Res Function(FaceDetectionResult) then,
  ) = _$FaceDetectionResultCopyWithImpl<$Res, FaceDetectionResult>;
  @useResult
  $Res call({
    String frameId,
    DateTime timestamp,
    List<DetectedFace> faces,
    FaceDetectionStatus status,
  });
}

/// @nodoc
class _$FaceDetectionResultCopyWithImpl<$Res, $Val extends FaceDetectionResult>
    implements $FaceDetectionResultCopyWith<$Res> {
  _$FaceDetectionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaceDetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frameId = null,
    Object? timestamp = null,
    Object? faces = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            frameId:
                null == frameId
                    ? _value.frameId
                    : frameId // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            faces:
                null == faces
                    ? _value.faces
                    : faces // ignore: cast_nullable_to_non_nullable
                        as List<DetectedFace>,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as FaceDetectionStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FaceDetectionResultImplCopyWith<$Res>
    implements $FaceDetectionResultCopyWith<$Res> {
  factory _$$FaceDetectionResultImplCopyWith(
    _$FaceDetectionResultImpl value,
    $Res Function(_$FaceDetectionResultImpl) then,
  ) = __$$FaceDetectionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String frameId,
    DateTime timestamp,
    List<DetectedFace> faces,
    FaceDetectionStatus status,
  });
}

/// @nodoc
class __$$FaceDetectionResultImplCopyWithImpl<$Res>
    extends _$FaceDetectionResultCopyWithImpl<$Res, _$FaceDetectionResultImpl>
    implements _$$FaceDetectionResultImplCopyWith<$Res> {
  __$$FaceDetectionResultImplCopyWithImpl(
    _$FaceDetectionResultImpl _value,
    $Res Function(_$FaceDetectionResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaceDetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frameId = null,
    Object? timestamp = null,
    Object? faces = null,
    Object? status = null,
  }) {
    return _then(
      _$FaceDetectionResultImpl(
        frameId:
            null == frameId
                ? _value.frameId
                : frameId // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        faces:
            null == faces
                ? _value._faces
                : faces // ignore: cast_nullable_to_non_nullable
                    as List<DetectedFace>,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as FaceDetectionStatus,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceDetectionResultImpl implements _FaceDetectionResult {
  const _$FaceDetectionResultImpl({
    required this.frameId,
    required this.timestamp,
    required final List<DetectedFace> faces,
    required this.status,
  }) : _faces = faces;

  factory _$FaceDetectionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceDetectionResultImplFromJson(json);

  @override
  final String frameId;
  @override
  final DateTime timestamp;
  final List<DetectedFace> _faces;
  @override
  List<DetectedFace> get faces {
    if (_faces is EqualUnmodifiableListView) return _faces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_faces);
  }

  @override
  final FaceDetectionStatus status;

  @override
  String toString() {
    return 'FaceDetectionResult(frameId: $frameId, timestamp: $timestamp, faces: $faces, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceDetectionResultImpl &&
            (identical(other.frameId, frameId) || other.frameId == frameId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._faces, _faces) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    frameId,
    timestamp,
    const DeepCollectionEquality().hash(_faces),
    status,
  );

  /// Create a copy of FaceDetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceDetectionResultImplCopyWith<_$FaceDetectionResultImpl> get copyWith =>
      __$$FaceDetectionResultImplCopyWithImpl<_$FaceDetectionResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FaceDetectionResultImplToJson(this);
  }
}

abstract class _FaceDetectionResult implements FaceDetectionResult {
  const factory _FaceDetectionResult({
    required final String frameId,
    required final DateTime timestamp,
    required final List<DetectedFace> faces,
    required final FaceDetectionStatus status,
  }) = _$FaceDetectionResultImpl;

  factory _FaceDetectionResult.fromJson(Map<String, dynamic> json) =
      _$FaceDetectionResultImpl.fromJson;

  @override
  String get frameId;
  @override
  DateTime get timestamp;
  @override
  List<DetectedFace> get faces;
  @override
  FaceDetectionStatus get status;

  /// Create a copy of FaceDetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceDetectionResultImplCopyWith<_$FaceDetectionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DetectedFace _$DetectedFaceFromJson(Map<String, dynamic> json) {
  return _DetectedFace.fromJson(json);
}

/// @nodoc
mixin _$DetectedFace {
  String get faceId => throw _privateConstructorUsedError;
  List<double> get box =>
      throw _privateConstructorUsedError; // [x, y, width, height]
  double get confidence => throw _privateConstructorUsedError;
  bool get isRecognized => throw _privateConstructorUsedError;
  String? get personId => throw _privateConstructorUsedError;
  String? get employeeName => throw _privateConstructorUsedError;

  /// Serializes this DetectedFace to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetectedFace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetectedFaceCopyWith<DetectedFace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetectedFaceCopyWith<$Res> {
  factory $DetectedFaceCopyWith(
    DetectedFace value,
    $Res Function(DetectedFace) then,
  ) = _$DetectedFaceCopyWithImpl<$Res, DetectedFace>;
  @useResult
  $Res call({
    String faceId,
    List<double> box,
    double confidence,
    bool isRecognized,
    String? personId,
    String? employeeName,
  });
}

/// @nodoc
class _$DetectedFaceCopyWithImpl<$Res, $Val extends DetectedFace>
    implements $DetectedFaceCopyWith<$Res> {
  _$DetectedFaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetectedFace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faceId = null,
    Object? box = null,
    Object? confidence = null,
    Object? isRecognized = null,
    Object? personId = freezed,
    Object? employeeName = freezed,
  }) {
    return _then(
      _value.copyWith(
            faceId:
                null == faceId
                    ? _value.faceId
                    : faceId // ignore: cast_nullable_to_non_nullable
                        as String,
            box:
                null == box
                    ? _value.box
                    : box // ignore: cast_nullable_to_non_nullable
                        as List<double>,
            confidence:
                null == confidence
                    ? _value.confidence
                    : confidence // ignore: cast_nullable_to_non_nullable
                        as double,
            isRecognized:
                null == isRecognized
                    ? _value.isRecognized
                    : isRecognized // ignore: cast_nullable_to_non_nullable
                        as bool,
            personId:
                freezed == personId
                    ? _value.personId
                    : personId // ignore: cast_nullable_to_non_nullable
                        as String?,
            employeeName:
                freezed == employeeName
                    ? _value.employeeName
                    : employeeName // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DetectedFaceImplCopyWith<$Res>
    implements $DetectedFaceCopyWith<$Res> {
  factory _$$DetectedFaceImplCopyWith(
    _$DetectedFaceImpl value,
    $Res Function(_$DetectedFaceImpl) then,
  ) = __$$DetectedFaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String faceId,
    List<double> box,
    double confidence,
    bool isRecognized,
    String? personId,
    String? employeeName,
  });
}

/// @nodoc
class __$$DetectedFaceImplCopyWithImpl<$Res>
    extends _$DetectedFaceCopyWithImpl<$Res, _$DetectedFaceImpl>
    implements _$$DetectedFaceImplCopyWith<$Res> {
  __$$DetectedFaceImplCopyWithImpl(
    _$DetectedFaceImpl _value,
    $Res Function(_$DetectedFaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetectedFace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faceId = null,
    Object? box = null,
    Object? confidence = null,
    Object? isRecognized = null,
    Object? personId = freezed,
    Object? employeeName = freezed,
  }) {
    return _then(
      _$DetectedFaceImpl(
        faceId:
            null == faceId
                ? _value.faceId
                : faceId // ignore: cast_nullable_to_non_nullable
                    as String,
        box:
            null == box
                ? _value._box
                : box // ignore: cast_nullable_to_non_nullable
                    as List<double>,
        confidence:
            null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                    as double,
        isRecognized:
            null == isRecognized
                ? _value.isRecognized
                : isRecognized // ignore: cast_nullable_to_non_nullable
                    as bool,
        personId:
            freezed == personId
                ? _value.personId
                : personId // ignore: cast_nullable_to_non_nullable
                    as String?,
        employeeName:
            freezed == employeeName
                ? _value.employeeName
                : employeeName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DetectedFaceImpl implements _DetectedFace {
  const _$DetectedFaceImpl({
    required this.faceId,
    required final List<double> box,
    required this.confidence,
    required this.isRecognized,
    this.personId,
    this.employeeName,
  }) : _box = box;

  factory _$DetectedFaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetectedFaceImplFromJson(json);

  @override
  final String faceId;
  final List<double> _box;
  @override
  List<double> get box {
    if (_box is EqualUnmodifiableListView) return _box;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_box);
  }

  // [x, y, width, height]
  @override
  final double confidence;
  @override
  final bool isRecognized;
  @override
  final String? personId;
  @override
  final String? employeeName;

  @override
  String toString() {
    return 'DetectedFace(faceId: $faceId, box: $box, confidence: $confidence, isRecognized: $isRecognized, personId: $personId, employeeName: $employeeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetectedFaceImpl &&
            (identical(other.faceId, faceId) || other.faceId == faceId) &&
            const DeepCollectionEquality().equals(other._box, _box) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.isRecognized, isRecognized) ||
                other.isRecognized == isRecognized) &&
            (identical(other.personId, personId) ||
                other.personId == personId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    faceId,
    const DeepCollectionEquality().hash(_box),
    confidence,
    isRecognized,
    personId,
    employeeName,
  );

  /// Create a copy of DetectedFace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetectedFaceImplCopyWith<_$DetectedFaceImpl> get copyWith =>
      __$$DetectedFaceImplCopyWithImpl<_$DetectedFaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetectedFaceImplToJson(this);
  }
}

abstract class _DetectedFace implements DetectedFace {
  const factory _DetectedFace({
    required final String faceId,
    required final List<double> box,
    required final double confidence,
    required final bool isRecognized,
    final String? personId,
    final String? employeeName,
  }) = _$DetectedFaceImpl;

  factory _DetectedFace.fromJson(Map<String, dynamic> json) =
      _$DetectedFaceImpl.fromJson;

  @override
  String get faceId;
  @override
  List<double> get box; // [x, y, width, height]
  @override
  double get confidence;
  @override
  bool get isRecognized;
  @override
  String? get personId;
  @override
  String? get employeeName;

  /// Create a copy of DetectedFace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetectedFaceImplCopyWith<_$DetectedFaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecognitionStatistics _$RecognitionStatisticsFromJson(
  Map<String, dynamic> json,
) {
  return _RecognitionStatistics.fromJson(json);
}

/// @nodoc
mixin _$RecognitionStatistics {
  int get totalFramesProcessed => throw _privateConstructorUsedError;
  int get totalFacesDetected => throw _privateConstructorUsedError;
  int get successfulRecognitions => throw _privateConstructorUsedError;
  int get failedRecognitions => throw _privateConstructorUsedError;
  double get averageConfidence => throw _privateConstructorUsedError;
  double get averageProcessingTimeMs => throw _privateConstructorUsedError;
  DateTime? get lastRecognitionTime => throw _privateConstructorUsedError;
  DateTime? get sessionStartTime => throw _privateConstructorUsedError;

  /// Serializes this RecognitionStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecognitionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecognitionStatisticsCopyWith<RecognitionStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecognitionStatisticsCopyWith<$Res> {
  factory $RecognitionStatisticsCopyWith(
    RecognitionStatistics value,
    $Res Function(RecognitionStatistics) then,
  ) = _$RecognitionStatisticsCopyWithImpl<$Res, RecognitionStatistics>;
  @useResult
  $Res call({
    int totalFramesProcessed,
    int totalFacesDetected,
    int successfulRecognitions,
    int failedRecognitions,
    double averageConfidence,
    double averageProcessingTimeMs,
    DateTime? lastRecognitionTime,
    DateTime? sessionStartTime,
  });
}

/// @nodoc
class _$RecognitionStatisticsCopyWithImpl<
  $Res,
  $Val extends RecognitionStatistics
>
    implements $RecognitionStatisticsCopyWith<$Res> {
  _$RecognitionStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecognitionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalFramesProcessed = null,
    Object? totalFacesDetected = null,
    Object? successfulRecognitions = null,
    Object? failedRecognitions = null,
    Object? averageConfidence = null,
    Object? averageProcessingTimeMs = null,
    Object? lastRecognitionTime = freezed,
    Object? sessionStartTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            totalFramesProcessed:
                null == totalFramesProcessed
                    ? _value.totalFramesProcessed
                    : totalFramesProcessed // ignore: cast_nullable_to_non_nullable
                        as int,
            totalFacesDetected:
                null == totalFacesDetected
                    ? _value.totalFacesDetected
                    : totalFacesDetected // ignore: cast_nullable_to_non_nullable
                        as int,
            successfulRecognitions:
                null == successfulRecognitions
                    ? _value.successfulRecognitions
                    : successfulRecognitions // ignore: cast_nullable_to_non_nullable
                        as int,
            failedRecognitions:
                null == failedRecognitions
                    ? _value.failedRecognitions
                    : failedRecognitions // ignore: cast_nullable_to_non_nullable
                        as int,
            averageConfidence:
                null == averageConfidence
                    ? _value.averageConfidence
                    : averageConfidence // ignore: cast_nullable_to_non_nullable
                        as double,
            averageProcessingTimeMs:
                null == averageProcessingTimeMs
                    ? _value.averageProcessingTimeMs
                    : averageProcessingTimeMs // ignore: cast_nullable_to_non_nullable
                        as double,
            lastRecognitionTime:
                freezed == lastRecognitionTime
                    ? _value.lastRecognitionTime
                    : lastRecognitionTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            sessionStartTime:
                freezed == sessionStartTime
                    ? _value.sessionStartTime
                    : sessionStartTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecognitionStatisticsImplCopyWith<$Res>
    implements $RecognitionStatisticsCopyWith<$Res> {
  factory _$$RecognitionStatisticsImplCopyWith(
    _$RecognitionStatisticsImpl value,
    $Res Function(_$RecognitionStatisticsImpl) then,
  ) = __$$RecognitionStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalFramesProcessed,
    int totalFacesDetected,
    int successfulRecognitions,
    int failedRecognitions,
    double averageConfidence,
    double averageProcessingTimeMs,
    DateTime? lastRecognitionTime,
    DateTime? sessionStartTime,
  });
}

/// @nodoc
class __$$RecognitionStatisticsImplCopyWithImpl<$Res>
    extends
        _$RecognitionStatisticsCopyWithImpl<$Res, _$RecognitionStatisticsImpl>
    implements _$$RecognitionStatisticsImplCopyWith<$Res> {
  __$$RecognitionStatisticsImplCopyWithImpl(
    _$RecognitionStatisticsImpl _value,
    $Res Function(_$RecognitionStatisticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecognitionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalFramesProcessed = null,
    Object? totalFacesDetected = null,
    Object? successfulRecognitions = null,
    Object? failedRecognitions = null,
    Object? averageConfidence = null,
    Object? averageProcessingTimeMs = null,
    Object? lastRecognitionTime = freezed,
    Object? sessionStartTime = freezed,
  }) {
    return _then(
      _$RecognitionStatisticsImpl(
        totalFramesProcessed:
            null == totalFramesProcessed
                ? _value.totalFramesProcessed
                : totalFramesProcessed // ignore: cast_nullable_to_non_nullable
                    as int,
        totalFacesDetected:
            null == totalFacesDetected
                ? _value.totalFacesDetected
                : totalFacesDetected // ignore: cast_nullable_to_non_nullable
                    as int,
        successfulRecognitions:
            null == successfulRecognitions
                ? _value.successfulRecognitions
                : successfulRecognitions // ignore: cast_nullable_to_non_nullable
                    as int,
        failedRecognitions:
            null == failedRecognitions
                ? _value.failedRecognitions
                : failedRecognitions // ignore: cast_nullable_to_non_nullable
                    as int,
        averageConfidence:
            null == averageConfidence
                ? _value.averageConfidence
                : averageConfidence // ignore: cast_nullable_to_non_nullable
                    as double,
        averageProcessingTimeMs:
            null == averageProcessingTimeMs
                ? _value.averageProcessingTimeMs
                : averageProcessingTimeMs // ignore: cast_nullable_to_non_nullable
                    as double,
        lastRecognitionTime:
            freezed == lastRecognitionTime
                ? _value.lastRecognitionTime
                : lastRecognitionTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        sessionStartTime:
            freezed == sessionStartTime
                ? _value.sessionStartTime
                : sessionStartTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecognitionStatisticsImpl implements _RecognitionStatistics {
  const _$RecognitionStatisticsImpl({
    this.totalFramesProcessed = 0,
    this.totalFacesDetected = 0,
    this.successfulRecognitions = 0,
    this.failedRecognitions = 0,
    this.averageConfidence = 0.0,
    this.averageProcessingTimeMs = 0.0,
    this.lastRecognitionTime,
    this.sessionStartTime,
  });

  factory _$RecognitionStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecognitionStatisticsImplFromJson(json);

  @override
  @JsonKey()
  final int totalFramesProcessed;
  @override
  @JsonKey()
  final int totalFacesDetected;
  @override
  @JsonKey()
  final int successfulRecognitions;
  @override
  @JsonKey()
  final int failedRecognitions;
  @override
  @JsonKey()
  final double averageConfidence;
  @override
  @JsonKey()
  final double averageProcessingTimeMs;
  @override
  final DateTime? lastRecognitionTime;
  @override
  final DateTime? sessionStartTime;

  @override
  String toString() {
    return 'RecognitionStatistics(totalFramesProcessed: $totalFramesProcessed, totalFacesDetected: $totalFacesDetected, successfulRecognitions: $successfulRecognitions, failedRecognitions: $failedRecognitions, averageConfidence: $averageConfidence, averageProcessingTimeMs: $averageProcessingTimeMs, lastRecognitionTime: $lastRecognitionTime, sessionStartTime: $sessionStartTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecognitionStatisticsImpl &&
            (identical(other.totalFramesProcessed, totalFramesProcessed) ||
                other.totalFramesProcessed == totalFramesProcessed) &&
            (identical(other.totalFacesDetected, totalFacesDetected) ||
                other.totalFacesDetected == totalFacesDetected) &&
            (identical(other.successfulRecognitions, successfulRecognitions) ||
                other.successfulRecognitions == successfulRecognitions) &&
            (identical(other.failedRecognitions, failedRecognitions) ||
                other.failedRecognitions == failedRecognitions) &&
            (identical(other.averageConfidence, averageConfidence) ||
                other.averageConfidence == averageConfidence) &&
            (identical(
                  other.averageProcessingTimeMs,
                  averageProcessingTimeMs,
                ) ||
                other.averageProcessingTimeMs == averageProcessingTimeMs) &&
            (identical(other.lastRecognitionTime, lastRecognitionTime) ||
                other.lastRecognitionTime == lastRecognitionTime) &&
            (identical(other.sessionStartTime, sessionStartTime) ||
                other.sessionStartTime == sessionStartTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalFramesProcessed,
    totalFacesDetected,
    successfulRecognitions,
    failedRecognitions,
    averageConfidence,
    averageProcessingTimeMs,
    lastRecognitionTime,
    sessionStartTime,
  );

  /// Create a copy of RecognitionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecognitionStatisticsImplCopyWith<_$RecognitionStatisticsImpl>
  get copyWith =>
      __$$RecognitionStatisticsImplCopyWithImpl<_$RecognitionStatisticsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecognitionStatisticsImplToJson(this);
  }
}

abstract class _RecognitionStatistics implements RecognitionStatistics {
  const factory _RecognitionStatistics({
    final int totalFramesProcessed,
    final int totalFacesDetected,
    final int successfulRecognitions,
    final int failedRecognitions,
    final double averageConfidence,
    final double averageProcessingTimeMs,
    final DateTime? lastRecognitionTime,
    final DateTime? sessionStartTime,
  }) = _$RecognitionStatisticsImpl;

  factory _RecognitionStatistics.fromJson(Map<String, dynamic> json) =
      _$RecognitionStatisticsImpl.fromJson;

  @override
  int get totalFramesProcessed;
  @override
  int get totalFacesDetected;
  @override
  int get successfulRecognitions;
  @override
  int get failedRecognitions;
  @override
  double get averageConfidence;
  @override
  double get averageProcessingTimeMs;
  @override
  DateTime? get lastRecognitionTime;
  @override
  DateTime? get sessionStartTime;

  /// Create a copy of RecognitionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecognitionStatisticsImplCopyWith<_$RecognitionStatisticsImpl>
  get copyWith => throw _privateConstructorUsedError;
}
