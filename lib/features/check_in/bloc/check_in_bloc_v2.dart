import 'dart:async';
import 'dart:convert' as json;

import 'package:flutter/widgets.dart' hide ConnectionState;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/constants/network_constants.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_event.dart'
    as conn_event;
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';

part 'check_in_bloc_v2.freezed.dart';
part 'check_in_event_v2.dart';
part 'check_in_state_v2.dart';

/// Main orchestrator BLoC for check-in feature
/// Coordinates between CameraBlocV2, StreamingBlocV2, and ConnectionBloc
@injectable
class CheckInBlocV2 extends Bloc<CheckInEventV2, CheckInStateV2>
    with WidgetsBindingObserver {
  final CameraBlocV2 _cameraBloc;
  final StreamingBlocV2 _streamingBloc;
  final ConnectionBloc _connectionBloc;

  StreamSubscription? _cameraBlocSubscription;
  StreamSubscription? _streamingBlocSubscription;
  StreamSubscription? _connectionBlocSubscription;
  StreamSubscription? _webSocketMessageSubscription;

  CheckInBlocV2(this._cameraBloc, this._streamingBloc, this._connectionBloc)
    : super(const CheckInStateV2()) {
    _registerEventHandlers();
    _setupBlocListeners();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        add(const CheckInEventV2.start());
        break;
      case AppLifecycleState.hidden:
        add(const CheckInEventV2.stop());
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _registerEventHandlers() {
    on<CheckInEventV2>((event, emit) {
      event.when(
        start: () => _onStart(emit),
        stop: () => _onStop(emit),
        toggleDebugMode: () => _onToggleDebugMode(emit),
        setMaxFps: (fps) => _onSetMaxFps(fps, emit),
        webSocketMessageReceived:
            (data) => _onWebSocketMessageReceived(data, emit),
        connectionStateChanged:
            (connectionState) =>
                _onConnectionStateChanged(connectionState, emit),
        cameraStateChanged:
            (cameraState) => _onCameraStateChanged(cameraState, emit),
        streamingStateChanged:
            (streamingState) => _onStreamingStateChanged(streamingState, emit),
      );
    });
  }

  void _setupBlocListeners() {
    // Listen to ConnectionBloc for WebSocket messages and state changes
    _connectionBlocSubscription?.cancel();
    _connectionBlocSubscription = _connectionBloc.stream.listen((
      connectionState,
    ) {
      add(CheckInEventV2.connectionStateChanged(connectionState));
    });

    _webSocketMessageSubscription?.cancel();
    _webSocketMessageSubscription = _connectionBloc.messageStream.listen((
      data,
    ) {
      add(CheckInEventV2.webSocketMessageReceived(data));
    });

    // Listen to other blocs for state coordination
    _cameraBlocSubscription?.cancel();
    _cameraBlocSubscription = _cameraBloc.stream.listen((cameraState) {
      add(CheckInEventV2.cameraStateChanged(cameraState));
    });

    _streamingBlocSubscription?.cancel();
    _streamingBlocSubscription = _streamingBloc.stream.listen((streamingState) {
      add(CheckInEventV2.streamingStateChanged(streamingState));
    });
  }

  void _onStart(Emitter<CheckInStateV2> emit) {
    emit(state.copyWith(status: CheckInStatusV2.initializing));
    _connectionBloc.add(const conn_event.ConnectionEvent.connect());
  }

  void _onStop(Emitter<CheckInStateV2> emit) {
    emit(state.copyWith(status: CheckInStatusV2.idle, latestFrameData: null));
    _streamingBloc.add(const StreamingEventV2.stopStreaming());
    _cameraBloc.add(const CameraEventV2.stopCamera());
    _connectionBloc.add(const conn_event.ConnectionEvent.disconnect());
  }

  void _onToggleDebugMode(Emitter<CheckInStateV2> emit) {
    emit(state.copyWith(isDebugMode: !state.isDebugMode));
  }

  void _onSetMaxFps(int fps, Emitter<CheckInStateV2> emit) {
    _streamingBloc.add(StreamingEventV2.setMaxFps(fps));
  }

  void _onCameraStateChanged(
    CameraStateV2 cameraState,
    Emitter<CheckInStateV2> emit,
  ) {
    // Auto-start streaming when camera is ready
    if (cameraState.isReady && state.connectionState.hasConnection) {
      final controller = cameraState.controller;
      if (controller != null) {
        _streamingBloc.add(StreamingEventV2.startStreaming(controller));
      }
    }

    if (cameraState.error != null) {
      final checkInError = cameraState.error!.when(
        permissionDenied:
            () => const CheckInError.permission(
              message:
                  'Camera permission is required to use face check-in feature',
            ),
        notAvailable:
            () => const CheckInError.camera(
              message:
                  'Front camera is required for face check-in feature. This device does not have a front camera.',
            ),
        unexpected:
            () => const CheckInError.camera(
              message: 'Failed to initialize camera',
            ),
      );
      emit(
        state.copyWith(
          status: CheckInStatusV2.error,
          currentError: checkInError,
        ),
      );
    }
  }

  void _onStreamingStateChanged(
    StreamingStateV2 streamingState,
    Emitter<CheckInStateV2> emit,
  ) {
    if (streamingState.hasError && streamingState.error != null) {
      final checkInError = streamingState.error!.when(
        processingFailed:
            () =>
                const CheckInError.backend(message: 'Frame processing failed'),
        webSocketFailed:
            () => const CheckInError.backend(
              message: 'WebSocket connection error',
            ),
      );
      emit(
        state.copyWith(
          status: CheckInStatusV2.error,
          currentError: checkInError,
        ),
      );
    }
  }

  void _onWebSocketMessageReceived(dynamic data, Emitter<CheckInStateV2> emit) {
    try {
      final Map<String, dynamic> jsonData;
      if (data is String) {
        jsonData = json.jsonDecode(data) as Map<String, dynamic>;
      } else if (data is Map<String, dynamic>) {
        jsonData = data;
      } else {
        throw Exception('Invalid data type: ${data.runtimeType}');
      }

      final type = jsonData[WebSocketResponseKeys.type] as String?;
      switch (type) {
        case WebSocketResponseTypes.frameResult:
          try {
            final response = FaceDetectionResponse.fromJson(jsonData);
            final frameData = response.data;
            emit(
              state.copyWith(
                latestFrameData: frameData,
                currentError: null,
                status: CheckInStatusV2.processing,
              ),
            );
          } catch (e) {
            emit(
              state.copyWith(
                currentError: CheckInError.backend(
                  message: 'Failed to parse frame result: $e',
                ),
                latestFrameData: null,
              ),
            );
          }
          break;
        case WebSocketResponseTypes.error:
          emit(
            state.copyWith(
              currentError: CheckInError.backend(
                message:
                    jsonData[WebSocketResponseKeys.message] as String? ??
                    (jsonData[WebSocketResponseKeys.error] as String? ??
                        'Unknown Backend Error'),
              ),
              latestFrameData: null,
            ),
          );
          break;
        default:
          break;
      }
    } catch (e) {
      emit(
        state.copyWith(
          currentError: CheckInError.backend(
            message: 'Failed to parse WebSocket data. Error: $e',
          ),
          latestFrameData: null,
        ),
      );
    }
  }

  void _onConnectionStateChanged(
    ConnectionState connectionState,
    Emitter<CheckInStateV2> emit,
  ) {
    emit(state.copyWith(connectionState: connectionState));

    final isCameraActive = _cameraBloc.state.status.isActive;

    switch (connectionState.status) {
      case AppConnectionStatus.connected:
        if (!isCameraActive) {
          _cameraBloc.add(const CameraEventV2.startCamera());
        }
        break;
      case AppConnectionStatus.initial:
      case AppConnectionStatus.networkLost:
      case AppConnectionStatus.failed:
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        if (isCameraActive) {
          add(const CheckInEventV2.stop());
        }
        break;
      case AppConnectionStatus.connecting:
        break;
    }
  }

  @override
  Future<void> close() async {
    await _cameraBlocSubscription?.cancel();
    await _streamingBlocSubscription?.cancel();
    await _connectionBlocSubscription?.cancel();
    await _webSocketMessageSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
