import 'dart:async';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import 'response_processor.dart';

/// Types of response errors that can occur
enum ResponseErrorType {
  /// Malformed JSON response
  malformedJson,

  /// Missing required fields
  missingFields,

  /// Invalid data types
  invalidDataTypes,

  /// Response timeout
  timeout,

  /// Backend error response
  backendError,

  /// Network connection error
  connectionError,

  /// Unknown message type
  unknownMessageType,

  /// Invalid face coordinates
  invalidFaceData,

  /// Processing timeout
  processingTimeout,

  /// Unknown error
  unknown,
}

/// Response error information
class ResponseError {
  const ResponseError({
    required this.type,
    required this.message,
    required this.timestamp,
    this.originalMessage,
    this.stackTrace,
    this.recoveryAction,
    this.isRecoverable = true,
    this.retryCount = 0,
  });

  final ResponseErrorType type;
  final String message;
  final DateTime timestamp;
  final dynamic originalMessage;
  final String? stackTrace;
  final String? recoveryAction;
  final bool isRecoverable;
  final int retryCount;

  /// Severity level of the error
  ErrorSeverity get severity {
    switch (type) {
      case ResponseErrorType.timeout:
      case ResponseErrorType.connectionError:
      case ResponseErrorType.processingTimeout:
        return ErrorSeverity.warning;

      case ResponseErrorType.malformedJson:
      case ResponseErrorType.missingFields:
      case ResponseErrorType.invalidDataTypes:
      case ResponseErrorType.invalidFaceData:
        return ErrorSeverity.error;

      case ResponseErrorType.backendError:
        return ErrorSeverity.critical;

      case ResponseErrorType.unknownMessageType:
        return ErrorSeverity.info;

      case ResponseErrorType.unknown:
        return ErrorSeverity.critical;
    }
  }

  /// Whether this error should trigger retry logic
  bool get shouldRetry =>
      isRecoverable &&
      retryCount < 3 &&
      (type == ResponseErrorType.timeout ||
          type == ResponseErrorType.connectionError ||
          type == ResponseErrorType.processingTimeout);

  /// User-friendly error message
  String get userMessage {
    switch (type) {
      case ResponseErrorType.malformedJson:
        return 'Invalid response format received from server';
      case ResponseErrorType.missingFields:
        return 'Incomplete response received from server';
      case ResponseErrorType.invalidDataTypes:
        return 'Response contains invalid data';
      case ResponseErrorType.timeout:
        return 'Response timeout - please check your connection';
      case ResponseErrorType.backendError:
        return 'Server error: $message';
      case ResponseErrorType.connectionError:
        return 'Connection error - please check your network';
      case ResponseErrorType.unknownMessageType:
        return 'Unknown message type received';
      case ResponseErrorType.invalidFaceData:
        return 'Invalid face detection data received';
      case ResponseErrorType.processingTimeout:
        return 'Response processing timeout';
      case ResponseErrorType.unknown:
        return 'An unexpected error occurred';
    }
  }

  ResponseError copyWithRetry() {
    return ResponseError(
      type: type,
      message: message,
      timestamp: timestamp,
      originalMessage: originalMessage,
      stackTrace: stackTrace,
      recoveryAction: recoveryAction,
      isRecoverable: isRecoverable,
      retryCount: retryCount + 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'originalMessage': originalMessage?.toString(),
      'stackTrace': stackTrace,
      'recoveryAction': recoveryAction,
      'isRecoverable': isRecoverable,
      'retryCount': retryCount,
      'severity': severity.name,
      'userMessage': userMessage,
    };
  }
}

/// Error severity levels
enum ErrorSeverity { info, warning, error, critical }

/// Error recovery strategies
enum RecoveryStrategy {
  retry,
  skipFrame,
  resetConnection,
  degradeQuality,
  notifyUser,
  ignore,
}

/// Response error statistics
class ErrorStatistics {
  const ErrorStatistics({
    required this.totalErrors,
    required this.errorsByType,
    required this.errorRate,
    required this.recoverySuccessRate,
    required this.averageRecoveryTime,
    required this.criticalErrorCount,
  });

  final int totalErrors;
  final Map<ResponseErrorType, int> errorsByType;
  final double errorRate;
  final double recoverySuccessRate;
  final Duration averageRecoveryTime;
  final int criticalErrorCount;

  Map<String, dynamic> toJson() {
    return {
      'totalErrors': totalErrors,
      'errorsByType': errorsByType.map(
        (key, value) => MapEntry(key.name, value),
      ),
      'errorRate': errorRate,
      'recoverySuccessRate': recoverySuccessRate,
      'averageRecoveryTime': averageRecoveryTime.inMilliseconds,
      'criticalErrorCount': criticalErrorCount,
    };
  }
}

/// Service for handling response processing errors
@injectable
class ResponseErrorHandler {
  ResponseErrorHandler() {
    developer.log(
      'Response error handler initialized',
      name: 'ResponseErrorHandler',
      level: 800,
    );
  }

  /// Error history storage
  final List<ResponseError> _errorHistory = <ResponseError>[];

  /// Recovery attempt history
  final Map<String, int> _recoveryAttempts = <String, int>{};

  /// Error statistics
  final Map<ResponseErrorType, int> _errorCounts = <ResponseErrorType, int>{};

  /// Maximum errors to keep in history
  static const int maxErrorHistorySize = 100;

  /// Response timeout duration
  static const Duration responseTimeout = Duration(seconds: 10);

  /// Processing timeout duration
  static const Duration processingTimeout = Duration(seconds: 5);

  /// Error event stream controller
  final StreamController<ResponseError> _errorStreamController =
      StreamController<ResponseError>.broadcast();

  /// Stream of response errors
  Stream<ResponseError> get errorStream => _errorStreamController.stream;

  /// Process response with error handling
  Future<FaceDetectionResponse?> processResponseSafely({
    required dynamic message,
    required ResponseProcessor processor,
    Duration? timeout,
  }) async {
    final processingTimeout = timeout ?? ResponseErrorHandler.processingTimeout;

    try {
      // Process with timeout
      final future = Future.microtask(() => processor.processMessage(message));
      final result = await future.timeout(processingTimeout);

      return result;
    } on TimeoutException {
      final error = ResponseError(
        type: ResponseErrorType.processingTimeout,
        message:
            'Response processing timeout after ${processingTimeout.inSeconds}s',
        timestamp: DateTime.now(),
        originalMessage: message,
        recoveryAction: 'Skip frame and continue processing',
      );

      await _handleError(error);
      return null;
    } on ResponseProcessingException catch (e) {
      final errorType = _categorizeProcessingException(e, message);
      final error = ResponseError(
        type: errorType,
        message: e.message,
        timestamp: DateTime.now(),
        originalMessage: message,
        stackTrace: e.cause?.toString(),
        recoveryAction: _getRecoveryAction(errorType),
      );

      await _handleError(error);
      return null;
    } catch (e, stackTrace) {
      final error = ResponseError(
        type: ResponseErrorType.unknown,
        message: e.toString(),
        timestamp: DateTime.now(),
        originalMessage: message,
        stackTrace: stackTrace.toString(),
        recoveryAction: 'Log error and continue',
        isRecoverable: false,
      );

      await _handleError(error);
      return null;
    }
  }

  /// Validate response structure
  bool validateResponseStructure(dynamic message) {
    try {
      if (message == null) {
        _recordValidationError(
          ResponseErrorType.missingFields,
          'Null message received',
        );
        return false;
      }

      if (message is String) {
        if (message.trim().isEmpty) {
          _recordValidationError(
            ResponseErrorType.missingFields,
            'Empty message received',
          );
          return false;
        }

        // Try to parse JSON
        try {
          final json = jsonDecode(message);
          return _validateJsonStructure(json);
        } on FormatException {
          _recordValidationError(
            ResponseErrorType.malformedJson,
            'Invalid JSON format',
          );
          return false;
        }
      }

      if (message is Map<String, dynamic>) {
        return _validateJsonStructure(message);
      }

      _recordValidationError(
        ResponseErrorType.invalidDataTypes,
        'Unsupported message type: ${message.runtimeType}',
      );
      return false;
    } catch (e, stackTrace) {
      developer.log(
        'Validation error: $e',
        name: 'ResponseErrorHandler',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
      return false;
    }
  }

  /// Handle connection timeout
  Future<void> handleConnectionTimeout({
    Duration? timeout,
    required VoidCallback onRetry,
  }) async {
    final error = ResponseError(
      type: ResponseErrorType.timeout,
      message:
          'Connection timeout after ${(timeout ?? responseTimeout).inSeconds}s',
      timestamp: DateTime.now(),
      recoveryAction: 'Retry connection',
    );

    await _handleError(error);

    if (error.shouldRetry) {
      developer.log(
        'Attempting connection retry due to timeout',
        name: 'ResponseErrorHandler',
        level: 900,
      );
      onRetry();
    }
  }

  /// Handle backend error response
  Future<void> handleBackendError({
    required String errorMessage,
    String? errorCode,
    dynamic originalMessage,
  }) async {
    final error = ResponseError(
      type: ResponseErrorType.backendError,
      message: errorCode != null ? '[$errorCode] $errorMessage' : errorMessage,
      timestamp: DateTime.now(),
      originalMessage: originalMessage,
      recoveryAction: 'Check backend logs and connection',
      isRecoverable: false,
    );

    await _handleError(error);
  }

  /// Get error statistics
  ErrorStatistics getErrorStatistics() {
    final totalErrors = _errorHistory.length;
    final totalFrames = totalErrors + 100; // Approximate based on error rate

    final recoveryAttempts =
        _errorHistory.where((e) => e.retryCount > 0).length;
    final successfulRecoveries =
        _recoveryAttempts.values.where((count) => count > 0).length;

    final criticalErrors =
        _errorHistory.where((e) => e.severity == ErrorSeverity.critical).length;

    final recoveryTimes =
        _errorHistory
            .where((e) => e.retryCount > 0)
            .map((e) => Duration(milliseconds: e.retryCount * 1000))
            .toList();

    return ErrorStatistics(
      totalErrors: totalErrors,
      errorsByType: Map<ResponseErrorType, int>.from(_errorCounts),
      errorRate: totalFrames > 0 ? (totalErrors / totalFrames) * 100 : 0.0,
      recoverySuccessRate:
          recoveryAttempts > 0
              ? (successfulRecoveries / recoveryAttempts) * 100
              : 0.0,
      averageRecoveryTime:
          recoveryTimes.isNotEmpty
              ? Duration(
                milliseconds:
                    recoveryTimes
                        .map((d) => d.inMilliseconds)
                        .reduce((a, b) => a + b) ~/
                    recoveryTimes.length,
              )
              : Duration.zero,
      criticalErrorCount: criticalErrors,
    );
  }

  /// Get recent errors
  List<ResponseError> getRecentErrors([int count = 10]) {
    return _errorHistory.take(count).toList();
  }

  /// Clear error history
  void clearErrorHistory() {
    _errorHistory.clear();
    _errorCounts.clear();
    _recoveryAttempts.clear();

    developer.log(
      'Error history cleared',
      name: 'ResponseErrorHandler',
      level: 800,
    );
  }

  /// Export error logs
  Map<String, dynamic> exportErrorLogs() {
    return {
      'errorHistory': _errorHistory.map((e) => e.toJson()).toList(),
      'errorStatistics': getErrorStatistics().toJson(),
      'recoveryAttempts': _recoveryAttempts,
      'exportTime': DateTime.now().toIso8601String(),
    };
  }

  /// Dispose resources
  void dispose() {
    _errorStreamController.close();
  }

  /// Handle error internally
  Future<void> _handleError(ResponseError error) async {
    // Add to history
    _errorHistory.insert(0, error);
    while (_errorHistory.length > maxErrorHistorySize) {
      _errorHistory.removeLast();
    }

    // Update statistics
    _errorCounts[error.type] = (_errorCounts[error.type] ?? 0) + 1;

    // Log error
    developer.log(
      'Response error: ${error.type.name} - ${error.message}',
      name: 'ResponseErrorHandler',
      level: _getLogLevel(error.severity),
    );

    // Emit error event
    _errorStreamController.add(error);

    // Attempt recovery if applicable
    if (error.shouldRetry) {
      await _attemptRecovery(error);
    }
  }

  /// Categorize processing exception
  ResponseErrorType _categorizeProcessingException(
    ResponseProcessingException e,
    dynamic message,
  ) {
    final errorMessage = e.message.toLowerCase();

    if (errorMessage.contains('json') || errorMessage.contains('parse')) {
      return ResponseErrorType.malformedJson;
    }

    if (errorMessage.contains('field') || errorMessage.contains('missing')) {
      return ResponseErrorType.missingFields;
    }

    if (errorMessage.contains('type') || errorMessage.contains('cast')) {
      return ResponseErrorType.invalidDataTypes;
    }

    if (errorMessage.contains('face') || errorMessage.contains('coordinate')) {
      return ResponseErrorType.invalidFaceData;
    }

    return ResponseErrorType.unknown;
  }

  /// Validate JSON structure
  bool _validateJsonStructure(Map<String, dynamic> json) {
    // Check for required type field
    if (!json.containsKey('type')) {
      _recordValidationError(
        ResponseErrorType.missingFields,
        'Missing type field',
      );
      return false;
    }

    final messageType = json['type'] as String?;

    switch (messageType?.toLowerCase()) {
      case 'frameresult':
      case 'frame_result':
        return _validateFrameResultStructure(json);

      case 'error':
        return _validateErrorStructure(json);

      case 'heartbeat':
      case 'pong':
        return true; // Heartbeat has minimal structure requirements

      default:
        _recordValidationError(
          ResponseErrorType.unknownMessageType,
          'Unknown message type: $messageType',
        );
        return false;
    }
  }

  /// Validate frame result structure
  bool _validateFrameResultStructure(Map<String, dynamic> json) {
    // Check for faces array
    if (!json.containsKey('faces')) {
      _recordValidationError(
        ResponseErrorType.missingFields,
        'Missing faces field',
      );
      return false;
    }

    final faces = json['faces'];
    if (faces is! List) {
      _recordValidationError(
        ResponseErrorType.invalidDataTypes,
        'Faces field is not an array',
      );
      return false;
    }

    // Validate each face object
    for (final face in faces) {
      if (face is! Map<String, dynamic>) {
        _recordValidationError(
          ResponseErrorType.invalidDataTypes,
          'Face object is not a map',
        );
        return false;
      }

      if (!_validateFaceStructure(face)) {
        return false;
      }
    }

    return true;
  }

  /// Validate face structure
  bool _validateFaceStructure(Map<String, dynamic> face) {
    final requiredFields = ['x', 'y', 'width', 'height', 'confidence'];

    for (final field in requiredFields) {
      if (!face.containsKey(field)) {
        _recordValidationError(
          ResponseErrorType.missingFields,
          'Missing face field: $field',
        );
        return false;
      }

      final value = face[field];
      if (value is! num) {
        _recordValidationError(
          ResponseErrorType.invalidDataTypes,
          'Face field $field is not a number',
        );
        return false;
      }

      // Validate coordinate ranges
      if (field == 'confidence' && (value < 0.0 || value > 1.0)) {
        _recordValidationError(
          ResponseErrorType.invalidFaceData,
          'Confidence value out of range: $value',
        );
        return false;
      }

      if (['x', 'y', 'width', 'height'].contains(field) && value < 0) {
        _recordValidationError(
          ResponseErrorType.invalidFaceData,
          'Negative coordinate value: $field = $value',
        );
        return false;
      }
    }

    return true;
  }

  /// Validate error structure
  bool _validateErrorStructure(Map<String, dynamic> json) {
    if (!json.containsKey('error')) {
      _recordValidationError(
        ResponseErrorType.missingFields,
        'Missing error field',
      );
      return false;
    }

    return true;
  }

  /// Record validation error
  void _recordValidationError(ResponseErrorType type, String message) {
    final error = ResponseError(
      type: type,
      message: message,
      timestamp: DateTime.now(),
      recoveryAction: _getRecoveryAction(type),
    );

    _handleError(error);
  }

  /// Get recovery action for error type
  String _getRecoveryAction(ResponseErrorType type) {
    switch (type) {
      case ResponseErrorType.malformedJson:
        return 'Skip malformed message and continue';
      case ResponseErrorType.missingFields:
        return 'Request complete message from backend';
      case ResponseErrorType.invalidDataTypes:
        return 'Validate data types before processing';
      case ResponseErrorType.timeout:
        return 'Retry with longer timeout';
      case ResponseErrorType.backendError:
        return 'Check backend status and logs';
      case ResponseErrorType.connectionError:
        return 'Retry connection';
      case ResponseErrorType.unknownMessageType:
        return 'Log and ignore unknown message';
      case ResponseErrorType.invalidFaceData:
        return 'Skip invalid face data';
      case ResponseErrorType.processingTimeout:
        return 'Optimize processing or increase timeout';
      case ResponseErrorType.unknown:
        return 'Log error details for investigation';
    }
  }

  /// Attempt error recovery
  Future<void> _attemptRecovery(ResponseError error) async {
    final recoveryKey =
        '${error.type.name}_${error.timestamp.millisecondsSinceEpoch}';
    _recoveryAttempts[recoveryKey] = (_recoveryAttempts[recoveryKey] ?? 0) + 1;

    developer.log(
      'Attempting recovery for ${error.type.name} (attempt ${error.retryCount + 1})',
      name: 'ResponseErrorHandler',
      level: 900,
    );

    // Implement recovery strategies based on error type
    switch (error.type) {
      case ResponseErrorType.timeout:
      case ResponseErrorType.connectionError:
        // Recovery handled by calling code (connection retry)
        break;

      case ResponseErrorType.processingTimeout:
        // Allow more time for processing
        await Future.delayed(const Duration(milliseconds: 100));
        break;

      default:
        // No automatic recovery for other error types
        break;
    }
  }

  /// Get log level for severity
  int _getLogLevel(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.info:
        return 700;
      case ErrorSeverity.warning:
        return 900;
      case ErrorSeverity.error:
        return 1000;
      case ErrorSeverity.critical:
        return 1200;
    }
  }
}
