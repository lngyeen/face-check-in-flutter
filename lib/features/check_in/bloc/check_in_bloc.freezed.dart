// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_bloc.dart';

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
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
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
abstract class _$$AppStartedImplCopyWith<$Res> {
  factory _$$AppStartedImplCopyWith(
    _$AppStartedImpl value,
    $Res Function(_$AppStartedImpl) then,
  ) = __$$AppStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppStartedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$AppStartedImpl>
    implements _$$AppStartedImplCopyWith<$Res> {
  __$$AppStartedImplCopyWithImpl(
    _$AppStartedImpl _value,
    $Res Function(_$AppStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AppStartedImpl implements AppStarted {
  const _$AppStartedImpl();

  @override
  String toString() {
    return 'CheckInEvent.appStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return appStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return appStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return appStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return appStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted(this);
    }
    return orElse();
  }
}

abstract class AppStarted implements CheckInEvent {
  const factory AppStarted() = _$AppStartedImpl;
}

/// @nodoc
abstract class _$$AppDisposedImplCopyWith<$Res> {
  factory _$$AppDisposedImplCopyWith(
    _$AppDisposedImpl value,
    $Res Function(_$AppDisposedImpl) then,
  ) = __$$AppDisposedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppDisposedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$AppDisposedImpl>
    implements _$$AppDisposedImplCopyWith<$Res> {
  __$$AppDisposedImplCopyWithImpl(
    _$AppDisposedImpl _value,
    $Res Function(_$AppDisposedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AppDisposedImpl implements AppDisposed {
  const _$AppDisposedImpl();

  @override
  String toString() {
    return 'CheckInEvent.appDisposed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppDisposedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return appDisposed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return appDisposed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (appDisposed != null) {
      return appDisposed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return appDisposed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return appDisposed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (appDisposed != null) {
      return appDisposed(this);
    }
    return orElse();
  }
}

abstract class AppDisposed implements CheckInEvent {
  const factory AppDisposed() = _$AppDisposedImpl;
}

/// @nodoc
abstract class _$$CameraPermissionRequestedImplCopyWith<$Res> {
  factory _$$CameraPermissionRequestedImplCopyWith(
    _$CameraPermissionRequestedImpl value,
    $Res Function(_$CameraPermissionRequestedImpl) then,
  ) = __$$CameraPermissionRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraPermissionRequestedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraPermissionRequestedImpl>
    implements _$$CameraPermissionRequestedImplCopyWith<$Res> {
  __$$CameraPermissionRequestedImplCopyWithImpl(
    _$CameraPermissionRequestedImpl _value,
    $Res Function(_$CameraPermissionRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraPermissionRequestedImpl implements CameraPermissionRequested {
  const _$CameraPermissionRequestedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraPermissionRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraPermissionRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraPermissionRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraPermissionRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPermissionRequested != null) {
      return cameraPermissionRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraPermissionRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraPermissionRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPermissionRequested != null) {
      return cameraPermissionRequested(this);
    }
    return orElse();
  }
}

abstract class CameraPermissionRequested implements CheckInEvent {
  const factory CameraPermissionRequested() = _$CameraPermissionRequestedImpl;
}

/// @nodoc
abstract class _$$CameraPermissionGrantedImplCopyWith<$Res> {
  factory _$$CameraPermissionGrantedImplCopyWith(
    _$CameraPermissionGrantedImpl value,
    $Res Function(_$CameraPermissionGrantedImpl) then,
  ) = __$$CameraPermissionGrantedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraPermissionGrantedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraPermissionGrantedImpl>
    implements _$$CameraPermissionGrantedImplCopyWith<$Res> {
  __$$CameraPermissionGrantedImplCopyWithImpl(
    _$CameraPermissionGrantedImpl _value,
    $Res Function(_$CameraPermissionGrantedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraPermissionGrantedImpl implements CameraPermissionGranted {
  const _$CameraPermissionGrantedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraPermissionGranted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraPermissionGrantedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraPermissionGranted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraPermissionGranted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPermissionGranted != null) {
      return cameraPermissionGranted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraPermissionGranted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraPermissionGranted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPermissionGranted != null) {
      return cameraPermissionGranted(this);
    }
    return orElse();
  }
}

abstract class CameraPermissionGranted implements CheckInEvent {
  const factory CameraPermissionGranted() = _$CameraPermissionGrantedImpl;
}

/// @nodoc
abstract class _$$CameraPermissionDeniedImplCopyWith<$Res> {
  factory _$$CameraPermissionDeniedImplCopyWith(
    _$CameraPermissionDeniedImpl value,
    $Res Function(_$CameraPermissionDeniedImpl) then,
  ) = __$$CameraPermissionDeniedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraPermissionDeniedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraPermissionDeniedImpl>
    implements _$$CameraPermissionDeniedImplCopyWith<$Res> {
  __$$CameraPermissionDeniedImplCopyWithImpl(
    _$CameraPermissionDeniedImpl _value,
    $Res Function(_$CameraPermissionDeniedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraPermissionDeniedImpl implements CameraPermissionDenied {
  const _$CameraPermissionDeniedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraPermissionDenied()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraPermissionDeniedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraPermissionDenied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraPermissionDenied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPermissionDenied != null) {
      return cameraPermissionDenied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraPermissionDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraPermissionDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPermissionDenied != null) {
      return cameraPermissionDenied(this);
    }
    return orElse();
  }
}

abstract class CameraPermissionDenied implements CheckInEvent {
  const factory CameraPermissionDenied() = _$CameraPermissionDeniedImpl;
}

/// @nodoc
abstract class _$$CameraInitRequestedImplCopyWith<$Res> {
  factory _$$CameraInitRequestedImplCopyWith(
    _$CameraInitRequestedImpl value,
    $Res Function(_$CameraInitRequestedImpl) then,
  ) = __$$CameraInitRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraInitRequestedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraInitRequestedImpl>
    implements _$$CameraInitRequestedImplCopyWith<$Res> {
  __$$CameraInitRequestedImplCopyWithImpl(
    _$CameraInitRequestedImpl _value,
    $Res Function(_$CameraInitRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraInitRequestedImpl implements CameraInitRequested {
  const _$CameraInitRequestedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraInitRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraInitRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraInitRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraInitRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraInitRequested != null) {
      return cameraInitRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraInitRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraInitRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraInitRequested != null) {
      return cameraInitRequested(this);
    }
    return orElse();
  }
}

abstract class CameraInitRequested implements CheckInEvent {
  const factory CameraInitRequested() = _$CameraInitRequestedImpl;
}

/// @nodoc
abstract class _$$CameraStartedImplCopyWith<$Res> {
  factory _$$CameraStartedImplCopyWith(
    _$CameraStartedImpl value,
    $Res Function(_$CameraStartedImpl) then,
  ) = __$$CameraStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraStartedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraStartedImpl>
    implements _$$CameraStartedImplCopyWith<$Res> {
  __$$CameraStartedImplCopyWithImpl(
    _$CameraStartedImpl _value,
    $Res Function(_$CameraStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraStartedImpl implements CameraStarted {
  const _$CameraStartedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CameraStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraStarted != null) {
      return cameraStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraStarted != null) {
      return cameraStarted(this);
    }
    return orElse();
  }
}

abstract class CameraStarted implements CheckInEvent {
  const factory CameraStarted() = _$CameraStartedImpl;
}

/// @nodoc
abstract class _$$CameraPausedImplCopyWith<$Res> {
  factory _$$CameraPausedImplCopyWith(
    _$CameraPausedImpl value,
    $Res Function(_$CameraPausedImpl) then,
  ) = __$$CameraPausedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraPausedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraPausedImpl>
    implements _$$CameraPausedImplCopyWith<$Res> {
  __$$CameraPausedImplCopyWithImpl(
    _$CameraPausedImpl _value,
    $Res Function(_$CameraPausedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraPausedImpl implements CameraPaused {
  const _$CameraPausedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraPaused()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CameraPausedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraPaused();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraPaused?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPaused != null) {
      return cameraPaused();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraPaused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraPaused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPaused != null) {
      return cameraPaused(this);
    }
    return orElse();
  }
}

abstract class CameraPaused implements CheckInEvent {
  const factory CameraPaused() = _$CameraPausedImpl;
}

/// @nodoc
abstract class _$$CameraResumedImplCopyWith<$Res> {
  factory _$$CameraResumedImplCopyWith(
    _$CameraResumedImpl value,
    $Res Function(_$CameraResumedImpl) then,
  ) = __$$CameraResumedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraResumedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraResumedImpl>
    implements _$$CameraResumedImplCopyWith<$Res> {
  __$$CameraResumedImplCopyWithImpl(
    _$CameraResumedImpl _value,
    $Res Function(_$CameraResumedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraResumedImpl implements CameraResumed {
  const _$CameraResumedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraResumed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CameraResumedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraResumed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraResumed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraResumed != null) {
      return cameraResumed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraResumed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraResumed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraResumed != null) {
      return cameraResumed(this);
    }
    return orElse();
  }
}

abstract class CameraResumed implements CheckInEvent {
  const factory CameraResumed() = _$CameraResumedImpl;
}

/// @nodoc
abstract class _$$CameraStoppedImplCopyWith<$Res> {
  factory _$$CameraStoppedImplCopyWith(
    _$CameraStoppedImpl value,
    $Res Function(_$CameraStoppedImpl) then,
  ) = __$$CameraStoppedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraStoppedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraStoppedImpl>
    implements _$$CameraStoppedImplCopyWith<$Res> {
  __$$CameraStoppedImplCopyWithImpl(
    _$CameraStoppedImpl _value,
    $Res Function(_$CameraStoppedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraStoppedImpl implements CameraStopped {
  const _$CameraStoppedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraStopped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CameraStoppedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraStopped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraStopped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraStopped != null) {
      return cameraStopped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraStopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraStopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraStopped != null) {
      return cameraStopped(this);
    }
    return orElse();
  }
}

abstract class CameraStopped implements CheckInEvent {
  const factory CameraStopped() = _$CameraStoppedImpl;
}

/// @nodoc
abstract class _$$CameraStatusChangedImplCopyWith<$Res> {
  factory _$$CameraStatusChangedImplCopyWith(
    _$CameraStatusChangedImpl value,
    $Res Function(_$CameraStatusChangedImpl) then,
  ) = __$$CameraStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CameraStatus status});
}

/// @nodoc
class __$$CameraStatusChangedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraStatusChangedImpl>
    implements _$$CameraStatusChangedImplCopyWith<$Res> {
  __$$CameraStatusChangedImplCopyWithImpl(
    _$CameraStatusChangedImpl _value,
    $Res Function(_$CameraStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$CameraStatusChangedImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                as CameraStatus,
      ),
    );
  }
}

/// @nodoc

class _$CameraStatusChangedImpl implements CameraStatusChanged {
  const _$CameraStatusChangedImpl(this.status);

  @override
  final CameraStatus status;

  @override
  String toString() {
    return 'CheckInEvent.cameraStatusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraStatusChangedImplCopyWith<_$CameraStatusChangedImpl> get copyWith =>
      __$$CameraStatusChangedImplCopyWithImpl<_$CameraStatusChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraStatusChanged != null) {
      return cameraStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraStatusChanged != null) {
      return cameraStatusChanged(this);
    }
    return orElse();
  }
}

abstract class CameraStatusChanged implements CheckInEvent {
  const factory CameraStatusChanged(final CameraStatus status) =
      _$CameraStatusChangedImpl;

  CameraStatus get status;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraStatusChangedImplCopyWith<_$CameraStatusChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraPreviewStartedImplCopyWith<$Res> {
  factory _$$CameraPreviewStartedImplCopyWith(
    _$CameraPreviewStartedImpl value,
    $Res Function(_$CameraPreviewStartedImpl) then,
  ) = __$$CameraPreviewStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraPreviewStartedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraPreviewStartedImpl>
    implements _$$CameraPreviewStartedImplCopyWith<$Res> {
  __$$CameraPreviewStartedImplCopyWithImpl(
    _$CameraPreviewStartedImpl _value,
    $Res Function(_$CameraPreviewStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraPreviewStartedImpl implements CameraPreviewStarted {
  const _$CameraPreviewStartedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraPreviewStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraPreviewStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraPreviewStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraPreviewStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPreviewStarted != null) {
      return cameraPreviewStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraPreviewStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraPreviewStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPreviewStarted != null) {
      return cameraPreviewStarted(this);
    }
    return orElse();
  }
}

abstract class CameraPreviewStarted implements CheckInEvent {
  const factory CameraPreviewStarted() = _$CameraPreviewStartedImpl;
}

/// @nodoc
abstract class _$$CameraPreviewStoppedImplCopyWith<$Res> {
  factory _$$CameraPreviewStoppedImplCopyWith(
    _$CameraPreviewStoppedImpl value,
    $Res Function(_$CameraPreviewStoppedImpl) then,
  ) = __$$CameraPreviewStoppedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraPreviewStoppedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraPreviewStoppedImpl>
    implements _$$CameraPreviewStoppedImplCopyWith<$Res> {
  __$$CameraPreviewStoppedImplCopyWithImpl(
    _$CameraPreviewStoppedImpl _value,
    $Res Function(_$CameraPreviewStoppedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CameraPreviewStoppedImpl implements CameraPreviewStopped {
  const _$CameraPreviewStoppedImpl();

  @override
  String toString() {
    return 'CheckInEvent.cameraPreviewStopped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraPreviewStoppedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraPreviewStopped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraPreviewStopped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPreviewStopped != null) {
      return cameraPreviewStopped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraPreviewStopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraPreviewStopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraPreviewStopped != null) {
      return cameraPreviewStopped(this);
    }
    return orElse();
  }
}

abstract class CameraPreviewStopped implements CheckInEvent {
  const factory CameraPreviewStopped() = _$CameraPreviewStoppedImpl;
}

/// @nodoc
abstract class _$$ConnectionRequestedImplCopyWith<$Res> {
  factory _$$ConnectionRequestedImplCopyWith(
    _$ConnectionRequestedImpl value,
    $Res Function(_$ConnectionRequestedImpl) then,
  ) = __$$ConnectionRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionRequestedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$ConnectionRequestedImpl>
    implements _$$ConnectionRequestedImplCopyWith<$Res> {
  __$$ConnectionRequestedImplCopyWithImpl(
    _$ConnectionRequestedImpl _value,
    $Res Function(_$ConnectionRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionRequestedImpl implements ConnectionRequested {
  const _$ConnectionRequestedImpl();

  @override
  String toString() {
    return 'CheckInEvent.connectionRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return connectionRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return connectionRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (connectionRequested != null) {
      return connectionRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return connectionRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return connectionRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (connectionRequested != null) {
      return connectionRequested(this);
    }
    return orElse();
  }
}

abstract class ConnectionRequested implements CheckInEvent {
  const factory ConnectionRequested() = _$ConnectionRequestedImpl;
}

/// @nodoc
abstract class _$$ConnectionStatusChangedImplCopyWith<$Res> {
  factory _$$ConnectionStatusChangedImplCopyWith(
    _$ConnectionStatusChangedImpl value,
    $Res Function(_$ConnectionStatusChangedImpl) then,
  ) = __$$ConnectionStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ConnectionStatus status});
}

/// @nodoc
class __$$ConnectionStatusChangedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$ConnectionStatusChangedImpl>
    implements _$$ConnectionStatusChangedImplCopyWith<$Res> {
  __$$ConnectionStatusChangedImplCopyWithImpl(
    _$ConnectionStatusChangedImpl _value,
    $Res Function(_$ConnectionStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$ConnectionStatusChangedImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                as ConnectionStatus,
      ),
    );
  }
}

/// @nodoc

class _$ConnectionStatusChangedImpl implements ConnectionStatusChanged {
  const _$ConnectionStatusChangedImpl(this.status);

  @override
  final ConnectionStatus status;

  @override
  String toString() {
    return 'CheckInEvent.connectionStatusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionStatusChangedImplCopyWith<_$ConnectionStatusChangedImpl>
  get copyWith => __$$ConnectionStatusChangedImplCopyWithImpl<
    _$ConnectionStatusChangedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return connectionStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return connectionStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (connectionStatusChanged != null) {
      return connectionStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return connectionStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return connectionStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (connectionStatusChanged != null) {
      return connectionStatusChanged(this);
    }
    return orElse();
  }
}

abstract class ConnectionStatusChanged implements CheckInEvent {
  const factory ConnectionStatusChanged(final ConnectionStatus status) =
      _$ConnectionStatusChangedImpl;

  ConnectionStatus get status;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionStatusChangedImplCopyWith<_$ConnectionStatusChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DisconnectionRequestedImplCopyWith<$Res> {
  factory _$$DisconnectionRequestedImplCopyWith(
    _$DisconnectionRequestedImpl value,
    $Res Function(_$DisconnectionRequestedImpl) then,
  ) = __$$DisconnectionRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisconnectionRequestedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$DisconnectionRequestedImpl>
    implements _$$DisconnectionRequestedImplCopyWith<$Res> {
  __$$DisconnectionRequestedImplCopyWithImpl(
    _$DisconnectionRequestedImpl _value,
    $Res Function(_$DisconnectionRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DisconnectionRequestedImpl implements DisconnectionRequested {
  const _$DisconnectionRequestedImpl();

  @override
  String toString() {
    return 'CheckInEvent.disconnectionRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisconnectionRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return disconnectionRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return disconnectionRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (disconnectionRequested != null) {
      return disconnectionRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return disconnectionRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return disconnectionRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (disconnectionRequested != null) {
      return disconnectionRequested(this);
    }
    return orElse();
  }
}

abstract class DisconnectionRequested implements CheckInEvent {
  const factory DisconnectionRequested() = _$DisconnectionRequestedImpl;
}

/// @nodoc
abstract class _$$WebSocketConnectionRequestedImplCopyWith<$Res> {
  factory _$$WebSocketConnectionRequestedImplCopyWith(
    _$WebSocketConnectionRequestedImpl value,
    $Res Function(_$WebSocketConnectionRequestedImpl) then,
  ) = __$$WebSocketConnectionRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WebSocketConnectionRequestedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketConnectionRequestedImpl>
    implements _$$WebSocketConnectionRequestedImplCopyWith<$Res> {
  __$$WebSocketConnectionRequestedImplCopyWithImpl(
    _$WebSocketConnectionRequestedImpl _value,
    $Res Function(_$WebSocketConnectionRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WebSocketConnectionRequestedImpl
    implements WebSocketConnectionRequested {
  const _$WebSocketConnectionRequestedImpl();

  @override
  String toString() {
    return 'CheckInEvent.webSocketConnectionRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketConnectionRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketConnectionRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketConnectionRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnectionRequested != null) {
      return webSocketConnectionRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketConnectionRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketConnectionRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnectionRequested != null) {
      return webSocketConnectionRequested(this);
    }
    return orElse();
  }
}

abstract class WebSocketConnectionRequested implements CheckInEvent {
  const factory WebSocketConnectionRequested() =
      _$WebSocketConnectionRequestedImpl;
}

/// @nodoc
abstract class _$$WebSocketConnectingImplCopyWith<$Res> {
  factory _$$WebSocketConnectingImplCopyWith(
    _$WebSocketConnectingImpl value,
    $Res Function(_$WebSocketConnectingImpl) then,
  ) = __$$WebSocketConnectingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WebSocketConnectingImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketConnectingImpl>
    implements _$$WebSocketConnectingImplCopyWith<$Res> {
  __$$WebSocketConnectingImplCopyWithImpl(
    _$WebSocketConnectingImpl _value,
    $Res Function(_$WebSocketConnectingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WebSocketConnectingImpl implements WebSocketConnecting {
  const _$WebSocketConnectingImpl();

  @override
  String toString() {
    return 'CheckInEvent.webSocketConnecting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketConnectingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketConnecting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketConnecting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnecting != null) {
      return webSocketConnecting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketConnecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketConnecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnecting != null) {
      return webSocketConnecting(this);
    }
    return orElse();
  }
}

abstract class WebSocketConnecting implements CheckInEvent {
  const factory WebSocketConnecting() = _$WebSocketConnectingImpl;
}

/// @nodoc
abstract class _$$WebSocketConnectedImplCopyWith<$Res> {
  factory _$$WebSocketConnectedImplCopyWith(
    _$WebSocketConnectedImpl value,
    $Res Function(_$WebSocketConnectedImpl) then,
  ) = __$$WebSocketConnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WebSocketConnectedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketConnectedImpl>
    implements _$$WebSocketConnectedImplCopyWith<$Res> {
  __$$WebSocketConnectedImplCopyWithImpl(
    _$WebSocketConnectedImpl _value,
    $Res Function(_$WebSocketConnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WebSocketConnectedImpl implements WebSocketConnected {
  const _$WebSocketConnectedImpl();

  @override
  String toString() {
    return 'CheckInEvent.webSocketConnected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WebSocketConnectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketConnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketConnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnected != null) {
      return webSocketConnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketConnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketConnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnected != null) {
      return webSocketConnected(this);
    }
    return orElse();
  }
}

abstract class WebSocketConnected implements CheckInEvent {
  const factory WebSocketConnected() = _$WebSocketConnectedImpl;
}

/// @nodoc
abstract class _$$WebSocketDisconnectedImplCopyWith<$Res> {
  factory _$$WebSocketDisconnectedImplCopyWith(
    _$WebSocketDisconnectedImpl value,
    $Res Function(_$WebSocketDisconnectedImpl) then,
  ) = __$$WebSocketDisconnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WebSocketDisconnectedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketDisconnectedImpl>
    implements _$$WebSocketDisconnectedImplCopyWith<$Res> {
  __$$WebSocketDisconnectedImplCopyWithImpl(
    _$WebSocketDisconnectedImpl _value,
    $Res Function(_$WebSocketDisconnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WebSocketDisconnectedImpl implements WebSocketDisconnected {
  const _$WebSocketDisconnectedImpl();

  @override
  String toString() {
    return 'CheckInEvent.webSocketDisconnected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketDisconnectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketDisconnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketDisconnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketDisconnected != null) {
      return webSocketDisconnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketDisconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketDisconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketDisconnected != null) {
      return webSocketDisconnected(this);
    }
    return orElse();
  }
}

abstract class WebSocketDisconnected implements CheckInEvent {
  const factory WebSocketDisconnected() = _$WebSocketDisconnectedImpl;
}

/// @nodoc
abstract class _$$WebSocketConnectionFailedImplCopyWith<$Res> {
  factory _$$WebSocketConnectionFailedImplCopyWith(
    _$WebSocketConnectionFailedImpl value,
    $Res Function(_$WebSocketConnectionFailedImpl) then,
  ) = __$$WebSocketConnectionFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$WebSocketConnectionFailedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketConnectionFailedImpl>
    implements _$$WebSocketConnectionFailedImplCopyWith<$Res> {
  __$$WebSocketConnectionFailedImplCopyWithImpl(
    _$WebSocketConnectionFailedImpl _value,
    $Res Function(_$WebSocketConnectionFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$WebSocketConnectionFailedImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketConnectionFailedImpl implements WebSocketConnectionFailed {
  const _$WebSocketConnectionFailedImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'CheckInEvent.webSocketConnectionFailed(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketConnectionFailedImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketConnectionFailedImplCopyWith<_$WebSocketConnectionFailedImpl>
  get copyWith => __$$WebSocketConnectionFailedImplCopyWithImpl<
    _$WebSocketConnectionFailedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketConnectionFailed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketConnectionFailed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnectionFailed != null) {
      return webSocketConnectionFailed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketConnectionFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketConnectionFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnectionFailed != null) {
      return webSocketConnectionFailed(this);
    }
    return orElse();
  }
}

abstract class WebSocketConnectionFailed implements CheckInEvent {
  const factory WebSocketConnectionFailed(final String error) =
      _$WebSocketConnectionFailedImpl;

  String get error;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketConnectionFailedImplCopyWith<_$WebSocketConnectionFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketConnectionTimeoutImplCopyWith<$Res> {
  factory _$$WebSocketConnectionTimeoutImplCopyWith(
    _$WebSocketConnectionTimeoutImpl value,
    $Res Function(_$WebSocketConnectionTimeoutImpl) then,
  ) = __$$WebSocketConnectionTimeoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WebSocketConnectionTimeoutImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketConnectionTimeoutImpl>
    implements _$$WebSocketConnectionTimeoutImplCopyWith<$Res> {
  __$$WebSocketConnectionTimeoutImplCopyWithImpl(
    _$WebSocketConnectionTimeoutImpl _value,
    $Res Function(_$WebSocketConnectionTimeoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WebSocketConnectionTimeoutImpl implements WebSocketConnectionTimeout {
  const _$WebSocketConnectionTimeoutImpl();

  @override
  String toString() {
    return 'CheckInEvent.webSocketConnectionTimeout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketConnectionTimeoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketConnectionTimeout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketConnectionTimeout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnectionTimeout != null) {
      return webSocketConnectionTimeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketConnectionTimeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketConnectionTimeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketConnectionTimeout != null) {
      return webSocketConnectionTimeout(this);
    }
    return orElse();
  }
}

abstract class WebSocketConnectionTimeout implements CheckInEvent {
  const factory WebSocketConnectionTimeout() = _$WebSocketConnectionTimeoutImpl;
}

/// @nodoc
abstract class _$$WebSocketRetryingImplCopyWith<$Res> {
  factory _$$WebSocketRetryingImplCopyWith(
    _$WebSocketRetryingImpl value,
    $Res Function(_$WebSocketRetryingImpl) then,
  ) = __$$WebSocketRetryingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int attempt});
}

/// @nodoc
class __$$WebSocketRetryingImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketRetryingImpl>
    implements _$$WebSocketRetryingImplCopyWith<$Res> {
  __$$WebSocketRetryingImplCopyWithImpl(
    _$WebSocketRetryingImpl _value,
    $Res Function(_$WebSocketRetryingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? attempt = null}) {
    return _then(
      _$WebSocketRetryingImpl(
        null == attempt
            ? _value.attempt
            : attempt // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketRetryingImpl implements WebSocketRetrying {
  const _$WebSocketRetryingImpl(this.attempt);

  @override
  final int attempt;

  @override
  String toString() {
    return 'CheckInEvent.webSocketRetrying(attempt: $attempt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketRetryingImpl &&
            (identical(other.attempt, attempt) || other.attempt == attempt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, attempt);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketRetryingImplCopyWith<_$WebSocketRetryingImpl> get copyWith =>
      __$$WebSocketRetryingImplCopyWithImpl<_$WebSocketRetryingImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketRetrying(attempt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketRetrying?.call(attempt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketRetrying != null) {
      return webSocketRetrying(attempt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketRetrying(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketRetrying?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketRetrying != null) {
      return webSocketRetrying(this);
    }
    return orElse();
  }
}

abstract class WebSocketRetrying implements CheckInEvent {
  const factory WebSocketRetrying(final int attempt) = _$WebSocketRetryingImpl;

  int get attempt;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketRetryingImplCopyWith<_$WebSocketRetryingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketMessageReceivedImplCopyWith<$Res> {
  factory _$$WebSocketMessageReceivedImplCopyWith(
    _$WebSocketMessageReceivedImpl value,
    $Res Function(_$WebSocketMessageReceivedImpl) then,
  ) = __$$WebSocketMessageReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> message});
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
  $Res call({Object? message = null}) {
    return _then(
      _$WebSocketMessageReceivedImpl(
        null == message
            ? _value._message
            : message // ignore: cast_nullable_to_non_nullable
                as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketMessageReceivedImpl implements WebSocketMessageReceived {
  const _$WebSocketMessageReceivedImpl(final Map<String, dynamic> message)
    : _message = message;

  final Map<String, dynamic> _message;
  @override
  Map<String, dynamic> get message {
    if (_message is EqualUnmodifiableMapView) return _message;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_message);
  }

  @override
  String toString() {
    return 'CheckInEvent.webSocketMessageReceived(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketMessageReceivedImpl &&
            const DeepCollectionEquality().equals(other._message, _message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_message));

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
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketMessageReceived(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketMessageReceived?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketMessageReceived != null) {
      return webSocketMessageReceived(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketMessageReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketMessageReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketMessageReceived != null) {
      return webSocketMessageReceived(this);
    }
    return orElse();
  }
}

abstract class WebSocketMessageReceived implements CheckInEvent {
  const factory WebSocketMessageReceived(final Map<String, dynamic> message) =
      _$WebSocketMessageReceivedImpl;

  Map<String, dynamic> get message;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketMessageReceivedImplCopyWith<_$WebSocketMessageReceivedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketMessageSentImplCopyWith<$Res> {
  factory _$$WebSocketMessageSentImplCopyWith(
    _$WebSocketMessageSentImpl value,
    $Res Function(_$WebSocketMessageSentImpl) then,
  ) = __$$WebSocketMessageSentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> message});
}

/// @nodoc
class __$$WebSocketMessageSentImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketMessageSentImpl>
    implements _$$WebSocketMessageSentImplCopyWith<$Res> {
  __$$WebSocketMessageSentImplCopyWithImpl(
    _$WebSocketMessageSentImpl _value,
    $Res Function(_$WebSocketMessageSentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$WebSocketMessageSentImpl(
        null == message
            ? _value._message
            : message // ignore: cast_nullable_to_non_nullable
                as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketMessageSentImpl implements WebSocketMessageSent {
  const _$WebSocketMessageSentImpl(final Map<String, dynamic> message)
    : _message = message;

  final Map<String, dynamic> _message;
  @override
  Map<String, dynamic> get message {
    if (_message is EqualUnmodifiableMapView) return _message;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_message);
  }

  @override
  String toString() {
    return 'CheckInEvent.webSocketMessageSent(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketMessageSentImpl &&
            const DeepCollectionEquality().equals(other._message, _message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_message));

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketMessageSentImplCopyWith<_$WebSocketMessageSentImpl>
  get copyWith =>
      __$$WebSocketMessageSentImplCopyWithImpl<_$WebSocketMessageSentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketMessageSent(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketMessageSent?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketMessageSent != null) {
      return webSocketMessageSent(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketMessageSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketMessageSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketMessageSent != null) {
      return webSocketMessageSent(this);
    }
    return orElse();
  }
}

abstract class WebSocketMessageSent implements CheckInEvent {
  const factory WebSocketMessageSent(final Map<String, dynamic> message) =
      _$WebSocketMessageSentImpl;

  Map<String, dynamic> get message;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketMessageSentImplCopyWith<_$WebSocketMessageSentImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketSendErrorImplCopyWith<$Res> {
  factory _$$WebSocketSendErrorImplCopyWith(
    _$WebSocketSendErrorImpl value,
    $Res Function(_$WebSocketSendErrorImpl) then,
  ) = __$$WebSocketSendErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$WebSocketSendErrorImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$WebSocketSendErrorImpl>
    implements _$$WebSocketSendErrorImplCopyWith<$Res> {
  __$$WebSocketSendErrorImplCopyWithImpl(
    _$WebSocketSendErrorImpl _value,
    $Res Function(_$WebSocketSendErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$WebSocketSendErrorImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketSendErrorImpl implements WebSocketSendError {
  const _$WebSocketSendErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'CheckInEvent.webSocketSendError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketSendErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketSendErrorImplCopyWith<_$WebSocketSendErrorImpl> get copyWith =>
      __$$WebSocketSendErrorImplCopyWithImpl<_$WebSocketSendErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return webSocketSendError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return webSocketSendError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketSendError != null) {
      return webSocketSendError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return webSocketSendError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return webSocketSendError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (webSocketSendError != null) {
      return webSocketSendError(this);
    }
    return orElse();
  }
}

abstract class WebSocketSendError implements CheckInEvent {
  const factory WebSocketSendError(final String error) =
      _$WebSocketSendErrorImpl;

  String get error;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketSendErrorImplCopyWith<_$WebSocketSendErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AutoConnectionTriggeredImplCopyWith<$Res> {
  factory _$$AutoConnectionTriggeredImplCopyWith(
    _$AutoConnectionTriggeredImpl value,
    $Res Function(_$AutoConnectionTriggeredImpl) then,
  ) = __$$AutoConnectionTriggeredImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AutoConnectionTriggeredImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$AutoConnectionTriggeredImpl>
    implements _$$AutoConnectionTriggeredImplCopyWith<$Res> {
  __$$AutoConnectionTriggeredImplCopyWithImpl(
    _$AutoConnectionTriggeredImpl _value,
    $Res Function(_$AutoConnectionTriggeredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AutoConnectionTriggeredImpl implements AutoConnectionTriggered {
  const _$AutoConnectionTriggeredImpl();

  @override
  String toString() {
    return 'CheckInEvent.autoConnectionTriggered()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoConnectionTriggeredImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return autoConnectionTriggered();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return autoConnectionTriggered?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (autoConnectionTriggered != null) {
      return autoConnectionTriggered();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return autoConnectionTriggered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return autoConnectionTriggered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (autoConnectionTriggered != null) {
      return autoConnectionTriggered(this);
    }
    return orElse();
  }
}

abstract class AutoConnectionTriggered implements CheckInEvent {
  const factory AutoConnectionTriggered() = _$AutoConnectionTriggeredImpl;
}

/// @nodoc
abstract class _$$AutoConnectionToggledImplCopyWith<$Res> {
  factory _$$AutoConnectionToggledImplCopyWith(
    _$AutoConnectionToggledImpl value,
    $Res Function(_$AutoConnectionToggledImpl) then,
  ) = __$$AutoConnectionToggledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$AutoConnectionToggledImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$AutoConnectionToggledImpl>
    implements _$$AutoConnectionToggledImplCopyWith<$Res> {
  __$$AutoConnectionToggledImplCopyWithImpl(
    _$AutoConnectionToggledImpl _value,
    $Res Function(_$AutoConnectionToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? enabled = null}) {
    return _then(
      _$AutoConnectionToggledImpl(
        null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                as bool,
      ),
    );
  }
}

/// @nodoc

class _$AutoConnectionToggledImpl implements AutoConnectionToggled {
  const _$AutoConnectionToggledImpl(this.enabled);

  @override
  final bool enabled;

  @override
  String toString() {
    return 'CheckInEvent.autoConnectionToggled(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoConnectionToggledImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoConnectionToggledImplCopyWith<_$AutoConnectionToggledImpl>
  get copyWith =>
      __$$AutoConnectionToggledImplCopyWithImpl<_$AutoConnectionToggledImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return autoConnectionToggled(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return autoConnectionToggled?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (autoConnectionToggled != null) {
      return autoConnectionToggled(enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return autoConnectionToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return autoConnectionToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (autoConnectionToggled != null) {
      return autoConnectionToggled(this);
    }
    return orElse();
  }
}

abstract class AutoConnectionToggled implements CheckInEvent {
  const factory AutoConnectionToggled(final bool enabled) =
      _$AutoConnectionToggledImpl;

  bool get enabled;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AutoConnectionToggledImplCopyWith<_$AutoConnectionToggledImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StreamingStartedImplCopyWith<$Res> {
  factory _$$StreamingStartedImplCopyWith(
    _$StreamingStartedImpl value,
    $Res Function(_$StreamingStartedImpl) then,
  ) = __$$StreamingStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StreamingStartedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$StreamingStartedImpl>
    implements _$$StreamingStartedImplCopyWith<$Res> {
  __$$StreamingStartedImplCopyWithImpl(
    _$StreamingStartedImpl _value,
    $Res Function(_$StreamingStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StreamingStartedImpl implements StreamingStarted {
  const _$StreamingStartedImpl();

  @override
  String toString() {
    return 'CheckInEvent.streamingStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StreamingStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return streamingStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return streamingStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (streamingStarted != null) {
      return streamingStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return streamingStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return streamingStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (streamingStarted != null) {
      return streamingStarted(this);
    }
    return orElse();
  }
}

abstract class StreamingStarted implements CheckInEvent {
  const factory StreamingStarted() = _$StreamingStartedImpl;
}

/// @nodoc
abstract class _$$StreamingStoppedImplCopyWith<$Res> {
  factory _$$StreamingStoppedImplCopyWith(
    _$StreamingStoppedImpl value,
    $Res Function(_$StreamingStoppedImpl) then,
  ) = __$$StreamingStoppedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StreamingStoppedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$StreamingStoppedImpl>
    implements _$$StreamingStoppedImplCopyWith<$Res> {
  __$$StreamingStoppedImplCopyWithImpl(
    _$StreamingStoppedImpl _value,
    $Res Function(_$StreamingStoppedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StreamingStoppedImpl implements StreamingStopped {
  const _$StreamingStoppedImpl();

  @override
  String toString() {
    return 'CheckInEvent.streamingStopped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StreamingStoppedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return streamingStopped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return streamingStopped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (streamingStopped != null) {
      return streamingStopped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return streamingStopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return streamingStopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (streamingStopped != null) {
      return streamingStopped(this);
    }
    return orElse();
  }
}

abstract class StreamingStopped implements CheckInEvent {
  const factory StreamingStopped() = _$StreamingStoppedImpl;
}

/// @nodoc
abstract class _$$StreamingStatusChangedImplCopyWith<$Res> {
  factory _$$StreamingStatusChangedImplCopyWith(
    _$StreamingStatusChangedImpl value,
    $Res Function(_$StreamingStatusChangedImpl) then,
  ) = __$$StreamingStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StreamingStatus status});
}

/// @nodoc
class __$$StreamingStatusChangedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$StreamingStatusChangedImpl>
    implements _$$StreamingStatusChangedImplCopyWith<$Res> {
  __$$StreamingStatusChangedImplCopyWithImpl(
    _$StreamingStatusChangedImpl _value,
    $Res Function(_$StreamingStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$StreamingStatusChangedImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                as StreamingStatus,
      ),
    );
  }
}

/// @nodoc

class _$StreamingStatusChangedImpl implements StreamingStatusChanged {
  const _$StreamingStatusChangedImpl(this.status);

  @override
  final StreamingStatus status;

  @override
  String toString() {
    return 'CheckInEvent.streamingStatusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingStatusChangedImplCopyWith<_$StreamingStatusChangedImpl>
  get copyWith =>
      __$$StreamingStatusChangedImplCopyWithImpl<_$StreamingStatusChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return streamingStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return streamingStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (streamingStatusChanged != null) {
      return streamingStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return streamingStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return streamingStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (streamingStatusChanged != null) {
      return streamingStatusChanged(this);
    }
    return orElse();
  }
}

abstract class StreamingStatusChanged implements CheckInEvent {
  const factory StreamingStatusChanged(final StreamingStatus status) =
      _$StreamingStatusChangedImpl;

  StreamingStatus get status;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingStatusChangedImplCopyWith<_$StreamingStatusChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FrameProcessedImplCopyWith<$Res> {
  factory _$$FrameProcessedImplCopyWith(
    _$FrameProcessedImpl value,
    $Res Function(_$FrameProcessedImpl) then,
  ) = __$$FrameProcessedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FrameProcessedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$FrameProcessedImpl>
    implements _$$FrameProcessedImplCopyWith<$Res> {
  __$$FrameProcessedImplCopyWithImpl(
    _$FrameProcessedImpl _value,
    $Res Function(_$FrameProcessedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FrameProcessedImpl implements FrameProcessed {
  const _$FrameProcessedImpl();

  @override
  String toString() {
    return 'CheckInEvent.frameProcessed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FrameProcessedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return frameProcessed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return frameProcessed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (frameProcessed != null) {
      return frameProcessed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return frameProcessed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return frameProcessed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (frameProcessed != null) {
      return frameProcessed(this);
    }
    return orElse();
  }
}

abstract class FrameProcessed implements CheckInEvent {
  const factory FrameProcessed() = _$FrameProcessedImpl;
}

/// @nodoc
abstract class _$$ErrorOccurredImplCopyWith<$Res> {
  factory _$$ErrorOccurredImplCopyWith(
    _$ErrorOccurredImpl value,
    $Res Function(_$ErrorOccurredImpl) then,
  ) = __$$ErrorOccurredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorOccurredImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$ErrorOccurredImpl>
    implements _$$ErrorOccurredImplCopyWith<$Res> {
  __$$ErrorOccurredImplCopyWithImpl(
    _$ErrorOccurredImpl _value,
    $Res Function(_$ErrorOccurredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorOccurredImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorOccurredImpl implements ErrorOccurred {
  const _$ErrorOccurredImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CheckInEvent.errorOccurred(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorOccurredImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorOccurredImplCopyWith<_$ErrorOccurredImpl> get copyWith =>
      __$$ErrorOccurredImplCopyWithImpl<_$ErrorOccurredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return errorOccurred(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return errorOccurred?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return errorOccurred(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return errorOccurred?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred(this);
    }
    return orElse();
  }
}

abstract class ErrorOccurred implements CheckInEvent {
  const factory ErrorOccurred(final String message) = _$ErrorOccurredImpl;

  String get message;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorOccurredImplCopyWith<_$ErrorOccurredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraErrorImplCopyWith<$Res> {
  factory _$$CameraErrorImplCopyWith(
    _$CameraErrorImpl value,
    $Res Function(_$CameraErrorImpl) then,
  ) = __$$CameraErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$CameraErrorImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$CameraErrorImpl>
    implements _$$CameraErrorImplCopyWith<$Res> {
  __$$CameraErrorImplCopyWithImpl(
    _$CameraErrorImpl _value,
    $Res Function(_$CameraErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$CameraErrorImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$CameraErrorImpl implements CameraError {
  const _$CameraErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'CheckInEvent.cameraError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraErrorImplCopyWith<_$CameraErrorImpl> get copyWith =>
      __$$CameraErrorImplCopyWithImpl<_$CameraErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return cameraError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return cameraError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraError != null) {
      return cameraError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return cameraError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return cameraError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (cameraError != null) {
      return cameraError(this);
    }
    return orElse();
  }
}

abstract class CameraError implements CheckInEvent {
  const factory CameraError(final String error) = _$CameraErrorImpl;

  String get error;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraErrorImplCopyWith<_$CameraErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorClearedImplCopyWith<$Res> {
  factory _$$ErrorClearedImplCopyWith(
    _$ErrorClearedImpl value,
    $Res Function(_$ErrorClearedImpl) then,
  ) = __$$ErrorClearedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ErrorClearedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$ErrorClearedImpl>
    implements _$$ErrorClearedImplCopyWith<$Res> {
  __$$ErrorClearedImplCopyWithImpl(
    _$ErrorClearedImpl _value,
    $Res Function(_$ErrorClearedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ErrorClearedImpl implements ErrorCleared {
  const _$ErrorClearedImpl();

  @override
  String toString() {
    return 'CheckInEvent.errorCleared()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ErrorClearedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return errorCleared();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return errorCleared?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (errorCleared != null) {
      return errorCleared();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return errorCleared(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return errorCleared?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (errorCleared != null) {
      return errorCleared(this);
    }
    return orElse();
  }
}

abstract class ErrorCleared implements CheckInEvent {
  const factory ErrorCleared() = _$ErrorClearedImpl;
}

/// @nodoc
abstract class _$$ToastRequestedImplCopyWith<$Res> {
  factory _$$ToastRequestedImplCopyWith(
    _$ToastRequestedImpl value,
    $Res Function(_$ToastRequestedImpl) then,
  ) = __$$ToastRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ToastRequestedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$ToastRequestedImpl>
    implements _$$ToastRequestedImplCopyWith<$Res> {
  __$$ToastRequestedImplCopyWithImpl(
    _$ToastRequestedImpl _value,
    $Res Function(_$ToastRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ToastRequestedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$ToastRequestedImpl implements ToastRequested {
  const _$ToastRequestedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CheckInEvent.toastRequested(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToastRequestedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToastRequestedImplCopyWith<_$ToastRequestedImpl> get copyWith =>
      __$$ToastRequestedImplCopyWithImpl<_$ToastRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return toastRequested(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return toastRequested?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (toastRequested != null) {
      return toastRequested(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return toastRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return toastRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (toastRequested != null) {
      return toastRequested(this);
    }
    return orElse();
  }
}

abstract class ToastRequested implements CheckInEvent {
  const factory ToastRequested(final String message) = _$ToastRequestedImpl;

  String get message;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToastRequestedImplCopyWith<_$ToastRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DebugModeToggledImplCopyWith<$Res> {
  factory _$$DebugModeToggledImplCopyWith(
    _$DebugModeToggledImpl value,
    $Res Function(_$DebugModeToggledImpl) then,
  ) = __$$DebugModeToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DebugModeToggledImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$DebugModeToggledImpl>
    implements _$$DebugModeToggledImplCopyWith<$Res> {
  __$$DebugModeToggledImplCopyWithImpl(
    _$DebugModeToggledImpl _value,
    $Res Function(_$DebugModeToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DebugModeToggledImpl implements DebugModeToggled {
  const _$DebugModeToggledImpl();

  @override
  String toString() {
    return 'CheckInEvent.debugModeToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DebugModeToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return debugModeToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return debugModeToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (debugModeToggled != null) {
      return debugModeToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return debugModeToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return debugModeToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (debugModeToggled != null) {
      return debugModeToggled(this);
    }
    return orElse();
  }
}

abstract class DebugModeToggled implements CheckInEvent {
  const factory DebugModeToggled() = _$DebugModeToggledImpl;
}

/// @nodoc
abstract class _$$StatisticsResetImplCopyWith<$Res> {
  factory _$$StatisticsResetImplCopyWith(
    _$StatisticsResetImpl value,
    $Res Function(_$StatisticsResetImpl) then,
  ) = __$$StatisticsResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatisticsResetImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$StatisticsResetImpl>
    implements _$$StatisticsResetImplCopyWith<$Res> {
  __$$StatisticsResetImplCopyWithImpl(
    _$StatisticsResetImpl _value,
    $Res Function(_$StatisticsResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StatisticsResetImpl implements StatisticsReset {
  const _$StatisticsResetImpl();

  @override
  String toString() {
    return 'CheckInEvent.statisticsReset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StatisticsResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return statisticsReset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return statisticsReset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (statisticsReset != null) {
      return statisticsReset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return statisticsReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return statisticsReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (statisticsReset != null) {
      return statisticsReset(this);
    }
    return orElse();
  }
}

abstract class StatisticsReset implements CheckInEvent {
  const factory StatisticsReset() = _$StatisticsResetImpl;
}

/// @nodoc
abstract class _$$RecognitionResultReceivedImplCopyWith<$Res> {
  factory _$$RecognitionResultReceivedImplCopyWith(
    _$RecognitionResultReceivedImpl value,
    $Res Function(_$RecognitionResultReceivedImpl) then,
  ) = __$$RecognitionResultReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool success, String message, String? employeeName});
}

/// @nodoc
class __$$RecognitionResultReceivedImplCopyWithImpl<$Res>
    extends _$CheckInEventCopyWithImpl<$Res, _$RecognitionResultReceivedImpl>
    implements _$$RecognitionResultReceivedImplCopyWith<$Res> {
  __$$RecognitionResultReceivedImplCopyWithImpl(
    _$RecognitionResultReceivedImpl _value,
    $Res Function(_$RecognitionResultReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? employeeName = freezed,
  }) {
    return _then(
      _$RecognitionResultReceivedImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
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

class _$RecognitionResultReceivedImpl implements RecognitionResultReceived {
  const _$RecognitionResultReceivedImpl({
    required this.success,
    required this.message,
    this.employeeName,
  });

  @override
  final bool success;
  @override
  final String message;
  @override
  final String? employeeName;

  @override
  String toString() {
    return 'CheckInEvent.recognitionResultReceived(success: $success, message: $message, employeeName: $employeeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecognitionResultReceivedImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, success, message, employeeName);

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecognitionResultReceivedImplCopyWith<_$RecognitionResultReceivedImpl>
  get copyWith => __$$RecognitionResultReceivedImplCopyWithImpl<
    _$RecognitionResultReceivedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function() appDisposed,
    required TResult Function() cameraPermissionRequested,
    required TResult Function() cameraPermissionGranted,
    required TResult Function() cameraPermissionDenied,
    required TResult Function() cameraInitRequested,
    required TResult Function() cameraStarted,
    required TResult Function() cameraPaused,
    required TResult Function() cameraResumed,
    required TResult Function() cameraStopped,
    required TResult Function(CameraStatus status) cameraStatusChanged,
    required TResult Function() cameraPreviewStarted,
    required TResult Function() cameraPreviewStopped,
    required TResult Function() connectionRequested,
    required TResult Function(ConnectionStatus status) connectionStatusChanged,
    required TResult Function() disconnectionRequested,
    required TResult Function() webSocketConnectionRequested,
    required TResult Function() webSocketConnecting,
    required TResult Function() webSocketConnected,
    required TResult Function() webSocketDisconnected,
    required TResult Function(String error) webSocketConnectionFailed,
    required TResult Function() webSocketConnectionTimeout,
    required TResult Function(int attempt) webSocketRetrying,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageReceived,
    required TResult Function(Map<String, dynamic> message)
    webSocketMessageSent,
    required TResult Function(String error) webSocketSendError,
    required TResult Function() autoConnectionTriggered,
    required TResult Function(bool enabled) autoConnectionToggled,
    required TResult Function() streamingStarted,
    required TResult Function() streamingStopped,
    required TResult Function(StreamingStatus status) streamingStatusChanged,
    required TResult Function() frameProcessed,
    required TResult Function(String message) errorOccurred,
    required TResult Function(String error) cameraError,
    required TResult Function() errorCleared,
    required TResult Function(String message) toastRequested,
    required TResult Function() debugModeToggled,
    required TResult Function() statisticsReset,
    required TResult Function(
      bool success,
      String message,
      String? employeeName,
    )
    recognitionResultReceived,
  }) {
    return recognitionResultReceived(success, message, employeeName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function()? appDisposed,
    TResult? Function()? cameraPermissionRequested,
    TResult? Function()? cameraPermissionGranted,
    TResult? Function()? cameraPermissionDenied,
    TResult? Function()? cameraInitRequested,
    TResult? Function()? cameraStarted,
    TResult? Function()? cameraPaused,
    TResult? Function()? cameraResumed,
    TResult? Function()? cameraStopped,
    TResult? Function(CameraStatus status)? cameraStatusChanged,
    TResult? Function()? cameraPreviewStarted,
    TResult? Function()? cameraPreviewStopped,
    TResult? Function()? connectionRequested,
    TResult? Function(ConnectionStatus status)? connectionStatusChanged,
    TResult? Function()? disconnectionRequested,
    TResult? Function()? webSocketConnectionRequested,
    TResult? Function()? webSocketConnecting,
    TResult? Function()? webSocketConnected,
    TResult? Function()? webSocketDisconnected,
    TResult? Function(String error)? webSocketConnectionFailed,
    TResult? Function()? webSocketConnectionTimeout,
    TResult? Function(int attempt)? webSocketRetrying,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult? Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult? Function(String error)? webSocketSendError,
    TResult? Function()? autoConnectionTriggered,
    TResult? Function(bool enabled)? autoConnectionToggled,
    TResult? Function()? streamingStarted,
    TResult? Function()? streamingStopped,
    TResult? Function(StreamingStatus status)? streamingStatusChanged,
    TResult? Function()? frameProcessed,
    TResult? Function(String message)? errorOccurred,
    TResult? Function(String error)? cameraError,
    TResult? Function()? errorCleared,
    TResult? Function(String message)? toastRequested,
    TResult? Function()? debugModeToggled,
    TResult? Function()? statisticsReset,
    TResult? Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
  }) {
    return recognitionResultReceived?.call(success, message, employeeName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function()? appDisposed,
    TResult Function()? cameraPermissionRequested,
    TResult Function()? cameraPermissionGranted,
    TResult Function()? cameraPermissionDenied,
    TResult Function()? cameraInitRequested,
    TResult Function()? cameraStarted,
    TResult Function()? cameraPaused,
    TResult Function()? cameraResumed,
    TResult Function()? cameraStopped,
    TResult Function(CameraStatus status)? cameraStatusChanged,
    TResult Function()? cameraPreviewStarted,
    TResult Function()? cameraPreviewStopped,
    TResult Function()? connectionRequested,
    TResult Function(ConnectionStatus status)? connectionStatusChanged,
    TResult Function()? disconnectionRequested,
    TResult Function()? webSocketConnectionRequested,
    TResult Function()? webSocketConnecting,
    TResult Function()? webSocketConnected,
    TResult Function()? webSocketDisconnected,
    TResult Function(String error)? webSocketConnectionFailed,
    TResult Function()? webSocketConnectionTimeout,
    TResult Function(int attempt)? webSocketRetrying,
    TResult Function(Map<String, dynamic> message)? webSocketMessageReceived,
    TResult Function(Map<String, dynamic> message)? webSocketMessageSent,
    TResult Function(String error)? webSocketSendError,
    TResult Function()? autoConnectionTriggered,
    TResult Function(bool enabled)? autoConnectionToggled,
    TResult Function()? streamingStarted,
    TResult Function()? streamingStopped,
    TResult Function(StreamingStatus status)? streamingStatusChanged,
    TResult Function()? frameProcessed,
    TResult Function(String message)? errorOccurred,
    TResult Function(String error)? cameraError,
    TResult Function()? errorCleared,
    TResult Function(String message)? toastRequested,
    TResult Function()? debugModeToggled,
    TResult Function()? statisticsReset,
    TResult Function(bool success, String message, String? employeeName)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (recognitionResultReceived != null) {
      return recognitionResultReceived(success, message, employeeName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AppDisposed value) appDisposed,
    required TResult Function(CameraPermissionRequested value)
    cameraPermissionRequested,
    required TResult Function(CameraPermissionGranted value)
    cameraPermissionGranted,
    required TResult Function(CameraPermissionDenied value)
    cameraPermissionDenied,
    required TResult Function(CameraInitRequested value) cameraInitRequested,
    required TResult Function(CameraStarted value) cameraStarted,
    required TResult Function(CameraPaused value) cameraPaused,
    required TResult Function(CameraResumed value) cameraResumed,
    required TResult Function(CameraStopped value) cameraStopped,
    required TResult Function(CameraStatusChanged value) cameraStatusChanged,
    required TResult Function(CameraPreviewStarted value) cameraPreviewStarted,
    required TResult Function(CameraPreviewStopped value) cameraPreviewStopped,
    required TResult Function(ConnectionRequested value) connectionRequested,
    required TResult Function(ConnectionStatusChanged value)
    connectionStatusChanged,
    required TResult Function(DisconnectionRequested value)
    disconnectionRequested,
    required TResult Function(WebSocketConnectionRequested value)
    webSocketConnectionRequested,
    required TResult Function(WebSocketConnecting value) webSocketConnecting,
    required TResult Function(WebSocketConnected value) webSocketConnected,
    required TResult Function(WebSocketDisconnected value)
    webSocketDisconnected,
    required TResult Function(WebSocketConnectionFailed value)
    webSocketConnectionFailed,
    required TResult Function(WebSocketConnectionTimeout value)
    webSocketConnectionTimeout,
    required TResult Function(WebSocketRetrying value) webSocketRetrying,
    required TResult Function(WebSocketMessageReceived value)
    webSocketMessageReceived,
    required TResult Function(WebSocketMessageSent value) webSocketMessageSent,
    required TResult Function(WebSocketSendError value) webSocketSendError,
    required TResult Function(AutoConnectionTriggered value)
    autoConnectionTriggered,
    required TResult Function(AutoConnectionToggled value)
    autoConnectionToggled,
    required TResult Function(StreamingStarted value) streamingStarted,
    required TResult Function(StreamingStopped value) streamingStopped,
    required TResult Function(StreamingStatusChanged value)
    streamingStatusChanged,
    required TResult Function(FrameProcessed value) frameProcessed,
    required TResult Function(ErrorOccurred value) errorOccurred,
    required TResult Function(CameraError value) cameraError,
    required TResult Function(ErrorCleared value) errorCleared,
    required TResult Function(ToastRequested value) toastRequested,
    required TResult Function(DebugModeToggled value) debugModeToggled,
    required TResult Function(StatisticsReset value) statisticsReset,
    required TResult Function(RecognitionResultReceived value)
    recognitionResultReceived,
  }) {
    return recognitionResultReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AppDisposed value)? appDisposed,
    TResult? Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult? Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult? Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult? Function(CameraInitRequested value)? cameraInitRequested,
    TResult? Function(CameraStarted value)? cameraStarted,
    TResult? Function(CameraPaused value)? cameraPaused,
    TResult? Function(CameraResumed value)? cameraResumed,
    TResult? Function(CameraStopped value)? cameraStopped,
    TResult? Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult? Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult? Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult? Function(ConnectionRequested value)? connectionRequested,
    TResult? Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult? Function(DisconnectionRequested value)? disconnectionRequested,
    TResult? Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult? Function(WebSocketConnecting value)? webSocketConnecting,
    TResult? Function(WebSocketConnected value)? webSocketConnected,
    TResult? Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult? Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult? Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult? Function(WebSocketRetrying value)? webSocketRetrying,
    TResult? Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult? Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult? Function(WebSocketSendError value)? webSocketSendError,
    TResult? Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult? Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult? Function(StreamingStarted value)? streamingStarted,
    TResult? Function(StreamingStopped value)? streamingStopped,
    TResult? Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult? Function(FrameProcessed value)? frameProcessed,
    TResult? Function(ErrorOccurred value)? errorOccurred,
    TResult? Function(CameraError value)? cameraError,
    TResult? Function(ErrorCleared value)? errorCleared,
    TResult? Function(ToastRequested value)? toastRequested,
    TResult? Function(DebugModeToggled value)? debugModeToggled,
    TResult? Function(StatisticsReset value)? statisticsReset,
    TResult? Function(RecognitionResultReceived value)?
    recognitionResultReceived,
  }) {
    return recognitionResultReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AppDisposed value)? appDisposed,
    TResult Function(CameraPermissionRequested value)?
    cameraPermissionRequested,
    TResult Function(CameraPermissionGranted value)? cameraPermissionGranted,
    TResult Function(CameraPermissionDenied value)? cameraPermissionDenied,
    TResult Function(CameraInitRequested value)? cameraInitRequested,
    TResult Function(CameraStarted value)? cameraStarted,
    TResult Function(CameraPaused value)? cameraPaused,
    TResult Function(CameraResumed value)? cameraResumed,
    TResult Function(CameraStopped value)? cameraStopped,
    TResult Function(CameraStatusChanged value)? cameraStatusChanged,
    TResult Function(CameraPreviewStarted value)? cameraPreviewStarted,
    TResult Function(CameraPreviewStopped value)? cameraPreviewStopped,
    TResult Function(ConnectionRequested value)? connectionRequested,
    TResult Function(ConnectionStatusChanged value)? connectionStatusChanged,
    TResult Function(DisconnectionRequested value)? disconnectionRequested,
    TResult Function(WebSocketConnectionRequested value)?
    webSocketConnectionRequested,
    TResult Function(WebSocketConnecting value)? webSocketConnecting,
    TResult Function(WebSocketConnected value)? webSocketConnected,
    TResult Function(WebSocketDisconnected value)? webSocketDisconnected,
    TResult Function(WebSocketConnectionFailed value)?
    webSocketConnectionFailed,
    TResult Function(WebSocketConnectionTimeout value)?
    webSocketConnectionTimeout,
    TResult Function(WebSocketRetrying value)? webSocketRetrying,
    TResult Function(WebSocketMessageReceived value)? webSocketMessageReceived,
    TResult Function(WebSocketMessageSent value)? webSocketMessageSent,
    TResult Function(WebSocketSendError value)? webSocketSendError,
    TResult Function(AutoConnectionTriggered value)? autoConnectionTriggered,
    TResult Function(AutoConnectionToggled value)? autoConnectionToggled,
    TResult Function(StreamingStarted value)? streamingStarted,
    TResult Function(StreamingStopped value)? streamingStopped,
    TResult Function(StreamingStatusChanged value)? streamingStatusChanged,
    TResult Function(FrameProcessed value)? frameProcessed,
    TResult Function(ErrorOccurred value)? errorOccurred,
    TResult Function(CameraError value)? cameraError,
    TResult Function(ErrorCleared value)? errorCleared,
    TResult Function(ToastRequested value)? toastRequested,
    TResult Function(DebugModeToggled value)? debugModeToggled,
    TResult Function(StatisticsReset value)? statisticsReset,
    TResult Function(RecognitionResultReceived value)?
    recognitionResultReceived,
    required TResult orElse(),
  }) {
    if (recognitionResultReceived != null) {
      return recognitionResultReceived(this);
    }
    return orElse();
  }
}

abstract class RecognitionResultReceived implements CheckInEvent {
  const factory RecognitionResultReceived({
    required final bool success,
    required final String message,
    final String? employeeName,
  }) = _$RecognitionResultReceivedImpl;

  bool get success;
  String get message;
  String? get employeeName;

  /// Create a copy of CheckInEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecognitionResultReceivedImplCopyWith<_$RecognitionResultReceivedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CheckInState {
  /// Current camera status
  CameraStatus get cameraStatus => throw _privateConstructorUsedError;

  /// Current permission status
  PermissionStatus get permissionStatus => throw _privateConstructorUsedError;

  /// Current WebSocket connection status
  ConnectionStatus get connectionStatus => throw _privateConstructorUsedError;

  /// Current frame streaming status
  StreamingStatus get streamingStatus => throw _privateConstructorUsedError;

  /// Whether the app is in a loading state
  bool get isLoading => throw _privateConstructorUsedError;

  /// Current error message, if any
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Camera controller instance
  CameraController? get cameraController => throw _privateConstructorUsedError;

  /// Current toast notification status
  ToastStatus get toastStatus => throw _privateConstructorUsedError;

  /// Message to display in toast notification
  String? get toastMessage => throw _privateConstructorUsedError;

  /// Whether debug mode is enabled
  bool get isDebugMode => throw _privateConstructorUsedError;

  /// Last recognition result timestamp
  DateTime? get lastRecognitionTime => throw _privateConstructorUsedError;

  /// Number of frames processed
  int get framesProcessed =>
      throw _privateConstructorUsedError; // WebSocket specific state fields for Story 2.1
  /// Number of connection attempts made
  int get connectionAttempts => throw _privateConstructorUsedError;

  /// Timestamp of last connection attempt
  DateTime? get lastConnectionAttempt => throw _privateConstructorUsedError;

  /// WebSocket specific error message
  String? get connectionError => throw _privateConstructorUsedError;

  /// Whether auto-connection is enabled
  bool get autoConnectionEnabled => throw _privateConstructorUsedError;

  /// Connection retry timer active
  bool get isRetryTimerActive => throw _privateConstructorUsedError;

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInStateCopyWith<CheckInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInStateCopyWith<$Res> {
  factory $CheckInStateCopyWith(
    CheckInState value,
    $Res Function(CheckInState) then,
  ) = _$CheckInStateCopyWithImpl<$Res, CheckInState>;
  @useResult
  $Res call({
    CameraStatus cameraStatus,
    PermissionStatus permissionStatus,
    ConnectionStatus connectionStatus,
    StreamingStatus streamingStatus,
    bool isLoading,
    String? errorMessage,
    CameraController? cameraController,
    ToastStatus toastStatus,
    String? toastMessage,
    bool isDebugMode,
    DateTime? lastRecognitionTime,
    int framesProcessed,
    int connectionAttempts,
    DateTime? lastConnectionAttempt,
    String? connectionError,
    bool autoConnectionEnabled,
    bool isRetryTimerActive,
  });
}

/// @nodoc
class _$CheckInStateCopyWithImpl<$Res, $Val extends CheckInState>
    implements $CheckInStateCopyWith<$Res> {
  _$CheckInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraStatus = null,
    Object? permissionStatus = null,
    Object? connectionStatus = null,
    Object? streamingStatus = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? cameraController = freezed,
    Object? toastStatus = null,
    Object? toastMessage = freezed,
    Object? isDebugMode = null,
    Object? lastRecognitionTime = freezed,
    Object? framesProcessed = null,
    Object? connectionAttempts = null,
    Object? lastConnectionAttempt = freezed,
    Object? connectionError = freezed,
    Object? autoConnectionEnabled = null,
    Object? isRetryTimerActive = null,
  }) {
    return _then(
      _value.copyWith(
            cameraStatus:
                null == cameraStatus
                    ? _value.cameraStatus
                    : cameraStatus // ignore: cast_nullable_to_non_nullable
                        as CameraStatus,
            permissionStatus:
                null == permissionStatus
                    ? _value.permissionStatus
                    : permissionStatus // ignore: cast_nullable_to_non_nullable
                        as PermissionStatus,
            connectionStatus:
                null == connectionStatus
                    ? _value.connectionStatus
                    : connectionStatus // ignore: cast_nullable_to_non_nullable
                        as ConnectionStatus,
            streamingStatus:
                null == streamingStatus
                    ? _value.streamingStatus
                    : streamingStatus // ignore: cast_nullable_to_non_nullable
                        as StreamingStatus,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            cameraController:
                freezed == cameraController
                    ? _value.cameraController
                    : cameraController // ignore: cast_nullable_to_non_nullable
                        as CameraController?,
            toastStatus:
                null == toastStatus
                    ? _value.toastStatus
                    : toastStatus // ignore: cast_nullable_to_non_nullable
                        as ToastStatus,
            toastMessage:
                freezed == toastMessage
                    ? _value.toastMessage
                    : toastMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            isDebugMode:
                null == isDebugMode
                    ? _value.isDebugMode
                    : isDebugMode // ignore: cast_nullable_to_non_nullable
                        as bool,
            lastRecognitionTime:
                freezed == lastRecognitionTime
                    ? _value.lastRecognitionTime
                    : lastRecognitionTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            framesProcessed:
                null == framesProcessed
                    ? _value.framesProcessed
                    : framesProcessed // ignore: cast_nullable_to_non_nullable
                        as int,
            connectionAttempts:
                null == connectionAttempts
                    ? _value.connectionAttempts
                    : connectionAttempts // ignore: cast_nullable_to_non_nullable
                        as int,
            lastConnectionAttempt:
                freezed == lastConnectionAttempt
                    ? _value.lastConnectionAttempt
                    : lastConnectionAttempt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            connectionError:
                freezed == connectionError
                    ? _value.connectionError
                    : connectionError // ignore: cast_nullable_to_non_nullable
                        as String?,
            autoConnectionEnabled:
                null == autoConnectionEnabled
                    ? _value.autoConnectionEnabled
                    : autoConnectionEnabled // ignore: cast_nullable_to_non_nullable
                        as bool,
            isRetryTimerActive:
                null == isRetryTimerActive
                    ? _value.isRetryTimerActive
                    : isRetryTimerActive // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CheckInStateImplCopyWith<$Res>
    implements $CheckInStateCopyWith<$Res> {
  factory _$$CheckInStateImplCopyWith(
    _$CheckInStateImpl value,
    $Res Function(_$CheckInStateImpl) then,
  ) = __$$CheckInStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CameraStatus cameraStatus,
    PermissionStatus permissionStatus,
    ConnectionStatus connectionStatus,
    StreamingStatus streamingStatus,
    bool isLoading,
    String? errorMessage,
    CameraController? cameraController,
    ToastStatus toastStatus,
    String? toastMessage,
    bool isDebugMode,
    DateTime? lastRecognitionTime,
    int framesProcessed,
    int connectionAttempts,
    DateTime? lastConnectionAttempt,
    String? connectionError,
    bool autoConnectionEnabled,
    bool isRetryTimerActive,
  });
}

/// @nodoc
class __$$CheckInStateImplCopyWithImpl<$Res>
    extends _$CheckInStateCopyWithImpl<$Res, _$CheckInStateImpl>
    implements _$$CheckInStateImplCopyWith<$Res> {
  __$$CheckInStateImplCopyWithImpl(
    _$CheckInStateImpl _value,
    $Res Function(_$CheckInStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraStatus = null,
    Object? permissionStatus = null,
    Object? connectionStatus = null,
    Object? streamingStatus = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? cameraController = freezed,
    Object? toastStatus = null,
    Object? toastMessage = freezed,
    Object? isDebugMode = null,
    Object? lastRecognitionTime = freezed,
    Object? framesProcessed = null,
    Object? connectionAttempts = null,
    Object? lastConnectionAttempt = freezed,
    Object? connectionError = freezed,
    Object? autoConnectionEnabled = null,
    Object? isRetryTimerActive = null,
  }) {
    return _then(
      _$CheckInStateImpl(
        cameraStatus:
            null == cameraStatus
                ? _value.cameraStatus
                : cameraStatus // ignore: cast_nullable_to_non_nullable
                    as CameraStatus,
        permissionStatus:
            null == permissionStatus
                ? _value.permissionStatus
                : permissionStatus // ignore: cast_nullable_to_non_nullable
                    as PermissionStatus,
        connectionStatus:
            null == connectionStatus
                ? _value.connectionStatus
                : connectionStatus // ignore: cast_nullable_to_non_nullable
                    as ConnectionStatus,
        streamingStatus:
            null == streamingStatus
                ? _value.streamingStatus
                : streamingStatus // ignore: cast_nullable_to_non_nullable
                    as StreamingStatus,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        cameraController:
            freezed == cameraController
                ? _value.cameraController
                : cameraController // ignore: cast_nullable_to_non_nullable
                    as CameraController?,
        toastStatus:
            null == toastStatus
                ? _value.toastStatus
                : toastStatus // ignore: cast_nullable_to_non_nullable
                    as ToastStatus,
        toastMessage:
            freezed == toastMessage
                ? _value.toastMessage
                : toastMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        isDebugMode:
            null == isDebugMode
                ? _value.isDebugMode
                : isDebugMode // ignore: cast_nullable_to_non_nullable
                    as bool,
        lastRecognitionTime:
            freezed == lastRecognitionTime
                ? _value.lastRecognitionTime
                : lastRecognitionTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        framesProcessed:
            null == framesProcessed
                ? _value.framesProcessed
                : framesProcessed // ignore: cast_nullable_to_non_nullable
                    as int,
        connectionAttempts:
            null == connectionAttempts
                ? _value.connectionAttempts
                : connectionAttempts // ignore: cast_nullable_to_non_nullable
                    as int,
        lastConnectionAttempt:
            freezed == lastConnectionAttempt
                ? _value.lastConnectionAttempt
                : lastConnectionAttempt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        connectionError:
            freezed == connectionError
                ? _value.connectionError
                : connectionError // ignore: cast_nullable_to_non_nullable
                    as String?,
        autoConnectionEnabled:
            null == autoConnectionEnabled
                ? _value.autoConnectionEnabled
                : autoConnectionEnabled // ignore: cast_nullable_to_non_nullable
                    as bool,
        isRetryTimerActive:
            null == isRetryTimerActive
                ? _value.isRetryTimerActive
                : isRetryTimerActive // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$CheckInStateImpl implements _CheckInState {
  const _$CheckInStateImpl({
    this.cameraStatus = CameraStatus.initial,
    this.permissionStatus = PermissionStatus.initial,
    this.connectionStatus = ConnectionStatus.disconnected,
    this.streamingStatus = StreamingStatus.idle,
    this.isLoading = false,
    this.errorMessage,
    this.cameraController,
    this.toastStatus = ToastStatus.none,
    this.toastMessage,
    this.isDebugMode = false,
    this.lastRecognitionTime,
    this.framesProcessed = 0,
    this.connectionAttempts = 0,
    this.lastConnectionAttempt,
    this.connectionError,
    this.autoConnectionEnabled = true,
    this.isRetryTimerActive = false,
  });

  /// Current camera status
  @override
  @JsonKey()
  final CameraStatus cameraStatus;

  /// Current permission status
  @override
  @JsonKey()
  final PermissionStatus permissionStatus;

  /// Current WebSocket connection status
  @override
  @JsonKey()
  final ConnectionStatus connectionStatus;

  /// Current frame streaming status
  @override
  @JsonKey()
  final StreamingStatus streamingStatus;

  /// Whether the app is in a loading state
  @override
  @JsonKey()
  final bool isLoading;

  /// Current error message, if any
  @override
  final String? errorMessage;

  /// Camera controller instance
  @override
  final CameraController? cameraController;

  /// Current toast notification status
  @override
  @JsonKey()
  final ToastStatus toastStatus;

  /// Message to display in toast notification
  @override
  final String? toastMessage;

  /// Whether debug mode is enabled
  @override
  @JsonKey()
  final bool isDebugMode;

  /// Last recognition result timestamp
  @override
  final DateTime? lastRecognitionTime;

  /// Number of frames processed
  @override
  @JsonKey()
  final int framesProcessed;
  // WebSocket specific state fields for Story 2.1
  /// Number of connection attempts made
  @override
  @JsonKey()
  final int connectionAttempts;

  /// Timestamp of last connection attempt
  @override
  final DateTime? lastConnectionAttempt;

  /// WebSocket specific error message
  @override
  final String? connectionError;

  /// Whether auto-connection is enabled
  @override
  @JsonKey()
  final bool autoConnectionEnabled;

  /// Connection retry timer active
  @override
  @JsonKey()
  final bool isRetryTimerActive;

  @override
  String toString() {
    return 'CheckInState(cameraStatus: $cameraStatus, permissionStatus: $permissionStatus, connectionStatus: $connectionStatus, streamingStatus: $streamingStatus, isLoading: $isLoading, errorMessage: $errorMessage, cameraController: $cameraController, toastStatus: $toastStatus, toastMessage: $toastMessage, isDebugMode: $isDebugMode, lastRecognitionTime: $lastRecognitionTime, framesProcessed: $framesProcessed, connectionAttempts: $connectionAttempts, lastConnectionAttempt: $lastConnectionAttempt, connectionError: $connectionError, autoConnectionEnabled: $autoConnectionEnabled, isRetryTimerActive: $isRetryTimerActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInStateImpl &&
            (identical(other.cameraStatus, cameraStatus) ||
                other.cameraStatus == cameraStatus) &&
            (identical(other.permissionStatus, permissionStatus) ||
                other.permissionStatus == permissionStatus) &&
            (identical(other.connectionStatus, connectionStatus) ||
                other.connectionStatus == connectionStatus) &&
            (identical(other.streamingStatus, streamingStatus) ||
                other.streamingStatus == streamingStatus) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.cameraController, cameraController) ||
                other.cameraController == cameraController) &&
            (identical(other.toastStatus, toastStatus) ||
                other.toastStatus == toastStatus) &&
            (identical(other.toastMessage, toastMessage) ||
                other.toastMessage == toastMessage) &&
            (identical(other.isDebugMode, isDebugMode) ||
                other.isDebugMode == isDebugMode) &&
            (identical(other.lastRecognitionTime, lastRecognitionTime) ||
                other.lastRecognitionTime == lastRecognitionTime) &&
            (identical(other.framesProcessed, framesProcessed) ||
                other.framesProcessed == framesProcessed) &&
            (identical(other.connectionAttempts, connectionAttempts) ||
                other.connectionAttempts == connectionAttempts) &&
            (identical(other.lastConnectionAttempt, lastConnectionAttempt) ||
                other.lastConnectionAttempt == lastConnectionAttempt) &&
            (identical(other.connectionError, connectionError) ||
                other.connectionError == connectionError) &&
            (identical(other.autoConnectionEnabled, autoConnectionEnabled) ||
                other.autoConnectionEnabled == autoConnectionEnabled) &&
            (identical(other.isRetryTimerActive, isRetryTimerActive) ||
                other.isRetryTimerActive == isRetryTimerActive));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    cameraStatus,
    permissionStatus,
    connectionStatus,
    streamingStatus,
    isLoading,
    errorMessage,
    cameraController,
    toastStatus,
    toastMessage,
    isDebugMode,
    lastRecognitionTime,
    framesProcessed,
    connectionAttempts,
    lastConnectionAttempt,
    connectionError,
    autoConnectionEnabled,
    isRetryTimerActive,
  );

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      __$$CheckInStateImplCopyWithImpl<_$CheckInStateImpl>(this, _$identity);
}

abstract class _CheckInState implements CheckInState {
  const factory _CheckInState({
    final CameraStatus cameraStatus,
    final PermissionStatus permissionStatus,
    final ConnectionStatus connectionStatus,
    final StreamingStatus streamingStatus,
    final bool isLoading,
    final String? errorMessage,
    final CameraController? cameraController,
    final ToastStatus toastStatus,
    final String? toastMessage,
    final bool isDebugMode,
    final DateTime? lastRecognitionTime,
    final int framesProcessed,
    final int connectionAttempts,
    final DateTime? lastConnectionAttempt,
    final String? connectionError,
    final bool autoConnectionEnabled,
    final bool isRetryTimerActive,
  }) = _$CheckInStateImpl;

  /// Current camera status
  @override
  CameraStatus get cameraStatus;

  /// Current permission status
  @override
  PermissionStatus get permissionStatus;

  /// Current WebSocket connection status
  @override
  ConnectionStatus get connectionStatus;

  /// Current frame streaming status
  @override
  StreamingStatus get streamingStatus;

  /// Whether the app is in a loading state
  @override
  bool get isLoading;

  /// Current error message, if any
  @override
  String? get errorMessage;

  /// Camera controller instance
  @override
  CameraController? get cameraController;

  /// Current toast notification status
  @override
  ToastStatus get toastStatus;

  /// Message to display in toast notification
  @override
  String? get toastMessage;

  /// Whether debug mode is enabled
  @override
  bool get isDebugMode;

  /// Last recognition result timestamp
  @override
  DateTime? get lastRecognitionTime;

  /// Number of frames processed
  @override
  int get framesProcessed; // WebSocket specific state fields for Story 2.1
  /// Number of connection attempts made
  @override
  int get connectionAttempts;

  /// Timestamp of last connection attempt
  @override
  DateTime? get lastConnectionAttempt;

  /// WebSocket specific error message
  @override
  String? get connectionError;

  /// Whether auto-connection is enabled
  @override
  bool get autoConnectionEnabled;

  /// Connection retry timer active
  @override
  bool get isRetryTimerActive;

  /// Create a copy of CheckInState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
