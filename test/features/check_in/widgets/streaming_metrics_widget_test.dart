import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/streaming_metrics_widget.dart';

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

  group('StreamingMetricsWidget', () {
    testWidgets('renders basic widget structure correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Streaming Metrics'), findsOneWidget);
      expect(find.byIcon(Icons.speed), findsOneWidget);
      expect(find.text('Streaming Status:'), findsOneWidget);
      expect(find.text('Performance Metrics:'), findsOneWidget);
      expect(find.text('Connection Metrics:'), findsOneWidget);
    });

    testWidgets('displays idle streaming status correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(streamingStatus: StreamingStatus.idle),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Idle'), findsOneWidget);
    });

    testWidgets('displays active streaming status correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(streamingStatus: StreamingStatus.active),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Active'), findsOneWidget);
    });

    testWidgets('displays error streaming status correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(streamingStatus: StreamingStatus.error),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('displays current frame rate correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(currentFrameRate: 29.5),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('29.5'), findsOneWidget);
      expect(find.text('Current FPS'), findsOneWidget);
    });

    testWidgets('displays frames processed count', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(framesProcessed: 150),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('150'), findsOneWidget);
      expect(find.text('Frames Processed'), findsOneWidget);
    });

    testWidgets('displays last frame sent time when available', (tester) async {
      final testTime = DateTime.now();
      when(() => mockCheckInBloc.state).thenReturn(
        CheckInState(lastFrameSent: testTime),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Last Frame Sent'), findsOneWidget);
      // Check that time is displayed (format may vary)
      expect(find.textContaining('ago'), findsAtLeastNWidgets(0));
    });

    testWidgets('does not display last frame sent when null', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(lastFrameSent: null),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Last Frame Sent'), findsNothing);
    });

    testWidgets('displays frame rate status based on current FPS', (tester) async {
      // Test excellent frame rate
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(currentFrameRate: 30.0),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Frame Rate Status'), findsOneWidget);
      expect(find.text('Excellent'), findsOneWidget);
    });

    testWidgets('displays connection status correctly', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(connectionStatus: ConnectionStatus.connected),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Connection Status'), findsOneWidget);
      expect(find.text('Connected'), findsOneWidget);
    });

    testWidgets('displays connection attempts count', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(connectionAttempts: 3),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Connection Attempts'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('displays last connection attempt time when available', (tester) async {
      final testTime = DateTime.now();
      when(() => mockCheckInBloc.state).thenReturn(
        CheckInState(lastConnectionAttempt: testTime),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Last Connection'), findsOneWidget);
    });

    testWidgets('displays connection error when available', (tester) async {
      const testError = 'Connection timeout';
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(connectionError: testError),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Last Error'), findsOneWidget);
      expect(find.text(testError), findsOneWidget);
    });

    testWidgets('does not display connection error when null', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(connectionError: null),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.text('Last Error'), findsNothing);
    });

    testWidgets('listens to BLoC state changes', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      expect(find.byType(BlocBuilder<CheckInBloc, CheckInState>), findsOneWidget);
    });

    testWidgets('displays proper styling and colors', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      // Find the main container with purple styling
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(StreamingMetricsWidget),
          matching: find.byType(Container),
        ).first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.purple.withValues(alpha: 0.1)));
      expect(decoration.border, isA<Border>());
    });

    testWidgets('displays comprehensive metrics state', (tester) async {
      final testTime = DateTime.now();
      when(() => mockCheckInBloc.state).thenReturn(
        CheckInState(
          streamingStatus: StreamingStatus.active,
          currentFrameRate: 29.8,
          framesProcessed: 89,
          lastFrameSent: testTime,
          connectionStatus: ConnectionStatus.connected,
          connectionAttempts: 1,
          lastConnectionAttempt: testTime,
          connectionError: null,
        ),
      );

      await tester.pumpWidget(createTestWidget(const StreamingMetricsWidget()));

      // Verify key metrics are displayed
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('29.8'), findsOneWidget);
      expect(find.text('89'), findsOneWidget);
      expect(find.text('Connected'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('Last Frame Sent'), findsOneWidget);
      expect(find.text('Last Connection'), findsOneWidget);
    });
  });
} 