import 'package:flutter/material.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/core/enums/face_detection_status.dart';

class FaceDetectionDebugWidget extends StatelessWidget {
  final CheckInState state;

  const FaceDetectionDebugWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Face Detection Stats',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            _buildMetric(
              'Status',
              state.faceDetectionStatus.name.toUpperCase(),
              _getStatusColor(state.faceDetectionStatus),
            ),
            _buildMetric(
              'Detected Faces',
              state.detectedFaces.length.toString(),
            ),
            _buildMetric(
              'Confidence',
              '${(state.primaryFaceConfidence * 100).toStringAsFixed(1)}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value, [Color? color]) {
    return Text(
      '$label: $value',
      style: TextStyle(color: color ?? Colors.white, fontSize: 12),
    );
  }

  Color _getStatusColor(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.faceFound:
        return Colors.green;
      case FaceDetectionStatus.noFace:
        return Colors.yellow;
      case FaceDetectionStatus.multipleFaces:
        return Colors.orange;
      case FaceDetectionStatus.error:
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}
