// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_bloc_v2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CheckInEventV2 {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInEventV2CopyWith<$Res> {
  factory $CheckInEventV2CopyWith(
    CheckInEventV2 value,
    $Res Function(CheckInEventV2) then,
  ) = _$CheckInEventV2CopyWithImpl<$Res, CheckInEventV2>;
}

/// @nodoc
class _$CheckInEventV2CopyWithImpl<$Res, $Val extends CheckInEventV2>
    implements $CheckInEventV2CopyWith<$Res> {
  _$CheckInEventV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CheckInStartImplCopyWith<$Res> {
  factory _$$CheckInStartImplCopyWith(
    _$CheckInStartImpl value,
    $Res Function(_$CheckInStartImpl) then,
  ) = __$$CheckInStartImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckInStartImplCopyWithImpl<$Res>
    extends _$CheckInEventV2CopyWithImpl<$Res, _$CheckInStartImpl>
    implements _$$CheckInStartImplCopyWith<$Res> {
  __$$CheckInStartImplCopyWithImpl(
    _$CheckInStartImpl _value,
    $Res Function(_$CheckInStartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckInStartImpl implements CheckInStart {
  const _$CheckInStartImpl();

  @override
  String toString() {
    return 'CheckInEventV2.start()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckInStartImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) {
    return start();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) {
    return start?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
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
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) {
    return start(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) {
    return start?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start(this);
    }
    return orElse();
  }
}

abstract class CheckInStart implements CheckInEventV2 {
  const factory CheckInStart() = _$CheckInStartImpl;
}

/// @nodoc
abstract class _$$CheckInStopImplCopyWith<$Res> {
  factory _$$CheckInStopImplCopyWith(
    _$CheckInStopImpl value,
    $Res Function(_$CheckInStopImpl) then,
  ) = __$$CheckInStopImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckInStopImplCopyWithImpl<$Res>
    extends _$CheckInEventV2CopyWithImpl<$Res, _$CheckInStopImpl>
    implements _$$CheckInStopImplCopyWith<$Res> {
  __$$CheckInStopImplCopyWithImpl(
    _$CheckInStopImpl _value,
    $Res Function(_$CheckInStopImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckInStopImpl implements CheckInStop {
  const _$CheckInStopImpl();

  @override
  String toString() {
    return 'CheckInEventV2.stop()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckInStopImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) {
    return stop();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) {
    return stop?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
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
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) {
    return stop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) {
    return stop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (stop != null) {
      return stop(this);
    }
    return orElse();
  }
}

abstract class CheckInStop implements CheckInEventV2 {
  const factory CheckInStop() = _$CheckInStopImpl;
}

/// @nodoc
abstract class _$$CheckInToggleDebugModeImplCopyWith<$Res> {
  factory _$$CheckInToggleDebugModeImplCopyWith(
    _$CheckInToggleDebugModeImpl value,
    $Res Function(_$CheckInToggleDebugModeImpl) then,
  ) = __$$CheckInToggleDebugModeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckInToggleDebugModeImplCopyWithImpl<$Res>
    extends _$CheckInEventV2CopyWithImpl<$Res, _$CheckInToggleDebugModeImpl>
    implements _$$CheckInToggleDebugModeImplCopyWith<$Res> {
  __$$CheckInToggleDebugModeImplCopyWithImpl(
    _$CheckInToggleDebugModeImpl _value,
    $Res Function(_$CheckInToggleDebugModeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckInToggleDebugModeImpl implements CheckInToggleDebugMode {
  const _$CheckInToggleDebugModeImpl();

  @override
  String toString() {
    return 'CheckInEventV2.toggleDebugMode()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInToggleDebugModeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) {
    return toggleDebugMode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) {
    return toggleDebugMode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (toggleDebugMode != null) {
      return toggleDebugMode();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) {
    return toggleDebugMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) {
    return toggleDebugMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (toggleDebugMode != null) {
      return toggleDebugMode(this);
    }
    return orElse();
  }
}

abstract class CheckInToggleDebugMode implements CheckInEventV2 {
  const factory CheckInToggleDebugMode() = _$CheckInToggleDebugModeImpl;
}

/// @nodoc
abstract class _$$CheckInSetMaxFpsImplCopyWith<$Res> {
  factory _$$CheckInSetMaxFpsImplCopyWith(
    _$CheckInSetMaxFpsImpl value,
    $Res Function(_$CheckInSetMaxFpsImpl) then,
  ) = __$$CheckInSetMaxFpsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int fps});
}

/// @nodoc
class __$$CheckInSetMaxFpsImplCopyWithImpl<$Res>
    extends _$CheckInEventV2CopyWithImpl<$Res, _$CheckInSetMaxFpsImpl>
    implements _$$CheckInSetMaxFpsImplCopyWith<$Res> {
  __$$CheckInSetMaxFpsImplCopyWithImpl(
    _$CheckInSetMaxFpsImpl _value,
    $Res Function(_$CheckInSetMaxFpsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fps = null}) {
    return _then(
      _$CheckInSetMaxFpsImpl(
        null == fps
            ? _value.fps
            : fps // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$CheckInSetMaxFpsImpl implements CheckInSetMaxFps {
  const _$CheckInSetMaxFpsImpl(this.fps);

  @override
  final int fps;

  @override
  String toString() {
    return 'CheckInEventV2.setMaxFps(fps: $fps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInSetMaxFpsImpl &&
            (identical(other.fps, fps) || other.fps == fps));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fps);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInSetMaxFpsImplCopyWith<_$CheckInSetMaxFpsImpl> get copyWith =>
      __$$CheckInSetMaxFpsImplCopyWithImpl<_$CheckInSetMaxFpsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) {
    return setMaxFps(fps);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) {
    return setMaxFps?.call(fps);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (setMaxFps != null) {
      return setMaxFps(fps);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) {
    return setMaxFps(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) {
    return setMaxFps?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (setMaxFps != null) {
      return setMaxFps(this);
    }
    return orElse();
  }
}

abstract class CheckInSetMaxFps implements CheckInEventV2 {
  const factory CheckInSetMaxFps(final int fps) = _$CheckInSetMaxFpsImpl;

  int get fps;

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInSetMaxFpsImplCopyWith<_$CheckInSetMaxFpsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckInWebSocketMessageReceivedImplCopyWith<$Res> {
  factory _$$CheckInWebSocketMessageReceivedImplCopyWith(
    _$CheckInWebSocketMessageReceivedImpl value,
    $Res Function(_$CheckInWebSocketMessageReceivedImpl) then,
  ) = __$$CheckInWebSocketMessageReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$CheckInWebSocketMessageReceivedImplCopyWithImpl<$Res>
    extends
        _$CheckInEventV2CopyWithImpl<
          $Res,
          _$CheckInWebSocketMessageReceivedImpl
        >
    implements _$$CheckInWebSocketMessageReceivedImplCopyWith<$Res> {
  __$$CheckInWebSocketMessageReceivedImplCopyWithImpl(
    _$CheckInWebSocketMessageReceivedImpl _value,
    $Res Function(_$CheckInWebSocketMessageReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = freezed}) {
    return _then(
      _$CheckInWebSocketMessageReceivedImpl(
        freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                as dynamic,
      ),
    );
  }
}

/// @nodoc

class _$CheckInWebSocketMessageReceivedImpl
    implements CheckInWebSocketMessageReceived {
  const _$CheckInWebSocketMessageReceivedImpl(this.data);

  @override
  final dynamic data;

  @override
  String toString() {
    return 'CheckInEventV2.webSocketMessageReceived(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInWebSocketMessageReceivedImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInWebSocketMessageReceivedImplCopyWith<
    _$CheckInWebSocketMessageReceivedImpl
  >
  get copyWith => __$$CheckInWebSocketMessageReceivedImplCopyWithImpl<
    _$CheckInWebSocketMessageReceivedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) {
    return webSocketMessageReceived(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) {
    return webSocketMessageReceived?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (webSocketMessageReceived != null) {
      return webSocketMessageReceived(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) {
    return webSocketMessageReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) {
    return webSocketMessageReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (webSocketMessageReceived != null) {
      return webSocketMessageReceived(this);
    }
    return orElse();
  }
}

abstract class CheckInWebSocketMessageReceived implements CheckInEventV2 {
  const factory CheckInWebSocketMessageReceived(final dynamic data) =
      _$CheckInWebSocketMessageReceivedImpl;

  dynamic get data;

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInWebSocketMessageReceivedImplCopyWith<
    _$CheckInWebSocketMessageReceivedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckInConnectionStateChangedImplCopyWith<$Res> {
  factory _$$CheckInConnectionStateChangedImplCopyWith(
    _$CheckInConnectionStateChangedImpl value,
    $Res Function(_$CheckInConnectionStateChangedImpl) then,
  ) = __$$CheckInConnectionStateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ConnectionState connectionState});

  $ConnectionStateCopyWith<$Res> get connectionState;
}

/// @nodoc
class __$$CheckInConnectionStateChangedImplCopyWithImpl<$Res>
    extends
        _$CheckInEventV2CopyWithImpl<$Res, _$CheckInConnectionStateChangedImpl>
    implements _$$CheckInConnectionStateChangedImplCopyWith<$Res> {
  __$$CheckInConnectionStateChangedImplCopyWithImpl(
    _$CheckInConnectionStateChangedImpl _value,
    $Res Function(_$CheckInConnectionStateChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? connectionState = null}) {
    return _then(
      _$CheckInConnectionStateChangedImpl(
        null == connectionState
            ? _value.connectionState
            : connectionState // ignore: cast_nullable_to_non_nullable
                as ConnectionState,
      ),
    );
  }

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionStateCopyWith<$Res> get connectionState {
    return $ConnectionStateCopyWith<$Res>(_value.connectionState, (value) {
      return _then(_value.copyWith(connectionState: value));
    });
  }
}

/// @nodoc

class _$CheckInConnectionStateChangedImpl
    implements CheckInConnectionStateChanged {
  const _$CheckInConnectionStateChangedImpl(this.connectionState);

  @override
  final ConnectionState connectionState;

  @override
  String toString() {
    return 'CheckInEventV2.connectionStateChanged(connectionState: $connectionState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInConnectionStateChangedImpl &&
            (identical(other.connectionState, connectionState) ||
                other.connectionState == connectionState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connectionState);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInConnectionStateChangedImplCopyWith<
    _$CheckInConnectionStateChangedImpl
  >
  get copyWith => __$$CheckInConnectionStateChangedImplCopyWithImpl<
    _$CheckInConnectionStateChangedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) {
    return connectionStateChanged(connectionState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) {
    return connectionStateChanged?.call(connectionState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (connectionStateChanged != null) {
      return connectionStateChanged(connectionState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) {
    return connectionStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) {
    return connectionStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (connectionStateChanged != null) {
      return connectionStateChanged(this);
    }
    return orElse();
  }
}

abstract class CheckInConnectionStateChanged implements CheckInEventV2 {
  const factory CheckInConnectionStateChanged(
    final ConnectionState connectionState,
  ) = _$CheckInConnectionStateChangedImpl;

  ConnectionState get connectionState;

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInConnectionStateChangedImplCopyWith<
    _$CheckInConnectionStateChangedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraStateChangedImplCopyWith<$Res> {
  factory _$$CameraStateChangedImplCopyWith(
    _$CameraStateChangedImpl value,
    $Res Function(_$CameraStateChangedImpl) then,
  ) = __$$CameraStateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CameraStateV2 cameraState});

  $CameraStateV2CopyWith<$Res> get cameraState;
}

/// @nodoc
class __$$CameraStateChangedImplCopyWithImpl<$Res>
    extends _$CheckInEventV2CopyWithImpl<$Res, _$CameraStateChangedImpl>
    implements _$$CameraStateChangedImplCopyWith<$Res> {
  __$$CameraStateChangedImplCopyWithImpl(
    _$CameraStateChangedImpl _value,
    $Res Function(_$CameraStateChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cameraState = null}) {
    return _then(
      _$CameraStateChangedImpl(
        null == cameraState
            ? _value.cameraState
            : cameraState // ignore: cast_nullable_to_non_nullable
                as CameraStateV2,
      ),
    );
  }

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CameraStateV2CopyWith<$Res> get cameraState {
    return $CameraStateV2CopyWith<$Res>(_value.cameraState, (value) {
      return _then(_value.copyWith(cameraState: value));
    });
  }
}

/// @nodoc

class _$CameraStateChangedImpl implements _CameraStateChanged {
  const _$CameraStateChangedImpl(this.cameraState);

  @override
  final CameraStateV2 cameraState;

  @override
  String toString() {
    return 'CheckInEventV2.cameraStateChanged(cameraState: $cameraState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraStateChangedImpl &&
            (identical(other.cameraState, cameraState) ||
                other.cameraState == cameraState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cameraState);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraStateChangedImplCopyWith<_$CameraStateChangedImpl> get copyWith =>
      __$$CameraStateChangedImplCopyWithImpl<_$CameraStateChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) {
    return cameraStateChanged(cameraState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) {
    return cameraStateChanged?.call(cameraState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (cameraStateChanged != null) {
      return cameraStateChanged(cameraState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) {
    return cameraStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) {
    return cameraStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (cameraStateChanged != null) {
      return cameraStateChanged(this);
    }
    return orElse();
  }
}

abstract class _CameraStateChanged implements CheckInEventV2 {
  const factory _CameraStateChanged(final CameraStateV2 cameraState) =
      _$CameraStateChangedImpl;

  CameraStateV2 get cameraState;

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraStateChangedImplCopyWith<_$CameraStateChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StreamingStateChangedImplCopyWith<$Res> {
  factory _$$StreamingStateChangedImplCopyWith(
    _$StreamingStateChangedImpl value,
    $Res Function(_$StreamingStateChangedImpl) then,
  ) = __$$StreamingStateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StreamingStateV2 streamingState});

  $StreamingStateV2CopyWith<$Res> get streamingState;
}

/// @nodoc
class __$$StreamingStateChangedImplCopyWithImpl<$Res>
    extends _$CheckInEventV2CopyWithImpl<$Res, _$StreamingStateChangedImpl>
    implements _$$StreamingStateChangedImplCopyWith<$Res> {
  __$$StreamingStateChangedImplCopyWithImpl(
    _$StreamingStateChangedImpl _value,
    $Res Function(_$StreamingStateChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? streamingState = null}) {
    return _then(
      _$StreamingStateChangedImpl(
        null == streamingState
            ? _value.streamingState
            : streamingState // ignore: cast_nullable_to_non_nullable
                as StreamingStateV2,
      ),
    );
  }

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamingStateV2CopyWith<$Res> get streamingState {
    return $StreamingStateV2CopyWith<$Res>(_value.streamingState, (value) {
      return _then(_value.copyWith(streamingState: value));
    });
  }
}

/// @nodoc

class _$StreamingStateChangedImpl implements _StreamingStateChanged {
  const _$StreamingStateChangedImpl(this.streamingState);

  @override
  final StreamingStateV2 streamingState;

  @override
  String toString() {
    return 'CheckInEventV2.streamingStateChanged(streamingState: $streamingState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingStateChangedImpl &&
            (identical(other.streamingState, streamingState) ||
                other.streamingState == streamingState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, streamingState);

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingStateChangedImplCopyWith<_$StreamingStateChangedImpl>
  get copyWith =>
      __$$StreamingStateChangedImplCopyWithImpl<_$StreamingStateChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function() toggleDebugMode,
    required TResult Function(int fps) setMaxFps,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
    required TResult Function(CameraStateV2 cameraState) cameraStateChanged,
    required TResult Function(StreamingStateV2 streamingState)
    streamingStateChanged,
  }) {
    return streamingStateChanged(streamingState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function()? toggleDebugMode,
    TResult? Function(int fps)? setMaxFps,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
    TResult? Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult? Function(StreamingStateV2 streamingState)? streamingStateChanged,
  }) {
    return streamingStateChanged?.call(streamingState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function()? toggleDebugMode,
    TResult Function(int fps)? setMaxFps,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    TResult Function(CameraStateV2 cameraState)? cameraStateChanged,
    TResult Function(StreamingStateV2 streamingState)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (streamingStateChanged != null) {
      return streamingStateChanged(streamingState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckInStart value) start,
    required TResult Function(CheckInStop value) stop,
    required TResult Function(CheckInToggleDebugMode value) toggleDebugMode,
    required TResult Function(CheckInSetMaxFps value) setMaxFps,
    required TResult Function(CheckInWebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(CheckInConnectionStateChanged value)
    connectionStateChanged,
    required TResult Function(_CameraStateChanged value) cameraStateChanged,
    required TResult Function(_StreamingStateChanged value)
    streamingStateChanged,
  }) {
    return streamingStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckInStart value)? start,
    TResult? Function(CheckInStop value)? stop,
    TResult? Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult? Function(CheckInSetMaxFps value)? setMaxFps,
    TResult? Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult? Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult? Function(_CameraStateChanged value)? cameraStateChanged,
    TResult? Function(_StreamingStateChanged value)? streamingStateChanged,
  }) {
    return streamingStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckInStart value)? start,
    TResult Function(CheckInStop value)? stop,
    TResult Function(CheckInToggleDebugMode value)? toggleDebugMode,
    TResult Function(CheckInSetMaxFps value)? setMaxFps,
    TResult Function(CheckInWebSocketMessageReceived value)?
    webSocketMessageReceived,
    TResult Function(CheckInConnectionStateChanged value)?
    connectionStateChanged,
    TResult Function(_CameraStateChanged value)? cameraStateChanged,
    TResult Function(_StreamingStateChanged value)? streamingStateChanged,
    required TResult orElse(),
  }) {
    if (streamingStateChanged != null) {
      return streamingStateChanged(this);
    }
    return orElse();
  }
}

abstract class _StreamingStateChanged implements CheckInEventV2 {
  const factory _StreamingStateChanged(final StreamingStateV2 streamingState) =
      _$StreamingStateChangedImpl;

  StreamingStateV2 get streamingState;

  /// Create a copy of CheckInEventV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingStateChangedImplCopyWith<_$StreamingStateChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CheckInStateV2 {
  CheckInStatusV2 get status => throw _privateConstructorUsedError;
  bool get isDebugMode => throw _privateConstructorUsedError;
  ConnectionState get connectionState => throw _privateConstructorUsedError;
  FaceDetectionData? get latestFrameData => throw _privateConstructorUsedError;
  CheckInError? get currentError => throw _privateConstructorUsedError;

  /// Create a copy of CheckInStateV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInStateV2CopyWith<CheckInStateV2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInStateV2CopyWith<$Res> {
  factory $CheckInStateV2CopyWith(
    CheckInStateV2 value,
    $Res Function(CheckInStateV2) then,
  ) = _$CheckInStateV2CopyWithImpl<$Res, CheckInStateV2>;
  @useResult
  $Res call({
    CheckInStatusV2 status,
    bool isDebugMode,
    ConnectionState connectionState,
    FaceDetectionData? latestFrameData,
    CheckInError? currentError,
  });

  $ConnectionStateCopyWith<$Res> get connectionState;
  $FaceDetectionDataCopyWith<$Res>? get latestFrameData;
  $CheckInErrorCopyWith<$Res>? get currentError;
}

/// @nodoc
class _$CheckInStateV2CopyWithImpl<$Res, $Val extends CheckInStateV2>
    implements $CheckInStateV2CopyWith<$Res> {
  _$CheckInStateV2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInStateV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? isDebugMode = null,
    Object? connectionState = null,
    Object? latestFrameData = freezed,
    Object? currentError = freezed,
  }) {
    return _then(
      _value.copyWith(
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as CheckInStatusV2,
            isDebugMode:
                null == isDebugMode
                    ? _value.isDebugMode
                    : isDebugMode // ignore: cast_nullable_to_non_nullable
                        as bool,
            connectionState:
                null == connectionState
                    ? _value.connectionState
                    : connectionState // ignore: cast_nullable_to_non_nullable
                        as ConnectionState,
            latestFrameData:
                freezed == latestFrameData
                    ? _value.latestFrameData
                    : latestFrameData // ignore: cast_nullable_to_non_nullable
                        as FaceDetectionData?,
            currentError:
                freezed == currentError
                    ? _value.currentError
                    : currentError // ignore: cast_nullable_to_non_nullable
                        as CheckInError?,
          )
          as $Val,
    );
  }

  /// Create a copy of CheckInStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionStateCopyWith<$Res> get connectionState {
    return $ConnectionStateCopyWith<$Res>(_value.connectionState, (value) {
      return _then(_value.copyWith(connectionState: value) as $Val);
    });
  }

  /// Create a copy of CheckInStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FaceDetectionDataCopyWith<$Res>? get latestFrameData {
    if (_value.latestFrameData == null) {
      return null;
    }

    return $FaceDetectionDataCopyWith<$Res>(_value.latestFrameData!, (value) {
      return _then(_value.copyWith(latestFrameData: value) as $Val);
    });
  }

  /// Create a copy of CheckInStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CheckInErrorCopyWith<$Res>? get currentError {
    if (_value.currentError == null) {
      return null;
    }

    return $CheckInErrorCopyWith<$Res>(_value.currentError!, (value) {
      return _then(_value.copyWith(currentError: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckInStateV2ImplCopyWith<$Res>
    implements $CheckInStateV2CopyWith<$Res> {
  factory _$$CheckInStateV2ImplCopyWith(
    _$CheckInStateV2Impl value,
    $Res Function(_$CheckInStateV2Impl) then,
  ) = __$$CheckInStateV2ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CheckInStatusV2 status,
    bool isDebugMode,
    ConnectionState connectionState,
    FaceDetectionData? latestFrameData,
    CheckInError? currentError,
  });

  @override
  $ConnectionStateCopyWith<$Res> get connectionState;
  @override
  $FaceDetectionDataCopyWith<$Res>? get latestFrameData;
  @override
  $CheckInErrorCopyWith<$Res>? get currentError;
}

/// @nodoc
class __$$CheckInStateV2ImplCopyWithImpl<$Res>
    extends _$CheckInStateV2CopyWithImpl<$Res, _$CheckInStateV2Impl>
    implements _$$CheckInStateV2ImplCopyWith<$Res> {
  __$$CheckInStateV2ImplCopyWithImpl(
    _$CheckInStateV2Impl _value,
    $Res Function(_$CheckInStateV2Impl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInStateV2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? isDebugMode = null,
    Object? connectionState = null,
    Object? latestFrameData = freezed,
    Object? currentError = freezed,
  }) {
    return _then(
      _$CheckInStateV2Impl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as CheckInStatusV2,
        isDebugMode:
            null == isDebugMode
                ? _value.isDebugMode
                : isDebugMode // ignore: cast_nullable_to_non_nullable
                    as bool,
        connectionState:
            null == connectionState
                ? _value.connectionState
                : connectionState // ignore: cast_nullable_to_non_nullable
                    as ConnectionState,
        latestFrameData:
            freezed == latestFrameData
                ? _value.latestFrameData
                : latestFrameData // ignore: cast_nullable_to_non_nullable
                    as FaceDetectionData?,
        currentError:
            freezed == currentError
                ? _value.currentError
                : currentError // ignore: cast_nullable_to_non_nullable
                    as CheckInError?,
      ),
    );
  }
}

/// @nodoc

class _$CheckInStateV2Impl extends _CheckInStateV2 {
  const _$CheckInStateV2Impl({
    this.status = CheckInStatusV2.idle,
    this.isDebugMode = false,
    this.connectionState = const ConnectionState(
      status: AppConnectionStatus.initial,
    ),
    this.latestFrameData,
    this.currentError,
  }) : super._();

  @override
  @JsonKey()
  final CheckInStatusV2 status;
  @override
  @JsonKey()
  final bool isDebugMode;
  @override
  @JsonKey()
  final ConnectionState connectionState;
  @override
  final FaceDetectionData? latestFrameData;
  @override
  final CheckInError? currentError;

  @override
  String toString() {
    return 'CheckInStateV2(status: $status, isDebugMode: $isDebugMode, connectionState: $connectionState, latestFrameData: $latestFrameData, currentError: $currentError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInStateV2Impl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isDebugMode, isDebugMode) ||
                other.isDebugMode == isDebugMode) &&
            (identical(other.connectionState, connectionState) ||
                other.connectionState == connectionState) &&
            (identical(other.latestFrameData, latestFrameData) ||
                other.latestFrameData == latestFrameData) &&
            (identical(other.currentError, currentError) ||
                other.currentError == currentError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    isDebugMode,
    connectionState,
    latestFrameData,
    currentError,
  );

  /// Create a copy of CheckInStateV2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInStateV2ImplCopyWith<_$CheckInStateV2Impl> get copyWith =>
      __$$CheckInStateV2ImplCopyWithImpl<_$CheckInStateV2Impl>(
        this,
        _$identity,
      );
}

abstract class _CheckInStateV2 extends CheckInStateV2 {
  const factory _CheckInStateV2({
    final CheckInStatusV2 status,
    final bool isDebugMode,
    final ConnectionState connectionState,
    final FaceDetectionData? latestFrameData,
    final CheckInError? currentError,
  }) = _$CheckInStateV2Impl;
  const _CheckInStateV2._() : super._();

  @override
  CheckInStatusV2 get status;
  @override
  bool get isDebugMode;
  @override
  ConnectionState get connectionState;
  @override
  FaceDetectionData? get latestFrameData;
  @override
  CheckInError? get currentError;

  /// Create a copy of CheckInStateV2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInStateV2ImplCopyWith<_$CheckInStateV2Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
