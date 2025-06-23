import 'package:flutter/material.dart';

import 'camera_preview_widget.dart';

/// Widget that displays the camera preview section with consistent styling and layout
class CameraSection extends StatelessWidget {
  const CameraSection({super.key});

  static const double _cameraPreviewHeight = 400.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _cameraPreviewHeight,
      child: Card(clipBehavior: Clip.antiAlias, child: CameraPreviewWidget()),
    );
  }
}
