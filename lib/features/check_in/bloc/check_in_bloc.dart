import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart'
    as ps;

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
    on<CameraStarted>(_onCameraStarted);
    on<CameraPaused>(_onCameraPaused);
    on<CameraResumed>(_onCameraResumed);
    on<CameraStopped>(_onCameraStopped);
    on<CameraStatusChanged>(_onCameraStatusChanged);
    on<CameraPreviewStarted>(_onCameraPreviewStarted);
    on<CameraPreviewStopped>(_onCameraPreviewStopped);

    // WebSocket events
    on<WebSocketConnectionRequested>(_onWebSocketConnectionRequested);
    on<WebSocketStatusChanged>(_onWebSocketStatusChanged);
    on<WebSocketDisconnectionRequested>(_onWebSocketDisconnectionRequested);
    on<WebSocketMessageReceived>(_onWebSocketMessageReceived);

    // Streaming events
    on<StreamingStarted>(_onStreamingStarted);
    on<StreamingStopped>(_onStreamingStopped);
    on<StreamingPaused>(_onStreamingPaused);
    on<StreamingResumed>(_onStreamingResumed);
    on<StreamingFailed>(_onStreamingFailed);
    on<StreamingStatusChanged>(_onStreamingStatusChanged);
    on<FrameProcessed>(_onFrameProcessed);

    // UI events
    on<ErrorOccurred>(_onErrorOccurred);
    on<ErrorCleared>(_onErrorCleared);
    on<ToastRequested>(_onToastRequested);

    // Debug events
    on<DebugModeToggled>(_onDebugModeToggled);
    on<StatisticsReset>(_onStatisticsReset);

    // Backend response events
    on<RecognitionResultReceived>(_onRecognitionResultReceived);

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

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // The permission will now be requested by the UI when needed.
      // add(const CheckInEvent.cameraPermissionRequested());
      emit(
        state.copyWith(
          isLoading: false,
          toastStatus: ToastStatus.showing,
          toastMessage: 'App initialized successfully',
        ),
      );

      debugPrint('✅ CheckInBloc: App initialization completed');
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to initialize app: $error',
        ),
      );
      debugPrint('❌ CheckInBloc: App initialization failed: $error');
    }
  }

  Future<void> _onAppDisposed(
    AppDisposed event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🔴 CheckInBloc: App disposing - cleaning up...');
    await state.cameraController?.dispose();
    await _webSocketStatusSubscription?.cancel();
    await _webSocketMessageSubscription?.cancel();
    _webSocketService.dispose();
    // Clean up resources
    emit(
      state.copyWith(
        cameraStatus: CameraStatus.initial,
        connectionStatus: ConnectionStatus.disconnected,
        streamingStatus: StreamingStatus.idle,
        isLoading: false,
        errorMessage: null,
        toastStatus: ToastStatus.none,
        toastMessage: null,
        cameraController: null,
      ),
    );
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

  // Camera event handlers (placeholders for future integration)
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

      // Find the front camera
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first, // Fallback to the first camera
      );

      final controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false, // Audio is not needed for face check-in
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await controller.initialize();

      // Set auto focus and exposure after initialization
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

  Future<void> _onCameraStarted(
    CameraStarted event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.cameraController?.value.isStreamingImages ?? false) {
      return;
    }
    await state.cameraController?.startImageStream((image) {
      add(_FrameCaptured(image));
    });
    emit(state.copyWith(cameraStatus: CameraStatus.streaming));
  }

  Future<void> _onCameraPaused(
    CameraPaused event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.cameraController?.value.isStreamingImages ?? false) {
      await state.cameraController?.stopImageStream();
    }
    await state.cameraController?.dispose();
    emit(
      state.copyWith(cameraStatus: CameraStatus.paused, cameraController: null),
    );
  }

  Future<void> _onCameraResumed(
    CameraResumed event,
    Emitter<CheckInState> emit,
  ) async {
    add(const CheckInEvent.cameraInitRequested());
  }

  Future<void> _onCameraStopped(
    CameraStopped event,
    Emitter<CheckInState> emit,
  ) async {
    await state.cameraController?.dispose();
    emit(
      state.copyWith(
        cameraController: null,
        cameraStatus: CameraStatus.initial,
      ),
    );
  }

  Future<void> _onCameraStatusChanged(
    CameraStatusChanged event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📷 CheckInBloc: Camera status changed to ${event.status}');

    emit(state.copyWith(cameraStatus: event.status));
  }

  Future<void> _onCameraPreviewStarted(
    CameraPreviewStarted event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📷 CheckInBloc: Camera preview started');
    // Placeholder - will be implemented in Story 1.2
  }

  Future<void> _onCameraPreviewStopped(
    CameraPreviewStopped event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📷 CheckInBloc: Camera preview stopped');
    // Placeholder - will be implemented in Story 1.2
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

  Future<void> _onWebSocketStatusChanged(
    WebSocketStatusChanged event,
    Emitter<CheckInState> emit,
  ) async {
    emit(state.copyWith(connectionStatus: event.status));
    if (event.status == ConnectionStatus.failed) {
      emit(state.copyWith(connectionError: 'Connection Failed'));
    } else {
      emit(state.copyWith(connectionError: null));
    }
  }

  Future<void> _onWebSocketDisconnectionRequested(
    WebSocketDisconnectionRequested event,
    Emitter<CheckInState> emit,
  ) async {
    await _webSocketService.disconnect();
  }

  Future<void> _onWebSocketMessageReceived(
    WebSocketMessageReceived event,
    Emitter<CheckInState> emit,
  ) async {
    try {
      final decodedMessage = jsonDecode(event.message) as Map<String, dynamic>;
      final facesData = decodedMessage['faces'] as List?;
      if (facesData == null) return;

      final faces =
          facesData.map((faceData) {
            final box = faceData['box'] as List<dynamic>;
            return Face(
              boundingBox: Rect.fromLTRB(
                box[0].toDouble(),
                box[1].toDouble(),
                box[2].toDouble(),
                box[3].toDouble(),
              ),
              confidence: faceData['confidence']?.toDouble() ?? 0.0,
              name: faceData['name'] as String?,
            );
          }).toList();

      emit(state.copyWith(detectedFaces: faces));
    } catch (e) {
      debugPrint('Error decoding websocket message: $e');
      add(ErrorOccurred('Error processing server response: $e'));
    }
  }

  // Streaming event handlers
  Future<void> _onStreamingStarted(
    StreamingStarted event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.streamingStatus == StreamingStatus.active) return;
    emit(state.copyWith(streamingStatus: StreamingStatus.active));
    add(const CameraStarted());
  }

  Future<void> _onStreamingStopped(
    StreamingStopped event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.streamingStatus == StreamingStatus.idle) return;
    await state.cameraController?.stopImageStream();
    emit(state.copyWith(streamingStatus: StreamingStatus.idle));
  }

  Future<void> _onStreamingPaused(
    StreamingPaused event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.streamingStatus != StreamingStatus.active) return;
    await state.cameraController?.stopImageStream();
    emit(state.copyWith(streamingStatus: StreamingStatus.paused));
  }

  Future<void> _onStreamingResumed(
    StreamingResumed event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.streamingStatus != StreamingStatus.paused) return;
    emit(state.copyWith(streamingStatus: StreamingStatus.active));
    add(const CameraStarted());
  }

  Future<void> _onStreamingFailed(
    StreamingFailed event,
    Emitter<CheckInState> emit,
  ) async {
    emit(
      state.copyWith(
        streamingStatus: StreamingStatus.error,
        errorMessage: event.error,
      ),
    );
  }

  Future<void> _onStreamingStatusChanged(
    StreamingStatusChanged event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📡 CheckInBloc: Streaming status changed to ${event.status}');

    emit(state.copyWith(streamingStatus: event.status));
  }

  Future<void> _onFrameProcessed(
    FrameProcessed event,
    Emitter<CheckInState> emit,
  ) async {
    emit(
      state.copyWith(
        framesProcessed: state.framesProcessed + 1,
        lastRecognitionTime: DateTime.now(),
      ),
    );
  }

  // UI event handlers
  Future<void> _onErrorOccurred(
    ErrorOccurred event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('❌ CheckInBloc: Error occurred: ${event.message}');

    emit(
      state.copyWith(
        errorMessage: event.message,
        isLoading: false,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Error: ${event.message}',
      ),
    );
  }

  Future<void> _onErrorCleared(
    ErrorCleared event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('✅ CheckInBloc: Error cleared');

    emit(state.copyWith(errorMessage: null));
  }

  Future<void> _onToastRequested(
    ToastRequested event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🍞 CheckInBloc: Toast requested: ${event.message}');
    emit(
      state.copyWith(
        toastStatus: ToastStatus.showing,
        toastMessage: event.message,
      ),
    );
    // Reset the status back to none so it can be triggered again.
    emit(state.copyWith(toastStatus: ToastStatus.none, toastMessage: null));
  }

  // Debug event handlers
  Future<void> _onDebugModeToggled(
    DebugModeToggled event,
    Emitter<CheckInState> emit,
  ) async {
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

  Future<void> _onStatisticsReset(
    StatisticsReset event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📊 CheckInBloc: Statistics reset');

    emit(
      state.copyWith(
        framesProcessed: 0,
        lastRecognitionTime: null,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Statistics reset',
      ),
    );
  }

  // Backend response event handlers (placeholders for future integration)
  Future<void> _onRecognitionResultReceived(
    RecognitionResultReceived event,
    Emitter<CheckInState> emit,
  ) async {
    // Implement logic to handle recognition results
    // This will be part of a future task
  }

  // New handler for captured frames
  Future<void> _onFrameCaptured(
    _FrameCaptured event,
    Emitter<CheckInState> emit,
  ) async {
    if (state.streamingStatus != StreamingStatus.active) return;

    final now = DateTime.now();
    if (state.lastFrameSentTime != null &&
        now.difference(state.lastFrameSentTime!).inMilliseconds < 66) {
      // Throttle the frame rate to ~15 FPS
      return;
    }

    final base64Image = await _convertImageToBase64(event.image);
    if (base64Image != null) {
      _webSocketService.sendMessage(base64Image);
      emit(
        state.copyWith(
          framesProcessed: state.framesProcessed + 1,
          lastFrameSentTime: now,
        ),
      );
    }
  }

  Future<String?> _convertImageToBase64(CameraImage image) async {
    try {
      // This is a compute-intensive task. Run it in a separate isolate.
      return await compute(_convertYUV420toBase64, image);
    } catch (e) {
      debugPrint('Error converting image to base64: $e');
      return null;
    }
  }

  @override
  Future<void> close() {
    state.cameraController?.dispose();
    return super.close();
  }
}

/// Top-level function to run in a separate isolate
String? _convertYUV420toBase64(CameraImage image) {
  try {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    // The image format is YUV420, which is converted to JPEG and then Base64.
    // For direct Base64 conversion of raw YUV data, we can just encode the bytes.
    // Note: The backend must be able to decode this raw YUV Base64 string.
    // If the backend expects a specific image format like JPEG,
    // an image conversion library would be needed here.
    final String base64Image = base64Encode(bytes);
    return base64Image;
  } catch (e) {
    debugPrint('Error in isolate image conversion: $e');
    return null;
  }
}
