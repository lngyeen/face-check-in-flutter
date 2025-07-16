// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppNotification {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String message, SnackBarType type)
    snackBar,
    required TResult Function(FaceDetectionResult face, String? annotatedImage)
    dialog,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String message, SnackBarType type)?
    snackBar,
    TResult? Function(FaceDetectionResult face, String? annotatedImage)? dialog,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String message, SnackBarType type)? snackBar,
    TResult Function(FaceDetectionResult face, String? annotatedImage)? dialog,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowSnackBar value) snackBar,
    required TResult Function(ShowSuccessDialog value) dialog,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowSnackBar value)? snackBar,
    TResult? Function(ShowSuccessDialog value)? dialog,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowSnackBar value)? snackBar,
    TResult Function(ShowSuccessDialog value)? dialog,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
    AppNotification value,
    $Res Function(AppNotification) then,
  ) = _$AppNotificationCopyWithImpl<$Res, AppNotification>;
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ShowSnackBarImplCopyWith<$Res> {
  factory _$$ShowSnackBarImplCopyWith(
    _$ShowSnackBarImpl value,
    $Res Function(_$ShowSnackBarImpl) then,
  ) = __$$ShowSnackBarImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, String message, SnackBarType type});
}

/// @nodoc
class __$$ShowSnackBarImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$ShowSnackBarImpl>
    implements _$$ShowSnackBarImplCopyWith<$Res> {
  __$$ShowSnackBarImplCopyWithImpl(
    _$ShowSnackBarImpl _value,
    $Res Function(_$ShowSnackBarImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? type = null,
  }) {
    return _then(
      _$ShowSnackBarImpl(
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as SnackBarType,
      ),
    );
  }
}

/// @nodoc

class _$ShowSnackBarImpl extends ShowSnackBar {
  const _$ShowSnackBarImpl({
    required this.title,
    required this.message,
    required this.type,
  }) : super._();

  @override
  final String title;
  @override
  final String message;
  @override
  final SnackBarType type;

  @override
  String toString() {
    return 'AppNotification.snackBar(title: $title, message: $message, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowSnackBarImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, message, type);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowSnackBarImplCopyWith<_$ShowSnackBarImpl> get copyWith =>
      __$$ShowSnackBarImplCopyWithImpl<_$ShowSnackBarImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String message, SnackBarType type)
    snackBar,
    required TResult Function(FaceDetectionResult face, String? annotatedImage)
    dialog,
  }) {
    return snackBar(title, message, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String message, SnackBarType type)?
    snackBar,
    TResult? Function(FaceDetectionResult face, String? annotatedImage)? dialog,
  }) {
    return snackBar?.call(title, message, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String message, SnackBarType type)? snackBar,
    TResult Function(FaceDetectionResult face, String? annotatedImage)? dialog,
    required TResult orElse(),
  }) {
    if (snackBar != null) {
      return snackBar(title, message, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowSnackBar value) snackBar,
    required TResult Function(ShowSuccessDialog value) dialog,
  }) {
    return snackBar(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowSnackBar value)? snackBar,
    TResult? Function(ShowSuccessDialog value)? dialog,
  }) {
    return snackBar?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowSnackBar value)? snackBar,
    TResult Function(ShowSuccessDialog value)? dialog,
    required TResult orElse(),
  }) {
    if (snackBar != null) {
      return snackBar(this);
    }
    return orElse();
  }
}

abstract class ShowSnackBar extends AppNotification {
  const factory ShowSnackBar({
    required final String title,
    required final String message,
    required final SnackBarType type,
  }) = _$ShowSnackBarImpl;
  const ShowSnackBar._() : super._();

  String get title;
  String get message;
  SnackBarType get type;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowSnackBarImplCopyWith<_$ShowSnackBarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShowSuccessDialogImplCopyWith<$Res> {
  factory _$$ShowSuccessDialogImplCopyWith(
    _$ShowSuccessDialogImpl value,
    $Res Function(_$ShowSuccessDialogImpl) then,
  ) = __$$ShowSuccessDialogImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FaceDetectionResult face, String? annotatedImage});

  $FaceDetectionResultCopyWith<$Res> get face;
}

/// @nodoc
class __$$ShowSuccessDialogImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$ShowSuccessDialogImpl>
    implements _$$ShowSuccessDialogImplCopyWith<$Res> {
  __$$ShowSuccessDialogImplCopyWithImpl(
    _$ShowSuccessDialogImpl _value,
    $Res Function(_$ShowSuccessDialogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? face = null, Object? annotatedImage = freezed}) {
    return _then(
      _$ShowSuccessDialogImpl(
        face:
            null == face
                ? _value.face
                : face // ignore: cast_nullable_to_non_nullable
                    as FaceDetectionResult,
        annotatedImage:
            freezed == annotatedImage
                ? _value.annotatedImage
                : annotatedImage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }

  /// Create a copy of AppNotification
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

class _$ShowSuccessDialogImpl extends ShowSuccessDialog {
  const _$ShowSuccessDialogImpl({required this.face, this.annotatedImage})
    : super._();

  @override
  final FaceDetectionResult face;
  @override
  final String? annotatedImage;

  @override
  String toString() {
    return 'AppNotification.dialog(face: $face, annotatedImage: $annotatedImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowSuccessDialogImpl &&
            (identical(other.face, face) || other.face == face) &&
            (identical(other.annotatedImage, annotatedImage) ||
                other.annotatedImage == annotatedImage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, face, annotatedImage);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowSuccessDialogImplCopyWith<_$ShowSuccessDialogImpl> get copyWith =>
      __$$ShowSuccessDialogImplCopyWithImpl<_$ShowSuccessDialogImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String message, SnackBarType type)
    snackBar,
    required TResult Function(FaceDetectionResult face, String? annotatedImage)
    dialog,
  }) {
    return dialog(face, annotatedImage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String message, SnackBarType type)?
    snackBar,
    TResult? Function(FaceDetectionResult face, String? annotatedImage)? dialog,
  }) {
    return dialog?.call(face, annotatedImage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String message, SnackBarType type)? snackBar,
    TResult Function(FaceDetectionResult face, String? annotatedImage)? dialog,
    required TResult orElse(),
  }) {
    if (dialog != null) {
      return dialog(face, annotatedImage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowSnackBar value) snackBar,
    required TResult Function(ShowSuccessDialog value) dialog,
  }) {
    return dialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowSnackBar value)? snackBar,
    TResult? Function(ShowSuccessDialog value)? dialog,
  }) {
    return dialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowSnackBar value)? snackBar,
    TResult Function(ShowSuccessDialog value)? dialog,
    required TResult orElse(),
  }) {
    if (dialog != null) {
      return dialog(this);
    }
    return orElse();
  }
}

abstract class ShowSuccessDialog extends AppNotification {
  const factory ShowSuccessDialog({
    required final FaceDetectionResult face,
    final String? annotatedImage,
  }) = _$ShowSuccessDialogImpl;
  const ShowSuccessDialog._() : super._();

  FaceDetectionResult get face;
  String? get annotatedImage;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowSuccessDialogImplCopyWith<_$ShowSuccessDialogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
