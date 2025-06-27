import 'dart:async';
import 'dart:convert' as json;

import 'package:flutter/widgets.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/constants/network_constants.dart';
import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/core/services/stream_service.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_event.dart'
    hide Initialize;

import 'check_in_event.dart';
import 'check_in_state.dart';

/// Main BLoC for managing check-in feature state
/// Handles camera, WebSocket, streaming, and UI state management
@injectable
class CheckInBloc extends Bloc<CheckInEvent, CheckInState>
    with WidgetsBindingObserver {
  final PermissionService _permissionService;
  final ConnectionBloc _connectionBloc;
  final StreamService _streamService;

  StreamSubscription? _webSocketMessageSubscription;
  StreamSubscription? _connectionStateSubscription;

  CheckInBloc(
    this._permissionService,
    this._connectionBloc,
    this._streamService,
  ) : super(const CheckInState()) {
    _registerEventHandlers();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        add(const CheckInEvent.initialize());
        break;
      case AppLifecycleState.hidden:
        add(const CheckInEvent.stopCamera());
        _connectionBloc.add(const ConnectionEvent.disconnect());
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _listenToConnectionBloc() {
    _connectionStateSubscription?.cancel();
    _connectionStateSubscription = _connectionBloc.stream.listen(
      (connectionState) => add(ConnectionStateChanged(connectionState)),
    );

    _webSocketMessageSubscription?.cancel();
    _webSocketMessageSubscription = _connectionBloc.messageStream.listen(
      (data) => add(WebSocketMessageReceived(data)),
    );
  }

  void _registerEventHandlers() {
    on<CheckInEvent>(_handleLifecycleEvent, transformer: sequential());

    on<ToggleDebugMode>(_onToggleDebugMode);
    on<WebSocketMessageReceived>(
      _onWebSocketMessageReceived,
      transformer: droppable(),
    );
    on<ConnectionStateChanged>(
      _onConnectionStateChanged,
      transformer: restartable(),
    );
  }

  Future<void> _handleLifecycleEvent(
    CheckInEvent event,
    Emitter<CheckInState> emit,
  ) async {
    switch (event) {
      case Initialize():
        _onInitialize(event, emit);
      case StartCamera():
        await _onStartCamera(event, emit);
      case StopCamera():
        await _onStopCamera(event, emit);
      default:
        return;
    }
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
            connectionState.isActiveStreaming ? state.latestFrameData : null,
      ),
    );

    final hasConnection = connectionState.hasConnection;
    final isCameraActive =
        state.cameraStatus == CameraStatus.opening ||
        state.cameraStatus == CameraStatus.initializing;

    if (hasConnection && !isCameraActive) {
      add(const CheckInEvent.startCamera());
      return;
    }

    if (state.connectionState.status ==
            AppConnectionStatus.backgroundRetrying &&
        isCameraActive) {
      add(const CheckInEvent.stopCamera());
      return;
    }

    if (isCameraActive && !hasConnection) {
      add(const CheckInEvent.stopCamera());
      return;
    }
  }

  @override
  Future<void> close() async {
    _streamService.dispose();
    await _stopCameraResources(state.cameraController);
    await _webSocketMessageSubscription?.cancel();
    await _connectionStateSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    return super.close();
  }

  // Initialization handlers
  void _onInitialize(Initialize event, Emitter<CheckInState> emit) {
    _listenToConnectionBloc();
    _connectionBloc.add(const ConnectionEvent.initialize());
  }

  // Camera handlers
  Future<void> _onStartCamera(
    StartCamera event,
    Emitter<CheckInState> emit,
  ) async {
    emit(state.copyWith(cameraStatus: CameraStatus.initializing));

    final permissionStatus =
        await _permissionService.getCameraPermissionStatus();

    if (permissionStatus == PermissionStatus.granted) {
      await _initCameraController(emit);
      return;
    }

    final status = await _permissionService.requestCameraPermission();
    if (status == PermissionStatus.granted) {
      await _initCameraController(emit);
    } else {
      emit(
        state.copyWith(
          cameraStatus: CameraStatus.permissionDenied,
          currentError: const CheckInError.permission(
            message:
                'Camera permission is required to use face check-in feature',
          ),
        ),
      );
    }
  }

  Future<void> _initCameraController(Emitter<CheckInState> emit) async {
    try {
      final cameras = await availableCameras();
      final frontCameras =
          cameras
              .where(
                (camera) => camera.lensDirection == CameraLensDirection.front,
              )
              .toList();

      if (frontCameras.isEmpty) {
        emit(
          state.copyWith(
            cameraStatus: CameraStatus.frontCameraNotAvailable,
            currentError: const CheckInError.camera(
              message:
                  'Front camera is required for face check-in feature. This device does not have a front camera.',
            ),
          ),
        );
        return;
      }

      final controller = CameraController(
        frontCameras.first,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await controller.initialize();
      await controller.setFocusMode(FocusMode.auto);
      await controller.setExposureMode(ExposureMode.auto);
      await controller.startImageStream((CameraImage image) {
        if (_connectionBloc.state.isActiveStreaming) {
          _connectionBloc.addFrame(image);
        }
      });

      emit(
        state.copyWith(
          cameraStatus: CameraStatus.opening,
          cameraController: controller,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          cameraStatus: CameraStatus.error,
          currentError: CheckInError.camera(
            message: 'Failed to initialize camera: $e',
          ),
        ),
      );
    }
  }

  Future<void> _onStopCamera(
    StopCamera event,
    Emitter<CheckInState> emit,
  ) async {
    final controller = state.cameraController;

    emit(
      state.copyWith(
        cameraController: null,
        cameraStatus: CameraStatus.initial,
      ),
    );

    await _stopCameraResources(controller);
  }

  Future<void> _stopCameraResources(CameraController? controller) async {
    if (controller != null) {
      try {
        if (controller.value.isStreamingImages) {
          await controller.stopImageStream();
        }
        await controller.dispose();
      } catch (e) {
        // Silent error handling
      }
    }
  }

  void _onWebSocketMessageReceived(
    WebSocketMessageReceived event,
    Emitter<CheckInState> emit,
  ) {
    try {
      final Map<String, dynamic> data;
      if (event.data is String) {
        data = json.jsonDecode(event.data as String) as Map<String, dynamic>;
      } else if (event.data is Map<String, dynamic>) {
        data = event.data as Map<String, dynamic>;
      } else {
        throw Exception('Invalid data type: ${event.data.runtimeType}');
      }

      final type = data[WebSocketResponseKeys.type] as String?;
      switch (type) {
        case WebSocketResponseTypes.frameResult:
          try {
            final response = FaceDetectionResponse.fromJson(data);
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
                    data[WebSocketResponseKeys.message] as String? ??
                    (data[WebSocketResponseKeys.error] as String? ??
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
    add(const CheckInEvent.startCamera());
  }

  /// Stop full flow - streaming and camera
  void stopFullFlow() {
    add(const CheckInEvent.stopCamera());
  }
}
