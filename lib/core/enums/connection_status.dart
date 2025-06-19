/// Represents the current WebSocket connection status
/// Enhanced for Story 2.1 requirements
enum ConnectionStatus {
  /// Not connected to backend
  disconnected,

  /// Attempting to connect
  connecting,

  /// Successfully connected
  connected,

  /// Connection failed
  failed,

  /// Connection timeout occurred
  timeout,

  /// Retrying connection after failure
  retrying,
}
