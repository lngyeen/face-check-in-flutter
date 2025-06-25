import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/face_bounding_box_overlay.dart';
import 'package:face_check_in_flutter/features/check_in/models/face_detection_result.dart';

class MockCheckInBloc extends MockBloc<CheckInEvent, CheckInState>
    implements CheckInBloc {}

void main() {
  late MockCheckInBloc mockCheckInBloc;

  setUp(() {
    mockCheckInBloc = MockCheckInBloc();
    when(() => mockCheckInBloc.state).thenReturn(const CheckInState());
  });

  Widget createTestWidget(Widget child) {
    return BlocProvider<CheckInBloc>.value(
      value: mockCheckInBloc,
      child: MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('FaceBoundingBoxOverlay', () {
    const testPreviewSize = Size(640, 480);
    const testChild = SizedBox(
      width: 200,
      height: 200,
      child: Placeholder(),
    );

    testWidgets('renders child widget correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(),
      );

      await tester.pumpWidget(
        createTestWidget(
          const FaceBoundingBoxOverlay(
            previewSize: testPreviewSize,
            child: testChild,
          ),
        ),
      );

      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.byType(FaceBoundingBoxOverlay), findsOneWidget);
    });

    testWidgets('creates widget with provided properties', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(detectedFaces: []),
      );

      await tester.pumpWidget(
        createTestWidget(
          const FaceBoundingBoxOverlay(
            previewSize: testPreviewSize,
            child: testChild,
          ),
        ),
      );

      final overlay = tester.widget<FaceBoundingBoxOverlay>(
        find.byType(FaceBoundingBoxOverlay),
      );
      
      expect(overlay.previewSize, equals(testPreviewSize));
      expect(overlay.child, isA<SizedBox>());
    });

    testWidgets('builds with different face detection states', (tester) async {
      // Test with no faces
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(detectedFaces: []),
      );

      await tester.pumpWidget(
        createTestWidget(
          const FaceBoundingBoxOverlay(
            previewSize: testPreviewSize,
            child: testChild,
          ),
        ),
      );

      expect(find.byType(FaceBoundingBoxOverlay), findsOneWidget);

      // Test with detected faces
      final mockFace = DetectedFace(
        faceId: 'test-face-1',
        box: [100, 150, 200, 250],
        confidence: 0.95,
        isRecognized: false,
        employeeName: null,
      );

      when(() => mockCheckInBloc.state).thenReturn(
        CheckInState(detectedFaces: [mockFace]),
      );

      await tester.pumpWidget(
        createTestWidget(
          const FaceBoundingBoxOverlay(
            previewSize: testPreviewSize,
            child: testChild,
          ),
        ),
      );

      expect(find.byType(FaceBoundingBoxOverlay), findsOneWidget);
    });

    testWidgets('listens to BLoC state changes', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(detectedFaces: []),
      );

      await tester.pumpWidget(
        createTestWidget(
          const FaceBoundingBoxOverlay(
            previewSize: testPreviewSize,
            child: testChild,
          ),
        ),
      );

      expect(find.byType(BlocBuilder<CheckInBloc, CheckInState>), findsOneWidget);
    });
  });

  group('FaceBoundingBoxPainter', () {
    const testSize = Size(400, 300);

    test('initializes correctly with empty faces list', () {
      final painter = FaceBoundingBoxPainter(
        faces: [],
        previewSize: testSize,
      );

      expect(painter.faces, isEmpty);
      expect(painter.previewSize, equals(testSize));
    });

    test('initializes correctly with face data', () {
      final mockFace = DetectedFace(
        faceId: 'test-face-1',
        box: [100, 150, 200, 250],
        confidence: 0.95,
        isRecognized: true,
        employeeName: 'John Doe',
      );

      final painter = FaceBoundingBoxPainter(
        faces: [mockFace],
        previewSize: testSize,
      );

      expect(painter.faces.length, equals(1));
      expect(painter.faces.first.faceId, equals('test-face-1'));
      expect(painter.previewSize, equals(testSize));
    });

    test('handles multiple faces correctly', () {
      final mockFaces = [
        DetectedFace(
          faceId: 'test-face-1',
          box: [100, 150, 200, 250],
          confidence: 0.95,
          isRecognized: true,
          employeeName: 'John Doe',
        ),
        DetectedFace(
          faceId: 'test-face-2',
          box: [300, 150, 400, 250],
          confidence: 0.85,
          isRecognized: false,
          employeeName: null,
        ),
      ];

      final painter = FaceBoundingBoxPainter(
        faces: mockFaces,
        previewSize: testSize,
      );

      expect(painter.faces.length, equals(2));
      expect(painter.faces[0].isRecognized, isTrue);
      expect(painter.faces[1].isRecognized, isFalse);
    });

    test('shouldRepaint returns true for different face lists', () {
      final painter1 = FaceBoundingBoxPainter(
        faces: [],
        previewSize: testSize,
      );

      final mockFace = DetectedFace(
        faceId: 'test-face-1',
        box: [100, 150, 200, 250],
        confidence: 0.95,
        isRecognized: false,
        employeeName: null,
      );

      final painter2 = FaceBoundingBoxPainter(
        faces: [mockFace],
        previewSize: testSize,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint handles same reference correctly', () {
      final mockFaces = <DetectedFace>[];
      
      final painter1 = FaceBoundingBoxPainter(
        faces: mockFaces,
        previewSize: testSize,
      );

      final painter2 = FaceBoundingBoxPainter(
        faces: mockFaces,
        previewSize: testSize,
      );

      // Should return false for same list reference
      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('can be used in CustomPaint widget', (tester) async {
      final painter = FaceBoundingBoxPainter(
        faces: [],
        previewSize: testSize,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              painter: painter,
              child: const SizedBox(width: 400, height: 300),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
    });
  });
} 