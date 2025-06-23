import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/domain/entities/connection_status.dart';

import 'network_connectivity_service.dart';
import 'reconnection_manager.dart';
import 'stream_service.dart';
import 'websocket_service.dart';

// Export commonly used types for consumers

/// Comprehensive connection status for UI banner system
enum ConnectionState {
  initializing, // App starting up
  connecting, // Attempting connection
  operational, // Ready for streaming
  disconnected, // User disconnected
  networkLost, // No network available
  reconnecting, // Auto-reconnecting
  failed, // Connection failed
}

/// Single source of truth for connection status - Perfect for UI banners
class ConnectionSummary {
  final bool networkConnected;
  final ConnectionStatus webSocketStatus;
  final bool isOperational;
  final ConnectionState currentState;

  const ConnectionSummary({
    required this.networkConnected,
    required this.webSocketStatus,
    required this.isOperational,
    required this.currentState,
  });

  /// Determine if banner should be shown
  bool get shouldShowBanner => !isOperational;

  /// Get banner color based on state
  String get bannerColor {
    switch (currentState) {
      case ConnectionState.operational:
        return 'green';
      case ConnectionState.connecting:
      case ConnectionState.reconnecting:
        return 'orange';
      case ConnectionState.networkLost:
      case ConnectionState.failed:
      case ConnectionState.disconnected:
        return 'red';
      case ConnectionState.initializing:
        return 'blue';
    }
  }

  /// Get user-friendly status message for banner
  String get bannerMessage {
    switch (currentState) {
      case ConnectionState.initializing:
        return 'Initializing connection...';
      case ConnectionState.connecting:
        return 'Connecting to server...';
      case ConnectionState.operational:
        return 'Connected and ready';
      case ConnectionState.disconnected:
        return 'Disconnected';
      case ConnectionState.networkLost:
        return 'No internet connection';
      case ConnectionState.reconnecting:
        return 'Reconnecting...';
      case ConnectionState.failed:
        return 'Connection failed';
    }
  }
}

/// Unified ConnectionManager - Single stream output
@singleton
class ConnectionManager {
  final NetworkConnectivityService _networkService;
  final ReconnectionManager _reconnectionManager;
  final WebSocketService _webSocketService;
  final StreamService _streamService;

  // Subscriptions
  StreamSubscription? _networkSubscription;
  StreamSubscription? _webSocketSubscription;
  StreamSubscription? _reconnectionSubscription;

  // State tracking
  bool _isNetworkConnected = false;
  ConnectionStatus _webSocketStatus = ConnectionStatus.disconnected;
  bool _isInitialized = false;
  bool _shouldBeConnected = false;
  ConnectionState _currentState = ConnectionState.initializing;

  // Single stream for consumers - ConnectionSummary only
  final _connectionSummaryController =
      StreamController<ConnectionSummary>.broadcast();
  Stream<ConnectionSummary> get connectionSummaryStream =>
      _connectionSummaryController.stream;

  ConnectionManager(
    this._networkService,
    this._reconnectionManager,
    this._webSocketService,
    this._streamService,
  );

  /// Initialize all connection services and start monitoring
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize all services
    await _networkService.initialize();
    _reconnectionManager.initialize();
    _webSocketService.initialize();

    // Get initial network state
    _isNetworkConnected = _networkService.isConnected;

    // Setup event listening
    _setupEventListeners();

    _isInitialized = true;

    // Emit initial state
    _updateState(ConnectionState.initializing);
  }

  void _setupEventListeners() {
    // Listen to network changes
    _networkSubscription = _networkService.connectivityStream.listen(
      _handleNetworkChange,
      onError: (error) => _handleError('Network monitoring error: $error'),
    );

    // Listen to WebSocket status changes
    _webSocketSubscription = _webSocketService.connectionStatusStream.listen(
      _handleWebSocketStatusChange,
      onError: (error) => _handleError('WebSocket monitoring error: $error'),
    );

    // Listen to reconnection events
    _reconnectionSubscription = _reconnectionManager.stateStream.listen(
      _handleReconnectionStateChange,
      onError: (error) => _handleError('Reconnection monitoring error: $error'),
    );
  }

  /// Request connection (app wants to be connected)
  Future<void> requestConnection() async {
    _shouldBeConnected = true;
    await _evaluateAndConnect();
  }

  /// Request disconnection (app wants to disconnect)
  Future<void> requestDisconnection() async {
    _shouldBeConnected = false;
    _reconnectionManager.stopReconnection();
    await _webSocketService.disconnect();
    _updateState(ConnectionState.disconnected);
  }

  /// Evaluate current conditions and decide on connection action
  Future<void> _evaluateAndConnect() async {
    if (!_shouldBeConnected) return;

    if (!_isNetworkConnected) {
      _updateState(ConnectionState.networkLost);
      return;
    }

    if (_webSocketStatus == ConnectionStatus.connected) {
      _updateState(ConnectionState.operational);
      return;
    }

    await _attemptConnection();
  }

  /// Attempt WebSocket connection with proper error handling
  Future<void> _attemptConnection() async {
    try {
      _updateState(ConnectionState.connecting);
      await _webSocketService.connect();
    } catch (e) {
      _handleError('Connection attempt failed: $e');
    }
  }

  /// Handle network connectivity changes
  void _handleNetworkChange(bool isConnected) {
    final wasConnected = _isNetworkConnected;
    _isNetworkConnected = isConnected;

    if (!wasConnected && isConnected) {
      _updateState(ConnectionState.connecting);
      if (_shouldBeConnected) {
        _reconnectionManager.handleNetworkRestored();
      }
    } else if (wasConnected && !isConnected) {
      _updateState(ConnectionState.networkLost);
      if (_shouldBeConnected) {
        _reconnectionManager.handleNetworkLost();
      }
    }
  }

  /// Handle WebSocket status changes
  void _handleWebSocketStatusChange(ConnectionStatus status) {
    final previousStatus = _webSocketStatus;
    _webSocketStatus = status;

    switch (status) {
      case ConnectionStatus.connected:
        _handleConnectionSuccess();
      case ConnectionStatus.failed:
      case ConnectionStatus.timeout:
        _handleConnectionFailure(status);
      case ConnectionStatus.connecting:
        _updateState(ConnectionState.connecting);
      case ConnectionStatus.disconnected:
        if (previousStatus == ConnectionStatus.connected) {
          _handleUnexpectedDisconnection();
        }
      case ConnectionStatus.retrying:
        break;
    }
  }

  /// Handle successful connection
  void _handleConnectionSuccess() {
    _reconnectionManager.handleConnectionSuccess();
    _updateState(ConnectionState.operational);
  }

  /// Handle connection failure
  void _handleConnectionFailure(ConnectionStatus failureType) {
    if (!_shouldBeConnected) return;

    if (!_isNetworkConnected) {
      _updateState(ConnectionState.networkLost);
    } else {
      _updateState(ConnectionState.reconnecting);
      _reconnectionManager.handleConnectionFailure();
    }
  }

  /// Handle unexpected disconnection
  void _handleUnexpectedDisconnection() {
    if (!_shouldBeConnected) return;

    _updateState(ConnectionState.reconnecting);

    if (_isNetworkConnected) {
      _reconnectionManager.handleConnectionFailure();
    } else {
      _reconnectionManager.handleNetworkLost();
    }
  }

  /// Handle reconnection state changes
  void _handleReconnectionStateChange(ReconnectionState state) {
    switch (state) {
      case ReconnectionState.fastRetrying:
        // Start the actual fast retry phase with exponential backoff
        _reconnectionManager.startFastRetryPhase(_performReconnection);
      case ReconnectionState.connected:
        break;
      case ReconnectionState.backgroundMonitoring:
        _updateState(ConnectionState.reconnecting);
      case ReconnectionState.failed:
        _updateState(ConnectionState.failed);
      case ReconnectionState.manualRetryAvailable:
        _updateState(ConnectionState.reconnecting);
    }
  }

  /// Handle manual retry request
  Future<void> requestManualRetry() async {
    if (_isNetworkConnected && _shouldBeConnected) {
      await _reconnectionManager.requestManualRetry(_performReconnection);
    }
  }

  /// Perform actual reconnection for ReconnectionManager
  Future<bool> _performReconnection() async {
    if (!_isNetworkConnected) return false;

    try {
      await _webSocketService.connect();
      _webSocketStatus = _webSocketService.currentStatus;
      return _webSocketStatus == ConnectionStatus.connected;
    } catch (e) {
      return false;
    }
  }

  /// Handle errors gracefully (internal only)
  void _handleError(String error) {
    debugPrint('ConnectionManager Error: $error');
  }

  /// Update state and emit to consumers
  void _updateState(ConnectionState state) {
    _currentState = state;

    if (!_connectionSummaryController.isClosed) {
      _connectionSummaryController.add(currentState);
    }
  }

  /// Get current operational state
  bool get isFullyOperational =>
      _isNetworkConnected &&
      _webSocketStatus == ConnectionStatus.connected &&
      _shouldBeConnected;

  /// Get current connection summary
  ConnectionSummary get currentState => ConnectionSummary(
    networkConnected: _isNetworkConnected,
    webSocketStatus: _webSocketStatus,
    isOperational: isFullyOperational,
    currentState: _currentState,
  );

  /// Expose WebSocket message stream
  Stream<dynamic> get messageStream => _webSocketService.messageStream;

  /// Start frame streaming
  Future<bool> startStreaming() async {
    if (!isFullyOperational) return false;

    try {
      await _streamService.startStream();
      return true;
    } catch (e) {
      _handleError('Failed to start streaming: $e');
      return false;
    }
  }

  /// Stop frame streaming
  Future<void> stopStreaming() async {
    try {
      await _streamService.stopStream();
    } catch (e) {
      _handleError('Failed to stop streaming: $e');
    }
  }

  /// Add frame to stream processing queue
  void addFrame(dynamic frame) {
    if (!isFullyOperational || !_streamService.isStreaming) {
      return;
    }
    _streamService.addFrame(frame);
  }

  /// Configure stream settings
  void configureStream({int? maxFps}) {
    if (maxFps != null) {
      _streamService.setMaxFps(maxFps);
    }
  }

  /// Get current streaming status
  bool get isStreaming => _streamService.isStreaming;

  /// Get current max FPS setting
  int get maxFps => _streamService.maxFps;

  /// Dispose all resources
  void dispose() {
    _networkSubscription?.cancel();
    _webSocketSubscription?.cancel();
    _reconnectionSubscription?.cancel();
    _connectionSummaryController.close();

    _networkService.dispose();
    _reconnectionManager.dispose();
    _webSocketService.dispose();
    _streamService.dispose();
  }
}
