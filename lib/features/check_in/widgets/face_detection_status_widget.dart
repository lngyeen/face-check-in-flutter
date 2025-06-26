import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/check_in_bloc.dart';
import '../models/face_detection_result.dart';

/// Widget to display current face detection status with visual indicators
/// Uses debouncing to provide stable display and avoid flickering
class FaceDetectionStatusWidget extends StatefulWidget {
  const FaceDetectionStatusWidget({super.key});

  @override
  State<FaceDetectionStatusWidget> createState() =>
      _FaceDetectionStatusWidgetState();
}

class _FaceDetectionStatusWidgetState extends State<FaceDetectionStatusWidget> {
  Timer? _debounceTimer;
  FaceDetectionStatus _stableStatus = FaceDetectionStatus.none;
  List<DetectedFace> _stableFaces = [];
  double _stableConfidence = 0.0;

  // Debounce duration - only update UI after status is stable for this duration
  static const Duration _debounceDuration = Duration(milliseconds: 1500);

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _updateStableStatus(
    FaceDetectionStatus newStatus,
    List<DetectedFace> newFaces,
    double newConfidence,
  ) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Start new timer
    _debounceTimer = Timer(_debounceDuration, () {
      if (mounted) {
        setState(() {
          _stableStatus = newStatus;
          _stableFaces = List.from(newFaces);
          _stableConfidence = newConfidence;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.faceStatus != current.faceStatus ||
              previous.faceConfidence != current.faceConfidence ||
              previous.detectedFaces.length != current.detectedFaces.length,
      builder: (context, state) {
        // Trigger debounce update when new data comes in
        _updateStableStatus(
          state.faceStatus,
          state.detectedFaces,
          state.faceConfidence,
        );

        // Use stable state for UI display
        final displayStatus = _stableStatus;
        final displayFaces = _stableFaces;
        final displayConfidence = _stableConfidence;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getStatusBackgroundColor(displayStatus),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _getStatusColor(displayStatus), width: 2),
            boxShadow: [
              BoxShadow(
                color: _getStatusColor(displayStatus).withValues(alpha: 0.3),
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
                  color: _getStatusColor(displayStatus),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getStatusIcon(displayStatus),
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
                      _getStatusText(displayStatus),
                      style: TextStyle(
                        color: _getStatusColor(displayStatus),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (displayFaces.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        _getDetailText(displayFaces, displayConfidence),
                        style: TextStyle(
                          color: _getStatusColor(
                            displayStatus,
                          ).withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Face count indicator
              if (displayFaces.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(displayStatus),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${displayFaces.length}',
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

  String _getDetailText(List<DetectedFace> faces, double confidence) {
    if (faces.isEmpty) return '';

    final recognizedFaces = faces.where((face) => face.isRecognized).length;

    if (recognizedFaces > 0) {
      return 'Recognized: $recognizedFaces • Confidence: ${(confidence * 100).toStringAsFixed(1)}%';
    } else {
      return 'Unknown faces • Confidence: ${(confidence * 100).toStringAsFixed(1)}%';
    }
  }
}
