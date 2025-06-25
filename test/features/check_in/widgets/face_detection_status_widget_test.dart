import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/face_detection_status_widget.dart';
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

  group('FaceDetectionStatusWidget', () {
    testWidgets('renders default state with "No Detection" status', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(),
      );

      await tester.pumpWidget(createTestWidget(const FaceDetectionStatusWidget()));

      expect(find.text('No Detection'), findsOneWidget);
      expect(find.byIcon(Icons.face_retouching_off), findsOneWidget);
    });

    testWidgets('renders detecting status correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(faceStatus: FaceDetectionStatus.detecting),
      );

      await tester.pumpWidget(createTestWidget(const FaceDetectionStatusWidget()));

      expect(find.text('Detecting...'), findsOneWidget);
      expect(find.byIcon(Icons.face_retouching_natural), findsOneWidget);
    });

    testWidgets('renders face found status with single face', (tester) async {
      final mockFace = DetectedFace(
        faceId: 'test-face-1',
        box: [100, 150, 200, 250],
        confidence: 0.95,
        isRecognized: false,
        employeeName: null,
      );

      when(() => mockCheckInBloc.state).thenReturn(
        CheckInState(
          faceStatus: FaceDetectionStatus.faceFound,
          detectedFaces: [mockFace],
          faceConfidence: 0.95,
        ),
      );

      await tester.pumpWidget(createTestWidget(const FaceDetectionStatusWidget()));

      expect(find.text('Face Detected'), findsOneWidget);
      expect(find.byIcon(Icons.face), findsOneWidget);
      expect(find.text('1'), findsOneWidget); // Face count indicator
      expect(find.textContaining('Confidence: 95.0%'), findsOneWidget);
    });

    testWidgets('renders multiple faces status correctly', (tester) async {
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

      when(() => mockCheckInBloc.state).thenReturn(
        CheckInState(
          faceStatus: FaceDetectionStatus.multipleFaces,
          detectedFaces: mockFaces,
          faceConfidence: 0.90,
        ),
      );

      await tester.pumpWidget(createTestWidget(const FaceDetectionStatusWidget()));

      expect(find.text('Multiple Faces'), findsOneWidget);
      expect(find.byIcon(Icons.groups), findsOneWidget);
      expect(find.text('2'), findsOneWidget); // Face count indicator
      expect(find.textContaining('Recognized: 1'), findsOneWidget);
    });

    testWidgets('renders no face found status', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(faceStatus: FaceDetectionStatus.noFace),
      );

      await tester.pumpWidget(createTestWidget(const FaceDetectionStatusWidget()));

      expect(find.text('No Face Found'), findsOneWidget);
      expect(find.byIcon(Icons.face_retouching_off), findsOneWidget);
    });

    testWidgets('renders error status correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(faceStatus: FaceDetectionStatus.error),
      );

      await tester.pumpWidget(createTestWidget(const FaceDetectionStatusWidget()));

      expect(find.text('Detection Error'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('only rebuilds when relevant state changes', (tester) async {
      var buildCount = 0;
      
      await tester.pumpWidget(
        BlocProvider<CheckInBloc>.value(
          value: mockCheckInBloc,
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  buildCount++;
                  return const FaceDetectionStatusWidget();
                },
              ),
            ),
          ),
        ),
      );

      expect(buildCount, equals(1));

      // Trigger state change with irrelevant field
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(isLoading: true),
      );
      
      // Should not rebuild for irrelevant state changes
      await tester.pump();
      expect(buildCount, equals(1));
    });

    testWidgets('displays proper styling for different status colors', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(faceStatus: FaceDetectionStatus.faceFound),
      );

      await tester.pumpWidget(createTestWidget(const FaceDetectionStatusWidget()));

      // Find the container with the status styling
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(FaceDetectionStatusWidget),
          matching: find.byType(Container),
        ).first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.green.withValues(alpha: 0.1)));
      expect(decoration.border, isA<Border>());
    });
  });
} 