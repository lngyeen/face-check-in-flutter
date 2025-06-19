import 'dart:collection';
import 'dart:developer' as developer;
import 'dart:math' as math;
import 'package:injectable/injectable.dart';
import 'response_processor.dart';

/// Face detection history entry with enhanced metadata
class FaceDetectionHistoryEntry {
  const FaceDetectionHistoryEntry({
    required this.timestamp,
    required this.response,
    required this.processingTime,
    this.frameId,
    this.sessionId,
  });

  final DateTime timestamp;
  final FaceDetectionResponse response;
  final Duration processingTime;
  final String? frameId;
  final String? sessionId;

  /// Unique identifier for this entry
  String get id =>
      '${timestamp.millisecondsSinceEpoch}_${frameId ?? 'unknown'}';

  /// Whether this entry represents a successful face detection
  bool get isSuccess => response.isSuccess && response.faces.isNotEmpty;

  /// Number of faces detected in this entry
  int get faceCount => response.faces.length;

  /// Highest confidence score from all faces
  double get maxConfidence => response.overallConfidence;

  /// Average confidence score from all faces
  double get averageConfidence {
    if (response.faces.isEmpty) return 0.0;
    final total = response.faces.fold<double>(
      0.0,
      (sum, face) => sum + face.confidence,
    );
    return total / response.faces.length;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'response': response.toJson(),
      'processingTime': processingTime.inMilliseconds,
      'frameId': frameId,
      'sessionId': sessionId,
      'isSuccess': isSuccess,
      'faceCount': faceCount,
      'maxConfidence': maxConfidence,
      'averageConfidence': averageConfidence,
    };
  }
}

/// Face detection session statistics
class FaceDetectionSessionStats {
  const FaceDetectionSessionStats({
    required this.sessionId,
    required this.startTime,
    required this.endTime,
    required this.totalFrames,
    required this.successfulDetections,
    required this.failedDetections,
    required this.averageConfidence,
    required this.maxConfidence,
    required this.averageProcessingTime,
    required this.faceDetectionRate,
  });

  final String sessionId;
  final DateTime startTime;
  final DateTime? endTime;
  final int totalFrames;
  final int successfulDetections;
  final int failedDetections;
  final double averageConfidence;
  final double maxConfidence;
  final Duration averageProcessingTime;
  final double faceDetectionRate;

  /// Session duration
  Duration get duration => (endTime ?? DateTime.now()).difference(startTime);

  /// Success rate as percentage
  double get successRate =>
      totalFrames > 0 ? (successfulDetections / totalFrames) * 100 : 0.0;

  /// Frames per second during session
  double get fps =>
      duration.inMilliseconds > 0
          ? totalFrames / (duration.inMilliseconds / 1000.0)
          : 0.0;

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'totalFrames': totalFrames,
      'successfulDetections': successfulDetections,
      'failedDetections': failedDetections,
      'averageConfidence': averageConfidence,
      'maxConfidence': maxConfidence,
      'averageProcessingTime': averageProcessingTime.inMilliseconds,
      'faceDetectionRate': faceDetectionRate,
      'duration': duration.inMilliseconds,
      'successRate': successRate,
      'fps': fps,
    };
  }
}

/// Service for managing face detection history and analytics
@injectable
class FaceDetectionHistory {
  FaceDetectionHistory() {
    _currentSessionId = _generateSessionId();
    _sessionStartTime = DateTime.now();

    developer.log(
      'Face detection history initialized with session: $_currentSessionId',
      name: 'FaceDetectionHistory',
      level: 800,
    );
  }

  /// Maximum number of history entries to keep in memory
  static const int maxHistorySize = 1000;

  /// Maximum number of sessions to track
  static const int maxSessionCount = 50;

  /// History queue with size limit
  final Queue<FaceDetectionHistoryEntry> _history =
      Queue<FaceDetectionHistoryEntry>();

  /// Session statistics tracking
  final Map<String, FaceDetectionSessionStats> _sessionStats =
      <String, FaceDetectionSessionStats>{};

  /// Current active session
  String _currentSessionId = '';
  DateTime _sessionStartTime = DateTime.now();

  /// Confidence threshold for successful detection
  double confidenceThreshold = 0.7;

  /// Get current session ID
  String get currentSessionId => _currentSessionId;

  /// Get all history entries
  List<FaceDetectionHistoryEntry> get allEntries =>
      List<FaceDetectionHistoryEntry>.unmodifiable(_history);

  /// Get recent entries (last N entries)
  List<FaceDetectionHistoryEntry> getRecentEntries(int count) {
    final entries = _history.toList();
    return entries.take(math.min(count, entries.length)).toList();
  }

  /// Get entries from current session
  List<FaceDetectionHistoryEntry> get currentSessionEntries {
    return _history
        .where((entry) => entry.sessionId == _currentSessionId)
        .toList();
  }

  /// Get session statistics
  Map<String, FaceDetectionSessionStats> get sessionStats =>
      Map<String, FaceDetectionSessionStats>.unmodifiable(_sessionStats);

  /// Add face detection result to history
  void addDetectionResult({
    required FaceDetectionResponse response,
    required Duration processingTime,
    String? frameId,
  }) {
    try {
      final entry = FaceDetectionHistoryEntry(
        timestamp: DateTime.now(),
        response: response,
        processingTime: processingTime,
        frameId: frameId,
        sessionId: _currentSessionId,
      );

      // Add to history queue
      _history.addFirst(entry);

      // Maintain size limit
      while (_history.length > maxHistorySize) {
        _history.removeLast();
      }

      // Update session statistics
      _updateSessionStats(entry);

      developer.log(
        'Added detection result: ${entry.faceCount} faces, confidence: ${entry.maxConfidence.toStringAsFixed(2)}',
        name: 'FaceDetectionHistory',
        level: 700,
      );
    } catch (e, stackTrace) {
      developer.log(
        'Failed to add detection result to history',
        name: 'FaceDetectionHistory',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }

  /// Start new detection session
  void startNewSession() {
    try {
      // Finalize current session
      _finalizeCurrentSession();

      // Start new session
      _currentSessionId = _generateSessionId();
      _sessionStartTime = DateTime.now();

      developer.log(
        'Started new face detection session: $_currentSessionId',
        name: 'FaceDetectionHistory',
        level: 800,
      );
    } catch (e, stackTrace) {
      developer.log(
        'Failed to start new session',
        name: 'FaceDetectionHistory',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }

  /// Get analytics for specified time period
  Map<String, dynamic> getAnalytics({
    DateTime? startTime,
    DateTime? endTime,
    String? sessionId,
  }) {
    try {
      var entries = _history.toList();

      // Filter by session if specified
      if (sessionId != null) {
        entries =
            entries.where((entry) => entry.sessionId == sessionId).toList();
      }

      // Filter by time range if specified
      if (startTime != null) {
        entries =
            entries
                .where((entry) => entry.timestamp.isAfter(startTime))
                .toList();
      }
      if (endTime != null) {
        entries =
            entries
                .where((entry) => entry.timestamp.isBefore(endTime))
                .toList();
      }

      if (entries.isEmpty) {
        return _getEmptyAnalytics();
      }

      // Calculate analytics
      final totalEntries = entries.length;
      final successfulEntries =
          entries.where((entry) => entry.isSuccess).length;
      final failedEntries = totalEntries - successfulEntries;

      final confidenceValues =
          entries
              .where((entry) => entry.isSuccess)
              .map((entry) => entry.maxConfidence)
              .toList();

      final processingTimes =
          entries.map((entry) => entry.processingTime.inMilliseconds).toList();

      final faceCountsDistribution = <int, int>{};
      for (final entry in entries) {
        faceCountsDistribution[entry.faceCount] =
            (faceCountsDistribution[entry.faceCount] ?? 0) + 1;
      }

      return {
        'totalEntries': totalEntries,
        'successfulDetections': successfulEntries,
        'failedDetections': failedEntries,
        'successRate':
            totalEntries > 0 ? (successfulEntries / totalEntries) * 100 : 0.0,
        'averageConfidence':
            confidenceValues.isNotEmpty
                ? confidenceValues.reduce((a, b) => a + b) /
                    confidenceValues.length
                : 0.0,
        'maxConfidence':
            confidenceValues.isNotEmpty
                ? confidenceValues.reduce(math.max)
                : 0.0,
        'minConfidence':
            confidenceValues.isNotEmpty
                ? confidenceValues.reduce(math.min)
                : 0.0,
        'averageProcessingTime':
            processingTimes.isNotEmpty
                ? processingTimes.reduce((a, b) => a + b) /
                    processingTimes.length
                : 0.0,
        'maxProcessingTime':
            processingTimes.isNotEmpty ? processingTimes.reduce(math.max) : 0.0,
        'faceCountDistribution': faceCountsDistribution,
        'timeRange': {
          'start': entries.last.timestamp.toIso8601String(),
          'end': entries.first.timestamp.toIso8601String(),
          'duration':
              entries.first.timestamp
                  .difference(entries.last.timestamp)
                  .inMilliseconds,
        },
      };
    } catch (e, stackTrace) {
      developer.log(
        'Failed to generate analytics',
        name: 'FaceDetectionHistory',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
      return _getEmptyAnalytics();
    }
  }

  /// Get current session statistics
  FaceDetectionSessionStats? getCurrentSessionStats() {
    return _sessionStats[_currentSessionId];
  }

  /// Clear all history
  void clearHistory() {
    try {
      _history.clear();
      _sessionStats.clear();

      developer.log(
        'Face detection history cleared',
        name: 'FaceDetectionHistory',
        level: 800,
      );
    } catch (e, stackTrace) {
      developer.log(
        'Failed to clear history',
        name: 'FaceDetectionHistory',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }

  /// Export history as JSON
  Map<String, dynamic> exportHistory() {
    try {
      return {
        'currentSessionId': _currentSessionId,
        'sessionStartTime': _sessionStartTime.toIso8601String(),
        'confidenceThreshold': confidenceThreshold,
        'history': _history.map((entry) => entry.toJson()).toList(),
        'sessionStats': _sessionStats.map(
          (key, value) => MapEntry(key, value.toJson()),
        ),
        'metadata': {
          'exportTime': DateTime.now().toIso8601String(),
          'totalEntries': _history.length,
          'totalSessions': _sessionStats.length,
        },
      };
    } catch (e, stackTrace) {
      developer.log(
        'Failed to export history',
        name: 'FaceDetectionHistory',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
      return {};
    }
  }

  /// Update session statistics with new entry
  void _updateSessionStats(FaceDetectionHistoryEntry entry) {
    final sessionEntries = currentSessionEntries;
    final totalFrames = sessionEntries.length;
    final successfulDetections =
        sessionEntries.where((e) => e.isSuccess).length;
    final failedDetections = totalFrames - successfulDetections;

    final confidenceValues =
        sessionEntries
            .where((e) => e.isSuccess)
            .map((e) => e.maxConfidence)
            .toList();

    final processingTimes =
        sessionEntries.map((e) => e.processingTime).toList();

    final stats = FaceDetectionSessionStats(
      sessionId: _currentSessionId,
      startTime: _sessionStartTime,
      endTime: null, // Session still active
      totalFrames: totalFrames,
      successfulDetections: successfulDetections,
      failedDetections: failedDetections,
      averageConfidence:
          confidenceValues.isNotEmpty
              ? confidenceValues.reduce((a, b) => a + b) /
                  confidenceValues.length
              : 0.0,
      maxConfidence:
          confidenceValues.isNotEmpty ? confidenceValues.reduce(math.max) : 0.0,
      averageProcessingTime:
          processingTimes.isNotEmpty
              ? Duration(
                milliseconds:
                    processingTimes
                        .map((d) => d.inMilliseconds)
                        .reduce((a, b) => a + b) ~/
                    processingTimes.length,
              )
              : Duration.zero,
      faceDetectionRate:
          totalFrames > 0 ? (successfulDetections / totalFrames) : 0.0,
    );

    _sessionStats[_currentSessionId] = stats;
  }

  /// Finalize current session
  void _finalizeCurrentSession() {
    if (_sessionStats.containsKey(_currentSessionId)) {
      final currentStats = _sessionStats[_currentSessionId]!;
      _sessionStats[_currentSessionId] = FaceDetectionSessionStats(
        sessionId: currentStats.sessionId,
        startTime: currentStats.startTime,
        endTime: DateTime.now(), // Mark as ended
        totalFrames: currentStats.totalFrames,
        successfulDetections: currentStats.successfulDetections,
        failedDetections: currentStats.failedDetections,
        averageConfidence: currentStats.averageConfidence,
        maxConfidence: currentStats.maxConfidence,
        averageProcessingTime: currentStats.averageProcessingTime,
        faceDetectionRate: currentStats.faceDetectionRate,
      );
    }

    // Maintain session count limit
    while (_sessionStats.length > maxSessionCount) {
      final oldestSessionId = _sessionStats.keys.first;
      _sessionStats.remove(oldestSessionId);
    }
  }

  /// Generate unique session ID
  String _generateSessionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = math.Random().nextInt(1000);
    return 'session_${timestamp}_$random';
  }

  /// Get empty analytics structure
  Map<String, dynamic> _getEmptyAnalytics() {
    return {
      'totalEntries': 0,
      'successfulDetections': 0,
      'failedDetections': 0,
      'successRate': 0.0,
      'averageConfidence': 0.0,
      'maxConfidence': 0.0,
      'minConfidence': 0.0,
      'averageProcessingTime': 0.0,
      'maxProcessingTime': 0.0,
      'faceCountDistribution': <int, int>{},
      'timeRange': null,
    };
  }
}
