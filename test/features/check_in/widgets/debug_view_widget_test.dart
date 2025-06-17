import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_view_widget.dart';

void main() {
  late ScrollController scrollController;
  late List<String> testMessages;

  setUp(() {
    scrollController = ScrollController();
    testMessages = [
      '[2024-03-20 10:00:00][INFO] Test message 1',
      '[2024-03-20 10:00:01][DEBUG] Test message 2',
      '[2024-03-20 10:00:02][WARNING] Test message 3',
    ];
  });

  tearDown(() {
    scrollController.dispose();
  });

  testWidgets('DebugViewWidget displays messages correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DebugViewWidget(
            messages: testMessages,
            scrollController: scrollController,
          ),
        ),
      ),
    );

    // Verify all messages are displayed
    for (final message in testMessages) {
      expect(find.text(message), findsOneWidget);
    }
  });

  testWidgets('DebugViewWidget has correct styling', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DebugViewWidget(
            messages: testMessages,
            scrollController: scrollController,
          ),
        ),
      ),
    );

    // Find the Container
    final container = tester.widget<Container>(find.byType(Container).first);

    // Verify decoration
    expect(container.decoration, isA<BoxDecoration>());
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.black.withOpacity(0.7));

    // Verify text style
    final text = tester.widget<Text>(find.byType(Text).first);
    expect(text.style?.fontFamily, 'monospace');
    expect(text.style?.color, Colors.white);
    expect(text.style?.fontSize, 12);
  });
}
