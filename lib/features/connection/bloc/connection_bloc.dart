import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/network_connectivity_service.dart';
import 'package:face_check_in_flutter/core/services/stream_service.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/connection_error.dart';
import 'package:face_check_in_flutter/domain/entities/connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

import 'connection_event.dart';
import 'connection_state.dart';

/// ConnectionBloc - Manages all connection-related state and retry logic
/// Replaces ConnectionManager + ReconnectionStrategy with clean BLoC pattern
@lazySingleton
class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final NetworkConnectivityService _networkService;
  final WebSocketService _webSocketService;
  final StreamService _streamService;

  // External service subscriptions
  StreamSubscription? _networkSubscription;
  StreamSubscription? _webSocketSubscription;

  ConnectionBloc(
    this._networkService,
    this._webSocketService,
    this._streamService,
  ) : super(const ConnectionState()) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    // Lifecycle events - must be sequential
    on<Initialize>(_onInitialize, transformer: sequential());

    // Network events - debounce rapid changes
    on<NetworkStatusChanged>(
      _onNetworkStatusChanged,
      transformer: _debounceTransformer(const Duration(milliseconds: 500)),
    );

    // WebSocket status events - latest wins (restartable)
    on<WebSocketStatusChanged>(
      _onWebSocketStatusChanged,
      transformer: restartable(),
    );

    // Connection control events - ALL in single bucket for true sequential processing
    on<ConnectionEvent>(_onConnectionEvent, transformer: sequential());

    // Streaming control events - drop duplicates to prevent conflicts
    on<StartStreaming>(_onStartStreaming, transformer: droppable());
    on<StopStreaming>(_onStopStreaming, transformer: droppable());
    on<ConfigureStream>(_onConfigureStream, transformer: droppable());
  }

  /// Initialize connection system and start listening to external services
  Future<void> _onInitialize(
    Initialize event,
    Emitter<ConnectionState> emit,
  ) async {
    if (state.status != AppConnectionStatus.initial) return;

    // Initialize all services
    await _networkService.initialize();
    _webSocketService.initialize();

    // Get initial network state
    final isNetworkConnected = _networkService.isConnected;
    emit(state.copyWith(isNetworkConnected: isNetworkConnected));

    // Setup external service listeners
    _setupExternalListeners();

    // Start auto-connection if network is available
    if (isNetworkConnected) {
      add(const ConnectionEvent.connectionRequested());
    } else {
      emit(state.copyWith(status: AppConnectionStatus.networkLost));
    }
  }

  void _setupExternalListeners() {
    // Listen to network connectivity changes
    _networkSubscription = _networkService.connectivityStream.listen(
      (isConnected) =>
          add(ConnectionEvent.networkStatusChanged(isConnected: isConnected)),
    );

    // Listen to WebSocket status changes
    _webSocketSubscription = _webSocketService.connectionStatusStream.listen(
      (status) => add(ConnectionEvent.webSocketStatusChanged(status: status)),
    );
  }

  /// Handle network connectivity changes
  Future<void> _onNetworkStatusChanged(
    NetworkStatusChanged event,
    Emitter<ConnectionState> emit,
  ) async {
    final wasConnected = state.isNetworkConnected;
    emit(state.copyWith(isNetworkConnected: event.isConnected));

    if (wasConnected && !event.isConnected) {
      // Network lost - stop everything
      emit(state.copyWith(status: AppConnectionStatus.networkLost));
    }
  }

  /// Handle WebSocket status changes - Core of connection management
  Future<void> _onWebSocketStatusChanged(
    WebSocketStatusChanged event,
    Emitter<ConnectionState> emit,
  ) async {
    final previousWebSocketStatus = state.webSocketStatus;
    final newWebSocketStatus = event.status;
    emit(state.copyWith(webSocketStatus: newWebSocketStatus));

    switch (newWebSocketStatus) {
      case WebSocketConnectionStatus.connected:
        await _onConnectionSuccess(emit);
      case WebSocketConnectionStatus.failed:
        await _onConnectionFailure(emit);
      case WebSocketConnectionStatus.connecting:
        emit(state.copyWith(status: AppConnectionStatus.connecting));
      case WebSocketConnectionStatus.disconnected:
        await _onDisconnection(emit, previousWebSocketStatus);
    }
  }

  /// Handle disconnection scenarios with proper logic
  Future<void> _onDisconnection(
    Emitter<ConnectionState> emit,
    WebSocketConnectionStatus previousStatus,
  ) async {
    switch (previousStatus) {
      case WebSocketConnectionStatus.connected:
        // Unexpected disconnection from connected state - immediate retry
        await _onConnectionFailure(emit);
      case WebSocketConnectionStatus.connecting:
        // Connection attempt failed - treat as failure
        await _onConnectionFailure(emit);
      case WebSocketConnectionStatus.failed:
        // Already handled failure, disconnection is expected - no action needed
        break;
      case WebSocketConnectionStatus.disconnected:
        // Already disconnected, might be initial state or duplicate event - no action needed
        break;
    }
  }

  /// Handle successful connection
  Future<void> _onConnectionSuccess(Emitter<ConnectionState> emit) async {
    _safeEmit(
      state.copyWith(status: AppConnectionStatus.connected, lastError: null),
      emit,
    );
    add(const ConnectionEvent.startStreaming());
  }

  /// Handle connection failure - decide retry strategy
  Future<void> _onConnectionFailure(Emitter<ConnectionState> emit) async {
    add(const ConnectionEvent.stopStreaming());

    if (!state.isNetworkConnected) {
      emit(state.copyWith(status: AppConnectionStatus.networkLost));
      return;
    }
  }

  /// Unified connection event handler - ensures true sequential processing
  Future<void> _onConnectionEvent(
    ConnectionEvent event,
    Emitter<ConnectionState> emit,
  ) async {
    switch (event) {
      case ConnectionRequested():
        await _onConnectionRequested(event, emit);
      case ManualRetryRequested():
        await _onManualRetryRequested(event, emit);
      default:
        // Other events handled by their specific handlers
        break;
    }
  }

  /// Handle connection request (manual or automatic)
  Future<void> _onConnectionRequested(
    ConnectionRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    if (!state.isNetworkConnected) return;

    // ✅ Prevent duplicate connection attempts
    if (state.status == AppConnectionStatus.connecting ||
        state.status == AppConnectionStatus.connected) {
      return; // Already connecting or connected, ignore duplicate request
    }

    emit(state.copyWith(status: AppConnectionStatus.connecting));
    await _performConnectionAttempt(emit);
  }

  /// Handle manual retry request from user
  Future<void> _onManualRetryRequested(
    ManualRetryRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    if (!state.isNetworkConnected) return;

    // TODO: Move this logic to websocket service
    // Manual retry always starts fresh fast retry phase
    //_cancelAllTimers();
    //_startFastRetryPhase(emit);
  }

  /// Perform actual connection attempt
  Future<void> _performConnectionAttempt(Emitter<ConnectionState> emit) async {
    // Enhanced protection with both levels
    if (_webSocketService.currentStatus ==
            WebSocketConnectionStatus.connecting ||
        _webSocketService.currentStatus ==
            WebSocketConnectionStatus.connected) {
      return;
    }

    try {
      await _webSocketService.connect();
    } catch (e) {
      _recordError(
        emit,
        WebSocketError(
          'Connection attempt failed: $e',
          'connection_attempt',
          lastStatus: _webSocketService.currentStatus,
        ),
      );
      // Error also handled by WebSocketService status updates
    }
  }

  /// Record connection error
  void _recordError(Emitter<ConnectionState> emit, ConnectionError error) {
    emit(state.copyWith(lastError: error));
  }

  /// Validate if state transition is valid (includes emergency transitions)
  bool _isValidTransition(AppConnectionStatus from, AppConnectionStatus to) {
    // Emergency transitions - always allowed from any state to prevent system collapse
    if (to == AppConnectionStatus.networkLost ||
        to == AppConnectionStatus.connecting) {
      // Recovery attempts always allowed
      return true;
    }

    // Normal state machine logic
    switch (from) {
      case AppConnectionStatus.initial:
        return [
          AppConnectionStatus.connecting,
          AppConnectionStatus.networkLost,
        ].contains(to);
      case AppConnectionStatus.connecting:
        return [
          AppConnectionStatus.connected,
          AppConnectionStatus.failed,
          AppConnectionStatus.networkLost,
        ].contains(to);
      case AppConnectionStatus.connected:
        return [
          AppConnectionStatus.failed,
          AppConnectionStatus.networkLost,
        ].contains(to);
      case AppConnectionStatus.failed:
        return [
          AppConnectionStatus.fastRetrying,
          AppConnectionStatus.connecting,
          AppConnectionStatus.networkLost,
        ].contains(to);
      case AppConnectionStatus.fastRetrying:
        return [
          AppConnectionStatus.connecting,
          AppConnectionStatus.backgroundRetrying,
          AppConnectionStatus.networkLost,
        ].contains(to);
      case AppConnectionStatus.backgroundRetrying:
        return [
          AppConnectionStatus.fastRetrying,
          AppConnectionStatus.networkLost,
        ].contains(to);
      case AppConnectionStatus.networkLost:
        return [AppConnectionStatus.connecting].contains(to);
    }
  }

  /// Safe emit with state transition validation - blocks invalid transitions
  void _safeEmit(ConnectionState newState, Emitter<ConnectionState> emit) {
    if (_isValidTransition(state.status, newState.status)) {
      // Clear error on successful transitions
      final resetState = newState.copyWith(lastError: null);
      emit(resetState);
    } else {
      _recordError(
        emit,
        StateTransitionError(
          state.status.toString(),
          newState.status.toString(),
          'blocked_transition',
        ),
      );
    }
  }

  /// Custom debounce transformer for network events
  EventTransformer<T> _debounceTransformer<T>(Duration duration) {
    return (events, mapper) {
      return events.distinct().debounceTime(duration).asyncExpand(mapper);
    };
  }

  // STREAMING EVENT HANDLERS

  /// Handle start streaming request
  Future<void> _onStartStreaming(
    StartStreaming event,
    Emitter<ConnectionState> emit,
  ) async {
    // ✅ Check if already streaming - prevent duplicate start
    if (state.streamingStatus == StreamingStatus.active) {
      return; // Already streaming, ignore duplicate request
    }

    if (!state.isConnectionReady) {
      emit(state.copyWith(streamingStatus: StreamingStatus.error));
      return;
    }

    try {
      if (!_streamService.isStreaming) {
        await _streamService.startStream();
      }
      emit(state.copyWith(streamingStatus: StreamingStatus.active));
    } catch (e) {
      emit(
        state.copyWith(
          streamingStatus: StreamingStatus.error,
          lastError: StreamingError(
            'Failed to start streaming: $e',
            'start_streaming',
            lastStatus: state.streamingStatus,
          ),
        ),
      );
    }
  }

  /// Handle stop streaming request
  Future<void> _onStopStreaming(
    StopStreaming event,
    Emitter<ConnectionState> emit,
  ) async {
    if (state.streamingStatus != StreamingStatus.active) {
      return; // Already streaming, ignore duplicate request
    }

    try {
      if (_streamService.isStreaming) {
        await _streamService.stopStream();
      }
      emit(state.copyWith(streamingStatus: StreamingStatus.idle));
    } catch (e) {
      emit(
        state.copyWith(
          streamingStatus: StreamingStatus.error,
          lastError: StreamingError(
            'Failed to stop streaming: $e',
            'stop_streaming',
            lastStatus: state.streamingStatus,
          ),
        ),
      );
    }
  }

  /// Handle stream configuration
  void _onConfigureStream(
    ConfigureStream event,
    Emitter<ConnectionState> emit,
  ) {
    _streamService.setMaxFps(event.maxFps);
  }

  /// Add frame to streaming service
  void addFrame(dynamic frame) {
    if (state.canStream) {
      _streamService.addFrame(frame);
    }
  }

  /// Expose WebSocket message stream for consumers
  Stream<dynamic> get messageStream => _webSocketService.messageStream;

  @override
  Future<void> close() async {
    _networkService.dispose();
    _webSocketService.dispose();
    _streamService.dispose();

    _networkSubscription?.cancel();
    _webSocketSubscription?.cancel();

    return super.close();
  }
}
