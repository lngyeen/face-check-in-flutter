import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_view_widget.dart';
import 'package:face_check_in_flutter/core/services/debug_log_service.dart';
import 'package:face_check_in_flutter/core/config/debug_config.dart';

void main() {
  final debugLogService = DebugLogService();

  tearDown(() {
    debugLogService.clear();
    DebugConfig.reset(); // Reset config after each test
  });

  testWidgets('DebugViewWidget displays messages and can be toggled', (
    WidgetTester tester,
  ) async {
    // Setup config for this specific test
    DebugConfig.isDebugViewEnabled = true;
    DebugConfig.isDebugToggleEnabled = true;
    DebugConfig.showDebugViewByDefault = true;

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DebugViewWidget())),
    );

    expect(find.text('Debug View'), findsOneWidget);
    // The view is visible, so the icon to hide it should be up.
    expect(find.byIcon(Icons.arrow_drop_up), findsOneWidget);

    debugLogService.logInfo('Test message 1');
    await tester.pumpAndSettle();
    expect(find.textContaining('Test message 1'), findsOneWidget);

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // The view is now hidden, so the icon to show it should be down.
    expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    expect(find.textContaining('Test message 1'), findsNothing);
  });

  testWidgets('DebugViewWidget is not visible when disabled in config', (
    WidgetTester tester,
  ) async {
    // Setup config for this specific test
    DebugConfig.isDebugViewEnabled = false;

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DebugViewWidget())),
    );

    // The widget itself exists, but it builds an empty SizedBox.
    expect(find.byType(DebugViewWidget), findsOneWidget);
    expect(find.byType(Column), findsNothing);
    expect(find.text('Debug View'), findsNothing);
  });

  testWidgets('DebugViewWidget is not visible when toggle is disabled', (
    WidgetTester tester,
  ) async {
    // Setup config for this specific test
    DebugConfig.isDebugViewEnabled = true;
    DebugConfig.isDebugToggleEnabled = false;

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DebugViewWidget())),
    );

    // The toggle text/icon should not be present.
    expect(find.text('Debug View'), findsNothing);
    // The view itself should still be visible if enabled and on by default.
    expect(find.byType(Container), findsOneWidget);
  });
}
