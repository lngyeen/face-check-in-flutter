import 'dart:async';
import 'dart:developer' as developer;
import 'package:injectable/injectable.dart';
import '../models/frame_data.dart';
import '../enums/frame_capture_status.dart';
import 'frame_capture_service.dart';

/// Service for monitoring and validating frame capture performance on real devices
@injectable
class PerformanceMonitor {
  PerformanceMonitor(this._frameCaptureService);

  final FrameCaptureService _frameCaptureService;

  // Performance tracking
  final List<PerformanceSnapshot> _snapshots = [];
  StreamSubscription<FrameData>? _frameSubscription;
  StreamSubscription<FrameCaptureMetrics>? _metricsSubscription;

  Timer? _monitoringTimer;
  bool _isMonitoring = false;

  // Performance thresholds
  static const double _targetFps = 30.0;
  static const int _targetProcessingTimeMs = 33;
  static const double _minAcceptableFps = 25.0;
  static const int _maxAcceptableProcessingTimeMs = 50;

  /// Starts real-time performance monitoring
  Future<void> startMonitoring() async {
    if (_isMonitoring) return;

    _isMonitoring = true;
    _snapshots.clear();

    // Subscribe to frame and metrics streams
    _frameSubscription = _frameCaptureService.frameStream.listen(
      _onFrameReceived,
    );
    _metricsSubscription = _frameCaptureService.metricsStream.listen(
      _onMetricsReceived,
    );

    // Start periodic performance snapshots
    _monitoringTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _capturePerformanceSnapshot();
    });

    developer.log(
      'Performance monitoring started',
      name: 'PerformanceMonitor',
      level: 800,
    );
  }

  /// Stops performance monitoring
  Future<void> stopMonitoring() async {
    if (!_isMonitoring) return;

    _isMonitoring = false;

    await _frameSubscription?.cancel();
    await _metricsSubscription?.cancel();
    _monitoringTimer?.cancel();

    _frameSubscription = null;
    _metricsSubscription = null;
    _monitoringTimer = null;

    developer.log(
      'Performance monitoring stopped',
      name: 'PerformanceMonitor',
      level: 800,
    );
  }

  /// Runs a comprehensive performance test on real device
  Future<PerformanceTestResult> runPerformanceTest({
    Duration testDuration = const Duration(minutes: 2),
  }) async {
    final startTime = DateTime.now();
    final results = <PerformanceSnapshot>[];

    developer.log(
      'Starting ${testDuration.inSeconds}s performance test on real device',
      name: 'PerformanceMonitor',
      level: 800,
    );

    await startMonitoring();

    // Run test for specified duration
    await Future.delayed(testDuration);

    await stopMonitoring();

    // Collect results
    results.addAll(_snapshots);

    final endTime = DateTime.now();
    final actualDuration = endTime.difference(startTime);

    // Analyze results
    final testResult = _analyzePerformanceResults(results, actualDuration);

    developer.log(
      'Performance test completed: ${testResult.summary}',
      name: 'PerformanceMonitor',
      level: 800,
    );

    return testResult;
  }

  /// Gets current performance status
  PerformanceStatus getCurrentPerformanceStatus() {
    if (_snapshots.isEmpty) {
      return PerformanceStatus.unknown;
    }

    final latest = _snapshots.last;
    return _evaluatePerformanceSnapshot(latest);
  }

  /// Gets performance history for analysis
  List<PerformanceSnapshot> getPerformanceHistory() {
    return List.unmodifiable(_snapshots);
  }

  /// Validates if current performance meets production requirements
  bool validateProductionReadiness() {
    if (_snapshots.length < 10) return false; // Need sufficient data

    final recentSnapshots = _snapshots.take(10).toList();

    // Check if recent performance consistently meets targets
    final goodPerformanceCount =
        recentSnapshots
            .where(
              (snapshot) =>
                  _evaluatePerformanceSnapshot(snapshot) ==
                  PerformanceStatus.excellent,
            )
            .length;

    return goodPerformanceCount >= 8; // 80% of recent samples must be excellent
  }

  // Private methods

  void _onFrameReceived(FrameData frameData) {
    // Log frame processing performance
    if (frameData.processingTimeMs != null) {
      final status =
          frameData.processingTimeMs! <= _targetProcessingTimeMs
              ? 'FAST'
              : frameData.processingTimeMs! <= _maxAcceptableProcessingTimeMs
              ? 'ACCEPTABLE'
              : 'SLOW';

      developer.log(
        'Frame processed: ${frameData.processingTimeMs}ms [$status] - ${frameData.sizeString}',
        name: 'PerformanceMonitor',
        level:
            frameData.processingTimeMs! > _maxAcceptableProcessingTimeMs
                ? 900
                : 700,
      );
    }
  }

  void _onMetricsReceived(FrameCaptureMetrics metrics) {
    // Log real-time metrics
    developer.log(
      'FPS: ${metrics.currentFps.toStringAsFixed(1)} | '
      'Avg Processing: ${metrics.averageProcessingTimeMs.toStringAsFixed(1)}ms | '
      'Success Rate: ${metrics.successRate.toStringAsFixed(1)}%',
      name: 'PerformanceMonitor',
      level: 700,
    );
  }

  void _capturePerformanceSnapshot() {
    final metrics = _frameCaptureService.metrics;
    final snapshot = PerformanceSnapshot(
      timestamp: DateTime.now(),
      currentFps: metrics.currentFps,
      averageProcessingTimeMs: metrics.averageProcessingTimeMs,
      successRate: metrics.successRate,
      totalFramesProcessed: metrics.totalFrames,
      memoryUsageMB: metrics.currentMemoryUsage / (1024 * 1024),
      throughput: metrics.throughputString,
    );

    _snapshots.add(snapshot);

    // Keep only recent snapshots (last 100)
    if (_snapshots.length > 100) {
      _snapshots.removeAt(0);
    }

    // Log performance status
    final status = _evaluatePerformanceSnapshot(snapshot);
    developer.log(
      'Performance snapshot: $status - ${snapshot.summary}',
      name: 'PerformanceMonitor',
      level: status == PerformanceStatus.poor ? 900 : 700,
    );
  }

  PerformanceStatus _evaluatePerformanceSnapshot(PerformanceSnapshot snapshot) {
    // Evaluate FPS
    if (snapshot.currentFps >= _targetFps &&
        snapshot.averageProcessingTimeMs <= _targetProcessingTimeMs &&
        snapshot.successRate >= 95.0) {
      return PerformanceStatus.excellent;
    }

    if (snapshot.currentFps >= _minAcceptableFps &&
        snapshot.averageProcessingTimeMs <= _maxAcceptableProcessingTimeMs &&
        snapshot.successRate >= 90.0) {
      return PerformanceStatus.good;
    }

    if (snapshot.currentFps >= 15.0 &&
        snapshot.averageProcessingTimeMs <= 100.0 &&
        snapshot.successRate >= 80.0) {
      return PerformanceStatus.acceptable;
    }

    return PerformanceStatus.poor;
  }

  PerformanceTestResult _analyzePerformanceResults(
    List<PerformanceSnapshot> snapshots,
    Duration testDuration,
  ) {
    if (snapshots.isEmpty) {
      return PerformanceTestResult(
        testDuration: testDuration,
        totalSnapshots: 0,
        averageFps: 0.0,
        averageProcessingTime: 0.0,
        averageSuccessRate: 0.0,
        peakMemoryUsageMB: 0.0,
        overallStatus: PerformanceStatus.unknown,
        passedValidation: false,
        summary: 'No performance data collected',
        recommendations: ['Check if frame capture is working correctly'],
      );
    }

    // Calculate averages
    final averageFps =
        snapshots.map((s) => s.currentFps).reduce((a, b) => a + b) /
        snapshots.length;
    final averageProcessingTime =
        snapshots
            .map((s) => s.averageProcessingTimeMs)
            .reduce((a, b) => a + b) /
        snapshots.length;
    final averageSuccessRate =
        snapshots.map((s) => s.successRate).reduce((a, b) => a + b) /
        snapshots.length;
    final peakMemoryUsage = snapshots
        .map((s) => s.memoryUsageMB)
        .reduce((a, b) => a > b ? a : b);

    // Determine overall status
    final statusCounts = <PerformanceStatus, int>{};
    for (final snapshot in snapshots) {
      final status = _evaluatePerformanceSnapshot(snapshot);
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
    }

    final dominantStatus =
        statusCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    // Generate recommendations
    final recommendations = <String>[];

    if (averageFps < _targetFps) {
      recommendations.add(
        'FPS below target: Consider reducing frame resolution or quality',
      );
    }

    if (averageProcessingTime > _targetProcessingTimeMs) {
      recommendations.add(
        'Processing time too high: Optimize image conversion algorithms',
      );
    }

    if (averageSuccessRate < 95.0) {
      recommendations.add(
        'Success rate below target: Improve error handling and recovery',
      );
    }

    if (peakMemoryUsage > 100.0) {
      recommendations.add(
        'High memory usage detected: Implement better memory management',
      );
    }

    if (recommendations.isEmpty) {
      recommendations.add(
        'Performance meets all targets - ready for production',
      );
    }

    final passedValidation =
        averageFps >= _minAcceptableFps &&
        averageProcessingTime <= _maxAcceptableProcessingTimeMs &&
        averageSuccessRate >= 90.0;

    return PerformanceTestResult(
      testDuration: testDuration,
      totalSnapshots: snapshots.length,
      averageFps: averageFps,
      averageProcessingTime: averageProcessingTime,
      averageSuccessRate: averageSuccessRate,
      peakMemoryUsageMB: peakMemoryUsage,
      overallStatus: dominantStatus,
      passedValidation: passedValidation,
      summary: _generateTestSummary(
        dominantStatus,
        averageFps,
        averageProcessingTime,
      ),
      recommendations: recommendations,
    );
  }

  String _generateTestSummary(
    PerformanceStatus status,
    double fps,
    double processingTime,
  ) {
    switch (status) {
      case PerformanceStatus.excellent:
        return 'EXCELLENT: ${fps.toStringAsFixed(1)} FPS, ${processingTime.toStringAsFixed(1)}ms processing';
      case PerformanceStatus.good:
        return 'GOOD: ${fps.toStringAsFixed(1)} FPS, ${processingTime.toStringAsFixed(1)}ms processing';
      case PerformanceStatus.acceptable:
        return 'ACCEPTABLE: ${fps.toStringAsFixed(1)} FPS, ${processingTime.toStringAsFixed(1)}ms processing';
      case PerformanceStatus.poor:
        return 'POOR: ${fps.toStringAsFixed(1)} FPS, ${processingTime.toStringAsFixed(1)}ms processing';
      case PerformanceStatus.unknown:
        return 'UNKNOWN: Insufficient data';
    }
  }

  void dispose() {
    stopMonitoring();
    _snapshots.clear();
  }
}

/// Performance status enumeration
enum PerformanceStatus { excellent, good, acceptable, poor, unknown }

/// Performance snapshot at a point in time
class PerformanceSnapshot {
  const PerformanceSnapshot({
    required this.timestamp,
    required this.currentFps,
    required this.averageProcessingTimeMs,
    required this.successRate,
    required this.totalFramesProcessed,
    required this.memoryUsageMB,
    required this.throughput,
  });

  final DateTime timestamp;
  final double currentFps;
  final double averageProcessingTimeMs;
  final double successRate;
  final int totalFramesProcessed;
  final double memoryUsageMB;
  final String throughput;

  String get summary =>
      '${currentFps.toStringAsFixed(1)} FPS, '
      '${averageProcessingTimeMs.toStringAsFixed(1)}ms, '
      '${successRate.toStringAsFixed(1)}% success, '
      '${memoryUsageMB.toStringAsFixed(1)}MB memory';
}

/// Result of a performance test
class PerformanceTestResult {
  const PerformanceTestResult({
    required this.testDuration,
    required this.totalSnapshots,
    required this.averageFps,
    required this.averageProcessingTime,
    required this.averageSuccessRate,
    required this.peakMemoryUsageMB,
    required this.overallStatus,
    required this.passedValidation,
    required this.summary,
    required this.recommendations,
  });

  final Duration testDuration;
  final int totalSnapshots;
  final double averageFps;
  final double averageProcessingTime;
  final double averageSuccessRate;
  final double peakMemoryUsageMB;
  final PerformanceStatus overallStatus;
  final bool passedValidation;
  final String summary;
  final List<String> recommendations;

  /// Generates a detailed report for debugging
  String generateDetailedReport() {
    final buffer = StringBuffer();

    buffer.writeln('═══ PERFORMANCE TEST REPORT ═══');
    buffer.writeln('Test Duration: ${testDuration.inSeconds}s');
    buffer.writeln('Total Snapshots: $totalSnapshots');
    buffer.writeln('');
    buffer.writeln('PERFORMANCE METRICS:');
    buffer.writeln('• Average FPS: ${averageFps.toStringAsFixed(2)}');
    buffer.writeln(
      '• Average Processing Time: ${averageProcessingTime.toStringAsFixed(2)}ms',
    );
    buffer.writeln(
      '• Average Success Rate: ${averageSuccessRate.toStringAsFixed(2)}%',
    );
    buffer.writeln(
      '• Peak Memory Usage: ${peakMemoryUsageMB.toStringAsFixed(2)}MB',
    );
    buffer.writeln('');
    buffer.writeln('OVERALL STATUS: ${overallStatus.name.toUpperCase()}');
    buffer.writeln('VALIDATION: ${passedValidation ? "PASSED" : "FAILED"}');
    buffer.writeln('');
    buffer.writeln('SUMMARY: $summary');
    buffer.writeln('');
    buffer.writeln('RECOMMENDATIONS:');
    for (int i = 0; i < recommendations.length; i++) {
      buffer.writeln('${i + 1}. ${recommendations[i]}');
    }
    buffer.writeln('═══════════════════════════════');

    return buffer.toString();
  }
}
