import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'check_in_event.dart';
import 'check_in_state.dart';

/// Main BLoC for managing check-in feature state
/// Handles camera, WebSocket, streaming, and UI state management
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  CheckInBloc() : super(const CheckInState()) {
    // App lifecycle events
    on<AppStarted>(_onAppStarted);
    on<AppDisposed>(_onAppDisposed);

    // Camera events
    on<CameraInitRequested>(_onCameraInitRequested);
    on<CameraStatusChanged>(_onCameraStatusChanged);
    on<CameraPreviewStarted>(_onCameraPreviewStarted);
    on<CameraPreviewStopped>(_onCameraPreviewStopped);

    // WebSocket events
    on<ConnectionRequested>(_onConnectionRequested);
    on<ConnectionStatusChanged>(_onConnectionStatusChanged);
    on<DisconnectionRequested>(_onDisconnectionRequested);

    // Streaming events
    on<StreamingStarted>(_onStreamingStarted);
    on<StreamingStopped>(_onStreamingStopped);
    on<StreamingStatusChanged>(_onStreamingStatusChanged);
    on<FrameProcessed>(_onFrameProcessed);

    // UI events
    on<ErrorOccurred>(_onErrorOccurred);
    on<ErrorCleared>(_onErrorCleared);
    on<ToastRequested>(_onToastRequested);
    on<ToastShown>(_onToastShown);
    on<ToastDismissed>(_onToastDismissed);

    // Debug events
    on<DebugModeToggled>(_onDebugModeToggled);
    on<StatisticsReset>(_onStatisticsReset);

    // Backend response events
    on<RecognitionResultReceived>(_onRecognitionResultReceived);
  }

  // App lifecycle event handlers
  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🚀 CheckInBloc: App started - initializing...');

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Initialize app state - removed artificial delay
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
      ),
    );
  }

  // Camera event handlers (placeholders for future integration)
  Future<void> _onCameraInitRequested(
    CameraInitRequested event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('📷 CheckInBloc: Camera initialization requested');

    emit(state.copyWith(cameraStatus: CameraStatus.initial, isLoading: true));

    // Placeholder for camera initialization logic
    // This will be implemented in Story 1.2
    await Future.delayed(const Duration(milliseconds: 1000));

    emit(
      state.copyWith(
        cameraStatus: CameraStatus.ready,
        isLoading: false,
        toastStatus: ToastStatus.showing,
        toastMessage: 'Camera ready (placeholder)',
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
  }

  Future<void> _onToastShown(
    ToastShown event,
    Emitter<CheckInState> emit,
  ) async {
    // After the toast is shown, wait for a duration and then dismiss it.
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed) {
      add(const CheckInEvent.toastDismissed());
    }
  }

  Future<void> _onToastDismissed(
    ToastDismissed event,
    Emitter<CheckInState> emit,
  ) async {
    debugPrint('🍞 CheckInBloc: Toast dismissed');

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

  @override
  Future<void> close() {
    debugPrint('🔴 CheckInBloc: Closing...');
    return super.close();
  }
}
