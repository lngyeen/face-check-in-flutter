import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/check_in_bloc.dart';
import '../models/face_detection_result.dart';

/// Widget to display face detection metrics and statistics in debug view
class FaceDetectionDebugWidget extends StatelessWidget {
  const FaceDetectionDebugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 8),
              _buildCurrentDetection(state),
              const SizedBox(height: 8),
              _buildStatistics(state.recognitionStats),
              if (state.detectedFaces.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildDetectedFaces(state.detectedFaces),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Icon(Icons.face, color: Colors.blue, size: 16),
        SizedBox(width: 4),
        Text(
          'Face Detection Metrics',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentDetection(CheckInState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Status: ${_getStatusText(state.faceStatus)}',
          style: TextStyle(
            color: _getStatusColor(state.faceStatus),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (state.faceConfidence > 0) ...[
          Text(
            'Avg Confidence: ${(state.faceConfidence * 100).toStringAsFixed(1)}%',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
        if (state.lastFaceDetection != null) ...[
          Text(
            'Last Detection: ${_formatTime(state.lastFaceDetection!)}',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
        Text(
          'Faces Found: ${state.detectedFaces.length}',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStatistics(RecognitionStatistics stats) {
    final successRate = stats.totalFramesProcessed > 0 
        ? (stats.successfulRecognitions / stats.totalFramesProcessed * 100)
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Session Statistics:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        _buildStatRow('Frames Processed', '${stats.totalFramesProcessed}'),
        _buildStatRow('Total Faces', '${stats.totalFacesDetected}'),
        _buildStatRow('Successful', '${stats.successfulRecognitions}'),
        _buildStatRow('Failed', '${stats.failedRecognitions}'),
        _buildStatRow('Success Rate', '${successRate.toStringAsFixed(1)}%'),
        if (stats.averageConfidence > 0) ...[
          _buildStatRow(
            'Avg Confidence', 
            '${(stats.averageConfidence * 100).toStringAsFixed(1)}%',
          ),
        ],
        if (stats.lastRecognitionTime != null) ...[
          _buildStatRow(
            'Last Recognition', 
            _formatTime(stats.lastRecognitionTime!),
          ),
        ],
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectedFaces(List<DetectedFace> faces) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detected Faces:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        ...faces.asMap().entries.map((entry) {
          final index = entry.key;
          final face = entry.value;
          return _buildFaceInfo(index + 1, face);
        }),
      ],
    );
  }

  Widget _buildFaceInfo(int index, DetectedFace face) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: face.isRecognized 
            ? Colors.green.withValues(alpha: 0.2)
            : Colors.orange.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Face $index: ${face.isRecognized ? "✓ ${face.employeeName ?? 'Recognized'}" : "? Unknown"}',
            style: TextStyle(
              color: face.isRecognized ? Colors.green : Colors.orange,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Confidence: ${(face.confidence * 100).toStringAsFixed(1)}%',
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
          Text(
            'Box: [${face.box.map((b) => b.toStringAsFixed(0)).join(', ')}]',
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }

  String _getStatusText(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.none:
        return 'None';
      case FaceDetectionStatus.detecting:
        return 'Detecting...';
      case FaceDetectionStatus.faceFound:
        return 'Face Found';
      case FaceDetectionStatus.multipleFaces:
        return 'Multiple Faces';
      case FaceDetectionStatus.noFace:
        return 'No Face';
      case FaceDetectionStatus.error:
        return 'Error';
    }
  }

  Color _getStatusColor(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.none:
        return Colors.grey;
      case FaceDetectionStatus.detecting:
        return Colors.blue;
      case FaceDetectionStatus.faceFound:
        return Colors.green;
      case FaceDetectionStatus.multipleFaces:
        return Colors.orange;
      case FaceDetectionStatus.noFace:
        return Colors.red;
      case FaceDetectionStatus.error:
        return Colors.red;
    }
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