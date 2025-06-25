/// Represents the current WebSocket connection status
enum WebSocketConnectionStatus {
  /// Network is available but WebSocket is not connected
  disconnected,

  /// Attempting to connect
  connecting,

  /// Successfully connected
  connected,

  /// Connection failed
  failed,
}
