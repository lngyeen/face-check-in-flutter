import 'dart:async';
import 'dart:convert' as json;

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/connection_manager.dart'
    as conn;
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';
import 'package:face_check_in_flutter/domain/entities/connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_status.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';
part 'check_in_bloc.freezed.dart';

/// Main BLoC for managing check-in feature state
/// Handles camera, WebSocket, streaming, and UI state management
@injectable
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final PermissionService _permissionService;
  final conn.ConnectionManager _connectionManager;

  StreamSubscription? _webSocketMessageSubscription;
  StreamSubscription? _connectionSummarySubscription;

  CheckInBloc(this._permissionService, this._connectionManager)
    : super(const CheckInState()) {
    _initializeServices();
    _registerEventHandlers();
  }

  void _initializeServices() async {
    // Initialize ConnectionManager (handles all connection-related services)
    await _connectionManager.initialize();

    // WebSocket message subscription (for face detection responses)
    _webSocketMessageSubscription?.cancel();
    _webSocketMessageSubscription = _connectionManager.messageStream.listen(
      (data) => add(WebSocketMessageReceived(data)),
    );

    // Connection summary subscription (single source of truth)
    _connectionSummarySubscription?.cancel();
    _connectionSummarySubscription = _connectionManager.connectionSummaryStream
        .listen((summary) => add(ConnectionSummaryReceived(summary: summary)));
  }

  void _registerEventHandlers() {
    // Lifecycle events - sequential processing to prevent race conditions
    on<CheckInEvent>(_handleLifecycleEvent, transformer: sequential());

    // Concurrent events - default behavior
    on<ToggleDebugMode>(_onToggleDebugMode);
    on<OpenAppSettings>(_onOpenAppSettings);
    on<WebSocketMessageReceived>(_onWebSocketMessageReceived);
    on<FrameResultReceived>(_onFrameResultReceived);
    on<ResponseErrorReceived>(_onResponseErrorReceived);
    on<WebSocketStatusChanged>(_onWebSocketStatusChanged);
    on<StreamingFailed>(_onStreamingFailed);

    // Special transformers
    on<ConfigureStream>(_onConfigureStream, transformer: restartable());
    on<_FrameCaptured>(_onFrameCaptured, transformer: droppable());

    // Connection summary handlers
    on<ConnectionSummaryReceived>(_onConnectionSummaryReceived);
    on<RequestManualRetry>(_onRequestManualRetry);
  }

  Future<void> _handleLifecycleEvent(
    CheckInEvent event,
    Emitter<CheckInState> emit,
  ) async {
    switch (event) {
      case RequestCameraPermission():
        await _onRequestCameraPermission(event, emit);
      case CameraPermissionGranted():
        await _onCameraPermissionGranted(event, emit);
      case CameraPermissionDenied():
        await _onCameraPermissionDenied(event, emit);
      case InitializeCamera():
        await _onInitializeCamera(event, emit);
      case StopCamera():
        await _onStopCamera(event, emit);
      case ConnectWebSocket():
        await _onConnectWebSocket(event, emit);
      case DisconnectWebSocket():
        await _onDisconnectWebSocket(event, emit);
      case StartStreaming():
        await _onStartStreaming(event, emit);
      case StopStreaming():
        await _onStopStreaming(event, emit);
      default:
        return; // Non-lifecycle events handled in separate buckets
    }
  }

  // Connection summary handlers
  void _onConnectionSummaryReceived(
    ConnectionSummaryReceived event,
    Emitter<CheckInState> emit,
  ) {
    final summary = event.summary;

    // Update connection summary
    emit(state.copyWith(connectionSummary: summary));

    // Handle auto-streaming when operational
    if (summary.currentState == conn.ConnectionState.operational &&
        state.cameraStatus == CameraStatus.operational) {
      add(const CheckInEvent.startStreaming());
    }

    // Handle auto-stop streaming when disconnected
    if (summary.currentState == conn.ConnectionState.disconnected ||
        summary.currentState == conn.ConnectionState.networkLost ||
        summary.currentState == conn.ConnectionState.failed) {
      add(const CheckInEvent.stopStreaming());
    }
  }

  Future<void> _onRequestManualRetry(
    RequestManualRetry event,
    Emitter<CheckInState> emit,
  ) async {
    await _connectionManager.requestManualRetry();
  }

  @override
  Future<void> close() async {
    try {
      await _connectionManager.stopStreaming();

      final controller = state.cameraController;
      if (controller != null && controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
      await controller?.dispose();

      await _webSocketMessageSubscription?.cancel();
      await _connectionSummarySubscription?.cancel();

      _connectionManager.dispose();
    } catch (e) {
      // Silent cleanup
    }
    return super.close();
  }

  // Permission handlers
  Future<void> _onRequestCameraPermission(
    RequestCameraPermission event,
    Emitter<CheckInState> emit,
  ) async {
    emit(state.copyWith(cameraStatus: CameraStatus.initializing));
    final status = await _permissionService.requestCameraPermission();

    if (status == PermissionStatus.granted) {
      add(const CheckInEvent.cameraPermissionGranted());
    } else {
      add(const CheckInEvent.cameraPermissionDenied());
    }
  }

  Future<void> _onCameraPermissionGranted(
    CameraPermissionGranted event,
    Emitter<CheckInState> emit,
  ) async {
    emit(state.copyWith(permissionStatus: PermissionStatus.granted));
    add(const CheckInEvent.initializeCamera());
  }

  Future<void> _onCameraPermissionDenied(
    CameraPermissionDenied event,
    Emitter<CheckInState> emit,
  ) async {
    final status = await _permissionService.requestCameraPermission();
    final isPermanentlyDenied = status == PermissionStatus.permanentlyDenied;

    if (isPermanentlyDenied) {
      _permissionService.openAppSettings();
    }

    emit(
      state.copyWith(
        permissionStatus:
            isPermanentlyDenied
                ? PermissionStatus.permanentlyDenied
                : PermissionStatus.denied,
        cameraStatus: CameraStatus.permissionDenied,
        currentError: const CheckInError(
          message: 'Camera permission is required to use face check-in feature',
          type: CheckInErrorType.permission,
        ),
      ),
    );
  }

  Future<void> _onOpenAppSettings(
    OpenAppSettings event,
    Emitter<CheckInState> emit,
  ) async {
    await _permissionService.openAppSettings();
  }

  // Camera handlers
  Future<void> _onInitializeCamera(
    InitializeCamera event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.permissionStatus != PermissionStatus.granted) {
      add(const CheckInEvent.requestCameraPermission());
      return;
    }

    emit(state.copyWith(cameraStatus: CameraStatus.initializing));

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }

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

      emit(
        state.copyWith(
          cameraStatus: CameraStatus.operational,
          cameraController: controller,
        ),
      );

      add(const CheckInEvent.connectWebSocket());
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
    emit(
      state.copyWith(
        cameraStatus: CameraStatus.initial,
        streamingStatus: StreamingStatus.idle,
      ),
    );

    final controller = state.cameraController;
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

    emit(
      state.copyWith(
        cameraController: null,
        cameraStatus: CameraStatus.initial,
        streamingStatus: StreamingStatus.idle,
      ),
    );
  }

  // WebSocket handlers
  Future<void> _onConnectWebSocket(
    ConnectWebSocket event,
    Emitter<CheckInState> emit,
  ) async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.connecting));
    await _connectionManager.requestConnection();
  }

  void _onWebSocketStatusChanged(
    WebSocketStatusChanged event,
    Emitter<CheckInState> emit,
  ) {
    emit(state.copyWith(connectionStatus: event.status));

    if (event.status == ConnectionStatus.failed) {
      emit(
        state.copyWith(
          currentError: const CheckInError(
            message: 'Connection Failed',
            type: CheckInErrorType.connection,
          ),
        ),
      );
    } else if (event.status == ConnectionStatus.connected) {
      emit(state.copyWith(currentError: null));

      if (state.cameraStatus == CameraStatus.operational &&
          state.streamingStatus == StreamingStatus.idle) {
        add(const CheckInEvent.startStreaming());
      }
    }
  }

  Future<void> _onDisconnectWebSocket(
    DisconnectWebSocket event,
    Emitter<CheckInState> emit,
  ) async {
    await _connectionManager.requestDisconnection();
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
    final frameDataMap = data['data'] as Map<String, dynamic>?;
    if (frameDataMap == null) return;

    try {
      final response = FaceDetectionResponse.fromJson(data);
      add(FrameResultReceived(response: response));
    } catch (e) {
      try {
        final frameData = FaceDetectionData.fromJson(frameDataMap);
        final response = FaceDetectionResponse(
          type: 'frameResult',
          data: frameData,
        );
        add(FrameResultReceived(response: response));
      } catch (e2) {
        final facesData =
            (frameDataMap['faces'] as List<dynamic>?)
                ?.map((e) => e as Map<String, dynamic>)
                .toList() ??
            [];
        add(FrameResultReceived(faces: facesData));
      }
    }
  }

  // Streaming handlers
  Future<void> _onStartStreaming(
    StartStreaming event,
    Emitter<CheckInState> emit,
  ) async {
    final controller = state.cameraController;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (controller.value.isStreamingImages) {
      if (state.streamingStatus != StreamingStatus.active) {
        emit(state.copyWith(streamingStatus: StreamingStatus.active));
      }
      return;
    }

    if (!_connectionManager.isFullyOperational) {
      emit(
        state.copyWith(
          streamingStatus: StreamingStatus.error,
          currentError: const CheckInError(
            message: 'Connection not ready. Cannot start streaming.',
            type: CheckInErrorType.connection,
          ),
        ),
      );
      return;
    }

    try {
      final streamStarted = await _connectionManager.startStreaming();
      if (!streamStarted) {
        emit(
          state.copyWith(
            streamingStatus: StreamingStatus.error,
            currentError: const CheckInError(
              message: 'Connection not ready. Cannot start streaming.',
              type: CheckInErrorType.connection,
            ),
          ),
        );
        return;
      }

      await controller.startImageStream((image) {
        if (state.streamingStatus == StreamingStatus.active) {
          add(_FrameCaptured(image));
        }
      });
      emit(state.copyWith(streamingStatus: StreamingStatus.active));
    } catch (e) {
      add(StreamingFailed('Failed to start streaming: $e'));
    }
  }

  Future<void> _onStopStreaming(
    StopStreaming event,
    Emitter<CheckInState> emit,
  ) async {
    final controller = state.cameraController;
    if (controller == null) {
      emit(state.copyWith(streamingStatus: StreamingStatus.idle));
      return;
    }

    try {
      if (controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
      await _connectionManager.stopStreaming();
      emit(state.copyWith(streamingStatus: StreamingStatus.idle));
    } catch (e) {
      add(StreamingFailed('Failed to stop streaming: $e'));
    }
  }

  void _onStreamingFailed(StreamingFailed event, Emitter<CheckInState> emit) {
    emit(
      state.copyWith(
        streamingStatus: StreamingStatus.error,
        currentError: CheckInError(
          message: event.error,
          type: CheckInErrorType.streaming,
        ),
      ),
    );
  }

  // UI and response handlers
  void _onToggleDebugMode(ToggleDebugMode event, Emitter<CheckInState> emit) {
    emit(state.copyWith(isDebugMode: !state.isDebugMode));
  }

  void _onFrameResultReceived(
    FrameResultReceived event,
    Emitter<CheckInState> emit,
  ) {
    List<FaceDetectionResult> faces = [];
    FaceDetectionData? frameData;

    final response = event.response;
    if (response != null) {
      faces = response.data.faces;
      frameData = response.data;
    } else if (event.faces != null) {
      faces =
          event.faces!
              .map((faceData) => FaceDetectionResult.fromJson(faceData))
              .toList();
    }

    final newStatus = _determineFaceStatus(faces);
    emit(
      state.copyWith(
        faceStatus: newStatus,
        responseError: null,
        latestFrameData: frameData,
      ),
    );
  }

  FaceDetectionStatus _determineFaceStatus(List<FaceDetectionResult> faces) {
    if (faces.isEmpty) return FaceDetectionStatus.noFace;
    if (faces.length > 1) return FaceDetectionStatus.multipleFaces;

    final hasRecognizedFace = faces.any((face) => face.isRecognized);
    return hasRecognizedFace
        ? FaceDetectionStatus.faceFound
        : FaceDetectionStatus.faceUnrecognized;
  }

  void _onResponseErrorReceived(
    ResponseErrorReceived event,
    Emitter<CheckInState> emit,
  ) {
    emit(
      state.copyWith(
        faceStatus: FaceDetectionStatus.error,
        responseError: BackendError(error: event.error, message: event.message),
      ),
    );
  }

  void _onConfigureStream(ConfigureStream event, Emitter<CheckInState> emit) {
    _connectionManager.configureStream(maxFps: event.maxFps);
  }

  Future<void> _onFrameCaptured(
    _FrameCaptured event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.streamingStatus != StreamingStatus.active) return;
    _connectionManager.addFrame(event.image);
  }

  /// Start full flow - camera, WebSocket, streaming
  void startFullFlow() {
    if (state.isLoading) return;
    add(const CheckInEvent.initializeCamera());
  }

  /// Stop full flow - streaming, WebSocket, camera
  void stopFullFlow() {
    if (state.isLoading) return;

    if (state.streamingStatus == StreamingStatus.active) {
      add(const CheckInEvent.stopStreaming());
    }
    if (state.connectionStatus == ConnectionStatus.connected) {
      add(const CheckInEvent.disconnectWebSocket());
    }
    add(const CheckInEvent.stopCamera());
  }

  /// Full restart for debug purposes (legacy method)
  void restartCamera() {
    if (state.isLoading) return;

    if (state.streamingStatus == StreamingStatus.active) {
      add(const CheckInEvent.stopStreaming());
    }
    if (state.connectionStatus == ConnectionStatus.connected) {
      add(const CheckInEvent.disconnectWebSocket());
    }

    add(const CheckInEvent.stopCamera());
    add(const CheckInEvent.initializeCamera());
  }
}
