/// Represents the current WebSocket connection status
enum ConnectionStatus {
  /// Not connected to backend
  disconnected,

  /// Attempting to connect
  connecting,

  /// Successfully connected
  connected,

  /// Connection failed
  failed,

  /// Connection timed out
  timeout,

  /// Retrying to connect
  retrying,
}
