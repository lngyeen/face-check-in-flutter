import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' as ps;

import 'package:face_check_in_flutter/domain/services/permission_service.dart'
    as ps;
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart';
import 'package:face_check_in_flutter/domain/services/camera_service.dart';

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
}

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  failed,
  retrying,
  timeout,
}

enum StreamingStatus { idle, active, error }

enum ToastStatus { none, showing }

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
  }) = _CheckInState;
}

/// Main BLoC for managing check-in feature state
/// Handles camera, WebSocket, streaming, and UI state management
@injectable
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final PermissionService _permissionService;
  final WebSocketService _webSocketService;
  final CameraService _cameraService;

  CheckInBloc(
    this._permissionService,
    this._webSocketService,
    this._cameraService,
  ) : super(const CheckInState()) {
    // Initialize WebSocket service integration
    _initializeWebSocketIntegration();

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
  }

  /// Initialize WebSocket service integration for Story 2.1
  /// Creates bridge between WebSocket service and BLoC events
  void _initializeWebSocketIntegration() {
    _webSocketService.connectionStatus.listen((status) {
      add(CheckInEvent.connectionStatusChanged(status));
    })..onError((error) {
      add(CheckInEvent.webSocketError(error.toString()));
    });

    // Listen to incoming WebSocket messages
    _webSocketService.messages.listen((message) {
      add(CheckInEvent.webSocketMessageReceived(message));
    });

    // Listen to WebSocket metrics for debugging
    _webSocketService.metrics.listen((metrics) {
      debugPrint(
        '📊 CheckInBloc: WebSocket metrics updated - ${metrics.toString()}',
      );
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
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }
      final controller = CameraController(
        cameras.first,
        ResolutionPreset.veryHigh,
        imageFormatGroup: ImageFormatGroup.bgra8888,
        enableAudio: false,
      );
      await controller.initialize();

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

    // Placeholder for WebSocket connection logic
    // This will be implemented in Story 2.1
    await Future.delayed(const Duration(milliseconds: 2000));

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.connected,
        isLoading: false,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Connected to backend (placeholder)',
      ),
    );
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

    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.disconnected,
        streamingStatus: StreamingStatus.idle,
      ),
    );
  }

  // Streaming event handlers (placeholders for future integration)
  Future<void> _onStreamingStarted(
    StreamingStarted event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📡 CheckInBloc: Frame streaming started');

    emit(state.copyWith(streamingStatus: StreamingStatus.active));
  }

  Future<void> _onStreamingStopped(
    StreamingStopped event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📡 CheckInBloc: Frame streaming stopped');

    emit(state.copyWith(streamingStatus: StreamingStatus.idle));
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
        streamingStatus: StreamingStatus.idle,
        isRetryTimerActive: false,
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

    // Handle different message types
    final messageType = event.message['type'] as String?;

    switch (messageType) {
      case 'recognition_result':
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

  @override
  Future<void> close() {
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
}
