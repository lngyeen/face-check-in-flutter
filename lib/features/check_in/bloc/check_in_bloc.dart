import 'dart:async';
import 'dart:convert' as json;

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
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
  }

  void _listenToConnectionBloc() {
    // Listen to ConnectionBloc state changes
    _connectionStateSubscription?.cancel();
    _connectionStateSubscription = _connectionBloc.stream.listen(
      (connectionState) => add(ConnectionStateChanged(connectionState)),
    );

    // Listen to WebSocket messages
    _webSocketMessageSubscription?.cancel();
    _webSocketMessageSubscription = _connectionBloc.messageStream.listen(
      (data) => add(WebSocketMessageReceived(data)),
    );
  }

  void _registerEventHandlers() {
    // Lifecycle events - sequential processing to prevent race conditions
    on<CheckInEvent>(_handleLifecycleEvent, transformer: sequential());

    // Concurrent events - default behavior
    on<ToggleDebugMode>(_onToggleDebugMode);
    on<WebSocketMessageReceived>(_onWebSocketMessageReceived);
    on<FrameResultReceived>(_onFrameResultReceived);
    on<ResponseErrorReceived>(_onResponseErrorReceived);

    // Connection state handlers
    on<ConnectionStateChanged>(_onConnectionStateChanged);
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

    final isConnectionReady = connectionState.isConnectionReady;
    final isCameraActive =
        state.cameraStatus == CameraStatus.opening ||
        state.cameraStatus == CameraStatus.initializing;

    // Auto-start camera when connection becomes ready
    if (isConnectionReady && !isCameraActive) {
      add(const CheckInEvent.startCamera());
      return;
    }

    // Stop camera when going to background retry (dispose completely)
    if (state.connectionState.status ==
            AppConnectionStatus.backgroundRetrying &&
        isCameraActive) {
      add(const CheckInEvent.stopCamera());
      return;
    }

    // Stop camera when connection lost
    if (isCameraActive && !isConnectionReady) {
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

    return super.close();
  }

  // Initialization handlers
  void _onInitialize(Initialize event, Emitter<CheckInState> emit) {
    // Initialize ConnectionBloc first
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
          currentError: const CheckInError(
            message:
                'Camera permission is required to use face check-in feature',
            type: CheckInErrorType.permission,
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
            currentError: const CheckInError(
              message:
                  'Front camera is required for face check-in feature. This device does not have a front camera.',
              type: CheckInErrorType.camera,
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

      // Initialize ConnectionBloc
      _connectionBloc.add(const ConnectionEvent.initialize());
      _listenToConnectionBloc();
    } catch (e) {
      emit(
        state.copyWith(
          cameraStatus: CameraStatus.error,
          currentError: CheckInError(
            message: 'Failed to initialize camera: $e',
            type: CheckInErrorType.camera,
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

      final type = data['type'] as String?;
      switch (type) {
        case 'frameResult':
          _handleFrameResult(data);
        case 'error':
          add(
            ResponseErrorReceived(
              error: data['error'] as String? ?? 'Unknown Backend Error',
              message: data['message'] as String?,
            ),
          );
        default:
          break;
      }
    } catch (e) {
      add(
        ResponseErrorReceived(
          error: 'MessageParsingError',
          message: 'Failed to parse WebSocket data. Error: $e',
        ),
      );
    }
  }

  void _handleFrameResult(Map<String, dynamic> data) {
    try {
      final response = FaceDetectionResponse.fromJson(data);
      add(FrameResultReceived(response: response));
    } catch (e) {
      // If parsing fails, treat as backend error instead of complex fallbacks
      add(
        ResponseErrorReceived(
          error: 'ResponseParsingError',
          message: 'Failed to parse frame result: $e',
        ),
      );
    }
  }

  // UI and response handlers
  void _onToggleDebugMode(ToggleDebugMode event, Emitter<CheckInState> emit) {
    emit(state.copyWith(isDebugMode: !state.isDebugMode));
  }

  void _onFrameResultReceived(
    FrameResultReceived event,
    Emitter<CheckInState> emit,
  ) {
    final frameData = event.response.data;
    emit(
      state.copyWith(
        latestFrameData: frameData,
        currentError: null, // Clear any previous errors on successful frame
      ),
    );
  }

  void _onResponseErrorReceived(
    ResponseErrorReceived event,
    Emitter<CheckInState> emit,
  ) {
    emit(
      state.copyWith(
        currentError: CheckInError(
          message: event.message ?? event.error,
          type: CheckInErrorType.backend,
        ),
        latestFrameData: null, // Clear frame data to show error status
      ),
    );
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
