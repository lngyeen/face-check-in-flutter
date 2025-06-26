import 'package:flutter/foundation.dart';

/// Configuration class for debug features
class DebugConfig {
  /// Whether debug view is enabled
  static bool isDebugViewEnabled = true;

  /// Whether debug logging is enabled
  static bool isDebugLoggingEnabled = kDebugMode;

  /// Maximum number of debug messages to store
  static const int maxDebugMessages = 100;

  /// Whether to show debug view by default
  static bool showDebugViewByDefault = false;

  /// Whether to enable debug toggle functionality
  static bool isDebugToggleEnabled = kDebugMode;

  /// Whether to use mock WebSocket responses instead of real server
  /// Set to false to connect to real OWT server
  static bool useMockWebSocketResponses =
      true; // Temporarily enabled for testing

  /// Resets the config to its default values (for testing)
  static void reset() {
    isDebugViewEnabled = false;
    isDebugLoggingEnabled = kDebugMode;
    showDebugViewByDefault = false;
    isDebugToggleEnabled = kDebugMode;
    useMockWebSocketResponses = false;
  }
}
