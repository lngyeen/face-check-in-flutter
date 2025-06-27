import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/stream_service.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/flavors.dart';

import 'connection_event.dart';
import 'connection_state.dart';

/// ConnectionBloc - Simplified to use WebSocketService as single source of truth
/// WebSocketService now handles all connection logic including network monitoring
@lazySingleton
class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final WebSocketService _webSocketService;
  final StreamService _streamService;

  // Service subscriptions
  StreamSubscription? _appConnectionSubscription;

  ConnectionBloc(this._webSocketService, this._streamService)
    : super(
        ConnectionState(status: _webSocketService.currentAppConnectionStatus),
      ) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    // Lifecycle events - must be sequential
    on<Initialize>(_onInitialize, transformer: sequential());
    on<RetryConnection>(_onRetryConnection, transformer: sequential());

    // App connection status events - computed from WebSocketService
    on<AppConnectionStatusChanged>(
      _onAppConnectionStatusChanged,
      transformer: restartable(),
    );

    // Streaming control events - drop duplicates to prevent conflicts
    on<StartStreaming>(_onStartStreaming, transformer: droppable());
    on<StopStreaming>(_onStopStreaming, transformer: droppable());
    on<ConfigureStream>(_onConfigureStream, transformer: droppable());
  }

  /// Initialize connection system - much simpler now
  Future<void> _onInitialize(
    Initialize event,
    Emitter<ConnectionState> emit,
  ) async {
    _setupWebSocketListeners();

    await _webSocketService.initialize(url: F.baseWebSocketUrl);

    _webSocketService.connect();
  }

  /// Handle manual retry connection request
  Future<void> _onRetryConnection(
    RetryConnection event,
    Emitter<ConnectionState> emit,
  ) async {
    // Force reconnect by calling WebSocket service connect
    await _webSocketService.connect();
  }

  void _setupWebSocketListeners() {
    _appConnectionSubscription?.cancel();
    _appConnectionSubscription = _webSocketService.appConnectionStatusStream
        .listen(
          (status) =>
              add(ConnectionEvent.appConnectionStatusChanged(status: status)),
        );
  }

  /// Handle computed app connection status changes - main logic
  Future<void> _onAppConnectionStatusChanged(
    AppConnectionStatusChanged event,
    Emitter<ConnectionState> emit,
  ) async {
    final newStatus = event.status;
    emit(state.copyWith(status: newStatus));

    switch (newStatus) {
      case AppConnectionStatus.connected:
        add(const ConnectionEvent.startStreaming());
      case AppConnectionStatus.networkLost:
      case AppConnectionStatus.failed:
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        add(const ConnectionEvent.stopStreaming());

      case AppConnectionStatus.connecting:
      case AppConnectionStatus.initial:
        break;
    }
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
      emit(state.copyWith(streamingStatus: StreamingStatus.error));
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
      emit(state.copyWith(streamingStatus: StreamingStatus.error));
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
    if (state.isActiveStreaming) {
      _streamService.addFrame(frame);
    }
  }

  /// Expose WebSocket message stream for consumers
  Stream<dynamic> get messageStream => _webSocketService.messageStream;

  @override
  Future<void> close() async {
    _webSocketService.dispose();
    _streamService.dispose();

    _appConnectionSubscription?.cancel();

    return super.close();
  }
}
