import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;

import 'package:face_check_in_flutter/core/services/websocket_service.dart';

import '../bloc/check_in_bloc.dart';
import '../widgets/camera_preview_widget.dart';

/// Main check-in screen
/// This is a placeholder implementation that will be expanded in future stories
class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CheckInBloc>().add(
      const CheckInEvent.cameraPermissionRequested(),
    );
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
          BlocListener<CheckInBloc, CheckInState>(
            listenWhen:
                (p, c) =>
                    p.toastStatus != c.toastStatus &&
                    c.toastStatus == ToastStatus.showing,
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
          BlocListener<CheckInBloc, CheckInState>(
            listenWhen:
                (p, c) =>
                    p.faceStatus != c.faceStatus &&
                    c.faceStatus == FaceDetectionStatus.backendError,
            listener: (context, state) {
              if (state.responseError != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Backend Error: ${state.responseError!.error}'
                      '${state.responseError!.message != null ? ' - ${state.responseError!.message}' : ''}',
                    ),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 4),
                  ),
                );
              }
            },
          ),
        ],
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
                          const SizedBox(height: 8),
                          _buildStatusRow(
                            'Face Detection',
                            state.faceStatus.name.toUpperCase(),
                            state.faceStatus.displayColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Camera Preview
                  const Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: CameraPreviewWidget(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action Buttons
                  if (state.cameraStatus == CameraStatus.ready &&
                      state.connectionStatus == ConnectionStatus.connected)
                    ElevatedButton.icon(
                      onPressed:
                          state.isLoading
                              ? null
                              : () {
                                final bloc = context.read<CheckInBloc>();
                                if (state.streamingStatus ==
                                    StreamingStatus.active) {
                                  bloc.add(
                                    const CheckInEvent.streamingStopped(),
                                  );
                                } else {
                                  bloc.add(
                                    const CheckInEvent.streamingStarted(),
                                  );
                                }
                              },
                      icon: Icon(
                        state.streamingStatus == StreamingStatus.active
                            ? Icons.stop_circle_outlined
                            : Icons.play_circle_outline,
                      ),
                      label: Text(
                        state.streamingStatus == StreamingStatus.active
                            ? 'Stop Streaming'
                            : 'Start Streaming',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            state.streamingStatus == StreamingStatus.active
                                ? Colors.redAccent
                                : Colors.green,
                      ),
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed:
                                state.isLoading ||
                                        state.cameraStatus == CameraStatus.ready
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
                                state.isLoading ||
                                        state.connectionStatus ==
                                            ConnectionStatus.connected
                                    ? null
                                    : () => context.read<CheckInBloc>().add(
                                      const CheckInEvent.webSocketConnectionRequested(),
                                    ),
                            icon: const Icon(Icons.wifi),
                            label: const Text('Connect to Backend'),
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
                            if (state.debugImage != null) ...[
                              const Text(
                                'Last Captured Frame:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 100,
                                ),
                                child: Image.memory(
                                  Uint8List.fromList(
                                    img.encodeJpg(state.debugImage!),
                                  ),
                                  gaplessPlayback: true,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                            Text('Face Status: ${state.faceStatus.name}'),
                            if (state.faceStatus ==
                                FaceDetectionStatus.faceFound)
                              Text(
                                'Confidence: ${(state.faceConfidence * 100).toStringAsFixed(2)}%',
                              ),
                            if (state.responseError != null)
                              Text(
                                'Response Error: ${state.responseError!.error} - ${state.responseError!.message}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            Text(
                              'Frame Rate: ${state.frameRate.toStringAsFixed(1)} FPS',
                            ),
                            Text('Frames Processed: ${state.framesProcessed}'),
                            Text(
                              'Last Reco: ${state.lastRecognitionTime?.toString() ?? 'N/A'}',
                            ),
                            Text('Loading: ${state.isLoading}'),
                            Text('Error Msg: ${state.errorMessage ?? 'None'}'),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CheckInBloc>().add(
                                  const CheckInEvent.statisticsReset(),
                                );
                              },
                              child: const Text('Reset Stats'),
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

  Widget _buildStatusRow(String title, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(status, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}

extension FaceDetectionStatusX on FaceDetectionStatus {
  Color get displayColor {
    switch (this) {
      case FaceDetectionStatus.faceFound:
        return Colors.green;
      case FaceDetectionStatus.noFace:
      case FaceDetectionStatus.detecting:
        return Colors.orange;
      case FaceDetectionStatus.multipleFaces:
      case FaceDetectionStatus.backendError:
      case FaceDetectionStatus.error:
        return Colors.red;
      case FaceDetectionStatus.none:
        return Colors.grey;
    }
  }
}

extension ConnectionStatusX on ConnectionStatus {
  String get displayText => toString().split('.').last.toUpperCase();

  Color get displayColor {
    switch (this) {
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.failed:
      case ConnectionStatus.timeout:
        return Colors.red;
      case ConnectionStatus.connecting:
      case ConnectionStatus.retrying:
        return Colors.orange;
      case ConnectionStatus.disconnected:
        return Colors.grey;
    }
  }
}
