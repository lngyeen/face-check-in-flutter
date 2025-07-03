import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/annotated_image_preview_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/stream_config_widget_v2.dart';

class DebugInformationCardV2 extends StatelessWidget {
  const DebugInformationCardV2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBlocV2, CheckInStateV2>(
      // Only rebuild when frame data changes
      buildWhen: (p, c) => p.latestFrameData != c.latestFrameData,
      builder: (context, state) {
        final faces = state.detectedFaces;
        final recognizedCount = faces.where((f) => f.isRecognized).length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Debug Info (V2 - Simple)'),
            Text('Total Faces: ${faces.length}'),
            Text('Recognized Faces: $recognizedCount'),
            if (faces.isNotEmpty) ..._buildFaceInfo(faces),
            if (state.annotatedImage != null)
              AnnotatedImagePreviewV2(annotatedImage: state.annotatedImage!),
            const SizedBox(height: 16),
            const StreamConfigWidgetV2(),
          ],
        );
      },
    );
  }

  List<Widget> _buildFaceInfo(List<FaceDetectionResult> faces) {
    return faces.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final face = entry.value;
      return Text(
        'Face $index: ID: ${face.faceId ?? "N/A"}, Confidence: ${face.confidence.toStringAsFixed(2)}',
      );
    }).toList();
  }
}
