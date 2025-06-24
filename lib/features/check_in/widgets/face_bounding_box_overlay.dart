import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/check_in_bloc.dart';
import '../models/face_detection_result.dart';

/// Overlay widget that draws bounding boxes for detected faces
class FaceBoundingBoxOverlay extends StatelessWidget {
  final Widget child;
  final Size previewSize;
  
  const FaceBoundingBoxOverlay({
    super.key,
    required this.child,
    required this.previewSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen: (previous, current) =>
          previous.detectedFaces != current.detectedFaces ||
          previous.faceStatus != current.faceStatus,
      builder: (context, state) {
        return Stack(
          children: [
            child,
            if (state.detectedFaces.isNotEmpty)
              Positioned.fill(
                child: CustomPaint(
                  painter: FaceBoundingBoxPainter(
                    faces: state.detectedFaces,
                    previewSize: previewSize,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Custom painter for drawing face bounding boxes
class FaceBoundingBoxPainter extends CustomPainter {
  final List<DetectedFace> faces;
  final Size previewSize;
  
  FaceBoundingBoxPainter({
    required this.faces,
    required this.previewSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (faces.isEmpty) return;

    for (int i = 0; i < faces.length; i++) {
      final face = faces[i];
      _drawFaceBoundingBox(canvas, size, face, i);
    }
  }

  void _drawFaceBoundingBox(Canvas canvas, Size size, DetectedFace face, int index) {
    // Convert normalized coordinates to screen coordinates
    final rect = _convertToScreenRect(face.box, size);
    
    // Choose colors based on recognition status
    final isRecognized = face.isRecognized;
    final boxColor = isRecognized ? Colors.green : Colors.orange;
    final confidence = face.confidence;
    
    // Draw main bounding box
    final boxPaint = Paint()
      ..color = boxColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    
    canvas.drawRect(rect, boxPaint);
    
    // Draw corner accents for better visibility
    _drawCornerAccents(canvas, rect, boxColor);
    
    // Draw face info background
    final labelHeight = 60.0;
    final labelRect = Rect.fromLTWH(
      rect.left,
      rect.top - labelHeight,
      rect.width.clamp(120.0, 200.0),
      labelHeight,
    );
    
    final backgroundPaint = Paint()
      ..color = boxColor.withValues(alpha: 0.8);
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(labelRect, const Radius.circular(8)),
      backgroundPaint,
    );
    
    // Draw face information text
    _drawFaceInfo(canvas, labelRect, face, index);
  }

  void _drawCornerAccents(Canvas canvas, Rect rect, Color color) {
    final accentPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;
    
    const accentLength = 20.0;
    
    // Top-left corner
    canvas.drawLine(
      Offset(rect.left, rect.top),
      Offset(rect.left + accentLength, rect.top),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.left, rect.top),
      Offset(rect.left, rect.top + accentLength),
      accentPaint,
    );
    
    // Top-right corner
    canvas.drawLine(
      Offset(rect.right, rect.top),
      Offset(rect.right - accentLength, rect.top),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.right, rect.top),
      Offset(rect.right, rect.top + accentLength),
      accentPaint,
    );
    
    // Bottom-left corner
    canvas.drawLine(
      Offset(rect.left, rect.bottom),
      Offset(rect.left + accentLength, rect.bottom),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.left, rect.bottom),
      Offset(rect.left, rect.bottom - accentLength),
      accentPaint,
    );
    
    // Bottom-right corner
    canvas.drawLine(
      Offset(rect.right, rect.bottom),
      Offset(rect.right - accentLength, rect.bottom),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.right, rect.bottom),
      Offset(rect.right, rect.bottom - accentLength),
      accentPaint,
    );
  }

  void _drawFaceInfo(Canvas canvas, Rect labelRect, DetectedFace face, int index) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    // Face identifier
    final faceText = face.isRecognized 
        ? (face.employeeName ?? 'Recognized')
        : 'Face ${index + 1}';
    
    textPainter.text = TextSpan(
      text: faceText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        labelRect.left + 8,
        labelRect.top + 8,
      ),
    );
    
    // Confidence level
    final confidenceText = '${(face.confidence * 100).toStringAsFixed(1)}%';
    textPainter.text = TextSpan(
      text: confidenceText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        labelRect.left + 8,
        labelRect.top + 28,
      ),
    );
    
    // Recognition status icon
    if (face.isRecognized) {
      final iconPainter = TextPainter(
        text: const TextSpan(
          text: '✓',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      iconPainter.layout();
      iconPainter.paint(
        canvas,
        Offset(
          labelRect.right - 24,
          labelRect.top + 8,
        ),
      );
    }
  }

  Rect _convertToScreenRect(List<double> box, Size screenSize) {
    // box format: [x, y, width, height] in normalized coordinates (0-1)
    if (box.length != 4) {
      return Rect.zero;
    }
    
    // Convert from normalized coordinates to screen coordinates
    final left = box[0] * screenSize.width;
    final top = box[1] * screenSize.height;
    final width = box[2] * screenSize.width;
    final height = box[3] * screenSize.height;
    
    return Rect.fromLTWH(left, top, width, height);
  }

  @override
  bool shouldRepaint(FaceBoundingBoxPainter oldDelegate) {
    return faces != oldDelegate.faces || previewSize != oldDelegate.previewSize;
  }
} 