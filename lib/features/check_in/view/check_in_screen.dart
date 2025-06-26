import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/check_in_bloc.dart';
import '../widgets/camera_preview_widget.dart';
import '../widgets/face_detection_status_widget.dart';

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
          // Original toast listener
          BlocListener<CheckInBloc, CheckInState>(
            listenWhen:
                (previous, current) =>
                    previous.toastStatus != current.toastStatus &&
                    current.toastStatus == ToastStatus.showing,
            listener: (context, state) {
              if (state.toastMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.toastMessage!),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
          // Face detection notification listener
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
                  '🎯 UI: Face detection notification listener triggered',
                );
                debugPrint(
                  '🎯 UI: Previous shouldShowNotification: ${previous.shouldShowNotification}',
                );
                debugPrint(
                  '🎯 UI: Current shouldShowNotification: ${current.shouldShowNotification}',
                );
                debugPrint(
                  '🎯 UI: Current notificationType: ${current.notificationType.name}',
                );
                debugPrint(
                  '🎯 UI: Current message: ${current.notificationMessage}',
                );
              } else {
                debugPrint(
                  '🎯 UI: Face detection notification listener NOT triggered',
                );
                debugPrint(
                  '🎯 UI: shouldShowNotification changed: ${previous.shouldShowNotification != current.shouldShowNotification}',
                );
                debugPrint(
                  '🎯 UI: current.shouldShowNotification == true: ${current.shouldShowNotification == true}',
                );
                debugPrint(
                  '🎯 UI: notificationType != none: ${current.notificationType != FaceDetectionNotificationType.none}',
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
                debugPrint('🎯 UI: About to show snack bar');
                debugPrint('🎯 UI: Message: ${state.notificationMessage}');
                debugPrint('🎯 UI: Type: ${state.notificationType.name}');

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          state.notificationType.icon,
                          color: state.notificationType.textColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            state.notificationMessage!,
                            style: TextStyle(
                              color: state.notificationType.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: state.notificationType.backgroundColor,
                    duration: state.notificationType.duration,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                    elevation: 6,
                  ),
                );
                debugPrint('🎯 UI: Snack bar shown successfully');
              } else {
                debugPrint(
                  '🎯 UI: Notification message is null or type is none',
                );
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
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CheckInBloc>().add(
                                  const CheckInEvent.statisticsReset(),
                                );
                              },
                              child: const Text('Reset Statistics'),
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
}
