import 'package:flutter/material.dart';
import '../../../core/config/debug_config.dart';
import 'debug_view_widget.dart';
import 'face_detection_debug_widget.dart';
import 'streaming_metrics_widget.dart';

/// A container widget that wraps content with a debug view
class DebugViewContainer extends StatelessWidget {
  final Widget child;

  const DebugViewContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!DebugConfig.isDebugViewEnabled) return child;

    return Column(
      children: [
        Expanded(child: child),
        // Streaming metrics for Phase 4
        const StreamingMetricsWidget(),
        // Face detection metrics for Phase 3
        const FaceDetectionDebugWidget(),
        // Original debug log view
        const DebugViewWidget(),
      ],
    );
  }
}
