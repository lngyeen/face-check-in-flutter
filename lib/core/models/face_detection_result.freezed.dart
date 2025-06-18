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
  String get id => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

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
    String id,
    double confidence,
    double x,
    double y,
    double width,
    double height,
    String? label,
    Map<String, dynamic>? metadata,
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
    Object? id = null,
    Object? confidence = null,
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
    Object? label = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            confidence:
                null == confidence
                    ? _value.confidence
                    : confidence // ignore: cast_nullable_to_non_nullable
                        as double,
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
            label:
                freezed == label
                    ? _value.label
                    : label // ignore: cast_nullable_to_non_nullable
                        as String?,
            metadata:
                freezed == metadata
                    ? _value.metadata
                    : metadata // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
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
    String id,
    double confidence,
    double x,
    double y,
    double width,
    double height,
    String? label,
    Map<String, dynamic>? metadata,
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
    Object? id = null,
    Object? confidence = null,
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
    Object? label = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$FaceDetectionResultImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        confidence:
            null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                    as double,
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
        label:
            freezed == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String?,
        metadata:
            freezed == metadata
                ? _value._metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceDetectionResultImpl implements _FaceDetectionResult {
  const _$FaceDetectionResultImpl({
    required this.id,
    required this.confidence,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.label,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata;

  factory _$FaceDetectionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceDetectionResultImplFromJson(json);

  @override
  final String id;
  @override
  final double confidence;
  @override
  final double x;
  @override
  final double y;
  @override
  final double width;
  @override
  final double height;
  @override
  final String? label;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'FaceDetectionResult(id: $id, confidence: $confidence, x: $x, y: $y, width: $width, height: $height, label: $label, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceDetectionResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    confidence,
    x,
    y,
    width,
    height,
    label,
    const DeepCollectionEquality().hash(_metadata),
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
    required final String id,
    required final double confidence,
    required final double x,
    required final double y,
    required final double width,
    required final double height,
    final String? label,
    final Map<String, dynamic>? metadata,
  }) = _$FaceDetectionResultImpl;

  factory _FaceDetectionResult.fromJson(Map<String, dynamic> json) =
      _$FaceDetectionResultImpl.fromJson;

  @override
  String get id;
  @override
  double get confidence;
  @override
  double get x;
  @override
  double get y;
  @override
  double get width;
  @override
  double get height;
  @override
  String? get label;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of FaceDetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceDetectionResultImplCopyWith<_$FaceDetectionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
