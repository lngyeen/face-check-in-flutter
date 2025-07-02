import 'package:flutter/material.dart';

import 'package:check_in_refactor/blocs/screen/check_in_screen_bloc.dart';
import 'package:check_in_refactor/entities/check_in_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugPanelWidget extends StatelessWidget {
  const DebugPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInScreenBloc, CheckInScreenState>(
      builder: (context, state) {
        return Container(
          color: Colors.black.withAlpha(191),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white, fontSize: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '--- DEBUG PANEL ---',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildStateSection('Camera State', {
                    'Status': state.cameraState.status.toString(),
                    'Error': state.cameraState.errorMessage ?? 'None',
                    'isReady': state.cameraState.isReady.toString(),
                  }),
                  _buildStateSection('Face Detection State', {
                    'Status':
                        state.faceDetectionState.connectionStatus.toString(),
                    'Error': state.faceDetectionState.errorMessage ?? 'None',
                    'Faces':
                        state.faceDetectionState.detectedFaces.length
                            .toString(),
                  }),
                  _buildStateSection('Streaming State', {
                    'Status': state.streamingState.status.toString(),
                    'Error': state.streamingState.errorMessage ?? 'None',
                    'FPS': state.streamingState.actualFps.toStringAsFixed(1),
                  }),
                  _buildStateSection('Screen State', {
                    'isFullScreen': state.isFullScreen.toString(),
                    'Pending Notification':
                        state.pendingNotification?.message ?? 'None',
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStateSection(String title, Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          ...data.entries.map((e) => Text('  ${e.key}: ${e.value}')),
        ],
      ),
    );
  }
}
