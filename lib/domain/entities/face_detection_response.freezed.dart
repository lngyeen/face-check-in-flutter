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
  String get type => throw _privateConstructorUsedError; // "frameResult"
  List<FaceDetectionResult> get faces => throw _privateConstructorUsedError;
  String? get frameId => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

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
  $Res call({
    String type,
    List<FaceDetectionResult> faces,
    String? frameId,
    DateTime? timestamp,
  });
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
  $Res call({
    Object? type = null,
    Object? faces = null,
    Object? frameId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            faces:
                null == faces
                    ? _value.faces
                    : faces // ignore: cast_nullable_to_non_nullable
                        as List<FaceDetectionResult>,
            frameId:
                freezed == frameId
                    ? _value.frameId
                    : frameId // ignore: cast_nullable_to_non_nullable
                        as String?,
            timestamp:
                freezed == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
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
  $Res call({
    String type,
    List<FaceDetectionResult> faces,
    String? frameId,
    DateTime? timestamp,
  });
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
  $Res call({
    Object? type = null,
    Object? faces = null,
    Object? frameId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$FaceDetectionResponseImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        faces:
            null == faces
                ? _value._faces
                : faces // ignore: cast_nullable_to_non_nullable
                    as List<FaceDetectionResult>,
        frameId:
            freezed == frameId
                ? _value.frameId
                : frameId // ignore: cast_nullable_to_non_nullable
                    as String?,
        timestamp:
            freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceDetectionResponseImpl implements _FaceDetectionResponse {
  const _$FaceDetectionResponseImpl({
    required this.type,
    required final List<FaceDetectionResult> faces,
    this.frameId,
    this.timestamp,
  }) : _faces = faces;

  factory _$FaceDetectionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceDetectionResponseImplFromJson(json);

  @override
  final String type;
  // "frameResult"
  final List<FaceDetectionResult> _faces;
  // "frameResult"
  @override
  List<FaceDetectionResult> get faces {
    if (_faces is EqualUnmodifiableListView) return _faces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_faces);
  }

  @override
  final String? frameId;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'FaceDetectionResponse(type: $type, faces: $faces, frameId: $frameId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceDetectionResponseImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._faces, _faces) &&
            (identical(other.frameId, frameId) || other.frameId == frameId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_faces),
    frameId,
    timestamp,
  );

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
    required final List<FaceDetectionResult> faces,
    final String? frameId,
    final DateTime? timestamp,
  }) = _$FaceDetectionResponseImpl;

  factory _FaceDetectionResponse.fromJson(Map<String, dynamic> json) =
      _$FaceDetectionResponseImpl.fromJson;

  @override
  String get type; // "frameResult"
  @override
  List<FaceDetectionResult> get faces;
  @override
  String? get frameId;
  @override
  DateTime? get timestamp;

  /// Create a copy of FaceDetectionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceDetectionResponseImplCopyWith<_$FaceDetectionResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FaceDetectionResult _$FaceDetectionResultFromJson(Map<String, dynamic> json) {
  return _FaceDetectionResult.fromJson(json);
}

/// @nodoc
mixin _$FaceDetectionResult {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String? get personId => throw _privateConstructorUsedError;
  String? get personName => throw _privateConstructorUsedError;

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
    double x,
    double y,
    double width,
    double height,
    double confidence,
    String? personId,
    String? personName,
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
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
    Object? confidence = null,
    Object? personId = freezed,
    Object? personName = freezed,
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
            confidence:
                null == confidence
                    ? _value.confidence
                    : confidence // ignore: cast_nullable_to_non_nullable
                        as double,
            personId:
                freezed == personId
                    ? _value.personId
                    : personId // ignore: cast_nullable_to_non_nullable
                        as String?,
            personName:
                freezed == personName
                    ? _value.personName
                    : personName // ignore: cast_nullable_to_non_nullable
                        as String?,
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
    double x,
    double y,
    double width,
    double height,
    double confidence,
    String? personId,
    String? personName,
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
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
    Object? confidence = null,
    Object? personId = freezed,
    Object? personName = freezed,
  }) {
    return _then(
      _$FaceDetectionResultImpl(
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
        confidence:
            null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                    as double,
        personId:
            freezed == personId
                ? _value.personId
                : personId // ignore: cast_nullable_to_non_nullable
                    as String?,
        personName:
            freezed == personName
                ? _value.personName
                : personName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceDetectionResultImpl implements _FaceDetectionResult {
  const _$FaceDetectionResultImpl({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.confidence,
    this.personId,
    this.personName,
  });

  factory _$FaceDetectionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceDetectionResultImplFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final double width;
  @override
  final double height;
  @override
  final double confidence;
  @override
  final String? personId;
  @override
  final String? personName;

  @override
  String toString() {
    return 'FaceDetectionResult(x: $x, y: $y, width: $width, height: $height, confidence: $confidence, personId: $personId, personName: $personName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceDetectionResultImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.personId, personId) ||
                other.personId == personId) &&
            (identical(other.personName, personName) ||
                other.personName == personName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    x,
    y,
    width,
    height,
    confidence,
    personId,
    personName,
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
    required final double x,
    required final double y,
    required final double width,
    required final double height,
    required final double confidence,
    final String? personId,
    final String? personName,
  }) = _$FaceDetectionResultImpl;

  factory _FaceDetectionResult.fromJson(Map<String, dynamic> json) =
      _$FaceDetectionResultImpl.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double get width;
  @override
  double get height;
  @override
  double get confidence;
  @override
  String? get personId;
  @override
  String? get personName;

  /// Create a copy of FaceDetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceDetectionResultImplCopyWith<_$FaceDetectionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
