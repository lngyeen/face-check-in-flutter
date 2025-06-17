import 'package:flutter/foundation.dart';

/// Configuration class for debug features
class DebugConfig {
  /// Whether debug view is enabled
  static bool isDebugViewEnabled = kDebugMode;

  /// Whether debug logging is enabled
  static bool isDebugLoggingEnabled = kDebugMode;

  /// Maximum number of debug messages to store
  static const int maxDebugMessages = 100;

  /// Whether to show debug view by default
  static bool showDebugViewByDefault = true;

  /// Whether to enable debug toggle functionality
  static bool isDebugToggleEnabled = kDebugMode;

  /// Resets the config to its default values (for testing)
  static void reset() {
    isDebugViewEnabled = kDebugMode;
    isDebugLoggingEnabled = kDebugMode;
    showDebugViewByDefault = true;
    isDebugToggleEnabled = kDebugMode;
  }
}
