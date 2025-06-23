// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_detection_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FaceDetectionResponse _$FaceDetectionResponseFromJson(
  Map<String, dynamic> json,
) {
  return _FaceDetectionResponse.fromJson(json);
}

/// @nodoc
mixin _$FaceDetectionResponse {
  String get type => throw _privateConstructorUsedError;
  FaceDetectionData get data => throw _privateConstructorUsedError;

  /// Serializes this FaceDetectionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FaceDetectionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaceDetectionResponseCopyWith<FaceDetectionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceDetectionResponseCopyWith<$Res> {
  factory $FaceDetectionResponseCopyWith(
    FaceDetectionResponse value,
    $Res Function(FaceDetectionResponse) then,
  ) = _$FaceDetectionResponseCopyWithImpl<$Res, FaceDetectionResponse>;
  @useResult
  $Res call({String type, FaceDetectionData data});

  $FaceDetectionDataCopyWith<$Res> get data;
}

/// @nodoc
class _$FaceDetectionResponseCopyWithImpl<
  $Res,
  $Val extends FaceDetectionResponse
>
    implements $FaceDetectionResponseCopyWith<$Res> {
  _$FaceDetectionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaceDetectionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? data = null}) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as FaceDetectionData,
          )
          as $Val,
    );
  }

  /// Create a copy of FaceDetectionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FaceDetectionDataCopyWith<$Res> get data {
    return $FaceDetectionDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FaceDetectionResponseImplCopyWith<$Res>
    implements $FaceDetectionResponseCopyWith<$Res> {
  factory _$$FaceDetectionResponseImplCopyWith(
    _$FaceDetectionResponseImpl value,
    $Res Function(_$FaceDetectionResponseImpl) then,
  ) = __$$FaceDetectionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, FaceDetectionData data});

  @override
  $FaceDetectionDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$FaceDetectionResponseImplCopyWithImpl<$Res>
    extends
        _$FaceDetectionResponseCopyWithImpl<$Res, _$FaceDetectionResponseImpl>
    implements _$$FaceDetectionResponseImplCopyWith<$Res> {
  __$$FaceDetectionResponseImplCopyWithImpl(
    _$FaceDetectionResponseImpl _value,
    $Res Function(_$FaceDetectionResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaceDetectionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? data = null}) {
    return _then(
      _$FaceDetectionResponseImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as FaceDetectionData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceDetectionResponseImpl implements _FaceDetectionResponse {
  const _$FaceDetectionResponseImpl({required this.type, required this.data});

  factory _$FaceDetectionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceDetectionResponseImplFromJson(json);

  @override
  final String type;
  @override
  final FaceDetectionData data;

  @override
  String toString() {
    return 'FaceDetectionResponse(type: $type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceDetectionResponseImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, data);

  /// Create a copy of FaceDetectionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceDetectionResponseImplCopyWith<_$FaceDetectionResponseImpl>
  get copyWith =>
      __$$FaceDetectionResponseImplCopyWithImpl<_$FaceDetectionResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FaceDetectionResponseImplToJson(this);
  }
}

abstract class _FaceDetectionResponse implements FaceDetectionResponse {
  const factory _FaceDetectionResponse({
    required final String type,
    required final FaceDetectionData data,
  }) = _$FaceDetectionResponseImpl;

  factory _FaceDetectionResponse.fromJson(Map<String, dynamic> json) =
      _$FaceDetectionResponseImpl.fromJson;

  @override
  String get type;
  @override
  FaceDetectionData get data;

  /// Create a copy of FaceDetectionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceDetectionResponseImplCopyWith<_$FaceDetectionResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FaceDetectionData _$FaceDetectionDataFromJson(Map<String, dynamic> json) {
  return _FaceDetectionData.fromJson(json);
}

/// @nodoc
mixin _$FaceDetectionData {
  List<FaceDetectionResult> get faces => throw _privateConstructorUsedError;
  String get faceImagePath => throw _privateConstructorUsedError;
  String get cameraId => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  int get processingTime => throw _privateConstructorUsedError;
  bool get isCheckinSent => throw _privateConstructorUsedError;
  String? get annotatedImage => throw _privateConstructorUsedError;

  /// Serializes this FaceDetectionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FaceDetectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaceDetectionDataCopyWith<FaceDetectionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceDetectionDataCopyWith<$Res> {
  factory $FaceDetectionDataCopyWith(
    FaceDetectionData value,
    $Res Function(FaceDetectionData) then,
  ) = _$FaceDetectionDataCopyWithImpl<$Res, FaceDetectionData>;
  @useResult
  $Res call({
    List<FaceDetectionResult> faces,
    String faceImagePath,
    String cameraId,
    String timestamp,
    int processingTime,
    bool isCheckinSent,
    String? annotatedImage,
  });
}

/// @nodoc
class _$FaceDetectionDataCopyWithImpl<$Res, $Val extends FaceDetectionData>
    implements $FaceDetectionDataCopyWith<$Res> {
  _$FaceDetectionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaceDetectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faces = null,
    Object? faceImagePath = null,
    Object? cameraId = null,
    Object? timestamp = null,
    Object? processingTime = null,
    Object? isCheckinSent = null,
    Object? annotatedImage = freezed,
  }) {
    return _then(
      _value.copyWith(
            faces:
                null == faces
                    ? _value.faces
                    : faces // ignore: cast_nullable_to_non_nullable
                        as List<FaceDetectionResult>,
            faceImagePath:
                null == faceImagePath
                    ? _value.faceImagePath
                    : faceImagePath // ignore: cast_nullable_to_non_nullable
                        as String,
            cameraId:
                null == cameraId
                    ? _value.cameraId
                    : cameraId // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as String,
            processingTime:
                null == processingTime
                    ? _value.processingTime
                    : processingTime // ignore: cast_nullable_to_non_nullable
                        as int,
            isCheckinSent:
                null == isCheckinSent
                    ? _value.isCheckinSent
                    : isCheckinSent // ignore: cast_nullable_to_non_nullable
                        as bool,
            annotatedImage:
                freezed == annotatedImage
                    ? _value.annotatedImage
                    : annotatedImage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FaceDetectionDataImplCopyWith<$Res>
    implements $FaceDetectionDataCopyWith<$Res> {
  factory _$$FaceDetectionDataImplCopyWith(
    _$FaceDetectionDataImpl value,
    $Res Function(_$FaceDetectionDataImpl) then,
  ) = __$$FaceDetectionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<FaceDetectionResult> faces,
    String faceImagePath,
    String cameraId,
    String timestamp,
    int processingTime,
    bool isCheckinSent,
    String? annotatedImage,
  });
}

/// @nodoc
class __$$FaceDetectionDataImplCopyWithImpl<$Res>
    extends _$FaceDetectionDataCopyWithImpl<$Res, _$FaceDetectionDataImpl>
    implements _$$FaceDetectionDataImplCopyWith<$Res> {
  __$$FaceDetectionDataImplCopyWithImpl(
    _$FaceDetectionDataImpl _value,
    $Res Function(_$FaceDetectionDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaceDetectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faces = null,
    Object? faceImagePath = null,
    Object? cameraId = null,
    Object? timestamp = null,
    Object? processingTime = null,
    Object? isCheckinSent = null,
    Object? annotatedImage = freezed,
  }) {
    return _then(
      _$FaceDetectionDataImpl(
        faces:
            null == faces
                ? _value._faces
                : faces // ignore: cast_nullable_to_non_nullable
                    as List<FaceDetectionResult>,
        faceImagePath:
            null == faceImagePath
                ? _value.faceImagePath
                : faceImagePath // ignore: cast_nullable_to_non_nullable
                    as String,
        cameraId:
            null == cameraId
                ? _value.cameraId
                : cameraId // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as String,
        processingTime:
            null == processingTime
                ? _value.processingTime
                : processingTime // ignore: cast_nullable_to_non_nullable
                    as int,
        isCheckinSent:
            null == isCheckinSent
                ? _value.isCheckinSent
                : isCheckinSent // ignore: cast_nullable_to_non_nullable
                    as bool,
        annotatedImage:
            freezed == annotatedImage
                ? _value.annotatedImage
                : annotatedImage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceDetectionDataImpl implements _FaceDetectionData {
  const _$FaceDetectionDataImpl({
    required final List<FaceDetectionResult> faces,
    this.faceImagePath = '',
    this.cameraId = '',
    required this.timestamp,
    this.processingTime = 0,
    this.isCheckinSent = false,
    this.annotatedImage,
  }) : _faces = faces;

  factory _$FaceDetectionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceDetectionDataImplFromJson(json);

  final List<FaceDetectionResult> _faces;
  @override
  List<FaceDetectionResult> get faces {
    if (_faces is EqualUnmodifiableListView) return _faces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_faces);
  }

  @override
  @JsonKey()
  final String faceImagePath;
  @override
  @JsonKey()
  final String cameraId;
  @override
  final String timestamp;
  @override
  @JsonKey()
  final int processingTime;
  @override
  @JsonKey()
  final bool isCheckinSent;
  @override
  final String? annotatedImage;

  @override
  String toString() {
    return 'FaceDetectionData(faces: $faces, faceImagePath: $faceImagePath, cameraId: $cameraId, timestamp: $timestamp, processingTime: $processingTime, isCheckinSent: $isCheckinSent, annotatedImage: $annotatedImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceDetectionDataImpl &&
            const DeepCollectionEquality().equals(other._faces, _faces) &&
            (identical(other.faceImagePath, faceImagePath) ||
                other.faceImagePath == faceImagePath) &&
            (identical(other.cameraId, cameraId) ||
                other.cameraId == cameraId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.processingTime, processingTime) ||
                other.processingTime == processingTime) &&
            (identical(other.isCheckinSent, isCheckinSent) ||
                other.isCheckinSent == isCheckinSent) &&
            (identical(other.annotatedImage, annotatedImage) ||
                other.annotatedImage == annotatedImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_faces),
    faceImagePath,
    cameraId,
    timestamp,
    processingTime,
    isCheckinSent,
    annotatedImage,
  );

  /// Create a copy of FaceDetectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceDetectionDataImplCopyWith<_$FaceDetectionDataImpl> get copyWith =>
      __$$FaceDetectionDataImplCopyWithImpl<_$FaceDetectionDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FaceDetectionDataImplToJson(this);
  }
}

abstract class _FaceDetectionData implements FaceDetectionData {
  const factory _FaceDetectionData({
    required final List<FaceDetectionResult> faces,
    final String faceImagePath,
    final String cameraId,
    required final String timestamp,
    final int processingTime,
    final bool isCheckinSent,
    final String? annotatedImage,
  }) = _$FaceDetectionDataImpl;

  factory _FaceDetectionData.fromJson(Map<String, dynamic> json) =
      _$FaceDetectionDataImpl.fromJson;

  @override
  List<FaceDetectionResult> get faces;
  @override
  String get faceImagePath;
  @override
  String get cameraId;
  @override
  String get timestamp;
  @override
  int get processingTime;
  @override
  bool get isCheckinSent;
  @override
  String? get annotatedImage;

  /// Create a copy of FaceDetectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceDetectionDataImplCopyWith<_$FaceDetectionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FaceDetectionResult _$FaceDetectionResultFromJson(Map<String, dynamic> json) {
  return _FaceDetectionResult.fromJson(json);
}

/// @nodoc
mixin _$FaceDetectionResult {
  String? get faceId => throw _privateConstructorUsedError;
  bool get isRecognized => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  bool get mask => throw _privateConstructorUsedError;
  List<int> get bbox => throw _privateConstructorUsedError;

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
    String? faceId,
    bool isRecognized,
    double confidence,
    String? gender,
    int? age,
    bool mask,
    List<int> bbox,
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
    Object? faceId = freezed,
    Object? isRecognized = null,
    Object? confidence = null,
    Object? gender = freezed,
    Object? age = freezed,
    Object? mask = null,
    Object? bbox = null,
  }) {
    return _then(
      _value.copyWith(
            faceId:
                freezed == faceId
                    ? _value.faceId
                    : faceId // ignore: cast_nullable_to_non_nullable
                        as String?,
            isRecognized:
                null == isRecognized
                    ? _value.isRecognized
                    : isRecognized // ignore: cast_nullable_to_non_nullable
                        as bool,
            confidence:
                null == confidence
                    ? _value.confidence
                    : confidence // ignore: cast_nullable_to_non_nullable
                        as double,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
            age:
                freezed == age
                    ? _value.age
                    : age // ignore: cast_nullable_to_non_nullable
                        as int?,
            mask:
                null == mask
                    ? _value.mask
                    : mask // ignore: cast_nullable_to_non_nullable
                        as bool,
            bbox:
                null == bbox
                    ? _value.bbox
                    : bbox // ignore: cast_nullable_to_non_nullable
                        as List<int>,
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
    String? faceId,
    bool isRecognized,
    double confidence,
    String? gender,
    int? age,
    bool mask,
    List<int> bbox,
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
    Object? faceId = freezed,
    Object? isRecognized = null,
    Object? confidence = null,
    Object? gender = freezed,
    Object? age = freezed,
    Object? mask = null,
    Object? bbox = null,
  }) {
    return _then(
      _$FaceDetectionResultImpl(
        faceId:
            freezed == faceId
                ? _value.faceId
                : faceId // ignore: cast_nullable_to_non_nullable
                    as String?,
        isRecognized:
            null == isRecognized
                ? _value.isRecognized
                : isRecognized // ignore: cast_nullable_to_non_nullable
                    as bool,
        confidence:
            null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                    as double,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
        age:
            freezed == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                    as int?,
        mask:
            null == mask
                ? _value.mask
                : mask // ignore: cast_nullable_to_non_nullable
                    as bool,
        bbox:
            null == bbox
                ? _value._bbox
                : bbox // ignore: cast_nullable_to_non_nullable
                    as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceDetectionResultImpl extends _FaceDetectionResult {
  const _$FaceDetectionResultImpl({
    this.faceId,
    this.isRecognized = false,
    this.confidence = 0.0,
    this.gender,
    this.age,
    this.mask = false,
    final List<int> bbox = const [],
  }) : _bbox = bbox,
       super._();

  factory _$FaceDetectionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceDetectionResultImplFromJson(json);

  @override
  final String? faceId;
  @override
  @JsonKey()
  final bool isRecognized;
  @override
  @JsonKey()
  final double confidence;
  @override
  final String? gender;
  @override
  final int? age;
  @override
  @JsonKey()
  final bool mask;
  final List<int> _bbox;
  @override
  @JsonKey()
  List<int> get bbox {
    if (_bbox is EqualUnmodifiableListView) return _bbox;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bbox);
  }

  @override
  String toString() {
    return 'FaceDetectionResult(faceId: $faceId, isRecognized: $isRecognized, confidence: $confidence, gender: $gender, age: $age, mask: $mask, bbox: $bbox)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceDetectionResultImpl &&
            (identical(other.faceId, faceId) || other.faceId == faceId) &&
            (identical(other.isRecognized, isRecognized) ||
                other.isRecognized == isRecognized) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.mask, mask) || other.mask == mask) &&
            const DeepCollectionEquality().equals(other._bbox, _bbox));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    faceId,
    isRecognized,
    confidence,
    gender,
    age,
    mask,
    const DeepCollectionEquality().hash(_bbox),
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

abstract class _FaceDetectionResult extends FaceDetectionResult {
  const factory _FaceDetectionResult({
    final String? faceId,
    final bool isRecognized,
    final double confidence,
    final String? gender,
    final int? age,
    final bool mask,
    final List<int> bbox,
  }) = _$FaceDetectionResultImpl;
  const _FaceDetectionResult._() : super._();

  factory _FaceDetectionResult.fromJson(Map<String, dynamic> json) =
      _$FaceDetectionResultImpl.fromJson;

  @override
  String? get faceId;
  @override
  bool get isRecognized;
  @override
  double get confidence;
  @override
  String? get gender;
  @override
  int? get age;
  @override
  bool get mask;
  @override
  List<int> get bbox;

  /// Create a copy of FaceDetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceDetectionResultImplCopyWith<_$FaceDetectionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImageSize _$ImageSizeFromJson(Map<String, dynamic> json) {
  return _ImageSize.fromJson(json);
}

/// @nodoc
mixin _$ImageSize {
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;

  /// Serializes this ImageSize to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageSize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageSizeCopyWith<ImageSize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageSizeCopyWith<$Res> {
  factory $ImageSizeCopyWith(ImageSize value, $Res Function(ImageSize) then) =
      _$ImageSizeCopyWithImpl<$Res, ImageSize>;
  @useResult
  $Res call({int width, int height});
}

/// @nodoc
class _$ImageSizeCopyWithImpl<$Res, $Val extends ImageSize>
    implements $ImageSizeCopyWith<$Res> {
  _$ImageSizeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageSize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? width = null, Object? height = null}) {
    return _then(
      _value.copyWith(
            width:
                null == width
                    ? _value.width
                    : width // ignore: cast_nullable_to_non_nullable
                        as int,
            height:
                null == height
                    ? _value.height
                    : height // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImageSizeImplCopyWith<$Res>
    implements $ImageSizeCopyWith<$Res> {
  factory _$$ImageSizeImplCopyWith(
    _$ImageSizeImpl value,
    $Res Function(_$ImageSizeImpl) then,
  ) = __$$ImageSizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int width, int height});
}

/// @nodoc
class __$$ImageSizeImplCopyWithImpl<$Res>
    extends _$ImageSizeCopyWithImpl<$Res, _$ImageSizeImpl>
    implements _$$ImageSizeImplCopyWith<$Res> {
  __$$ImageSizeImplCopyWithImpl(
    _$ImageSizeImpl _value,
    $Res Function(_$ImageSizeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageSize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? width = null, Object? height = null}) {
    return _then(
      _$ImageSizeImpl(
        width:
            null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                    as int,
        height:
            null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageSizeImpl implements _ImageSize {
  const _$ImageSizeImpl({required this.width, required this.height});

  factory _$ImageSizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageSizeImplFromJson(json);

  @override
  final int width;
  @override
  final int height;

  @override
  String toString() {
    return 'ImageSize(width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageSizeImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, width, height);

  /// Create a copy of ImageSize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageSizeImplCopyWith<_$ImageSizeImpl> get copyWith =>
      __$$ImageSizeImplCopyWithImpl<_$ImageSizeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageSizeImplToJson(this);
  }
}

abstract class _ImageSize implements ImageSize {
  const factory _ImageSize({
    required final int width,
    required final int height,
  }) = _$ImageSizeImpl;

  factory _ImageSize.fromJson(Map<String, dynamic> json) =
      _$ImageSizeImpl.fromJson;

  @override
  int get width;
  @override
  int get height;

  /// Create a copy of ImageSize
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageSizeImplCopyWith<_$ImageSizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BoundingBox _$BoundingBoxFromJson(Map<String, dynamic> json) {
  return _BoundingBox.fromJson(json);
}

/// @nodoc
mixin _$BoundingBox {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;

  /// Serializes this BoundingBox to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoundingBoxCopyWith<BoundingBox> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoundingBoxCopyWith<$Res> {
  factory $BoundingBoxCopyWith(
    BoundingBox value,
    $Res Function(BoundingBox) then,
  ) = _$BoundingBoxCopyWithImpl<$Res, BoundingBox>;
  @useResult
  $Res call({double x, double y, double width, double height});
}

/// @nodoc
class _$BoundingBoxCopyWithImpl<$Res, $Val extends BoundingBox>
    implements $BoundingBoxCopyWith<$Res> {
  _$BoundingBoxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(
      _value.copyWith(
            x:
                null == x
                    ? _value.x
                    : x // ignore: cast_nullable_to_non_nullable
                        as double,
            y:
                null == y
                    ? _value.y
                    : y // ignore: cast_nullable_to_non_nullable
                        as double,
            width:
                null == width
                    ? _value.width
                    : width // ignore: cast_nullable_to_non_nullable
                        as double,
            height:
                null == height
                    ? _value.height
                    : height // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BoundingBoxImplCopyWith<$Res>
    implements $BoundingBoxCopyWith<$Res> {
  factory _$$BoundingBoxImplCopyWith(
    _$BoundingBoxImpl value,
    $Res Function(_$BoundingBoxImpl) then,
  ) = __$$BoundingBoxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y, double width, double height});
}

/// @nodoc
class __$$BoundingBoxImplCopyWithImpl<$Res>
    extends _$BoundingBoxCopyWithImpl<$Res, _$BoundingBoxImpl>
    implements _$$BoundingBoxImplCopyWith<$Res> {
  __$$BoundingBoxImplCopyWithImpl(
    _$BoundingBoxImpl _value,
    $Res Function(_$BoundingBoxImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(
      _$BoundingBoxImpl(
        x:
            null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                    as double,
        y:
            null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                    as double,
        width:
            null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                    as double,
        height:
            null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BoundingBoxImpl implements _BoundingBox {
  const _$BoundingBoxImpl({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory _$BoundingBoxImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoundingBoxImplFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final double width;
  @override
  final double height;

  @override
  String toString() {
    return 'BoundingBox(x: $x, y: $y, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoundingBoxImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, width, height);

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoundingBoxImplCopyWith<_$BoundingBoxImpl> get copyWith =>
      __$$BoundingBoxImplCopyWithImpl<_$BoundingBoxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoundingBoxImplToJson(this);
  }
}

abstract class _BoundingBox implements BoundingBox {
  const factory _BoundingBox({
    required final double x,
    required final double y,
    required final double width,
    required final double height,
  }) = _$BoundingBoxImpl;

  factory _BoundingBox.fromJson(Map<String, dynamic> json) =
      _$BoundingBoxImpl.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double get width;
  @override
  double get height;

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoundingBoxImplCopyWith<_$BoundingBoxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
