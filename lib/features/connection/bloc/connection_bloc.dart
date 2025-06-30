import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/flavors.dart';

import 'connection_event.dart';
import 'connection_state.dart';

/// ConnectionBloc - Simplified to use WebSocketService as single source of truth
/// WebSocketService now handles all connection logic including network monitoring
@lazySingleton
class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final WebSocketService _webSocketService;

  StreamSubscription? _appConnectionSubscription;

  ConnectionBloc(this._webSocketService)
    : super(
        ConnectionState(status: _webSocketService.currentAppConnectionStatus),
      ) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<Initialize>(_onInitialize, transformer: sequential());
    on<RetryConnection>(_onRetryConnection, transformer: sequential());

    on<AppConnectionStatusChanged>(
      _onAppConnectionStatusChanged,
      transformer: restartable(),
    );

    on<Disconnect>(_onDisconnect, transformer: sequential());
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<ConnectionState> emit,
  ) async {
    _setupWebSocketListeners();
    await _webSocketService.initialize(url: F.baseWebSocketUrl);
    await _webSocketService.connect();
  }

  Future<void> _onRetryConnection(
    RetryConnection event,
    Emitter<ConnectionState> emit,
  ) async {
    await _webSocketService.connect();
  }

  Future<void> _onDisconnect(
    Disconnect event,
    Emitter<ConnectionState> emit,
  ) async {
    await _webSocketService.disconnect();
  }

  void _setupWebSocketListeners() {
    _appConnectionSubscription?.cancel();
    _appConnectionSubscription = _webSocketService.appConnectionStatusStream
        .listen(
          (status) =>
              add(ConnectionEvent.appConnectionStatusChanged(status: status)),
        );
  }

  Future<void> _onAppConnectionStatusChanged(
    AppConnectionStatusChanged event,
    Emitter<ConnectionState> emit,
  ) async {
    final newStatus = event.status;
    emit(state.copyWith(status: newStatus));
  }

  Stream<dynamic> get messageStream => _webSocketService.messageStream;

  @override
  Future<void> close() async {
    _webSocketService.dispose();
    _appConnectionSubscription?.cancel();

    return super.close();
  }
}
