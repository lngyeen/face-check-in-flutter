import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/check_in_bloc.dart';
import '../models/face_detection_result.dart';
import '../widgets/camera_preview_widget.dart';
import '../widgets/check_in_success_dialog.dart';
import '../widgets/face_detection_status_widget.dart';
import '../../../core/services/toast_service.dart';

/// Main check-in screen
/// This is a placeholder implementation that will be expanded in future stories
class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<CheckInBloc>().add(
      const CheckInEvent.cameraPermissionRequested(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final bloc = context.read<CheckInBloc>();
    switch (state) {
      case AppLifecycleState.resumed:
        bloc.add(const CheckInEvent.cameraResumed());
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        bloc.add(const CheckInEvent.cameraPaused());
        break;
    }
  }

  /// Extract user name from toast message like "Welcome, John Doe!"
  String? _extractUserNameFromMessage(String message) {
    final welcomeRegex = RegExp(r'Welcome,?\s+([^!]+)!?');
    final match = welcomeRegex.firstMatch(message);
    return match?.group(1)?.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Check-In'),
        actions: [
          BlocBuilder<CheckInBloc, CheckInState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isDebugMode
                      ? Icons.bug_report
                      : Icons.bug_report_outlined,
                ),
                onPressed: () {
                  context.read<CheckInBloc>().add(
                    const CheckInEvent.debugModeToggled(),
                  );
                },
                tooltip: 'Toggle Debug Mode',
              );
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          // Toast notification listener (Story 2.3 Task 2)
          BlocListener<CheckInBloc, CheckInState>(
            listenWhen:
                (previous, current) =>
                    previous.toastStatus != current.toastStatus &&
                    current.toastStatus == ToastStatus.showing,
            listener: (context, state) {
              if (state.toastMessage != null) {
                debugPrint('🍞 UI: Showing toast - ${state.toastMessage}');

                // Determine toast type based on message content
                if (state.toastMessage!.toLowerCase().contains('welcome') ||
                    state.toastMessage!.toLowerCase().contains('success')) {
                  // Extract user name from welcome message or use default
                  final userName =
                      _extractUserNameFromMessage(state.toastMessage!) ??
                      'User';
                  ToastService.instance.showSuccess(context, userName);
                } else {
                  // Show failure toast for error messages
                  ToastService.instance.showFailure(
                    context,
                    customMessage: state.toastMessage,
                  );
                }
              }
            },
          ),
          // Face detection notification listener (Story 2.3 Task 2 - Toast Integration)
          BlocListener<CheckInBloc, CheckInState>(
            listenWhen: (previous, current) {
              // Listen when notification should be shown AND notification content changed
              final shouldListen =
                  current.shouldShowNotification == true &&
                  current.notificationType !=
                      FaceDetectionNotificationType.none &&
                  (previous.notificationMessage !=
                          current.notificationMessage ||
                      previous.notificationType != current.notificationType);

              if (shouldListen) {
                debugPrint(
                  '🎯 UI: Face detection notification listener triggered for toast',
                );
                debugPrint(
                  '🎯 UI: Current notificationType: ${current.notificationType.name}',
                );
                debugPrint(
                  '🎯 UI: Current message: ${current.notificationMessage}',
                );
              }

              return shouldListen;
            },
            listener: (context, state) {
              debugPrint(
                '🎯 UI: Inside face detection notification listener callback',
              );

              if (state.notificationMessage != null &&
                  state.notificationType !=
                      FaceDetectionNotificationType.none) {
                debugPrint('🍞 UI: About to show toast notification');
                debugPrint('🍞 UI: Message: ${state.notificationMessage}');
                debugPrint('🍞 UI: Type: ${state.notificationType.name}');

                // Determine appropriate toast based on notification type
                switch (state.notificationType) {
                  case FaceDetectionNotificationType.checkInSuccess:
                    // Extract user name for success toast
                    final userName =
                        _extractUserNameFromMessage(
                          state.notificationMessage!,
                        ) ??
                        'User';
                    ToastService.instance.showSuccess(context, userName);
                    break;
                  case FaceDetectionNotificationType.noFaceDetected:
                    ToastService.instance.showFaceDetectionFailure(
                      context,
                      'no_face',
                    );
                    break;
                  case FaceDetectionNotificationType.multipleFacesWarning:
                    ToastService.instance.showFaceDetectionFailure(
                      context,
                      'multiple_faces',
                    );
                    break;
                  case FaceDetectionNotificationType.faceDetectedUnrecognized:
                    ToastService.instance.showFaceDetectionFailure(
                      context,
                      'low_confidence',
                    );
                    break;
                  case FaceDetectionNotificationType.faceDetectedSuccess:
                    // Success face detection
                    final userName =
                        _extractUserNameFromMessage(
                          state.notificationMessage!,
                        ) ??
                        'User';
                    ToastService.instance.showSuccess(context, userName);
                    break;
                  case FaceDetectionNotificationType.checkInFailed:
                  case FaceDetectionNotificationType.connectionError:
                    ToastService.instance.showFaceDetectionFailure(
                      context,
                      'processing_error',
                    );
                    break;
                  case FaceDetectionNotificationType.processingError:
                    ToastService.instance.showFaceDetectionFailure(
                      context,
                      'processing_error',
                    );
                    break;
                  case FaceDetectionNotificationType.none:
                    // Do nothing
                    break;
                }
                debugPrint('🍞 UI: Toast notification shown successfully');
              } else {
                debugPrint(
                  '🍞 UI: Notification message is null or type is none',
                );
              }
            },
          ),
          // Check-in success listener
          BlocListener<CheckInBloc, CheckInState>(
            listenWhen: (previous, current) {
              // Listen for check-in success
              return current.notificationType ==
                      FaceDetectionNotificationType.checkInSuccess &&
                  previous.notificationType != current.notificationType;
            },
            listener: (context, state) {
              // Show success dialog when check-in is successful
              if (state.detectedFaces.isNotEmpty) {
                final recognizedFace = state.detectedFaces.firstWhere(
                  (face) => face.isRecognized,
                  orElse: () => state.detectedFaces.first,
                );

                // Show success dialog
                _showCheckInSuccessDialog(context, recognizedFace);
              }
            },
          ),
        ],
        child: BlocBuilder<CheckInBloc, CheckInState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Face Detection Status
                  const FaceDetectionStatusWidget(),

                  const SizedBox(height: 16),

                  // Camera Preview with 3:4 aspect ratio
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double maxWidth = constraints.maxWidth;
                      final double screenHeight =
                          MediaQuery.of(context).size.height;

                      // Calculate ideal height but limit to max 60% of screen height
                      final double idealHeight =
                          maxWidth * (4.0 / 3.0); // 3:4 aspect ratio
                      final double maxAllowedHeight = screenHeight * 0.6;
                      final double previewHeight =
                          idealHeight > maxAllowedHeight
                              ? maxAllowedHeight
                              : idealHeight;

                      return SizedBox(
                        height: previewHeight,
                        child: const Card(
                          clipBehavior: Clip.antiAlias,
                          child: CameraPreviewWidget(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : () {
                                    context.read<CheckInBloc>().add(
                                      const CheckInEvent.cameraInitRequested(),
                                    );
                                  },
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Initialize Camera'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : () {
                                    context.read<CheckInBloc>().add(
                                      const CheckInEvent.connectionRequested(),
                                    );
                                  },
                          icon: const Icon(Icons.wifi),
                          label: const Text('Connect Backend'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Streaming Controls
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              state.isLoading ||
                                      state.cameraStatus !=
                                          CameraStatus.ready ||
                                      state.connectionStatus !=
                                          ConnectionStatus.connected
                                  ? null
                                  : state.streamingStatus ==
                                      StreamingStatus.active
                                  ? () {
                                    context.read<CheckInBloc>().add(
                                      const CheckInEvent.streamingStopRequested(),
                                    );
                                  }
                                  : () {
                                    context.read<CheckInBloc>().add(
                                      const CheckInEvent.streamingStartRequested(),
                                    );
                                  },
                          icon: Icon(
                            state.streamingStatus == StreamingStatus.active
                                ? Icons.stop
                                : Icons.play_arrow,
                          ),
                          label: Text(
                            state.streamingStatus == StreamingStatus.active
                                ? 'Stop Streaming'
                                : 'Start Streaming',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                state.streamingStatus == StreamingStatus.active
                                    ? Colors.red[400]
                                    : Colors.green[400],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : () {
                                    context.read<CheckInBloc>().add(
                                      const CheckInEvent.statisticsReset(),
                                    );
                                  },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset Stats'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Debug Information (if debug mode is enabled)
                  if (state.isDebugMode) ...[
                    const SizedBox(height: 16),
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Debug Information',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text('Frames Processed: ${state.framesProcessed}'),
                            Text(
                              'Last Recognition: ${state.lastRecognitionTime?.toString() ?? 'None'}',
                            ),
                            Text('Loading: ${state.isLoading}'),
                            Text('Error: ${state.errorMessage ?? 'None'}'),
                            if (state.notificationMessage != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                'Last Notification: ${state.notificationMessage}',
                              ),
                              Text(
                                'Notification Type: ${state.notificationType.name}',
                              ),
                            ],
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<CheckInBloc>().add(
                                        const CheckInEvent.statisticsReset(),
                                      );
                                    },
                                    child: const Text('Reset Statistics'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Test success dialog
                                      _showTestSuccessDialog(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Test Dialog'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Loading Indicator
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Show simplified check-in success dialog
  void _showCheckInSuccessDialog(
    BuildContext context,
    DetectedFace recognizedFace,
  ) {
    // Notify BLoC that dialog is being shown (triggers pause)
    context.read<CheckInBloc>().add(const CheckInEvent.successDialogShown());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CheckInSuccessDialog(
          faceId: recognizedFace.faceId,
          checkInTime: DateTime.now(),
          confidence: recognizedFace.confidence,
          onClose: () {
            // Notify BLoC that dialog is being dismissed (triggers resume)
            context.read<CheckInBloc>().add(
              const CheckInEvent.successDialogDismissed(),
            );

            // Reset the system after dialog closes
            context.read<CheckInBloc>().add(
              const CheckInEvent.resetAfterCheckIn(),
            );
          },
        );
      },
    ).then((_) {
      // Fallback: ensure dialog dismissed event is triggered even if dialog closed unexpectedly
      if (context.mounted) {
        context.read<CheckInBloc>().add(
          const CheckInEvent.successDialogDismissed(),
        );
      }
    });
  }

  /// Test method to show success dialog with sample data
  void _showTestSuccessDialog(BuildContext context) {
    // Create a fake detected face for testing
    final testFace = DetectedFace(
      faceId: 'test_face_001',
      box: [100.0, 100.0, 200.0, 200.0],
      confidence: 0.85, // 85% confidence for testing
      isRecognized: true,
      employeeName: 'Nguyễn Văn Test',
      personId: 'TEST001',
    );

    // Show dialog with pause/resume performance optimization
    _showCheckInSuccessDialog(context, testFace);
  }
}
