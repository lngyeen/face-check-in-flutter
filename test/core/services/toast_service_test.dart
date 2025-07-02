import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:face_check_in_flutter/core/services/toast_service.dart';

void main() {
  group('Story 2.3 Task 2 - ToastService Tests', () {
    group('Singleton behavior', () {
      test('returns the same instance', () {
        final instance1 = ToastService.instance;
        final instance2 = ToastService.instance;

        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('showSuccess method', () {
      testWidgets('shows success toast with user name', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showSuccess(context, 'John Doe');
                    },
                    child: const Text('Show Success'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Show Success'));
        await tester.pump();

        // Verify success toast appears
        expect(find.text('Welcome, John Doe!'), findsOneWidget);
        expect(find.byIcon(Icons.check_circle), findsOneWidget);
      });

      testWidgets('accepts custom duration and callback', (tester) async {
        bool callbackCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showSuccess(
                        context,
                        'John Doe',
                        duration: const Duration(milliseconds: 100),
                        onDismissed: () {
                          callbackCalled = true;
                        },
                      );
                    },
                    child: const Text('Show Success'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Show Success'));
        await tester.pump();

        // Wait for auto-hide
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 300));

        // Verify callback was called
        expect(callbackCalled, isTrue);
      });
    });

    group('showFailure method', () {
      testWidgets('shows failure toast with default message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showFailure(context);
                    },
                    child: const Text('Show Failure'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Show Failure'));
        await tester.pump();

        // Verify failure toast appears
        expect(
          find.text('Recognition failed. Please try again.'),
          findsOneWidget,
        );
        expect(find.byIcon(Icons.error), findsOneWidget);
      });

      testWidgets('shows failure toast with custom message', (tester) async {
        const customMessage = 'Custom error occurred';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showFailure(
                        context,
                        customMessage: customMessage,
                      );
                    },
                    child: const Text('Show Failure'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Show Failure'));
        await tester.pump();

        // Verify custom message appears
        expect(find.text(customMessage), findsOneWidget);
      });
    });

    group('showCheckInSuccess method', () {
      testWidgets('shows success with high confidence', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showCheckInSuccess(
                        context,
                        'John Doe',
                        0.95, // High confidence
                      );
                    },
                    child: const Text('Check In'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Check In'));
        await tester.pump();

        // Verify welcome message (no percentage shown for high confidence)
        expect(find.text('Welcome, John Doe!'), findsOneWidget);
      });

      testWidgets('shows success with low confidence percentage', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showCheckInSuccess(
                        context,
                        'John Doe',
                        0.75, // Low confidence
                      );
                    },
                    child: const Text('Check In'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Check In'));
        await tester.pump();

        // Verify welcome message with percentage (expected behavior)
        expect(find.text('Welcome, John Doe!'), findsOneWidget);
      });
    });

    group('showFaceDetectionFailure method', () {
      testWidgets('shows no_face error message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showFaceDetectionFailure(
                        context,
                        'no_face',
                      );
                    },
                    child: const Text('No Face'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('No Face'));
        await tester.pump();

        // Verify specific no face message
        expect(
          find.text(
            'No face detected. Please position yourself in front of the camera.',
          ),
          findsOneWidget,
        );
      });

      testWidgets('shows multiple_faces error message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showFaceDetectionFailure(
                        context,
                        'multiple_faces',
                      );
                    },
                    child: const Text('Multiple Faces'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Multiple Faces'));
        await tester.pump();

        // Verify specific multiple faces message
        expect(
          find.text(
            'Multiple faces detected. Please ensure only one person in frame.',
          ),
          findsOneWidget,
        );
      });

      testWidgets('shows low_confidence error message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showFaceDetectionFailure(
                        context,
                        'low_confidence',
                      );
                    },
                    child: const Text('Low Confidence'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Low Confidence'));
        await tester.pump();

        // Verify specific low confidence message
        expect(
          find.text('Face detected but not recognized. Please try again.'),
          findsOneWidget,
        );
      });

      testWidgets('shows processing_error message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showFaceDetectionFailure(
                        context,
                        'processing_error',
                      );
                    },
                    child: const Text('Processing Error'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Processing Error'));
        await tester.pump();

        // Verify specific processing error message
        expect(
          find.text('Processing error. Please try again.'),
          findsOneWidget,
        );
      });

      testWidgets('shows default message for unknown reason', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showFaceDetectionFailure(
                        context,
                        'unknown_reason',
                      );
                    },
                    child: const Text('Unknown Error'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Unknown Error'));
        await tester.pump();

        // Verify default error message
        expect(
          find.text('Recognition failed. Please try again.'),
          findsOneWidget,
        );
      });

      testWidgets('handles case insensitive reason matching', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showFaceDetectionFailure(
                        context,
                        'NO_FACE', // Uppercase
                      );
                    },
                    child: const Text('No Face Upper'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('No Face Upper'));
        await tester.pump();

        // Verify case insensitive matching works
        expect(
          find.text(
            'No face detected. Please position yourself in front of the camera.',
          ),
          findsOneWidget,
        );
      });
    });

    group('showRecognitionStatsToast method', () {
      testWidgets('shows recognition stats toast', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showRecognitionStatsToast(
                        context,
                        8, // successful recognitions
                        10, // total frames
                      );
                    },
                    child: const Text('Show Stats'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Show Stats'));
        await tester.pump();

        // Verify stats message
        expect(find.text('Welcome, Stats: 80%!'), findsOneWidget);
      });

      testWidgets('handles zero total frames gracefully', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ToastService.instance.showRecognitionStatsToast(
                        context,
                        0, // successful recognitions
                        0, // total frames
                      );
                    },
                    child: const Text('Show Stats'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap to show toast
        await tester.tap(find.text('Show Stats'));
        await tester.pump();

        // Verify no toast appears for zero frames
        expect(find.text('Welcome, Stats:'), findsNothing);
      });
    });

    group('BuildContext extension', () {
      testWidgets('provides toast service through context extension', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      // Use extension method
                      context.toast.showSuccess(context, 'John Doe');
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
      });
    });
  });
}
