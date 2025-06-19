import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/face_detection_debug_widget.dart';
import 'package:face_check_in_flutter/core/enums/face_detection_status.dart';
import 'package:face_check_in_flutter/core/models/face_detection_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FaceDetectionDebugWidget', () {
    testWidgets('displays correct information from state', (
      WidgetTester tester,
    ) async {
      final state = CheckInState(
        faceDetectionStatus: FaceDetectionStatus.faceFound,
        detectedFaces: [
          FaceDetectionResult(
            id: '1',
            confidence: 0.95,
            x: 10,
            y: 20,
            width: 30,
            height: 40,
          ),
        ],
        primaryFaceConfidence: 0.95,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(children: [FaceDetectionDebugWidget(state: state)]),
          ),
        ),
      );

      expect(find.text('Status: FACEFOUND'), findsOneWidget);
      expect(find.text('Detected Faces: 1'), findsOneWidget);
      expect(find.text('Confidence: 95.0%'), findsOneWidget);
    });
  });
}
