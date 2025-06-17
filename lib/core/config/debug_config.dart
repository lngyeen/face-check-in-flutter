import 'package:flutter/foundation.dart';

/// Configuration class for debug features
class DebugConfig {
  /// Whether debug view is enabled
  static bool get isDebugViewEnabled => kDebugMode;

  /// Whether debug logging is enabled
  static bool get isDebugLoggingEnabled => kDebugMode;

  /// Maximum number of debug messages to store
  static const int maxDebugMessages = 100;

  /// Whether to show debug view by default
  static const bool showDebugViewByDefault = true;

  /// Whether to enable debug toggle functionality
  static bool get isDebugToggleEnabled => kDebugMode;
}
