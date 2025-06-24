import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/check_in_bloc.dart';

/// Widget to display real-time streaming metrics and performance data
class StreamingMetricsWidget extends StatelessWidget {
  const StreamingMetricsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen: (previous, current) =>
          previous.streamingStatus != current.streamingStatus ||
          previous.currentFrameRate != current.currentFrameRate ||
          previous.framesProcessed != current.framesProcessed ||
          previous.lastFrameSent != current.lastFrameSent ||
          previous.connectionStatus != current.connectionStatus,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.1),
            border: Border.all(color: Colors.purple, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 8),
              _buildStreamingStatus(state),
              const SizedBox(height: 8),
              _buildPerformanceMetrics(state),
              const SizedBox(height: 8),
              _buildConnectionMetrics(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Icon(Icons.speed, color: Colors.purple, size: 16),
        SizedBox(width: 4),
        Text(
          'Streaming Metrics',
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStreamingStatus(CheckInState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Streaming Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _getStreamingStatusColor(state.streamingStatus),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _getStreamingStatusText(state.streamingStatus),
              style: TextStyle(
                color: _getStreamingStatusColor(state.streamingStatus),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics(CheckInState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Metrics:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        _buildMetricRow('Current FPS', '${state.currentFrameRate.toStringAsFixed(1)}'),
        _buildMetricRow('Frames Processed', '${state.framesProcessed}'),
        if (state.lastFrameSent != null) ...[
          _buildMetricRow(
            'Last Frame Sent', 
            _formatTime(state.lastFrameSent!),
          ),
        ],
        _buildMetricRow(
          'Frame Rate Status', 
          _getFrameRateStatus(state.currentFrameRate),
        ),
      ],
    );
  }

  Widget _buildConnectionMetrics(CheckInState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connection Metrics:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        _buildMetricRow('Connection Status', _getConnectionStatusText(state.connectionStatus)),
        _buildMetricRow('Connection Attempts', '${state.connectionAttempts}'),
        if (state.lastConnectionAttempt != null) ...[
          _buildMetricRow(
            'Last Connection', 
            _formatTime(state.lastConnectionAttempt!),
          ),
        ],
        if (state.connectionError != null) ...[
          _buildMetricRow('Last Error', state.connectionError!, isError: true),
        ],
      ],
    );
  }

  Widget _buildMetricRow(String label, String value, {bool isError = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isError ? Colors.red : Colors.white,
                fontSize: 11,
                fontWeight: isError ? FontWeight.w500 : FontWeight.normal,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStreamingStatusColor(StreamingStatus status) {
    switch (status) {
      case StreamingStatus.idle:
        return Colors.grey;
      case StreamingStatus.starting:
        return Colors.blue;
      case StreamingStatus.active:
        return Colors.green;
      case StreamingStatus.paused:
        return Colors.orange;
      case StreamingStatus.stopping:
        return Colors.yellow;
      case StreamingStatus.error:
        return Colors.red;
    }
  }

  String _getStreamingStatusText(StreamingStatus status) {
    switch (status) {
      case StreamingStatus.idle:
        return 'Idle';
      case StreamingStatus.starting:
        return 'Starting...';
      case StreamingStatus.active:
        return 'Active';
      case StreamingStatus.paused:
        return 'Paused';
      case StreamingStatus.stopping:
        return 'Stopping...';
      case StreamingStatus.error:
        return 'Error';
    }
  }

  String _getConnectionStatusText(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.disconnected:
        return 'Disconnected';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.failed:
        return 'Failed';
      case ConnectionStatus.timeout:
        return 'Timeout';
      case ConnectionStatus.retrying:
        return 'Retrying...';
    }
  }

  String _getFrameRateStatus(double fps) {
    if (fps >= 25) return 'Excellent';
    if (fps >= 20) return 'Good';
    if (fps >= 15) return 'Fair';
    if (fps >= 10) return 'Poor';
    return 'Very Poor';
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    
    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }
} 