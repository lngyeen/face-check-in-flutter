import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/check_in_bloc.dart';
import '../models/face_detection_result.dart';

/// Widget to display current face detection status with visual indicators
class FaceDetectionStatusWidget extends StatelessWidget {
  const FaceDetectionStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen: (previous, current) =>
          previous.faceStatus != current.faceStatus ||
          previous.faceConfidence != current.faceConfidence ||
          previous.detectedFaces.length != current.detectedFaces.length,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getStatusBackgroundColor(state.faceStatus),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getStatusColor(state.faceStatus),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _getStatusColor(state.faceStatus).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Status icon with animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getStatusColor(state.faceStatus),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getStatusIcon(state.faceStatus),
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              // Status text and details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _getStatusText(state.faceStatus),
                      style: TextStyle(
                        color: _getStatusColor(state.faceStatus),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (state.detectedFaces.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        _getDetailText(state),
                        style: TextStyle(
                          color: _getStatusColor(state.faceStatus).withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Face count indicator
              if (state.detectedFaces.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(state.faceStatus),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${state.detectedFaces.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
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
        return Colors.red.shade700;
    }
  }

  Color _getStatusBackgroundColor(FaceDetectionStatus status) {
    return _getStatusColor(status).withValues(alpha: 0.1);
  }

  IconData _getStatusIcon(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.none:
        return Icons.face_retouching_off;
      case FaceDetectionStatus.detecting:
        return Icons.face_retouching_natural;
      case FaceDetectionStatus.faceFound:
        return Icons.face;
      case FaceDetectionStatus.multipleFaces:
        return Icons.groups;
      case FaceDetectionStatus.noFace:
        return Icons.face_retouching_off;
      case FaceDetectionStatus.error:
        return Icons.error;
    }
  }

  String _getStatusText(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.none:
        return 'No Detection';
      case FaceDetectionStatus.detecting:
        return 'Detecting...';
      case FaceDetectionStatus.faceFound:
        return 'Face Detected';
      case FaceDetectionStatus.multipleFaces:
        return 'Multiple Faces';
      case FaceDetectionStatus.noFace:
        return 'No Face Found';
      case FaceDetectionStatus.error:
        return 'Detection Error';
    }
  }

  String _getDetailText(CheckInState state) {
    if (state.detectedFaces.isEmpty) return '';
    
    final recognizedFaces = state.detectedFaces.where((face) => face.isRecognized).length;
    final averageConfidence = state.faceConfidence;
    
    if (recognizedFaces > 0) {
      return 'Recognized: $recognizedFaces • Confidence: ${(averageConfidence * 100).toStringAsFixed(1)}%';
    } else {
      return 'Unknown faces • Confidence: ${(averageConfidence * 100).toStringAsFixed(1)}%';
    }
  }
} 