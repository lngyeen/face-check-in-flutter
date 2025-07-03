// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionResult face) recognizedFace,
    required TResult Function() unrecognized,
    required TResult Function(List<FaceDetectionResult> faces) multipleFaces,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionResult face)? recognizedFace,
    TResult? Function()? unrecognized,
    TResult? Function(List<FaceDetectionResult> faces)? multipleFaces,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionResult face)? recognizedFace,
    TResult Function()? unrecognized,
    TResult Function(List<FaceDetectionResult> faces)? multipleFaces,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RecognizedFace value) recognizedFace,
    required TResult Function(_Unrecognized value) unrecognized,
    required TResult Function(_MultipleFaces value) multipleFaces,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RecognizedFace value)? recognizedFace,
    TResult? Function(_Unrecognized value)? unrecognized,
    TResult? Function(_MultipleFaces value)? multipleFaces,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RecognizedFace value)? recognizedFace,
    TResult Function(_Unrecognized value)? unrecognized,
    TResult Function(_MultipleFaces value)? multipleFaces,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationTypeCopyWith<$Res> {
  factory $NotificationTypeCopyWith(
    NotificationType value,
    $Res Function(NotificationType) then,
  ) = _$NotificationTypeCopyWithImpl<$Res, NotificationType>;
}

/// @nodoc
class _$NotificationTypeCopyWithImpl<$Res, $Val extends NotificationType>
    implements $NotificationTypeCopyWith<$Res> {
  _$NotificationTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RecognizedFaceImplCopyWith<$Res> {
  factory _$$RecognizedFaceImplCopyWith(
    _$RecognizedFaceImpl value,
    $Res Function(_$RecognizedFaceImpl) then,
  ) = __$$RecognizedFaceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FaceDetectionResult face});

  $FaceDetectionResultCopyWith<$Res> get face;
}

/// @nodoc
class __$$RecognizedFaceImplCopyWithImpl<$Res>
    extends _$NotificationTypeCopyWithImpl<$Res, _$RecognizedFaceImpl>
    implements _$$RecognizedFaceImplCopyWith<$Res> {
  __$$RecognizedFaceImplCopyWithImpl(
    _$RecognizedFaceImpl _value,
    $Res Function(_$RecognizedFaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? face = null}) {
    return _then(
      _$RecognizedFaceImpl(
        null == face
            ? _value.face
            : face // ignore: cast_nullable_to_non_nullable
                as FaceDetectionResult,
      ),
    );
  }

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FaceDetectionResultCopyWith<$Res> get face {
    return $FaceDetectionResultCopyWith<$Res>(_value.face, (value) {
      return _then(_value.copyWith(face: value));
    });
  }
}

/// @nodoc

class _$RecognizedFaceImpl implements _RecognizedFace {
  const _$RecognizedFaceImpl(this.face);

  @override
  final FaceDetectionResult face;

  @override
  String toString() {
    return 'NotificationType.recognizedFace(face: $face)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecognizedFaceImpl &&
            (identical(other.face, face) || other.face == face));
  }

  @override
  int get hashCode => Object.hash(runtimeType, face);

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecognizedFaceImplCopyWith<_$RecognizedFaceImpl> get copyWith =>
      __$$RecognizedFaceImplCopyWithImpl<_$RecognizedFaceImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionResult face) recognizedFace,
    required TResult Function() unrecognized,
    required TResult Function(List<FaceDetectionResult> faces) multipleFaces,
  }) {
    return recognizedFace(face);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionResult face)? recognizedFace,
    TResult? Function()? unrecognized,
    TResult? Function(List<FaceDetectionResult> faces)? multipleFaces,
  }) {
    return recognizedFace?.call(face);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionResult face)? recognizedFace,
    TResult Function()? unrecognized,
    TResult Function(List<FaceDetectionResult> faces)? multipleFaces,
    required TResult orElse(),
  }) {
    if (recognizedFace != null) {
      return recognizedFace(face);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RecognizedFace value) recognizedFace,
    required TResult Function(_Unrecognized value) unrecognized,
    required TResult Function(_MultipleFaces value) multipleFaces,
  }) {
    return recognizedFace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RecognizedFace value)? recognizedFace,
    TResult? Function(_Unrecognized value)? unrecognized,
    TResult? Function(_MultipleFaces value)? multipleFaces,
  }) {
    return recognizedFace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RecognizedFace value)? recognizedFace,
    TResult Function(_Unrecognized value)? unrecognized,
    TResult Function(_MultipleFaces value)? multipleFaces,
    required TResult orElse(),
  }) {
    if (recognizedFace != null) {
      return recognizedFace(this);
    }
    return orElse();
  }
}

abstract class _RecognizedFace implements NotificationType {
  const factory _RecognizedFace(final FaceDetectionResult face) =
      _$RecognizedFaceImpl;

  FaceDetectionResult get face;

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecognizedFaceImplCopyWith<_$RecognizedFaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnrecognizedImplCopyWith<$Res> {
  factory _$$UnrecognizedImplCopyWith(
    _$UnrecognizedImpl value,
    $Res Function(_$UnrecognizedImpl) then,
  ) = __$$UnrecognizedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnrecognizedImplCopyWithImpl<$Res>
    extends _$NotificationTypeCopyWithImpl<$Res, _$UnrecognizedImpl>
    implements _$$UnrecognizedImplCopyWith<$Res> {
  __$$UnrecognizedImplCopyWithImpl(
    _$UnrecognizedImpl _value,
    $Res Function(_$UnrecognizedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnrecognizedImpl implements _Unrecognized {
  const _$UnrecognizedImpl();

  @override
  String toString() {
    return 'NotificationType.unrecognized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnrecognizedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionResult face) recognizedFace,
    required TResult Function() unrecognized,
    required TResult Function(List<FaceDetectionResult> faces) multipleFaces,
  }) {
    return unrecognized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionResult face)? recognizedFace,
    TResult? Function()? unrecognized,
    TResult? Function(List<FaceDetectionResult> faces)? multipleFaces,
  }) {
    return unrecognized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionResult face)? recognizedFace,
    TResult Function()? unrecognized,
    TResult Function(List<FaceDetectionResult> faces)? multipleFaces,
    required TResult orElse(),
  }) {
    if (unrecognized != null) {
      return unrecognized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RecognizedFace value) recognizedFace,
    required TResult Function(_Unrecognized value) unrecognized,
    required TResult Function(_MultipleFaces value) multipleFaces,
  }) {
    return unrecognized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RecognizedFace value)? recognizedFace,
    TResult? Function(_Unrecognized value)? unrecognized,
    TResult? Function(_MultipleFaces value)? multipleFaces,
  }) {
    return unrecognized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RecognizedFace value)? recognizedFace,
    TResult Function(_Unrecognized value)? unrecognized,
    TResult Function(_MultipleFaces value)? multipleFaces,
    required TResult orElse(),
  }) {
    if (unrecognized != null) {
      return unrecognized(this);
    }
    return orElse();
  }
}

abstract class _Unrecognized implements NotificationType {
  const factory _Unrecognized() = _$UnrecognizedImpl;
}

/// @nodoc
abstract class _$$MultipleFacesImplCopyWith<$Res> {
  factory _$$MultipleFacesImplCopyWith(
    _$MultipleFacesImpl value,
    $Res Function(_$MultipleFacesImpl) then,
  ) = __$$MultipleFacesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FaceDetectionResult> faces});
}

/// @nodoc
class __$$MultipleFacesImplCopyWithImpl<$Res>
    extends _$NotificationTypeCopyWithImpl<$Res, _$MultipleFacesImpl>
    implements _$$MultipleFacesImplCopyWith<$Res> {
  __$$MultipleFacesImplCopyWithImpl(
    _$MultipleFacesImpl _value,
    $Res Function(_$MultipleFacesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? faces = null}) {
    return _then(
      _$MultipleFacesImpl(
        null == faces
            ? _value._faces
            : faces // ignore: cast_nullable_to_non_nullable
                as List<FaceDetectionResult>,
      ),
    );
  }
}

/// @nodoc

class _$MultipleFacesImpl implements _MultipleFaces {
  const _$MultipleFacesImpl(final List<FaceDetectionResult> faces)
    : _faces = faces;

  final List<FaceDetectionResult> _faces;
  @override
  List<FaceDetectionResult> get faces {
    if (_faces is EqualUnmodifiableListView) return _faces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_faces);
  }

  @override
  String toString() {
    return 'NotificationType.multipleFaces(faces: $faces)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultipleFacesImpl &&
            const DeepCollectionEquality().equals(other._faces, _faces));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_faces));

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultipleFacesImplCopyWith<_$MultipleFacesImpl> get copyWith =>
      __$$MultipleFacesImplCopyWithImpl<_$MultipleFacesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FaceDetectionResult face) recognizedFace,
    required TResult Function() unrecognized,
    required TResult Function(List<FaceDetectionResult> faces) multipleFaces,
  }) {
    return multipleFaces(faces);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FaceDetectionResult face)? recognizedFace,
    TResult? Function()? unrecognized,
    TResult? Function(List<FaceDetectionResult> faces)? multipleFaces,
  }) {
    return multipleFaces?.call(faces);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FaceDetectionResult face)? recognizedFace,
    TResult Function()? unrecognized,
    TResult Function(List<FaceDetectionResult> faces)? multipleFaces,
    required TResult orElse(),
  }) {
    if (multipleFaces != null) {
      return multipleFaces(faces);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RecognizedFace value) recognizedFace,
    required TResult Function(_Unrecognized value) unrecognized,
    required TResult Function(_MultipleFaces value) multipleFaces,
  }) {
    return multipleFaces(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RecognizedFace value)? recognizedFace,
    TResult? Function(_Unrecognized value)? unrecognized,
    TResult? Function(_MultipleFaces value)? multipleFaces,
  }) {
    return multipleFaces?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RecognizedFace value)? recognizedFace,
    TResult Function(_Unrecognized value)? unrecognized,
    TResult Function(_MultipleFaces value)? multipleFaces,
    required TResult orElse(),
  }) {
    if (multipleFaces != null) {
      return multipleFaces(this);
    }
    return orElse();
  }
}

abstract class _MultipleFaces implements NotificationType {
  const factory _MultipleFaces(final List<FaceDetectionResult> faces) =
      _$MultipleFacesImpl;

  List<FaceDetectionResult> get faces;

  /// Create a copy of NotificationType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultipleFacesImplCopyWith<_$MultipleFacesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
