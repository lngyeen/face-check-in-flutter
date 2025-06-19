import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/services/performance_monitor.dart';

/// Debug widget for displaying real-time performance metrics
/// Only shown in debug builds
class PerformanceDebugWidget extends StatefulWidget {
  const PerformanceDebugWidget({
    super.key,
    required this.performanceMonitor,
    this.isVisible = true,
  });

  final PerformanceMonitor performanceMonitor;
  final bool isVisible;

  @override
  State<PerformanceDebugWidget> createState() => _PerformanceDebugWidgetState();
}

class _PerformanceDebugWidgetState extends State<PerformanceDebugWidget> {
  Timer? _updateTimer;
  PerformanceSnapshot? _latestSnapshot;
  PerformanceStatus _currentStatus = PerformanceStatus.unknown;
  bool _isMonitoring = false;

  @override
  void initState() {
    super.initState();
    _startPerformanceTracking();
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  void _startPerformanceTracking() {
    // Update performance display every second
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          final history = widget.performanceMonitor.getPerformanceHistory();
          if (history.isNotEmpty) {
            _latestSnapshot = history.last;
            _currentStatus =
                widget.performanceMonitor.getCurrentPerformanceStatus();
          }
        });
      }
    });
  }

  Future<void> _startMonitoring() async {
    await widget.performanceMonitor.startMonitoring();
    setState(() {
      _isMonitoring = true;
    });
  }

  Future<void> _stopMonitoring() async {
    await widget.performanceMonitor.stopMonitoring();
    setState(() {
      _isMonitoring = false;
    });
  }

  Future<void> _runPerformanceTest() async {
    if (!_isMonitoring) {
      await _startMonitoring();
    }

    // Show loading dialog
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => const AlertDialog(
              title: Text('Running Performance Test'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Testing frame capture performance on real device...\nThis will take 2 minutes.',
                  ),
                ],
              ),
            ),
      );
    }

    try {
      final result = await widget.performanceMonitor.runPerformanceTest(
        testDuration: const Duration(minutes: 2),
      );

      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog

        // Show results dialog
        showDialog(
          context: context,
          builder: (context) => _PerformanceTestResultDialog(result: result),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Performance test failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || !widget.isVisible) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _getStatusColor(), width: 2.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          if (_latestSnapshot != null) ...[
            _buildMetricsDisplay(),
            const SizedBox(height: 8),
          ],
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.analytics, color: _getStatusColor(), size: 16),
        const SizedBox(width: 8),
        Text(
          'Performance Monitor',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getStatusColor(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            _currentStatus.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsDisplay() {
    final snapshot = _latestSnapshot!;

    return Column(
      children: [
        _buildMetricRow(
          'FPS',
          '${snapshot.currentFps.toStringAsFixed(1)}',
          snapshot.currentFps >= 25.0,
        ),
        _buildMetricRow(
          'Processing',
          '${snapshot.averageProcessingTimeMs.toStringAsFixed(1)}ms',
          snapshot.averageProcessingTimeMs <= 50.0,
        ),
        _buildMetricRow(
          'Success Rate',
          '${snapshot.successRate.toStringAsFixed(1)}%',
          snapshot.successRate >= 90.0,
        ),
        _buildMetricRow(
          'Memory',
          '${snapshot.memoryUsageMB.toStringAsFixed(1)}MB',
          snapshot.memoryUsageMB <= 100.0,
        ),
        _buildMetricRow('Throughput', snapshot.throughput, true),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value, bool isGood) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            isGood ? Icons.check_circle : Icons.warning,
            color: isGood ? Colors.green : Colors.orange,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: isGood ? Colors.green : Colors.orange,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      children: [
        _buildControlButton(
          label: _isMonitoring ? 'Stop' : 'Start',
          icon: _isMonitoring ? Icons.stop : Icons.play_arrow,
          onPressed: _isMonitoring ? _stopMonitoring : _startMonitoring,
          color: _isMonitoring ? Colors.red : Colors.green,
        ),
        const SizedBox(width: 8),
        _buildControlButton(
          label: 'Test',
          icon: Icons.speed,
          onPressed: _runPerformanceTest,
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 12),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (_currentStatus) {
      case PerformanceStatus.excellent:
        return Colors.green;
      case PerformanceStatus.good:
        return Colors.lightGreen;
      case PerformanceStatus.acceptable:
        return Colors.yellow;
      case PerformanceStatus.poor:
        return Colors.red;
      case PerformanceStatus.unknown:
        return Colors.grey;
    }
  }
}

/// Dialog to display performance test results
class _PerformanceTestResultDialog extends StatelessWidget {
  const _PerformanceTestResultDialog({required this.result});

  final PerformanceTestResult result;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            result.passedValidation ? Icons.check_circle : Icons.error,
            color: result.passedValidation ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(
            'Performance Test ${result.passedValidation ? 'PASSED' : 'FAILED'}',
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.summary,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildResultMetric(
              'Test Duration',
              '${result.testDuration.inSeconds}s',
            ),
            _buildResultMetric(
              'Average FPS',
              result.averageFps.toStringAsFixed(2),
            ),
            _buildResultMetric(
              'Processing Time',
              '${result.averageProcessingTime.toStringAsFixed(2)}ms',
            ),
            _buildResultMetric(
              'Success Rate',
              '${result.averageSuccessRate.toStringAsFixed(2)}%',
            ),
            _buildResultMetric(
              'Peak Memory',
              '${result.peakMemoryUsageMB.toStringAsFixed(2)}MB',
            ),
            const SizedBox(height: 16),
            const Text(
              'Recommendations:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...result.recommendations.map(
              (rec) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Text('• $rec', style: const TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            // Copy detailed report to clipboard
            final report = result.generateDetailedReport();
            debugPrint(report); // Print to console for debugging
            Navigator.of(context).pop();
          },
          child: const Text('Copy Report'),
        ),
      ],
    );
  }

  Widget _buildResultMetric(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
