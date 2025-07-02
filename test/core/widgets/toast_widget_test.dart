import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:face_check_in_flutter/core/widgets/toast_widget.dart';

void main() {
  group('Story 2.3 Task 2 - ToastWidget Tests', () {
    testWidgets('shows success toast with correct styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ToastWidget.showSuccess(context, 'John Doe');
                  },
                  child: const Text('Show Toast'),
                );
              },
            ),
          ),
        ),
      );

      // Tap to show toast
      await tester.tap(find.text('Show Toast'));
      await tester.pump();

      // Verify toast appears
      expect(find.text('Welcome, John Doe!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      // Verify success styling (green background)
      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(ToastWidget),
              matching: find.byType(Container),
            )
            .first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(const Color(0xFF4CAF50))); // Green
    });

    testWidgets('shows failure toast with correct styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ToastWidget.showFailure(context);
                  },
                  child: const Text('Show Toast'),
                );
              },
            ),
          ),
        ),
      );

      // Tap to show toast
      await tester.tap(find.text('Show Toast'));
      await tester.pump();

      // Verify toast appears
      expect(
        find.text('Recognition Failed. Please try again.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.error), findsOneWidget);

      // Verify failure styling (orange/red background)
      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(ToastWidget),
              matching: find.byType(Container),
            )
            .first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(const Color(0xFFFF5722))); // Orange/Red
    });

    testWidgets('shows custom failure message', (tester) async {
      const customMessage = 'Custom error message';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ToastWidget.showFailure(
                      context,
                      customMessage: customMessage,
                    );
                  },
                  child: const Text('Show Toast'),
                );
              },
            ),
          ),
        ),
      );

      // Tap to show toast
      await tester.tap(find.text('Show Toast'));
      await tester.pump();

      // Verify custom message appears
      expect(find.text(customMessage), findsOneWidget);
    });

    testWidgets('auto-hides after specified duration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ToastWidget.showSuccess(
                      context,
                      'John Doe',
                      duration: const Duration(milliseconds: 100),
                    );
                  },
                  child: const Text('Show Toast'),
                );
              },
            ),
          ),
        ),
      );

      // Tap to show toast
      await tester.tap(find.text('Show Toast'));
      await tester.pump();

      // Verify toast appears
      expect(find.text('Welcome, John Doe!'), findsOneWidget);

      // Wait for auto-hide duration + animation
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300)); // Animation time

      // Verify toast disappeared
      expect(find.text('Welcome, John Doe!'), findsNothing);
    });

    testWidgets('calls onDismissed callback when auto-hidden', (tester) async {
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ToastWidget.showSuccess(
                      context,
                      'John Doe',
                      duration: const Duration(milliseconds: 100),
                      onDismissed: () {
                        dismissed = true;
                      },
                    );
                  },
                  child: const Text('Show Toast'),
                );
              },
            ),
          ),
        ),
      );

      // Tap to show toast
      await tester.tap(find.text('Show Toast'));
      await tester.pump();

      // Wait for auto-hide + animation
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));

      // Verify callback was called
      expect(dismissed, isTrue);
    });

    testWidgets('displays toast in correct position (top overlay)', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ToastWidget.showSuccess(context, 'John Doe');
                  },
                  child: const Text('Show Toast'),
                );
              },
            ),
          ),
        ),
      );

      // Tap to show toast
      await tester.tap(find.text('Show Toast'));
      await tester.pump();

      // Find the positioned widget
      final positioned = tester.widget<Positioned>(find.byType(Positioned));

      // Verify toast is positioned at top with proper margins
      expect(positioned.top, greaterThan(0)); // Top positioned
      expect(positioned.left, equals(16)); // Left margin
      expect(positioned.right, equals(16)); // Right margin
    });

    testWidgets('shows smooth slide animation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ToastWidget.showSuccess(context, 'John Doe');
                  },
                  child: const Text('Show Toast'),
                );
              },
            ),
          ),
        ),
      );

      // Tap to show toast
      await tester.tap(find.text('Show Toast'));

      // Verify animation widgets are present
      expect(find.byType(FadeTransition), findsWidgets);
      expect(find.byType(SlideTransition), findsOneWidget);

      // Pump animation frames
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150)); // Mid animation
      await tester.pump(const Duration(milliseconds: 300)); // Full animation

      // Toast should be visible after animation
      expect(find.text('Welcome, John Doe!'), findsOneWidget);
    });

    group('ToastType enum tests', () {
      test('has correct enum values', () {
        expect(ToastType.values.length, equals(2));
        expect(ToastType.values, contains(ToastType.success));
        expect(ToastType.values, contains(ToastType.failure));
      });
    });

    group('ToastWidget constructor tests', () {
      testWidgets('creates widget with required parameters', (tester) async {
        const toast = ToastWidget(
          message: 'Test message',
          type: ToastType.success,
        );

        expect(toast.message, equals('Test message'));
        expect(toast.type, equals(ToastType.success));
        expect(toast.duration, equals(const Duration(seconds: 3))); // Default
      });

      testWidgets('creates widget with custom duration', (tester) async {
        const customDuration = Duration(seconds: 5);
        const toast = ToastWidget(
          message: 'Test message',
          type: ToastType.success,
          duration: customDuration,
        );

        expect(toast.duration, equals(customDuration));
      });
    });
  });
}
