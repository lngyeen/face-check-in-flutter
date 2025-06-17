import 'dart:async';
import 'package:flutter/foundation.dart';
import '../config/debug_config.dart';

/// Service for managing debug logs
class DebugLogService {
  static final DebugLogService _instance = DebugLogService._internal();
  factory DebugLogService() => _instance;

  DebugLogService._internal();

  final _messageController = StreamController<List<String>>.broadcast();
  final List<String> _messages = [];
  StreamSubscription? _subscription;

  /// Stream of debug messages
  Stream<List<String>> get debugStream => _messageController.stream;

  /// Log a debug message
  void logDebug(String message) {
    if (!DebugConfig.isDebugLoggingEnabled) return;
    _addMessage('DEBUG', message);
  }

  /// Log an info message
  void logInfo(String message) {
    if (!DebugConfig.isDebugLoggingEnabled) return;
    _addMessage('INFO', message);
  }

  /// Log a warning message
  void logWarning(String message) {
    if (!DebugConfig.isDebugLoggingEnabled) return;
    _addMessage('WARN', message);
  }

  /// Log an error message
  void logError(String message) {
    if (!DebugConfig.isDebugLoggingEnabled) return;
    _addMessage('ERROR', message);
  }

  void _addMessage(String level, String message) {
    final timestamp = DateTime.now();
    final formattedMessage =
        '[${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}.'
        '${timestamp.millisecond.toString().padLeft(3, '0')}] '
        '[$level] $message';

    _messages.add(formattedMessage);
    if (_messages.length > DebugConfig.maxDebugMessages) {
      _messages.removeAt(0);
    }
    _messageController.add(List.unmodifiable(_messages));
  }

  /// Clear all messages
  void clear() {
    _messages.clear();
    _messageController.add(List.unmodifiable(_messages));
  }

  /// Dispose the service
  void dispose() {
    _subscription?.cancel();
    _messageController.close();
  }
}
