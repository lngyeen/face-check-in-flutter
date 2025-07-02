// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CameraEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() permissionRequested,
    required TResult Function(dynamic newStatus) statusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? permissionRequested,
    TResult? Function(dynamic newStatus)? statusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? permissionRequested,
    TResult Function(dynamic newStatus)? statusChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(Start value) start,
    required TResult Function(Stop value) stop,
    required TResult Function(PermissionRequested value) permissionRequested,
    required TResult Function(StatusChanged value) statusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(Start value)? start,
    TResult? Function(Stop value)? stop,
    TResult? Function(PermissionRequested value)? permissionRequested,
    TResult? Function(StatusChanged value)? statusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(Start value)? start,
    TResult Function(Stop value)? stop,
    TResult Function(PermissionRequested value)? permissionRequested,
    TResult Function(StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraEventCopyWith<$Res> {
  factory $CameraEventCopyWith(
          CameraEvent value, $Res Function(CameraEvent) then) =
      _$CameraEventCopyWithImpl<$Res, CameraEvent>;
}

/// @nodoc
class _$CameraEventCopyWithImpl<$Res, $Val extends CameraEvent>
    implements $CameraEventCopyWith<$Res> {
  _$CameraEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CameraEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializeImplCopyWith<$Res> {
  factory _$$InitializeImplCopyWith(
          _$InitializeImpl value, $Res Function(_$InitializeImpl) then) =
      __$$InitializeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializeImplCopyWithImpl<$Res>
    extends _$CameraEventCopyWithImpl<$Res, _$InitializeImpl>
    implements _$$InitializeImplCopyWith<$Res> {
  __$$InitializeImplCopyWithImpl(
      _$InitializeImpl _value, $Res Function(_$InitializeImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitializeImpl implements Initialize {
  const _$InitializeImpl();

  @override
  String toString() {
    return 'CameraEvent.initialize()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitializeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() permissionRequested,
    required TResult Function(dynamic newStatus) statusChanged,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? permissionRequested,
    TResult? Function(dynamic newStatus)? statusChanged,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? permissionRequested,
    TResult Function(dynamic newStatus)? statusChanged,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(Start value) start,
    required TResult Function(Stop value) stop,
    required TResult Function(PermissionRequested value) permissionRequested,
    required TResult Function(StatusChanged value) statusChanged,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(Start value)? start,
    TResult? Function(Stop value)? stop,
    TResult? Function(PermissionRequested value)? permissionRequested,
    TResult? Function(StatusChanged value)? statusChanged,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(Start value)? start,
    TResult Function(Stop value)? stop,
    TResult Function(PermissionRequested value)? permissionRequested,
    TResult Function(StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class Initialize implements CameraEvent {
  const factory Initialize() = _$InitializeImpl;
}

/// @nodoc
abstract class _$$StartImplCopyWith<$Res> {
  factory _$$StartImplCopyWith(
          _$StartImpl value, $Res Function(_$StartImpl) then) =
      __$$StartImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartImplCopyWithImpl<$Res>
    extends _$CameraEventCopyWithImpl<$Res, _$StartImpl>
    implements _$$StartImplCopyWith<$Res> {
  __$$StartImplCopyWithImpl(
      _$StartImpl _value, $Res Function(_$StartImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartImpl implements Start {
  const _$StartImpl();

  @override
  String toString() {
    return 'CameraEvent.start()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() permissionRequested,
    required TResult Function(dynamic newStatus) statusChanged,
  }) {
    return start();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? permissionRequested,
    TResult? Function(dynamic newStatus)? statusChanged,
  }) {
    return start?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? permissionRequested,
    TResult Function(dynamic newStatus)? statusChanged,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(Start value) start,
    required TResult Function(Stop value) stop,
    required TResult Function(PermissionRequested value) permissionRequested,
    required TResult Function(StatusChanged value) statusChanged,
  }) {
    return start(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(Start value)? start,
    TResult? Function(Stop value)? stop,
    TResult? Function(PermissionRequested value)? permissionRequested,
    TResult? Function(StatusChanged value)? statusChanged,
  }) {
    return start?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(Start value)? start,
    TResult Function(Stop value)? stop,
    TResult Function(PermissionRequested value)? permissionRequested,
    TResult Function(StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start(this);
    }
    return orElse();
  }
}

abstract class Start implements CameraEvent {
  const factory Start() = _$StartImpl;
}

/// @nodoc
abstract class _$$StopImplCopyWith<$Res> {
  factory _$$StopImplCopyWith(
          _$StopImpl value, $Res Function(_$StopImpl) then) =
      __$$StopImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopImplCopyWithImpl<$Res>
    extends _$CameraEventCopyWithImpl<$Res, _$StopImpl>
    implements _$$StopImplCopyWith<$Res> {
  __$$StopImplCopyWithImpl(_$StopImpl _value, $Res Function(_$StopImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopImpl implements Stop {
  const _$StopImpl();

  @override
  String toString() {
    return 'CameraEvent.stop()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StopImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() permissionRequested,
    required TResult Function(dynamic newStatus) statusChanged,
  }) {
    return stop();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? permissionRequested,
    TResult? Function(dynamic newStatus)? statusChanged,
  }) {
    return stop?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? permissionRequested,
    TResult Function(dynamic newStatus)? statusChanged,
    required TResult orElse(),
  }) {
    if (stop != null) {
      return stop();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(Start value) start,
    required TResult Function(Stop value) stop,
    required TResult Function(PermissionRequested value) permissionRequested,
    required TResult Function(StatusChanged value) statusChanged,
  }) {
    return stop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(Start value)? start,
    TResult? Function(Stop value)? stop,
    TResult? Function(PermissionRequested value)? permissionRequested,
    TResult? Function(StatusChanged value)? statusChanged,
  }) {
    return stop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(Start value)? start,
    TResult Function(Stop value)? stop,
    TResult Function(PermissionRequested value)? permissionRequested,
    TResult Function(StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (stop != null) {
      return stop(this);
    }
    return orElse();
  }
}

abstract class Stop implements CameraEvent {
  const factory Stop() = _$StopImpl;
}

/// @nodoc
abstract class _$$PermissionRequestedImplCopyWith<$Res> {
  factory _$$PermissionRequestedImplCopyWith(_$PermissionRequestedImpl value,
          $Res Function(_$PermissionRequestedImpl) then) =
      __$$PermissionRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermissionRequestedImplCopyWithImpl<$Res>
    extends _$CameraEventCopyWithImpl<$Res, _$PermissionRequestedImpl>
    implements _$$PermissionRequestedImplCopyWith<$Res> {
  __$$PermissionRequestedImplCopyWithImpl(_$PermissionRequestedImpl _value,
      $Res Function(_$PermissionRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermissionRequestedImpl implements PermissionRequested {
  const _$PermissionRequestedImpl();

  @override
  String toString() {
    return 'CameraEvent.permissionRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() permissionRequested,
    required TResult Function(dynamic newStatus) statusChanged,
  }) {
    return permissionRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? permissionRequested,
    TResult? Function(dynamic newStatus)? statusChanged,
  }) {
    return permissionRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? permissionRequested,
    TResult Function(dynamic newStatus)? statusChanged,
    required TResult orElse(),
  }) {
    if (permissionRequested != null) {
      return permissionRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(Start value) start,
    required TResult Function(Stop value) stop,
    required TResult Function(PermissionRequested value) permissionRequested,
    required TResult Function(StatusChanged value) statusChanged,
  }) {
    return permissionRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(Start value)? start,
    TResult? Function(Stop value)? stop,
    TResult? Function(PermissionRequested value)? permissionRequested,
    TResult? Function(StatusChanged value)? statusChanged,
  }) {
    return permissionRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(Start value)? start,
    TResult Function(Stop value)? stop,
    TResult Function(PermissionRequested value)? permissionRequested,
    TResult Function(StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (permissionRequested != null) {
      return permissionRequested(this);
    }
    return orElse();
  }
}

abstract class PermissionRequested implements CameraEvent {
  const factory PermissionRequested() = _$PermissionRequestedImpl;
}

/// @nodoc
abstract class _$$StatusChangedImplCopyWith<$Res> {
  factory _$$StatusChangedImplCopyWith(
          _$StatusChangedImpl value, $Res Function(_$StatusChangedImpl) then) =
      __$$StatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic newStatus});
}

/// @nodoc
class __$$StatusChangedImplCopyWithImpl<$Res>
    extends _$CameraEventCopyWithImpl<$Res, _$StatusChangedImpl>
    implements _$$StatusChangedImplCopyWith<$Res> {
  __$$StatusChangedImplCopyWithImpl(
      _$StatusChangedImpl _value, $Res Function(_$StatusChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newStatus = freezed,
  }) {
    return _then(_$StatusChangedImpl(
      freezed == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$StatusChangedImpl implements StatusChanged {
  const _$StatusChangedImpl(this.newStatus);

  @override
  final dynamic newStatus;

  @override
  String toString() {
    return 'CameraEvent.statusChanged(newStatus: $newStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusChangedImpl &&
            const DeepCollectionEquality().equals(other.newStatus, newStatus));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(newStatus));

  /// Create a copy of CameraEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusChangedImplCopyWith<_$StatusChangedImpl> get copyWith =>
      __$$StatusChangedImplCopyWithImpl<_$StatusChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() permissionRequested,
    required TResult Function(dynamic newStatus) statusChanged,
  }) {
    return statusChanged(newStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? permissionRequested,
    TResult? Function(dynamic newStatus)? statusChanged,
  }) {
    return statusChanged?.call(newStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? permissionRequested,
    TResult Function(dynamic newStatus)? statusChanged,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(newStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(Start value) start,
    required TResult Function(Stop value) stop,
    required TResult Function(PermissionRequested value) permissionRequested,
    required TResult Function(StatusChanged value) statusChanged,
  }) {
    return statusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(Start value)? start,
    TResult? Function(Stop value)? stop,
    TResult? Function(PermissionRequested value)? permissionRequested,
    TResult? Function(StatusChanged value)? statusChanged,
  }) {
    return statusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(Start value)? start,
    TResult Function(Stop value)? stop,
    TResult Function(PermissionRequested value)? permissionRequested,
    TResult Function(StatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(this);
    }
    return orElse();
  }
}

abstract class StatusChanged implements CameraEvent {
  const factory StatusChanged(final dynamic newStatus) = _$StatusChangedImpl;

  dynamic get newStatus;

  /// Create a copy of CameraEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusChangedImplCopyWith<_$StatusChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
