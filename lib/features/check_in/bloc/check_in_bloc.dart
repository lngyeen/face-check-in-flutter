import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' as ps;

import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/core/services/frame_streaming_service.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart';
import 'package:face_check_in_flutter/domain/services/camera_service.dart';
import 'package:face_check_in_flutter/core/services/frame_streaming_service.dart'
    as frame_streaming;
import 'package:face_check_in_flutter/features/check_in/models/face_detection_result.dart';

part 'check_in_bloc.freezed.dart';
part 'check_in_event.dart';

// --- STATE DEFINITIONS ---
enum CameraStatus {
  initial,
  permissionRequesting,
  initializing,
  ready,
  error,
  permissionDenied,
  streaming,
  paused,
}

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  failed,
  retrying,
  timeout,
}

// Use StreamingStatus from FrameStreamingService
enum StreamingStatus { idle, active, error }

enum ToastStatus { none, showing }

// Face detection snack bar types
enum FaceDetectionNotificationType {
  none,
  faceDetectedSuccess,
  multipleFacesWarning,
  noFaceDetected,
  checkInSuccess,
  checkInFailed,
  connectionError,
  processingError,
}

@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState({
    @Default(CameraStatus.initial) CameraStatus cameraStatus,
    @Default(ps.PermissionStatus.denied) ps.PermissionStatus permissionStatus,
    @Default(ConnectionStatus.disconnected) ConnectionStatus connectionStatus,
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,
    @Default(false) bool isLoading,
    String? errorMessage,
    CameraController? cameraController,
    @Default(ToastStatus.none) ToastStatus toastStatus,
    String? toastMessage,
    @Default(false) bool isDebugMode,
    DateTime? lastRecognitionTime,
    @Default(0) int framesProcessed,
    @Default(0) int connectionAttempts,
    DateTime? lastConnectionAttempt,
    String? connectionError,
    @Default(true) bool autoConnectionEnabled,
    @Default(false) bool isRetryTimerActive,
    // Face detection state - Phase 3
    @Default([]) List<DetectedFace> detectedFaces,
    @Default(FaceDetectionStatus.none) FaceDetectionStatus faceStatus,
    @Default(0.0) double faceConfidence,
    DateTime? lastFaceDetection,
    @Default(RecognitionStatistics()) RecognitionStatistics recognitionStats,
    // Frame streaming metrics - Phase 3
    @Default(0.0) double currentFrameRate,
    DateTime? lastFrameSent,
    // Face detection notifications
    @Default(FaceDetectionNotificationType.none)
    FaceDetectionNotificationType notificationType,
    String? notificationMessage,
    @Default(false) bool shouldShowNotification,
  }) = _CheckInState;
}

/// Main BLoC for managing check-in feature state
/// Handles camera, WebSocket, streaming, and UI state management
@injectable
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  // Services
  final CameraService _cameraService;
  final PermissionService _permissionService;
  final WebSocketService _webSocketService;
  final FrameStreamingService _frameStreamingService;

  // Stream subscriptions for cleanup
  StreamSubscription<dynamic>? _messageSubscription;

  CheckInBloc(
    this._permissionService,
    this._webSocketService,
    this._cameraService,
    this._frameStreamingService,
  ) : super(const CheckInState()) {
    debugPrint('🔥 CheckInBloc: Constructor called');
    debugPrint(
      '🔥 CheckInBloc: WebSocket service instance: ${_webSocketService.hashCode}',
    );
    debugPrint(
      '🔥 CheckInBloc: WebSocket service is connected: ${_webSocketService.isConnected}',
    );

    // Initialize WebSocket service integration
    _initializeWebSocketIntegration();

    // Initialize Frame Streaming service integration
    _initializeFrameStreamingIntegration();

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

    // Legacy WebSocket events (keeping for compatibility)
    on<ConnectionRequested>(_onConnectionRequested);
    on<ConnectionStatusChanged>(_onConnectionStatusChanged);
    on<DisconnectionRequested>(_onDisconnectionRequested);

    // Enhanced WebSocket events for Story 2.1
    on<WebSocketConnectionRequested>(_onWebSocketConnectionRequested);
    on<WebSocketConnecting>(_onWebSocketConnecting);
    on<WebSocketConnected>(_onWebSocketConnected);
    on<WebSocketDisconnected>(_onWebSocketDisconnected);
    on<WebSocketConnectionFailed>(_onWebSocketConnectionFailed);
    on<WebSocketConnectionTimeout>(_onWebSocketConnectionTimeout);
    on<WebSocketRetrying>(_onWebSocketRetrying);
    on<WebSocketMessageReceived>(_onWebSocketMessageReceived);
    on<WebSocketMessageSent>(_onWebSocketMessageSent);
    on<WebSocketSendError>(_onWebSocketSendError);
    on<AutoConnectionTriggered>(_onAutoConnectionTriggered);
    on<AutoConnectionToggled>(_onAutoConnectionToggled);

    // Streaming events
    on<StreamingStartRequested>(_onStreamingStartRequested);
    on<StreamingStopRequested>(_onStreamingStopRequested);
    on<StreamingStarted>(_onStreamingStarted);
    on<StreamingStopped>(_onStreamingStopped);
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
    on<BackendResponseReceived>(_onBackendResponseReceived);

    // Face detection notification events
    on<ShowFaceDetectionNotification>(_onShowFaceDetectionNotification);
    on<ClearFaceDetectionNotification>(_onClearFaceDetectionNotification);

    // Reset events
    on<ResetAfterCheckIn>(_onResetAfterCheckIn);
  }

  /// Initialize WebSocket service integration for Story 2.1
  /// Creates bridge between WebSocket service and BLoC events
  void _initializeWebSocketIntegration() {
    debugPrint('🔥 CheckInBloc: Initializing WebSocket integration...');

    _webSocketService.connectionStatus.listen(
      (status) {
        debugPrint('🔥 CheckInBloc: Connection status changed to: $status');
        add(CheckInEvent.connectionStatusChanged(status));
      },
      onError: (error) {
        debugPrint('❌ CheckInBloc: Connection status error: $error');
        add(CheckInEvent.webSocketError(error.toString()));
      },
    );

    // Listen to incoming WebSocket messages
    debugPrint('🔥 CheckInBloc: Setting up message subscription...');
    _messageSubscription = _webSocketService.messages.listen(
      (message) {
        debugPrint(
          '🔥 CheckInBloc: Raw WebSocket message received in listener: $message',
        );
        add(CheckInEvent.webSocketMessageReceived(message));
      },
      onError: (error) {
        debugPrint('❌ CheckInBloc: WebSocket message stream error: $error');
      },
      onDone: () {
        debugPrint('📪 CheckInBloc: WebSocket message stream closed');
      },
    );

    debugPrint('🔥 CheckInBloc: WebSocket message listener setup complete');
    debugPrint(
      '🔥 CheckInBloc: Message subscription active: ${_messageSubscription != null}',
    );

    // Listen to WebSocket metrics for debugging
    _webSocketService.metrics.listen((metrics) {
      debugPrint(
        '📊 CheckInBloc: WebSocket metrics updated - ${metrics.toString()}',
      );
    });

    debugPrint(
      '🔥 CheckInBloc: WebSocket integration initialization completed',
    );
  }

  /// Convert FrameStreamingService.StreamingStatus to CheckInBloc.StreamingStatus
  StreamingStatus _mapStreamingStatus(frame_streaming.StreamingStatus status) {
    switch (status) {
      case frame_streaming.StreamingStatus.idle:
        return StreamingStatus.idle;
      case frame_streaming.StreamingStatus.starting:
      case frame_streaming.StreamingStatus.active:
        return StreamingStatus.active;
      case frame_streaming.StreamingStatus.paused:
      case frame_streaming.StreamingStatus.stopping:
      case frame_streaming.StreamingStatus.error:
        return StreamingStatus.error;
    }
  }

  /// Initialize Frame Streaming service integration
  void _initializeFrameStreamingIntegration() {
    // Listen to streaming status changes from FrameStreamingService
    _frameStreamingService.statusStream
        .listen((status) {
          final mappedStatus = _mapStreamingStatus(status);
          add(CheckInEvent.streamingStatusChanged(mappedStatus));
        })
        .onError((error) {
          debugPrint('❌ FrameStreamingService status error: $error');
          add(CheckInEvent.errorOccurred('Streaming error: $error'));
        });

    // Listen to frame metrics for debugging
    _frameStreamingService.metricsStream.listen((metrics) {
      debugPrint('📊 Frame metrics: $metrics');
      // Could trigger frame processed event here if needed
    });
  }

  // App lifecycle event handlers
  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🚀 CheckInBloc: App started - initializing...');

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

    // Stop streaming if active
    if (state.streamingStatus == StreamingStatus.active) {
      await _frameStreamingService.stopStreaming();
    }

    await state.cameraController?.dispose();
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
    final permission = await _permissionService.requestCameraPermission();
    emit(state.copyWith(permissionStatus: permission));

    if (permission.isGranted) {
      try {
        emit(
          state.copyWith(
            cameraStatus: CameraStatus.initializing,
            isLoading: true,
          ),
        );
        await _cameraService.initialize();
        emit(
          state.copyWith(
            cameraStatus: CameraStatus.ready,
            isLoading: false,
            cameraController: _cameraService.controller,
            toastStatus: ToastStatus.showing,
            toastMessage: 'Camera ready',
          ),
        );
        // Auto-connect after camera is ready
        add(const CheckInEvent.connectionRequested(isAutoConnect: true));
      } catch (e) {
        emit(
          state.copyWith(
            cameraStatus: CameraStatus.error,
            isLoading: false,
            errorMessage: e.toString(),
          ),
        );
      }
    } else {
      emit(state.copyWith(cameraStatus: CameraStatus.permissionDenied));
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
      // Use CameraService instead of direct camera initialization
      // This ensures front camera is selected correctly
      await _cameraService.initialize();

      final controller = _cameraService.controller;
      if (controller == null) {
        throw Exception('Camera controller not available after initialization');
      }

      try {
        await controller.setFocusMode(FocusMode.auto);
        await controller.setExposureMode(ExposureMode.auto);
      } on CameraException catch (e) {
        debugPrint('Error setting camera modes: $e');
        // Silently fail if modes are not supported, as camera can still function
      }

      emit(
        state.copyWith(
          cameraStatus: CameraStatus.ready,
          cameraController: controller,
          isLoading: false,
          toastStatus: ToastStatus.showing,
          toastMessage: 'Camera ready',
        ),
      );

      // Trigger auto-connection after camera becomes ready
      add(const CheckInEvent.autoConnectionTriggered());
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
      // Process image in another story
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
        cameraStatus: CameraStatus.initial,
        cameraController: null,
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

  // WebSocket event handlers (placeholders for future integration)
  Future<void> _onConnectionRequested(
    ConnectionRequested event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🌐 CheckInBloc: WebSocket connection requested');

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.connecting,
        isLoading: true,
      ),
    );

    try {
      // Use real WebSocket service instead of placeholder
      final success = await _webSocketService.connect();

      if (success) {
        emit(
          state.copyWith(
            connectionStatus: ConnectionStatus.connected,
            isLoading: false,
            toastStatus: ToastStatus.showing,
            toastMessage: 'Connected to backend',
          ),
        );
        debugPrint('✅ CheckInBloc: WebSocket connected successfully');
      } else {
        throw Exception('Failed to connect to WebSocket');
      }
    } catch (e) {
      debugPrint('❌ CheckInBloc: Connection failed: $e');
      emit(
        state.copyWith(
          connectionStatus: ConnectionStatus.failed,
          isLoading: false,
          errorMessage: 'Connection failed: $e',
          toastStatus: ToastStatus.showing,
          toastMessage: 'Connection failed',
        ),
      );
    }
  }

  Future<void> _onConnectionStatusChanged(
    ConnectionStatusChanged event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🌐 CheckInBloc: Connection status changed to ${event.status}');

    emit(state.copyWith(connectionStatus: event.status));
  }

  Future<void> _onDisconnectionRequested(
    DisconnectionRequested event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🌐 CheckInBloc: WebSocket disconnection requested');

    emit(state.copyWith(connectionStatus: ConnectionStatus.disconnected));
  }

  // Streaming event handlers
  Future<void> _onStreamingStartRequested(
    StreamingStartRequested event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📡 CheckInBloc: Frame streaming start requested');

    try {
      // Check prerequisites
      if (state.cameraStatus != CameraStatus.ready) {
        throw Exception('Camera not ready for streaming');
      }

      if (state.connectionStatus != ConnectionStatus.connected) {
        throw Exception('WebSocket not connected');
      }

      // Start streaming via service
      await _frameStreamingService.startStreaming();

      debugPrint('✅ CheckInBloc: Frame streaming start request completed');
    } catch (e) {
      debugPrint('❌ CheckInBloc: Failed to start streaming: $e');
      emit(
        state.copyWith(
          errorMessage: 'Failed to start streaming: $e',
          streamingStatus: StreamingStatus.error,
        ),
      );
    }
  }

  Future<void> _onStreamingStopRequested(
    StreamingStopRequested event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📡 CheckInBloc: Frame streaming stop requested');

    try {
      // Stop streaming via service
      await _frameStreamingService.stopStreaming();

      debugPrint('✅ CheckInBloc: Frame streaming stop request completed');
    } catch (e) {
      debugPrint('❌ CheckInBloc: Failed to stop streaming: $e');
      emit(state.copyWith(errorMessage: 'Failed to stop streaming: $e'));
    }
  }

  Future<void> _onStreamingStarted(
    StreamingStarted event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📡 CheckInBloc: Frame streaming started');
    emit(
      state.copyWith(
        streamingStatus: StreamingStatus.active,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Frame streaming started',
      ),
    );
  }

  Future<void> _onStreamingStopped(
    StreamingStopped event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📡 CheckInBloc: Frame streaming stopped');
    emit(
      state.copyWith(
        streamingStatus: StreamingStatus.idle,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Frame streaming stopped',
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
    // Update frame processing metrics
    emit(state.copyWith(framesProcessed: state.framesProcessed + 1));
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
    debugPrint(
      '🎯 CheckInBloc: Recognition result received - Success: ${event.success}',
    );

    final message =
        event.success
            ? 'Welcome ${event.employeeName ?? 'Employee'}!'
            : event.message;

    emit(
      state.copyWith(
        lastRecognitionTime: DateTime.now(),
        toastStatus: ToastStatus.showing,
        toastMessage: message,
      ),
    );
  }

  Future<void> _onBackendResponseReceived(
    BackendResponseReceived event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint(
      '🎯 CheckInBloc: Backend response received - ${event.result.faces.length} faces, status: ${event.result.status}',
    );
    debugPrint('   Event: $event');

    final result = event.result;

    // Update state with detection results
    emit(
      state.copyWith(
        detectedFaces: result.faces,
        faceStatus: result.status,
        lastFaceDetection: result.timestamp,
        recognitionStats: state.recognitionStats.copyWith(
          totalFramesProcessed: state.recognitionStats.totalFramesProcessed + 1,
          totalFacesDetected:
              state.recognitionStats.totalFacesDetected + result.faces.length,
          lastRecognitionTime: result.timestamp,
        ),
      ),
    );

    // Generate appropriate notification based on face detection result
    _processFaceDetectionResult(result);
  }

  // Process face detection result and show appropriate notification
  void _processFaceDetectionResult(FaceDetectionResult result) {
    debugPrint(
      '🎯 CheckInBloc: _processFaceDetectionResult called with ${result.faces.length} faces, status: ${result.status}',
    );

    String message;
    FaceDetectionNotificationType notificationType;

    switch (result.status) {
      case FaceDetectionStatus.none:
        if (result.faces.isEmpty) {
          notificationType = FaceDetectionNotificationType.noFaceDetected;
          message =
              '👤 Không phát hiện khuôn mặt - Hãy di chuyển vào khung hình';
        } else {
          notificationType = FaceDetectionNotificationType.faceDetectedSuccess;
          message = '✅ Phát hiện khuôn mặt thành công!';
        }
        break;
      case FaceDetectionStatus.faceFound:
        notificationType = FaceDetectionNotificationType.faceDetectedSuccess;
        message = '✅ Đã phát hiện khuôn mặt - Đang xử lý...';
        break;
      case FaceDetectionStatus.multipleFaces:
        notificationType = FaceDetectionNotificationType.multipleFacesWarning;
        message =
            '⚠️ Phát hiện nhiều khuôn mặt - Chỉ một người trong khung hình';
        break;
      case FaceDetectionStatus.detecting:
        notificationType = FaceDetectionNotificationType.faceDetectedSuccess;
        message = '🔍 Đang phát hiện khuôn mặt...';
        break;
      case FaceDetectionStatus.error:
        notificationType = FaceDetectionNotificationType.processingError;
        message = '❌ Lỗi xử lý hình ảnh - Vui lòng thử lại';
        break;
      case FaceDetectionStatus.noFace:
        notificationType = FaceDetectionNotificationType.noFaceDetected;
        message = '👤 Không tìm thấy khuôn mặt - Hãy di chuyển gần camera hơn';
        break;
    }

    debugPrint(
      '🎯 CheckInBloc: Determined notification type: ${notificationType.name}',
    );
    debugPrint('🎯 CheckInBloc: Determined message: $message');

    // Check if any face has high confidence for potential check-in
    if (result.faces.isNotEmpty) {
      final highConfidenceFaces =
          result.faces.where((face) => face.confidence > 0.8).toList();
      if (highConfidenceFaces.isNotEmpty) {
        if (highConfidenceFaces.any((face) => face.isRecognized)) {
          notificationType = FaceDetectionNotificationType.checkInSuccess;
          final recognizedFace = highConfidenceFaces.firstWhere(
            (face) => face.isRecognized,
          );
          message =
              '🎉 Check-in thành công! Chào ${recognizedFace.employeeName ?? 'bạn'}';

          // Immediately stop streaming on successful check-in
          debugPrint(
            '🔄 CheckInBloc: Check-in successful, stopping streaming immediately',
          );
          if (state.streamingStatus == StreamingStatus.active) {
            _frameStreamingService.stopStreaming();
          }

          // Schedule auto-reset after showing success message
          debugPrint(
            '🔄 CheckInBloc: Check-in successful, scheduling auto-reset in 3 seconds',
          );
          Timer(const Duration(seconds: 3), () {
            if (!isClosed) {
              add(const CheckInEvent.resetAfterCheckIn());
            }
          });
        } else {
          notificationType = FaceDetectionNotificationType.faceDetectedSuccess;
          message =
              '✅ Khuôn mặt rõ ràng (${(highConfidenceFaces.first.confidence * 100).toStringAsFixed(1)}%) - Đang nhận diện...';
        }
        debugPrint(
          '🎯 CheckInBloc: Updated notification for high confidence faces: ${notificationType.name}',
        );
        debugPrint('🎯 CheckInBloc: Updated message: $message');
      }
    }

    // Show notification
    debugPrint(
      '🎯 CheckInBloc: About to add showFaceDetectionNotification event',
    );
    add(
      CheckInEvent.showFaceDetectionNotification(
        type: notificationType,
        message: message,
      ),
    );
    debugPrint(
      '🎯 CheckInBloc: showFaceDetectionNotification event added successfully',
    );
  }

  // Enhanced WebSocket event handlers for Story 2.1
  Future<void> _onWebSocketConnectionRequested(
    WebSocketConnectionRequested event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🌐 CheckInBloc: Enhanced WebSocket connection requested');

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.connecting,
        connectionAttempts: 0,
        lastConnectionAttempt: DateTime.now(),
        connectionError: null,
        isRetryTimerActive: false,
      ),
    );

    // Use the WebSocket service to connect
    final success = await _webSocketService.connect();

    if (!success) {
      // Connection will be handled by WebSocket service status updates
      debugPrint('❌ CheckInBloc: WebSocket connection failed');
    }
  }

  Future<void> _onWebSocketConnecting(
    WebSocketConnecting event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🌐 CheckInBloc: WebSocket connecting...');

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.connecting,
        lastConnectionAttempt: DateTime.now(),
      ),
    );
  }

  Future<void> _onWebSocketConnected(
    WebSocketConnected event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('✅ CheckInBloc: WebSocket connected successfully');

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.connected,
        connectionError: null,
        isRetryTimerActive: false,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Connected to backend',
      ),
    );
  }

  Future<void> _onWebSocketDisconnected(
    WebSocketDisconnected event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🔴 CheckInBloc: WebSocket disconnected');

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.disconnected,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Disconnected from backend',
      ),
    );
  }

  Future<void> _onWebSocketConnectionFailed(
    WebSocketConnectionFailed event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('❌ CheckInBloc: WebSocket connection failed: ${event.error}');

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.failed,
        connectionError: event.error,
        connectionAttempts: state.connectionAttempts + 1,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Connection failed: ${event.error}',
      ),
    );
  }

  Future<void> _onWebSocketConnectionTimeout(
    WebSocketConnectionTimeout event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('⏰ CheckInBloc: WebSocket connection timeout');

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.timeout,
        connectionError: 'Connection timeout',
        connectionAttempts: state.connectionAttempts + 1,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Connection timeout',
      ),
    );
  }

  Future<void> _onWebSocketRetrying(
    WebSocketRetrying event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint(
      '🔄 CheckInBloc: WebSocket retrying connection (attempt ${event.attempt})',
    );

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.retrying,
        connectionAttempts: event.attempt,
        isRetryTimerActive: true,
        lastConnectionAttempt: DateTime.now(),
        toastStatus: ToastStatus.showing,
        toastMessage: 'Retrying connection (${event.attempt})...',
      ),
    );
  }

  Future<void> _onWebSocketMessageReceived(
    WebSocketMessageReceived event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint(
      '📥 CheckInBloc: WebSocket message received: ${event.message['type']}',
    );
    debugPrint('📥 CheckInBloc: Full message: ${event.message}');

    // Handle different message types
    final messageType = event.message['type'] as String?;

    switch (messageType) {
      case 'frameResult':
        debugPrint('📥 CheckInBloc: Processing frameResult message');
        // Parse face detection result from backend - Phase 3
        await _parseAndProcessFrameResult(event.message);
        break;

      case 'recognition_result':
        debugPrint('📥 CheckInBloc: Processing recognition_result message');
        // Legacy recognition result support
        add(
          CheckInEvent.recognitionResultReceived(
            success: event.message['success'] ?? false,
            message: event.message['message'] ?? '',
            employeeName: event.message['employee_name'],
          ),
        );
        break;

      case 'pong':
        // Handle heartbeat response
        debugPrint('💓 CheckInBloc: Heartbeat response received');
        break;

      default:
        debugPrint('❓ CheckInBloc: Unknown message type: $messageType');
    }
  }

  /// Parse and process frame result from backend - Phase 3
  Future<void> _parseAndProcessFrameResult(Map<String, dynamic> message) async {
    debugPrint('🔍 CheckInBloc: Starting to parse frameResult...');

    try {
      // Extract data payload
      final data = message['data'] as Map<String, dynamic>?;
      if (data == null) {
        debugPrint('❌ CheckInBloc: No data in frameResult message');
        return;
      }

      debugPrint('🔍 CheckInBloc: Extracted data: $data');

      // Parse timestamp
      final timestampStr = data['timestamp'] as String?;
      final timestamp =
          timestampStr != null
              ? DateTime.tryParse(timestampStr) ?? DateTime.now()
              : DateTime.now();

      debugPrint('🔍 CheckInBloc: Parsed timestamp: $timestamp');

      // Parse faces array
      final facesJson = data['faces'] as List<dynamic>? ?? [];
      debugPrint('🔍 CheckInBloc: Raw faces data: $facesJson');

      final faces =
          facesJson.map((face) {
            final faceMap = face as Map<String, dynamic>;
            return DetectedFace(
              faceId: faceMap['faceId'] as String? ?? '',
              box:
                  (faceMap['box'] as List<dynamic>?)
                      ?.map((e) => (e as num).toDouble())
                      .toList() ??
                  [0, 0, 0, 0],
              confidence: (faceMap['confidence'] as num?)?.toDouble() ?? 0.0,
              isRecognized: faceMap['isRecognized'] as bool? ?? false,
              personId: faceMap['personId'] as String?,
              employeeName: faceMap['employeeName'] as String?,
            );
          }).toList();

      debugPrint('🔍 CheckInBloc: Parsed faces: ${faces.length} faces');

      // Parse status
      final statusStr = data['status'] as String? ?? 'none';
      final status = _parseDetectionStatus(statusStr);

      debugPrint('🔍 CheckInBloc: Parsed status: $status');

      // Create face detection result
      final result = FaceDetectionResult(
        frameId: data['frameId'] as String? ?? '',
        timestamp: timestamp,
        faces: faces,
        status: status,
      );

      debugPrint(
        '🔍 CheckInBloc: Created FaceDetectionResult, adding backendResponseReceived event',
      );

      // Add backend response received event
      add(CheckInEvent.backendResponseReceived(result));

      debugPrint(
        '✅ CheckInBloc: Parsed frameResult - ${faces.length} faces, status: $status',
      );
    } catch (e) {
      debugPrint('❌ CheckInBloc: Error parsing frameResult: $e');
      add(CheckInEvent.errorOccurred('Failed to parse backend response: $e'));
    }
  }

  /// Parse face detection status from string
  FaceDetectionStatus _parseDetectionStatus(String status) {
    switch (status.toLowerCase()) {
      case 'face_found':
        return FaceDetectionStatus.faceFound;
      case 'multiple_faces':
        return FaceDetectionStatus.multipleFaces;
      case 'no_face':
        return FaceDetectionStatus.noFace;
      case 'detecting':
        return FaceDetectionStatus.detecting;
      case 'error':
        return FaceDetectionStatus.error;
      default:
        return FaceDetectionStatus.none;
    }
  }

  Future<void> _onWebSocketMessageSent(
    WebSocketMessageSent event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint(
      '📤 CheckInBloc: WebSocket message sent: ${event.message['type']}',
    );

    // Could update UI to show message send status if needed
    // For now, just log
  }

  Future<void> _onWebSocketSendError(
    WebSocketSendError event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('❌ CheckInBloc: WebSocket send error: ${event.error}');

    emit(
      state.copyWith(
        toastStatus: ToastStatus.showing,
        toastMessage: 'Send error: ${event.error}',
      ),
    );
  }

  Future<void> _onAutoConnectionTriggered(
    AutoConnectionTriggered event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🔄 CheckInBloc: Auto-connection triggered');

    // Only auto-connect if camera is ready and we're not already connected
    if (state.cameraStatus == CameraStatus.ready &&
        state.connectionStatus == ConnectionStatus.disconnected &&
        state.autoConnectionEnabled) {
      debugPrint('✅ CheckInBloc: Camera ready, starting auto-connection');
      add(const CheckInEvent.webSocketConnectionRequested());
    }
  }

  Future<void> _onAutoConnectionToggled(
    AutoConnectionToggled event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🔄 CheckInBloc: Auto-connection toggled: ${event.enabled}');

    emit(
      state.copyWith(
        autoConnectionEnabled: event.enabled,
        toastStatus: ToastStatus.showing,
        toastMessage:
            'Auto-connection ${event.enabled ? 'enabled' : 'disabled'}',
      ),
    );
  }

  // Face detection notification handlers
  Future<void> _onShowFaceDetectionNotification(
    ShowFaceDetectionNotification event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint(
      '📢 CheckInBloc: Showing notification - ${event.type.name}: ${event.message}',
    );
    debugPrint(
      '📢 CheckInBloc: Current state shouldShowNotification: ${state.shouldShowNotification}',
    );

    emit(
      state.copyWith(
        notificationType: event.type,
        notificationMessage: event.message,
        shouldShowNotification: true,
      ),
    );

    debugPrint(
      '📢 CheckInBloc: State updated - shouldShowNotification: true, type: ${event.type.name}',
    );

    // Auto-clear notification after 3 seconds using Timer
    Timer(const Duration(seconds: 3), () {
      if (!isClosed) {
        debugPrint(
          '📢 CheckInBloc: Auto-clearing notification after 3 seconds',
        );
        add(const CheckInEvent.clearFaceDetectionNotification());
      }
    });
  }

  Future<void> _onClearFaceDetectionNotification(
    ClearFaceDetectionNotification event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🔕 CheckInBloc: Clearing notification');
    debugPrint(
      '🔕 CheckInBloc: Previous state - shouldShowNotification: ${state.shouldShowNotification}',
    );

    emit(
      state.copyWith(
        notificationType: FaceDetectionNotificationType.none,
        notificationMessage: null,
        shouldShowNotification: false,
      ),
    );

    debugPrint('🔕 CheckInBloc: State updated - shouldShowNotification: false');
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    state.cameraController?.dispose();
    _webSocketService.dispose();
    return super.close();
  }

  // Helper method to get color based on camera status for UI
  Color getCameraStatusColor(CameraStatus status) {
    switch (status) {
      case CameraStatus.initial:
        return Colors.grey;
      case CameraStatus.permissionRequesting:
        return Colors.blue;
      case CameraStatus.initializing:
        return Colors.orange;
      case CameraStatus.ready:
        return Colors.green;
      case CameraStatus.streaming:
        return Colors.purple;
      case CameraStatus.paused:
        return Colors.amber;
      case CameraStatus.error:
      case CameraStatus.permissionDenied:
        return Colors.red;
    }
  }

  // Helper method to get color based on connection status for UI
  Color getConnectionStatusColor(ConnectionStatus status) {
    // Implement the logic to return the appropriate color based on the connection status
    // This is a placeholder and should be implemented based on your specific requirements
    return Colors.grey; // Placeholder return, actual implementation needed
  }

  /// Reset system after successful check-in
  Future<void> _onResetAfterCheckIn(
    ResetAfterCheckIn event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🔄 CheckInBloc: Resetting system after successful check-in');

    try {
      // Show reset notification
      emit(
        state.copyWith(
          toastStatus: ToastStatus.showing,
          toastMessage: '🔄 Đang reset hệ thống để quét tiếp...',
        ),
      );

      // Stop streaming first
      if (state.streamingStatus == StreamingStatus.active) {
        debugPrint('🛑 CheckInBloc: Stopping frame streaming...');
        await _frameStreamingService.stopStreaming();
      }

      // Reset relevant state
      emit(
        state.copyWith(
          streamingStatus: StreamingStatus.idle,
          detectedFaces: [],
          faceStatus: FaceDetectionStatus.none,
          faceConfidence: 0.0,
          lastFaceDetection: null,
          notificationType: FaceDetectionNotificationType.none,
          notificationMessage: null,
          shouldShowNotification: false,
          framesProcessed: 0,
          lastFrameSent: null,
          currentFrameRate: 0.0,
          toastStatus: ToastStatus.showing,
          toastMessage: '✅ Hệ thống đã reset - Sẵn sàng quét lại',
        ),
      );

      debugPrint('✅ CheckInBloc: System reset completed');

      // Auto-restart streaming after a brief pause
      Timer(const Duration(seconds: 2), () {
        if (!isClosed && state.connectionStatus == ConnectionStatus.connected) {
          debugPrint('🔄 CheckInBloc: Auto-restarting streaming after reset');
          add(const CheckInEvent.streamingStartRequested());
        }
      });
    } catch (error) {
      debugPrint('❌ CheckInBloc: Error during reset: $error');
      emit(
        state.copyWith(
          errorMessage: 'Reset failed: $error',
          toastStatus: ToastStatus.showing,
          toastMessage: '❌ Reset thất bại - Vui lòng thử lại',
        ),
      );
    }
  }
}

/// Extension to provide display text for CameraStatus enum
extension CameraStatusDisplay on CameraStatus {
  String get displayText {
    switch (this) {
      case CameraStatus.initial:
        return 'Initial';
      case CameraStatus.permissionRequesting:
        return 'Requesting Permission...';
      case CameraStatus.initializing:
        return 'Initializing...';
      case CameraStatus.ready:
        return 'Ready';
      case CameraStatus.streaming:
        return 'Streaming';
      case CameraStatus.paused:
        return 'Paused';
      case CameraStatus.error:
        return 'Error';
      case CameraStatus.permissionDenied:
        return 'Permission Denied';
    }
  }

  Color get displayColor {
    switch (this) {
      case CameraStatus.initial:
      case CameraStatus.permissionDenied:
        return Colors.grey;
      case CameraStatus.permissionRequesting:
      case CameraStatus.initializing:
        return Colors.orange;
      case CameraStatus.ready:
        return Colors.green;
      case CameraStatus.streaming:
        return Colors.blue;
      case CameraStatus.paused:
        return Colors.yellow;
      case CameraStatus.error:
        return Colors.red;
    }
  }
}

/// Extension to provide display text for ConnectionStatus enum
extension ConnectionStatusDisplay on ConnectionStatus {
  String get displayText {
    switch (this) {
      case ConnectionStatus.disconnected:
        return 'Disconnected';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.failed:
        return 'Connection Failed';
      case ConnectionStatus.retrying:
        return 'Retrying...';
      case ConnectionStatus.timeout:
        return 'Connection Timeout';
    }
  }

  Color get displayColor {
    switch (this) {
      case ConnectionStatus.disconnected:
        return Colors.grey;
      case ConnectionStatus.connecting:
      case ConnectionStatus.retrying:
        return Colors.orange;
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.failed:
      case ConnectionStatus.timeout:
        return Colors.red;
    }
  }
}

/// Extension to provide display text for StreamingStatus enum
extension StreamingStatusDisplay on StreamingStatus {
  String get displayText {
    switch (this) {
      case StreamingStatus.idle:
        return 'Idle';
      case StreamingStatus.active:
        return 'Active';
      case StreamingStatus.error:
        return 'Error';
    }
  }

  Color get displayColor {
    switch (this) {
      case StreamingStatus.idle:
        return Colors.grey;
      case StreamingStatus.active:
        return Colors.green;
      case StreamingStatus.error:
        return Colors.red;
    }
  }
}

/// Extension to provide display properties for FaceDetectionNotificationType
extension FaceDetectionNotificationDisplay on FaceDetectionNotificationType {
  Color get backgroundColor {
    switch (this) {
      case FaceDetectionNotificationType.none:
        return Colors.grey;
      case FaceDetectionNotificationType.faceDetectedSuccess:
      case FaceDetectionNotificationType.checkInSuccess:
        return Colors.green;
      case FaceDetectionNotificationType.multipleFacesWarning:
        return Colors.orange;
      case FaceDetectionNotificationType.noFaceDetected:
        return Colors.blue;
      case FaceDetectionNotificationType.checkInFailed:
      case FaceDetectionNotificationType.connectionError:
      case FaceDetectionNotificationType.processingError:
        return Colors.red;
    }
  }

  Color get textColor {
    switch (this) {
      case FaceDetectionNotificationType.none:
        return Colors.black87;
      case FaceDetectionNotificationType.faceDetectedSuccess:
      case FaceDetectionNotificationType.checkInSuccess:
      case FaceDetectionNotificationType.multipleFacesWarning:
      case FaceDetectionNotificationType.noFaceDetected:
      case FaceDetectionNotificationType.checkInFailed:
      case FaceDetectionNotificationType.connectionError:
      case FaceDetectionNotificationType.processingError:
        return Colors.white;
    }
  }

  IconData get icon {
    switch (this) {
      case FaceDetectionNotificationType.none:
        return Icons.info;
      case FaceDetectionNotificationType.faceDetectedSuccess:
        return Icons.face;
      case FaceDetectionNotificationType.checkInSuccess:
        return Icons.check_circle;
      case FaceDetectionNotificationType.multipleFacesWarning:
        return Icons.warning;
      case FaceDetectionNotificationType.noFaceDetected:
        return Icons.person_search;
      case FaceDetectionNotificationType.checkInFailed:
        return Icons.error;
      case FaceDetectionNotificationType.connectionError:
        return Icons.wifi_off;
      case FaceDetectionNotificationType.processingError:
        return Icons.error_outline;
    }
  }

  Duration get duration {
    switch (this) {
      case FaceDetectionNotificationType.none:
        return const Duration(seconds: 1);
      case FaceDetectionNotificationType.faceDetectedSuccess:
      case FaceDetectionNotificationType.noFaceDetected:
        return const Duration(seconds: 2);
      case FaceDetectionNotificationType.multipleFacesWarning:
      case FaceDetectionNotificationType.processingError:
        return const Duration(seconds: 3);
      case FaceDetectionNotificationType.checkInSuccess:
      case FaceDetectionNotificationType.checkInFailed:
      case FaceDetectionNotificationType.connectionError:
        return const Duration(seconds: 4);
    }
  }
}
