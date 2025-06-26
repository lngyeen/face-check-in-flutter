// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CheckInEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInEventCopyWith<$Res> {
  factory $CheckInEventCopyWith(
    CheckInEvent value,
    $Res Function(CheckInEvent) then,
  ) = _$CheckInEventCopyWithImpl<$Res, CheckInEvent>;
}

/// @nodoc
class _$CheckInEventCopyWithImpl<$Res, $Val extends CheckInEvent>
    implements $CheckInEventCopyWith<$Res> {
  _$CheckInEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializeImplCopyWith<$Res> {
  factory _$$InitializeImplCopyWith(
    _$InitializeImpl value,
    $Res Function(_$InitializeImpl) then,
  ) = __$$InitializeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializeImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$InitializeImpl>
    implements _$$InitializeImplCopyWith<$Res> {
  __$$InitializeImplCopyWithImpl(
    _$InitializeImpl _value,
    $Res Function(_$InitializeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitializeImpl implements Initialize {
  const _$InitializeImpl();

  @override
  String toString() {
    return 'CheckInEvent.initialize()';
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
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
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
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class Initialize implements CheckInEvent {
  const factory Initialize() = _$InitializeImpl;
}

/// @nodoc
abstract class _$$StartCameraImplCopyWith<$Res> {
  factory _$$StartCameraImplCopyWith(
    _$StartCameraImpl value,
    $Res Function(_$StartCameraImpl) then,
  ) = __$$StartCameraImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartCameraImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$StartCameraImpl>
    implements _$$StartCameraImplCopyWith<$Res> {
  __$$StartCameraImplCopyWithImpl(
    _$StartCameraImpl _value,
    $Res Function(_$StartCameraImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartCameraImpl implements StartCamera {
  const _$StartCameraImpl();

  @override
  String toString() {
    return 'CheckInEvent.startCamera()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartCameraImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) {
    return startCamera();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) {
    return startCamera?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (startCamera != null) {
      return startCamera();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) {
    return startCamera(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) {
    return startCamera?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (startCamera != null) {
      return startCamera(this);
    }
    return orElse();
  }
}

abstract class StartCamera implements CheckInEvent {
  const factory StartCamera() = _$StartCameraImpl;
}

/// @nodoc
abstract class _$$StopCameraImplCopyWith<$Res> {
  factory _$$StopCameraImplCopyWith(
    _$StopCameraImpl value,
    $Res Function(_$StopCameraImpl) then,
  ) = __$$StopCameraImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopCameraImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$StopCameraImpl>
    implements _$$StopCameraImplCopyWith<$Res> {
  __$$StopCameraImplCopyWithImpl(
    _$StopCameraImpl _value,
    $Res Function(_$StopCameraImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopCameraImpl implements StopCamera {
  const _$StopCameraImpl();

  @override
  String toString() {
    return 'CheckInEvent.stopCamera()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StopCameraImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) {
    return stopCamera();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) {
    return stopCamera?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (stopCamera != null) {
      return stopCamera();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) {
    return stopCamera(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) {
    return stopCamera?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (stopCamera != null) {
      return stopCamera(this);
    }
    return orElse();
  }
}

abstract class StopCamera implements CheckInEvent {
  const factory StopCamera() = _$StopCameraImpl;
}

/// @nodoc
abstract class _$$WebSocketMessageReceivedImplCopyWith<$Res> {
  factory _$$WebSocketMessageReceivedImplCopyWith(
    _$WebSocketMessageReceivedImpl value,
    $Res Function(_$WebSocketMessageReceivedImpl) then,
  ) = __$$WebSocketMessageReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$WebSocketMessageReceivedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketMessageReceivedImpl>
    implements _$$WebSocketMessageReceivedImplCopyWith<$Res> {
  __$$WebSocketMessageReceivedImplCopyWithImpl(
    _$WebSocketMessageReceivedImpl _value,
    $Res Function(_$WebSocketMessageReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = freezed}) {
    return _then(
      _$WebSocketMessageReceivedImpl(
        freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                as dynamic,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketMessageReceivedImpl implements WebSocketMessageReceived {
  const _$WebSocketMessageReceivedImpl(this.data);

  @override
  final dynamic data;

  @override
  String toString() {
    return 'CheckInEvent.webSocketMessageReceived(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketMessageReceivedImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketMessageReceivedImplCopyWith<_$WebSocketMessageReceivedImpl>
  get copyWith => __$$WebSocketMessageReceivedImplCopyWithImpl<
    _$WebSocketMessageReceivedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) {
    return webSocketMessageReceived(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) {
    return webSocketMessageReceived?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
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
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) {
    return webSocketMessageReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) {
    return webSocketMessageReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (webSocketMessageReceived != null) {
      return webSocketMessageReceived(this);
    }
    return orElse();
  }
}

abstract class WebSocketMessageReceived implements CheckInEvent {
  const factory WebSocketMessageReceived(final dynamic data) =
      _$WebSocketMessageReceivedImpl;

  dynamic get data;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketMessageReceivedImplCopyWith<_$WebSocketMessageReceivedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleDebugModeImplCopyWith<$Res> {
  factory _$$ToggleDebugModeImplCopyWith(
    _$ToggleDebugModeImpl value,
    $Res Function(_$ToggleDebugModeImpl) then,
  ) = __$$ToggleDebugModeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleDebugModeImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$ToggleDebugModeImpl>
    implements _$$ToggleDebugModeImplCopyWith<$Res> {
  __$$ToggleDebugModeImplCopyWithImpl(
    _$ToggleDebugModeImpl _value,
    $Res Function(_$ToggleDebugModeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleDebugModeImpl implements ToggleDebugMode {
  const _$ToggleDebugModeImpl();

  @override
  String toString() {
    return 'CheckInEvent.toggleDebugMode()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleDebugModeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) {
    return toggleDebugMode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) {
    return toggleDebugMode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
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
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) {
    return toggleDebugMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) {
    return toggleDebugMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (toggleDebugMode != null) {
      return toggleDebugMode(this);
    }
    return orElse();
  }
}

abstract class ToggleDebugMode implements CheckInEvent {
  const factory ToggleDebugMode() = _$ToggleDebugModeImpl;
}

/// @nodoc
abstract class _$$FrameResultReceivedImplCopyWith<$Res> {
  factory _$$FrameResultReceivedImplCopyWith(
    _$FrameResultReceivedImpl value,
    $Res Function(_$FrameResultReceivedImpl) then,
  ) = __$$FrameResultReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Map<String, dynamic>>? faces,
    FaceDetectionResponse? response,
  });

  $FaceDetectionResponseCopyWith<$Res>? get response;
}

/// @nodoc
class __$$FrameResultReceivedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$FrameResultReceivedImpl>
    implements _$$FrameResultReceivedImplCopyWith<$Res> {
  __$$FrameResultReceivedImplCopyWithImpl(
    _$FrameResultReceivedImpl _value,
    $Res Function(_$FrameResultReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? faces = freezed, Object? response = freezed}) {
    return _then(
      _$FrameResultReceivedImpl(
        faces:
            freezed == faces
                ? _value._faces
                : faces // ignore: cast_nullable_to_non_nullable
                    as List<Map<String, dynamic>>?,
        response:
            freezed == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                    as FaceDetectionResponse?,
      ),
    );
  }

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FaceDetectionResponseCopyWith<$Res>? get response {
    if (_value.response == null) {
      return null;
    }

    return $FaceDetectionResponseCopyWith<$Res>(_value.response!, (value) {
      return _then(_value.copyWith(response: value));
    });
  }
}

/// @nodoc

class _$FrameResultReceivedImpl implements FrameResultReceived {
  const _$FrameResultReceivedImpl({
    final List<Map<String, dynamic>>? faces,
    this.response,
  }) : _faces = faces;

  final List<Map<String, dynamic>>? _faces;
  @override
  List<Map<String, dynamic>>? get faces {
    final value = _faces;
    if (value == null) return null;
    if (_faces is EqualUnmodifiableListView) return _faces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final FaceDetectionResponse? response;

  @override
  String toString() {
    return 'CheckInEvent.frameResultReceived(faces: $faces, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrameResultReceivedImpl &&
            const DeepCollectionEquality().equals(other._faces, _faces) &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_faces),
    response,
  );

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrameResultReceivedImplCopyWith<_$FrameResultReceivedImpl> get copyWith =>
      __$$FrameResultReceivedImplCopyWithImpl<_$FrameResultReceivedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) {
    return frameResultReceived(faces, response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) {
    return frameResultReceived?.call(faces, response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (frameResultReceived != null) {
      return frameResultReceived(faces, response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) {
    return frameResultReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) {
    return frameResultReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (frameResultReceived != null) {
      return frameResultReceived(this);
    }
    return orElse();
  }
}

abstract class FrameResultReceived implements CheckInEvent {
  const factory FrameResultReceived({
    final List<Map<String, dynamic>>? faces,
    final FaceDetectionResponse? response,
  }) = _$FrameResultReceivedImpl;

  List<Map<String, dynamic>>? get faces;
  FaceDetectionResponse? get response;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrameResultReceivedImplCopyWith<_$FrameResultReceivedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResponseErrorReceivedImplCopyWith<$Res> {
  factory _$$ResponseErrorReceivedImplCopyWith(
    _$ResponseErrorReceivedImpl value,
    $Res Function(_$ResponseErrorReceivedImpl) then,
  ) = __$$ResponseErrorReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error, String? message});
}

/// @nodoc
class __$$ResponseErrorReceivedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$ResponseErrorReceivedImpl>
    implements _$$ResponseErrorReceivedImplCopyWith<$Res> {
  __$$ResponseErrorReceivedImplCopyWithImpl(
    _$ResponseErrorReceivedImpl _value,
    $Res Function(_$ResponseErrorReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? message = freezed}) {
    return _then(
      _$ResponseErrorReceivedImpl(
        error:
            null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$ResponseErrorReceivedImpl implements ResponseErrorReceived {
  const _$ResponseErrorReceivedImpl({required this.error, this.message});

  @override
  final String error;
  @override
  final String? message;

  @override
  String toString() {
    return 'CheckInEvent.responseErrorReceived(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseErrorReceivedImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseErrorReceivedImplCopyWith<_$ResponseErrorReceivedImpl>
  get copyWith =>
      __$$ResponseErrorReceivedImplCopyWithImpl<_$ResponseErrorReceivedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) {
    return responseErrorReceived(error, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) {
    return responseErrorReceived?.call(error, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (responseErrorReceived != null) {
      return responseErrorReceived(error, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) {
    return responseErrorReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) {
    return responseErrorReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (responseErrorReceived != null) {
      return responseErrorReceived(this);
    }
    return orElse();
  }
}

abstract class ResponseErrorReceived implements CheckInEvent {
  const factory ResponseErrorReceived({
    required final String error,
    final String? message,
  }) = _$ResponseErrorReceivedImpl;

  String get error;
  String? get message;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResponseErrorReceivedImplCopyWith<_$ResponseErrorReceivedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionStateChangedImplCopyWith<$Res> {
  factory _$$ConnectionStateChangedImplCopyWith(
    _$ConnectionStateChangedImpl value,
    $Res Function(_$ConnectionStateChangedImpl) then,
  ) = __$$ConnectionStateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ConnectionState connectionState});

  $ConnectionStateCopyWith<$Res> get connectionState;
}

/// @nodoc
class __$$ConnectionStateChangedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$ConnectionStateChangedImpl>
    implements _$$ConnectionStateChangedImplCopyWith<$Res> {
  __$$ConnectionStateChangedImplCopyWithImpl(
    _$ConnectionStateChangedImpl _value,
    $Res Function(_$ConnectionStateChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? connectionState = null}) {
    return _then(
      _$ConnectionStateChangedImpl(
        null == connectionState
            ? _value.connectionState
            : connectionState // ignore: cast_nullable_to_non_nullable
                as ConnectionState,
      ),
    );
  }

  /// Create a copy of CheckInEvent
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

class _$ConnectionStateChangedImpl implements ConnectionStateChanged {
  const _$ConnectionStateChangedImpl(this.connectionState);

  @override
  final ConnectionState connectionState;

  @override
  String toString() {
    return 'CheckInEvent.connectionStateChanged(connectionState: $connectionState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionStateChangedImpl &&
            (identical(other.connectionState, connectionState) ||
                other.connectionState == connectionState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connectionState);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionStateChangedImplCopyWith<_$ConnectionStateChangedImpl>
  get copyWith =>
      __$$ConnectionStateChangedImplCopyWithImpl<_$ConnectionStateChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function() startCamera,
    required TResult Function() stopCamera,
    required TResult Function(dynamic data) webSocketMessageReceived,
    required TResult Function() toggleDebugMode,
    required TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )
    frameResultReceived,
    required TResult Function(String error, String? message)
    responseErrorReceived,
    required TResult Function(ConnectionState connectionState)
    connectionStateChanged,
  }) {
    return connectionStateChanged(connectionState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function()? startCamera,
    TResult? Function()? stopCamera,
    TResult? Function(dynamic data)? webSocketMessageReceived,
    TResult? Function()? toggleDebugMode,
    TResult? Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult? Function(String error, String? message)? responseErrorReceived,
    TResult? Function(ConnectionState connectionState)? connectionStateChanged,
  }) {
    return connectionStateChanged?.call(connectionState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function()? startCamera,
    TResult Function()? stopCamera,
    TResult Function(dynamic data)? webSocketMessageReceived,
    TResult Function()? toggleDebugMode,
    TResult Function(
      List<Map<String, dynamic>>? faces,
      FaceDetectionResponse? response,
    )?
    frameResultReceived,
    TResult Function(String error, String? message)? responseErrorReceived,
    TResult Function(ConnectionState connectionState)? connectionStateChanged,
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
    required TResult Function(Initialize value) initialize,
    required TResult Function(StartCamera value) startCamera,
    required TResult Function(StopCamera value) stopCamera,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(ToggleDebugMode value) toggleDebugMode,
    required TResult Function(FrameResultReceived value) frameResultReceived,
    required TResult Function(ResponseErrorReceived value)
    responseErrorReceived,
    required TResult Function(ConnectionStateChanged value)
    connectionStateChanged,
  }) {
    return connectionStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialize value)? initialize,
    TResult? Function(StartCamera value)? startCamera,
    TResult? Function(StopCamera value)? stopCamera,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(FrameResultReceived value)? frameResultReceived,
    TResult? Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
  }) {
    return connectionStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialize value)? initialize,
    TResult Function(StartCamera value)? startCamera,
    TResult Function(StopCamera value)? stopCamera,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(ToggleDebugMode value)? toggleDebugMode,
    TResult Function(FrameResultReceived value)? frameResultReceived,
    TResult Function(ResponseErrorReceived value)? responseErrorReceived,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    required TResult orElse(),
  }) {
    if (connectionStateChanged != null) {
      return connectionStateChanged(this);
    }
    return orElse();
  }
}

abstract class ConnectionStateChanged implements CheckInEvent {
  const factory ConnectionStateChanged(final ConnectionState connectionState) =
      _$ConnectionStateChangedImpl;

  ConnectionState get connectionState;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionStateChangedImplCopyWith<_$ConnectionStateChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
