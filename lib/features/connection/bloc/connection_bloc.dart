import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/flavors.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';

import 'connection_event.dart';
import 'connection_state.dart';

/// ConnectionBloc - Simplified to use WebSocketService as single source of truth
/// WebSocketService now handles all connection logic including network monitoring
@lazySingleton
class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final WebSocketService _webSocketService;

  StreamSubscription? _appConnectionSubscription;
  bool _isInitialized = false;

  ConnectionBloc(this._webSocketService)
    : super(const ConnectionState(status: AppConnectionStatus.initial)) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<Connect>(_onConnect, transformer: sequential());
    on<RetryConnection>(_onRetryConnection, transformer: sequential());

    on<AppConnectionStatusChanged>(
      _onAppConnectionStatusChanged,
      transformer: restartable(),
    );

    on<Disconnect>(_onDisconnect, transformer: sequential());
  }

  Future<void> _onConnect(Connect event, Emitter<ConnectionState> emit) async {
    if (!_isInitialized) {
      _setupWebSocketListeners();
      await _webSocketService.initialize(
        url: F.baseWebSocketUrl,
        apiKey: dotenv.env['API_KEY']!,
      );
      _isInitialized = true;
    }
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
