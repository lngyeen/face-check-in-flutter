import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/check_in_bloc.dart';
import '../bloc/check_in_event.dart';
import '../bloc/check_in_state.dart';

/// Main check-in screen
/// This is a placeholder implementation that will be expanded in future stories
class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

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
      body: BlocListener<CheckInBloc, CheckInState>(
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
        child: BlocBuilder<CheckInBloc, CheckInState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Status Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'System Status',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 16),
                          _buildStatusRow(
                            'Camera',
                            state.cameraStatus.displayText,
                            state.cameraStatus.displayColor,
                          ),
                          const SizedBox(height: 8),
                          _buildStatusRow(
                            'Connection',
                            state.connectionStatus.displayText,
                            state.connectionStatus.displayColor,
                          ),
                          const SizedBox(height: 8),
                          _buildStatusRow(
                            'Streaming',
                            state.streamingStatus.displayText,
                            state.streamingStatus.displayColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Camera Preview Placeholder
                  Expanded(
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Camera Preview',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Will be implemented in Story 1.2',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

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

  Widget _buildStatusRow(String label, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withAlpha(70)),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
