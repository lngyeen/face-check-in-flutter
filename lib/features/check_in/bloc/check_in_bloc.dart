import 'dart:async';
import 'dart:convert' as json;

import 'package:flutter/widgets.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/constants/network_constants.dart';
import 'package:face_check_in_flutter/core/services/stream_service.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_event.dart'
    as conn_event;

import 'check_in_event.dart';
import 'check_in_state.dart';

/// Main BLoC for managing check-in feature state
/// Handles camera, WebSocket, streaming, and UI state management
@injectable
class CheckInBloc extends Bloc<CheckInEvent, CheckInState>
    with WidgetsBindingObserver {
  final ConnectionBloc _connectionBloc;
  final StreamService _streamService;

  StreamSubscription? _webSocketMessageSubscription;
  StreamSubscription? _connectionStateSubscription;
  StreamSubscription? _cameraStatusSubscription;
  StreamSubscription? _cameraControllerSubscription;
  StreamSubscription? _streamingStatusSubscription;

  CheckInBloc(this._connectionBloc, this._streamService)
    : super(const CheckInState()) {
    _registerEventHandlers();
    WidgetsBinding.instance.addObserver(this);
    _listenToStreamService();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        add(const SeparatedSequentialCheckInEvent.initialize());
        break;
      case AppLifecycleState.hidden:
        add(const BucketRestartableCheckInEvent.stopCamera());
        _connectionBloc.add(const conn_event.ConnectionEvent.disconnect());
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _registerEventHandlers() {
    on<SeparatedSequentialCheckInEvent>((event, emit) {
      if (event is Initialize) {
        _onInitialize(event, emit);
      } else if (event is WebSocketMessageReceived) {
        _onWebSocketMessageReceived(event, emit);
      }
    }, transformer: sequential());

    on<BucketRestartableCheckInEvent>((event, emit) {
      if (event is StartCamera) {
        _onStartCamera(event, emit);
      } else if (event is StopCamera) {
        _onStopCamera(event, emit);
      } else if (event is StartImageStream) {
        _onStartImageStream(event, emit);
      } else if (event is StopImageStream) {
        _onStopImageStream(event, emit);
      }
    }, transformer: restartable());

    on<ConnectionStateChanged>(
      _onConnectionStateChanged,
      transformer: restartable(),
    );

    on<CameraStatusChanged>(_onCameraStatusChanged, transformer: restartable());

    on<CameraControllerChanged>(
      _onCameraControllerChanged,
      transformer: restartable(),
    );

    on<StreamingStatusChanged>(
      _onStreamingStatusChanged,
      transformer: restartable(),
    );

    on<DroppableCheckInEvent>((event, emit) {
      if (event is ToggleDebugMode) {
        _onToggleDebugMode(event, emit);
      }
    }, transformer: droppable());
  }

  void _listenToStreamService() {
    _cameraStatusSubscription?.cancel();
    _cameraStatusSubscription = _streamService.cameraStatusStream.listen(
      (status) => add(
        SeparatedRestartableCheckInEvent.cameraStatusChanged(status: status),
      ),
    );

    _cameraControllerSubscription?.cancel();
    _cameraControllerSubscription = _streamService.cameraControllerStream
        .listen(
          (controller) => add(
            SeparatedRestartableCheckInEvent.cameraControllerChanged(
              controller: controller,
            ),
          ),
        );

    _streamingStatusSubscription?.cancel();
    _streamingStatusSubscription = _streamService.streamingStatusStream.listen(
      (status) => add(
        SeparatedRestartableCheckInEvent.streamingStatusChanged(status: status),
      ),
    );
  }

  void _listenToConnectionBloc() {
    _connectionStateSubscription?.cancel();
    _connectionStateSubscription = _connectionBloc.stream.listen(
      (connectionState) => add(
        SeparatedRestartableCheckInEvent.connectionStateChanged(
          connectionState: connectionState,
        ),
      ),
    );

    _webSocketMessageSubscription?.cancel();
    _webSocketMessageSubscription = _connectionBloc.messageStream.listen(
      (data) => add(
        SeparatedSequentialCheckInEvent.webSocketMessageReceived(data: data),
      ),
    );
  }

  // Connection state handlers
  void _onConnectionStateChanged(
    ConnectionStateChanged event,
    Emitter<CheckInState> emit,
  ) {
    final connectionState = event.connectionState;
    emit(
      state.copyWith(
        connectionState: connectionState,
        latestFrameData:
            connectionState.hasConnection ? state.latestFrameData : null,
      ),
    );

    final isCameraActive =
        state.cameraStatus == CameraStatus.ready ||
        state.cameraStatus == CameraStatus.initializing;

    switch (connectionState.status) {
      case AppConnectionStatus.connected:
        if (!isCameraActive) {
          add(const BucketRestartableCheckInEvent.startCamera());
        }
        break;
      case AppConnectionStatus.initial:
      case AppConnectionStatus.networkLost:
      case AppConnectionStatus.failed:
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        if (isCameraActive) {
          add(const BucketRestartableCheckInEvent.stopCamera());
        }
        break;
      case AppConnectionStatus.connecting:
        break;
    }
  }

  void _onCameraStatusChanged(
    CameraStatusChanged event,
    Emitter<CheckInState> emit,
  ) {
    emit(state.copyWith(cameraStatus: event.status));
    switch (event.status) {
      case CameraStatus.permissionDenied:
        emit(
          state.copyWith(
            currentError: const CheckInError.permission(
              message:
                  'Camera permission is required to use face check-in feature',
            ),
          ),
        );
        break;
      case CameraStatus.frontCameraNotAvailable:
        emit(
          state.copyWith(
            currentError: const CheckInError.camera(
              message:
                  'Front camera is required for face check-in feature. This device does not have a front camera.',
            ),
          ),
        );
        break;
      case CameraStatus.error:
        emit(
          state.copyWith(
            currentError: const CheckInError.camera(
              message: 'Failed to initialize camera',
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  void _onCameraControllerChanged(
    CameraControllerChanged event,
    Emitter<CheckInState> emit,
  ) {
    emit(state.copyWith(cameraController: event.controller));
  }

  @override
  Future<void> close() async {
    _streamService.dispose();
    await _webSocketMessageSubscription?.cancel();
    await _connectionStateSubscription?.cancel();
    await _cameraControllerSubscription?.cancel();
    await _cameraStatusSubscription?.cancel();
    await _streamingStatusSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    return super.close();
  }

  // Initialization handlers
  void _onInitialize(Initialize event, Emitter<CheckInState> emit) {
    _listenToConnectionBloc();
    _connectionBloc.add(const conn_event.ConnectionEvent.connect());
  }

  // Camera handlers
  Future<void> _onStartCamera(
    StartCamera event,
    Emitter<CheckInState> emit,
  ) async {
    await _streamService.startCamera();
    add(const BucketRestartableCheckInEvent.startImageStream());
  }

  Future<void> _onStopCamera(
    StopCamera event,
    Emitter<CheckInState> emit,
  ) async {
    await _streamService.stopCamera();
  }

  Future<void> _onStopImageStream(
    StopImageStream event,
    Emitter<CheckInState> emit,
  ) async {
    await _streamService.stopImageStream();
  }

  Future<void> _onStartImageStream(
    StartImageStream event,
    Emitter<CheckInState> emit,
  ) async {
    await _streamService.startImageStream();
  }

  void _onStreamingStatusChanged(
    StreamingStatusChanged event,
    Emitter<CheckInState> emit,
  ) {
    emit(state.copyWith(streamingStatus: event.status));
  }

  void _onWebSocketMessageReceived(
    WebSocketMessageReceived event,
    Emitter<CheckInState> emit,
  ) {
    try {
      final data = event.data;
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
              state.copyWith(latestFrameData: frameData, currentError: null),
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

  // UI and response handlers
  void _onToggleDebugMode(ToggleDebugMode event, Emitter<CheckInState> emit) {
    emit(state.copyWith(isDebugMode: !state.isDebugMode));
  }

  /// Start full flow - camera and auto-streaming
  void startFullFlow() {
    add(const BucketRestartableCheckInEvent.startCamera());
  }

  /// Stop full flow - streaming and camera
  void stopFullFlow() {
    add(const BucketRestartableCheckInEvent.stopCamera());
  }

  void setStreamMaxFps(int maxFps) {
    _streamService.setMaxFps(maxFps);
  }
}
