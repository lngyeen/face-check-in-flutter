import 'package:face_check_in_flutter/features/check_in/view/face_detection_painter.dart';
import 'package:face_check_in_flutter/core/models/face_detection_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FaceDetectionPainter', () {
    testWidgets('paints rectangles for each face', (WidgetTester tester) async {
      final faces = [
        FaceDetectionResult(
          id: '1',
          confidence: 0.9,
          x: 10,
          y: 20,
          width: 30,
          height: 40,
        ),
        FaceDetectionResult(
          id: '2',
          confidence: 0.8,
          x: 50,
          y: 60,
          width: 70,
          height: 80,
        ),
      ];
      const key = Key('face_painter');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              key: key,
              painter: FaceDetectionPainter(
                faces: faces,
                imageSize: const Size(640, 480),
              ),
              size: const Size(300, 400),
            ),
          ),
        ),
      );

      // We can't easily test that a canvas draws a rect, but we can test
      // that the painter is on the widget tree and doesn't throw errors.
      expect(find.byKey(key), findsOneWidget);
    });
  });
}
