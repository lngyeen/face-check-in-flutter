import 'dart:async';

import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/domain/entities/connection_status.dart';

import '../network_connectivity_service.dart';
import '../stream_service.dart';
import '../websocket_service.dart';

import 'connection_models.dart';
import 'reconnection_strategy.dart';

/// Simple connection states for UI
enum AppConnectionState {
  disconnected, // App starting or disposed
  connecting, // Initial connection or fast retry
  connected, // Ready to use
  networkLost, // No internet
  retrying, // Background retry (show manual retry button)
  failed, // Connection failed
}

/// Unified ConnectionManager - Single stream output with auto-connection
@lazySingleton
class ConnectionManager {
  final NetworkConnectivityService _networkService;
  final WebSocketService _webSocketService;
  final StreamService _streamService;
  late final ReconnectionStrategy _reconnectionStrategy;

  // Subscriptions
  StreamSubscription? _networkSubscription;
  StreamSubscription? _webSocketSubscription;
  StreamSubscription? _reconnectionSubscription;

  // Connection state tracking
  bool _isNetworkConnected = false;
  WebSocketConnectionStatus _webSocketStatus =
      WebSocketConnectionStatus.disconnected;
  bool _isInitialized = false;
  AppConnectionState _currentState = AppConnectionState.disconnected;

  // Single stream for consumers - AppConnectionState only
  final _connectionStateController =
      StreamController<AppConnectionState>.broadcast();
  Stream<AppConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  ConnectionManager(
    this._networkService,
    this._webSocketService,
    this._streamService,
  ) {
    _reconnectionStrategy = ReconnectionStrategy();
  }

  /// Current connection state
  AppConnectionState get currentState => _currentState;

  /// Initialize all connection services and start auto-connection
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize all services
    await _networkService.initialize();
    _webSocketService.initialize();

    // Initialize reconnection strategy
    _reconnectionStrategy.initialize(
      performReconnection: _performReconnection,
      onConnectionSuccess: _handleConnectionSuccess,
      webSocketStatusStream: _webSocketService.connectionStatusStream,
    );

    // Get initial network state
    _isNetworkConnected = _networkService.isConnected;

    // Setup event listening
    _setupEventListeners();

    _isInitialized = true;

    // Auto-connect immediately
    await _evaluateAndConnect();
  }

  void _setupEventListeners() {
    // Listen to network changes
    _networkSubscription = _networkService.connectivityStream.listen(
      _handleNetworkChange,
    );

    // Listen to WebSocket status changes
    _webSocketSubscription = _webSocketService.connectionStatusStream.listen(
      _handleWebSocketStatusChange,
    );

    // Listen to reconnection state changes - store subscription for cleanup
    _reconnectionSubscription = _reconnectionStrategy.reconnectionStateStream
        .listen(_handleReconnectionStateChange);
  }

  /// Evaluate current conditions and decide on connection action
  Future<void> _evaluateAndConnect() async {
    if (!_isNetworkConnected) {
      _updateState(AppConnectionState.networkLost);
      return;
    }

    if (_webSocketStatus == WebSocketConnectionStatus.connected) {
      // Use proper connection success handler to ensure stream starts
      _handleConnectionSuccess();
      return;
    }

    await _attemptConnection();
  }

  /// Attempt WebSocket connection with proper error handling
  Future<void> _attemptConnection() async {
    try {
      _updateState(AppConnectionState.connecting);
      await _webSocketService.connect();
    } catch (e) {
      _updateState(AppConnectionState.failed);
    }
  }

  /// Handle network connectivity changes
  void _handleNetworkChange(bool isConnected) {
    final wasConnected = _isNetworkConnected;
    _isNetworkConnected = isConnected;

    if (!wasConnected && isConnected) {
      // Network restored - always try to reconnect
      _updateState(AppConnectionState.connecting);
      _handleNetworkRestored();
    } else if (wasConnected && !isConnected) {
      // Network lost
      _updateState(AppConnectionState.networkLost);
      _handleNetworkLost();
    }
  }

  /// Handle WebSocket status changes
  void _handleWebSocketStatusChange(WebSocketConnectionStatus status) {
    final previousStatus = _webSocketStatus;
    _webSocketStatus = status;

    switch (status) {
      case WebSocketConnectionStatus.connected:
        _handleConnectionSuccess();
      case WebSocketConnectionStatus.failed:
        _handleConnectionFailureFromWebSocket(status);
      case WebSocketConnectionStatus.connecting:
        _updateState(AppConnectionState.connecting);
      case WebSocketConnectionStatus.disconnected:
        if (previousStatus == WebSocketConnectionStatus.connected) {
          _handleUnexpectedDisconnection();
        }
    }
  }

  /// Handle reconnection state changes
  void _handleReconnectionStateChange(ReconnectionState reconnectionState) {
    switch (reconnectionState) {
      case ReconnectionState.connected:
        // Already handled by _handleConnectionSuccess
        break;
      case ReconnectionState.fastRetrying:
        _updateState(AppConnectionState.connecting);
      case ReconnectionState.backgroundMonitoring:
        _updateState(AppConnectionState.retrying);
      case ReconnectionState.failed:
        _updateState(AppConnectionState.failed);
    }
  }

  /// Handle successful connection
  void _handleConnectionSuccess() {
    _reconnectionStrategy.handleConnectionSuccess();
    _updateState(AppConnectionState.connected);
    _streamService.startStream();
  }

  /// Handle connection failure from WebSocket events
  void _handleConnectionFailureFromWebSocket(
    WebSocketConnectionStatus failureType,
  ) {
    if (!_isNetworkConnected) {
      _updateState(AppConnectionState.networkLost);
    } else {
      _updateState(AppConnectionState.connecting);
      _handleConnectionFailureInternal();
    }
  }

  /// Handle unexpected disconnection
  void _handleUnexpectedDisconnection() {
    _streamService.stopStream();

    if (_isNetworkConnected) {
      _updateState(AppConnectionState.connecting);
      _handleConnectionFailureInternal();
    } else {
      _updateState(AppConnectionState.networkLost);
      _handleNetworkLost();
    }
  }

  /// Update state and emit to consumers
  void _updateState(AppConnectionState state) {
    if (_currentState != state) {
      _currentState = state;
      if (!_connectionStateController.isClosed) {
        _connectionStateController.add(state);
      }
    }
  }

  /// Get current operational state
  bool get isFullyOperational =>
      _isNetworkConnected &&
      _webSocketStatus == WebSocketConnectionStatus.connected &&
      _currentState == AppConnectionState.connected;

  /// Expose WebSocket message stream
  Stream<dynamic> get messageStream => _webSocketService.messageStream;

  /// Check if streaming should be allowed based on connection state
  bool get canStream => isFullyOperational;

  /// Access to StreamService for consumers who need direct streaming control
  /// Note: Consumers should check `canStream` before using StreamService
  StreamService get streamService => _streamService;

  /// Handle network connectivity loss
  void _handleNetworkLost() {
    _reconnectionStrategy.handleNetworkLost();
    // Stop streaming when network is lost
    _streamService.stopStream();
  }

  /// Handle network connectivity restored
  void _handleNetworkRestored() {
    _reconnectionStrategy.handleNetworkRestored();
  }

  /// Handle connection failure (server down, timeout, etc.)
  void _handleConnectionFailureInternal() {
    _reconnectionStrategy.handleConnectionFailure();
  }

  /// Stop all reconnection attempts
  void _stopReconnection() {
    _reconnectionStrategy.stopReconnection();
  }

  /// Handle manual retry request from user
  Future<bool> requestManualRetry() async {
    if (!_isNetworkConnected) return false;
    return await _reconnectionStrategy.requestManualRetry();
  }

  /// Perform actual reconnection - event-driven approach
  Future<void> _performReconnection() async {
    if (!_isNetworkConnected) return;

    try {
      // Simply trigger connection - result will be handled via WebSocket status stream
      await _webSocketService.connect();
    } catch (e) {
      // Log error, but ReconnectionStrategy will handle failure via status stream
      print('Connection attempt failed: $e');
    }
  }

  /// Dispose all resources and disconnect
  void dispose() {
    _stopReconnection();
    _updateState(AppConnectionState.disconnected);

    _networkSubscription?.cancel();
    _webSocketSubscription?.cancel();
    _reconnectionSubscription?.cancel(); // Add missing cleanup
    _connectionStateController.close();

    _reconnectionStrategy.dispose();
    _networkService.dispose();
    _webSocketService.dispose();
    _streamService.dispose();
  }
}
