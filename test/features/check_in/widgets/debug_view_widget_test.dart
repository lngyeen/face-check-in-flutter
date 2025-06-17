import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_view_widget.dart';
import 'package:face_check_in_flutter/core/services/debug_log_service.dart';

void main() {
  late DebugLogService debugLogService;

  setUp(() {
    debugLogService = DebugLogService();
  });

  tearDown(() {
    debugLogService.clear();
  });

  testWidgets('DebugViewWidget displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DebugViewWidget())),
    );

    // Add some test messages
    debugLogService.logInfo('Test message 1');
    debugLogService.logDebug('Test message 2');
    debugLogService.logWarning('Test message 3');

    // Wait for stream to update
    await tester.pump();
    await Future.delayed(const Duration(milliseconds: 100));
    await tester.pump();

    // Verify debug view toggle is present
    expect(find.text('Debug View'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
  });

  testWidgets('DebugViewWidget can be toggled', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DebugViewWidget())),
    );

    // Find the toggle gesture detector
    final toggleFinder = find.byType(GestureDetector);
    expect(toggleFinder, findsOneWidget);

    // Tap to toggle visibility
    await tester.tap(toggleFinder);
    await tester.pump();

    // Verify icon changed
    expect(find.byIcon(Icons.arrow_drop_up), findsOneWidget);
  });

  testWidgets('DebugViewWidget has correct styling', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DebugViewWidget())),
    );

    // Add a test message
    debugLogService.logInfo('Test message');
    await tester.pump();
    await Future.delayed(const Duration(milliseconds: 100));
    await tester.pump();

    // Find the message display container
    final containerFinder = find.byType(Container).last;
    expect(containerFinder, findsOneWidget);

    final container = tester.widget<Container>(containerFinder);
    expect(container.decoration, isA<BoxDecoration>());
  });
}
