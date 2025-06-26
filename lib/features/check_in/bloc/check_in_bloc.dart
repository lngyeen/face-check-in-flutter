import 'dart:async';
import 'dart:convert' as json;

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/transformers.dart';

import 'package:face_check_in_flutter/core/services/stream_service.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_status.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart';
import 'package:face_check_in_flutter/features/connection/connection.dart';

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
    _listenToConnectionBloc();
  }

  void _listenToConnectionBloc() {
    // Listen to ConnectionBloc state changes
    _connectionStateSubscription?.cancel();
    _connectionStateSubscription = _connectionBloc.stream
        .startWith(_connectionBloc.state)
        .listen(
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
    on<OpenAppSettings>(_onOpenAppSettings);
    on<WebSocketMessageReceived>(_onWebSocketMessageReceived);
    on<FrameResultReceived>(_onFrameResultReceived);
    on<ResponseErrorReceived>(_onResponseErrorReceived);

    // Special transformers
    on<FrameCaptured>(_onFrameCaptured);

    // Connection state handlers
    on<ConnectionStateChanged>(_onConnectionStateChanged);
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
      default:
        return; // Non-lifecycle events handled in separate buckets
    }
  }

  // Connection state handlers
  void _onConnectionStateChanged(
    ConnectionStateChanged event,
    Emitter<CheckInState> emit,
  ) {
    final connectionState = event.connectionState;
    emit(state.copyWith(connectionState: connectionState));
    _handleCameraControl(connectionState);
  }

  void _handleCameraControl(ConnectionState connectionState) {
    // Only manage camera based on connection readiness
    final isConnectionReady = connectionState.isConnectionReady;
    final isCameraOpening = state.cameraStatus == CameraStatus.opening;

    if (isConnectionReady && !isCameraOpening) {
      // Connection ready but camera not → Start camera if we have permission
      if (state.permissionStatus == PermissionStatus.granted) {
        add(const CheckInEvent.initializeCamera());
      }
    } else if (isConnectionReady && isCameraOpening) {
      // Both camera and connection ready → Start image stream
      _startCameraImageStream();
    }

    // Note: We DON'T stop camera when connection lost
    // User might want to keep camera preview active
    // Only stop camera on explicit user action or app lifecycle
  }

  /// Start camera image stream if conditions are met
  Future<void> _startCameraImageStream() async {
    final controller = state.cameraController;
    if (controller == null ||
        !controller.value.isInitialized ||
        controller.value.isStreamingImages) {
      return;
    }

    try {
      await controller.startImageStream((CameraImage image) {
        add(CheckInEvent.frameCaptured(image));
      });
    } catch (e) {
      // Handle error silently for now, could emit error state if needed
    }
  }

  @override
  Future<void> close() async {
    try {
      await _streamService.stopStream();

      final controller = state.cameraController;
      if (controller != null && controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
      await controller?.dispose();

      await _webSocketMessageSubscription?.cancel();
      await _connectionStateSubscription?.cancel();
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

    emit(
      state.copyWith(
        permissionStatus: status,
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
          cameraStatus: CameraStatus.opening,
          cameraController: controller,
        ),
      );

      // Initialize ConnectionBloc
      _connectionBloc.add(const ConnectionEvent.initialize());
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

    // TODO: Stop connection bloc as well - Maybe need more event from ConnectionBloc

    emit(
      state.copyWith(
        cameraController: null,
        cameraStatus: CameraStatus.initial,
      ),
    );
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

  void _onFrameCaptured(FrameCaptured event, Emitter<CheckInState> emit) {
    if (_connectionBloc.state.canStream) {
      _connectionBloc.addFrame(event.image);
    }
  }

  /// Start full flow - camera and auto-streaming
  void startFullFlow() {
    add(const CheckInEvent.initializeCamera());
  }

  /// Stop full flow - streaming and camera
  void stopFullFlow() {
    add(const CheckInEvent.stopCamera());
  }
}
