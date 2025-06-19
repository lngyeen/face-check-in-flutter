import 'package:flutter/material.dart';
import 'package:face_check_in_flutter/core/models/face_detection_result.dart';

class FaceDetectionPainter extends CustomPainter {
  final List<FaceDetectionResult> faces;
  final Size imageSize;

  FaceDetectionPainter({required this.faces, required this.imageSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..color = Colors.red;

    for (final face in faces) {
      final rect = _scaleRect(
        Rect.fromLTWH(face.x, face.y, face.width, face.height),
        imageSize,
        size,
      );
      canvas.drawRect(rect, paint);

      final textSpan = TextSpan(
        text:
            'ID: ${face.id}\nConf: ${(face.confidence * 100).toStringAsFixed(2)}%',
        style: const TextStyle(color: Colors.white, fontSize: 12.0),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, rect.topLeft.translate(0, -textPainter.height));
    }
  }

  @override
  bool shouldRepaint(FaceDetectionPainter oldDelegate) {
    return oldDelegate.faces != faces || oldDelegate.imageSize != imageSize;
  }

  Rect _scaleRect(Rect rect, Size imageSize, Size widgetSize) {
    final scaleX = widgetSize.width / imageSize.height;
    final scaleY = widgetSize.height / imageSize.width;

    final scaledLeft = rect.left * scaleX;
    final scaledTop = rect.top * scaleY;
    final scaledRight = rect.right * scaleX;
    final scaledBottom = rect.bottom * scaleY;

    return Rect.fromLTRB(scaledLeft, scaledTop, scaledRight, scaledBottom);
  }
}
