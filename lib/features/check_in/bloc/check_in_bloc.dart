import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:image/image.dart' as img;

import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart'
    as ps;

import '../../../core/services/image_converter.dart';
import '../../../core/services/websocket_service.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';
part 'check_in_bloc.freezed.dart';

/// Main BLoC for managing check-in feature state
/// Handles camera, WebSocket, streaming, and UI state management
@injectable
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final ps.PermissionService _permissionService;
  final WebSocketService _webSocketService;
  StreamSubscription? _webSocketStatusSubscription;
  StreamSubscription? _webSocketMessageSubscription;

  CheckInBloc(this._permissionService, this._webSocketService)
    : super(const CheckInState()) {
    // App lifecycle events
    on<AppStarted>(_onAppStarted);
    on<AppDisposed>(_onAppDisposed);

    // Camera permission events
    on<CameraPermissionRequested>(_onCameraPermissionRequested);

    // Camera lifecycle events
    on<CameraInitRequested>(_onCameraInitRequested);
    on<CameraStopped>(_onCameraStopped);

    // WebSocket events
    on<WebSocketConnectionRequested>(_onWebSocketConnectionRequested);
    on<WebSocketStatusChanged>(_onWebSocketStatusChanged);
    on<WebSocketDisconnectionRequested>(_onWebSocketDisconnectionRequested);
    on<WebSocketMessageReceived>(_onWebSocketMessageReceived);

    // Streaming events
    on<StreamingStarted>(_onStreamingStarted);
    on<StreamingStopped>(_onStreamingStopped);
    on<StreamingFailed>(_onStreamingFailed);
    on<FrameProcessed>(_onFrameProcessed);

    // UI events
    on<ErrorOccurred>(_onErrorOccurred);
    on<ErrorCleared>(_onErrorCleared);

    // Debug events
    on<DebugModeToggled>(_onDebugModeToggled);
    on<StatisticsReset>(_onStatisticsReset);

    // Backend response events
    on<RecognitionResultReceived>(_onRecognitionResultReceived);
    on<FrameResultReceived>(_onFrameResultReceived);
    on<ResponseErrorReceived>(_onResponseErrorReceived);

    // Internal events for stream processing
    on<_FrameCaptured>(_onFrameCaptured);
  }

  // App lifecycle event handlers
  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🚀 CheckInBloc: App started - initializing...');
    _webSocketService.initialize();

    _webSocketStatusSubscription?.cancel();
    _webSocketStatusSubscription = _webSocketService.connectionStatusStream
        .listen((status) {
          add(WebSocketStatusChanged(status));
        });

    _webSocketMessageSubscription?.cancel();
    _webSocketMessageSubscription = _webSocketService.messageStream.listen((
      message,
    ) {
      add(WebSocketMessageReceived(message));
    });

    emit(
      state.copyWith(
        isLoading: false,
        toastStatus: ToastStatus.showing,
        toastMessage: 'App initialized successfully',
      ),
    );
    debugPrint('✅ CheckInBloc: App initialization completed');
  }

  Future<void> _onAppDisposed(
    AppDisposed event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🔴 CheckInBloc: App disposing - cleaning up...');
    await state.cameraController?.stopImageStream();
    await state.cameraController?.dispose();
    await _webSocketStatusSubscription?.cancel();
    await _webSocketMessageSubscription?.cancel();
    _webSocketService.dispose();
    // Clean up resources
    emit(const CheckInState()); // Reset to initial state
  }

  // Camera permission handlers
  Future<void> _onCameraPermissionRequested(
    CameraPermissionRequested event,
    Emitter<CheckInState> emit,
  ) async {
    emit(state.copyWith(cameraStatus: CameraStatus.permissionRequesting));
    debugPrint('📷 CheckInBloc: Requesting camera permission...');
    final status = await _permissionService.requestCameraPermission();
    if (status == ps.PermissionStatus.granted) {
      debugPrint('✅ CheckInBloc: Camera permission granted.');
      emit(state.copyWith(permissionStatus: PermissionStatus.granted));
      add(const CheckInEvent.cameraInitRequested());
    } else {
      debugPrint('❌ CheckInBloc: Camera permission denied.');
      if (status == ps.PermissionStatus.permanentlyDenied) {
        // Open app settings if permission is permanently denied
        _permissionService.openAppSettings();
      }
      final newStatus =
          status == ps.PermissionStatus.permanentlyDenied
              ? PermissionStatus.permanentlyDenied
              : PermissionStatus.denied;
      emit(
        state.copyWith(
          permissionStatus: newStatus,
          cameraStatus: CameraStatus.permissionDenied,
        ),
      );
    }
  }

  // Camera event handlers
  Future<void> _onCameraInitRequested(
    CameraInitRequested event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📷 CheckInBloc: Camera initialization requested');

    if (state.permissionStatus != PermissionStatus.granted) {
      debugPrint(
        '❌ CheckInBloc: Camera permission not granted. Aborting initialization.',
      );
      add(const CheckInEvent.cameraPermissionRequested());
      return;
    }

    emit(
      state.copyWith(cameraStatus: CameraStatus.initializing, isLoading: true),
    );

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await controller.initialize();

      await controller.setFocusMode(FocusMode.auto);
      await controller.setExposureMode(ExposureMode.auto);

      emit(
        state.copyWith(
          cameraStatus: CameraStatus.ready,
          cameraController: controller,
          isLoading: false,
          toastStatus: ToastStatus.showing,
          toastMessage: 'Camera ready',
        ),
      );

      add(const WebSocketConnectionRequested());
    } catch (e) {
      debugPrint('❌ CheckInBloc: Camera initialization failed: $e');
      emit(
        state.copyWith(
          cameraStatus: CameraStatus.error,
          errorMessage: 'Failed to initialize camera: $e',
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onCameraStopped(
    CameraStopped event,
    Emitter<CheckInState> emit,
  ) async {
    await state.cameraController?.stopImageStream();
    await state.cameraController?.dispose();
    emit(
      state.copyWith(
        cameraController: null,
        cameraStatus: CameraStatus.initial,
      ),
    );
  }

  // WebSocket event handlers
  Future<void> _onWebSocketConnectionRequested(
    WebSocketConnectionRequested event,
    Emitter<CheckInState> emit,
  ) async {
    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.connecting,
        connectionAttempts: state.connectionAttempts + 1,
        connectionError: null,
      ),
    );
    await _webSocketService.connect();
  }

  void _onWebSocketStatusChanged(
    WebSocketStatusChanged event,
    Emitter<CheckInState> emit,
  ) {
    emit(state.copyWith(connectionStatus: event.status));
    if (event.status == ConnectionStatus.failed) {
      emit(state.copyWith(connectionError: 'Connection Failed'));
    } else if (event.status == ConnectionStatus.connected) {
      emit(state.copyWith(connectionError: null));
    }
  }

  Future<void> _onWebSocketDisconnectionRequested(
    WebSocketDisconnectionRequested event,
    Emitter<CheckInState> emit,
  ) async {
    await _webSocketService.disconnect();
  }

  void _onWebSocketMessageReceived(
    WebSocketMessageReceived event,
    Emitter<CheckInState> emit,
  ) {
    try {
      final data = json.decode(event.message) as Map<String, dynamic>;
      final type = data['type'] as String?;

      switch (type) {
        case 'frameResult':
          final facesData =
              (data['faces'] as List<dynamic>?)
                  ?.map((e) => e as Map<String, dynamic>)
                  .toList() ??
              [];
          add(FrameResultReceived(faces: facesData));
          break;
        case 'recognitionResult':
          add(RecognitionResultReceived(data));
          break;
        case 'error':
          add(
            ResponseErrorReceived(
              error: data['error'] as String? ?? 'Unknown Backend Error',
              message: data['message'] as String?,
            ),
          );
          break;
        default:
          debugPrint('Unknown WebSocket message type: $type');
      }
    } catch (e) {
      add(
        ResponseErrorReceived(
          error: 'MessageParsingError',
          message: 'Failed to parse message: ${event.message}. Error: $e',
        ),
      );
    }
  }

  // Streaming event handlers
  Future<void> _onStreamingStarted(
    StreamingStarted event,
    Emitter<CheckInState> emit,
  ) async {
    final controller = state.cameraController;

    // --- Defensive Checks ---
    if (controller == null) {
      debugPrint('❌ Cannot start stream: Camera controller is null.');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint(
        '❌ Cannot start stream: Camera controller is not initialized.',
      );
      return;
    }
    // This is the most reliable check to prevent crashes from starting an existing stream.
    if (controller.value.isStreamingImages) {
      debugPrint('⏹️ Stream already active, ignoring request.');
      // If our state is somehow out of sync, correct it.
      if (state.streamingStatus != StreamingStatus.active) {
        emit(state.copyWith(streamingStatus: StreamingStatus.active));
      }
      return;
    }
    if (state.connectionStatus != ConnectionStatus.connected) {
      emit(
        state.copyWith(
          streamingStatus: StreamingStatus.error,
          errorMessage: 'WebSocket not connected. Cannot start streaming.',
        ),
      );
      return;
    }
    // --- End of Checks ---

    try {
      debugPrint('▶️ Attempting to start image stream...');
      emit(state.copyWith(streamingStatus: StreamingStatus.starting));

      await controller.startImageStream((image) {
        // Only process frames if we are in the active state.
        // This prevents frames from being processed while stopping.
        if (state.streamingStatus == StreamingStatus.active) {
          add(_FrameCaptured(image));
        }
      });

      emit(state.copyWith(streamingStatus: StreamingStatus.active));
      debugPrint('✅ CheckInBloc: Frame streaming started successfully.');
    } catch (e, stackTrace) {
      debugPrint('❌ CheckIn-Bloc: CRITICAL - Failed to start streaming: $e');
      debugPrint(stackTrace.toString());
      add(StreamingFailed('Failed to start streaming: $e'));
    }
  }

  Future<void> _onStreamingStopped(
    StreamingStopped event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.cameraController == null ||
        !state.cameraController!.value.isStreamingImages) {
      return;
    }
    try {
      await state.cameraController!.stopImageStream();
      // The camera itself is not stopped, just the stream.
      emit(state.copyWith(streamingStatus: StreamingStatus.idle));
      debugPrint('⏹️ CheckInBloc: Frame streaming stopped.');
    } catch (e) {
      debugPrint('❌ CheckInBloc: Failed to stop streaming: $e');
      add(StreamingFailed('Failed to stop streaming: $e'));
    }
  }

  void _onStreamingFailed(StreamingFailed event, Emitter<CheckInState> emit) {
    emit(
      state.copyWith(
        streamingStatus: StreamingStatus.error,
        errorMessage: event.error,
      ),
    );
  }

  void _onFrameProcessed(FrameProcessed event, Emitter<CheckInState> emit) {
    final now = DateTime.now();
    double newFrameRate = 0.0;

    if (state.lastFrameProcessTime != null) {
      final diff = now.difference(state.lastFrameProcessTime!).inMilliseconds;
      if (diff > 0) {
        final currentFps = 1000 / diff;
        // Simple moving average to smooth out the frame rate
        newFrameRate = (state.frameRate * 0.9) + (currentFps * 0.1);
      }
    }

    emit(
      state.copyWith(
        framesProcessed: state.framesProcessed + 1,
        totalFramesProcessed: state.totalFramesProcessed + 1,
        lastFrameProcessTime: now,
        frameRate: newFrameRate,
      ),
    );
  }

  // UI event handlers
  void _onErrorOccurred(ErrorOccurred event, Emitter<CheckInState> emit) {
    debugPrint('❌ CheckInBloc: Error occurred: ${event.message}');
    emit(state.copyWith(errorMessage: event.message, isLoading: false));
  }

  void _onErrorCleared(ErrorCleared event, Emitter<CheckInState> emit) {
    emit(state.copyWith(errorMessage: null));
  }

  // Debug event handlers
  void _onDebugModeToggled(DebugModeToggled event, Emitter<CheckInState> emit) {
    final newDebugMode = !state.isDebugMode;
    debugPrint('🐛 CheckInBloc: Debug mode toggled to $newDebugMode');

    emit(
      state.copyWith(
        isDebugMode: newDebugMode,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Debug mode ${newDebugMode ? 'enabled' : 'disabled'}',
      ),
    );
  }

  void _onStatisticsReset(StatisticsReset event, Emitter<CheckInState> emit) {
    emit(
      state.copyWith(
        framesProcessed: 0,
        totalFramesProcessed: 0,
        lastFrameProcessTime: null,
        frameRate: 0.0,
        successfulRecognitions: 0,
        failedRecognitions: 0,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Statistics reset',
      ),
    );
  }

  // Backend response handlers
  void _onRecognitionResultReceived(
    RecognitionResultReceived event,
    Emitter<CheckInState> emit,
  ) {
    emit(
      state.copyWith(
        successfulRecognitions: state.successfulRecognitions + 1,
        lastRecognitionTime: DateTime.now(),
      ),
    );
  }

  void _onFrameResultReceived(
    FrameResultReceived event,
    Emitter<CheckInState> emit,
  ) {
    final faces =
        event.faces
            .map((faceData) => FaceDetectionResult.fromJson(faceData))
            .toList();

    FaceDetectionStatus newStatus;
    if (faces.isEmpty) {
      newStatus = FaceDetectionStatus.noFace;
    } else if (faces.length > 1) {
      newStatus = FaceDetectionStatus.multipleFaces;
    } else {
      newStatus = FaceDetectionStatus.faceFound;
    }

    emit(
      state.copyWith(
        detectedFaces: faces,
        faceStatus: newStatus,
        faceConfidence: faces.isNotEmpty ? faces.first.confidence : 0.0,
        lastFaceDetection: DateTime.now(),
        responseError: null, // Clear previous errors on a successful result
      ),
    );
  }

  void _onResponseErrorReceived(
    ResponseErrorReceived event,
    Emitter<CheckInState> emit,
  ) {
    emit(
      state.copyWith(
        faceStatus: FaceDetectionStatus.backendError,
        responseError: BackendError(error: event.error, message: event.message),
        failedRecognitions: state.failedRecognitions + 1,
      ),
    );
  }

  // Internal event handlers
  Future<void> _onFrameCaptured(
    _FrameCaptured event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.streamingStatus != StreamingStatus.active) return;

    // Throttle frame processing to roughly 10 FPS
    if (state.lastFrameSentTime != null &&
        DateTime.now().difference(state.lastFrameSentTime!).inMilliseconds <
            100) {
      return;
    }

    emit(state.copyWith(lastFrameSentTime: DateTime.now()));

    try {
      // Step 1: Convert CameraImage to Image and emit for debug UI
      final image = ImageConverter.convertCameraImageToImage(event.image);

      if (image == null) {
        // Handle conversion failure if necessary
        return;
      }

      if (state.isDebugMode) {
        emit(state.copyWith(debugImage: image));
      }

      // Step 2: Encode the Image to Base64
      final base64Image = ImageConverter.encodeImageToBase64(image);

      // Step 3: Send the payload
      final payload = {'type': 'processFrame', 'image': base64Image};
      _webSocketService.sendMessage(json.encode(payload));
      add(const FrameProcessed());
    } catch (e) {
      debugPrint('❌ CheckInBloc: Frame processing failed: $e');
      add(StreamingFailed('Frame processing failed: $e'));
    }
  }
}
