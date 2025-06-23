import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

import '../bloc/check_in_bloc.dart';

import 'status_extensions.dart';

/// Widget that displays the current system status (camera, connection, streaming, face detection)
class SystemStatusCard extends StatelessWidget {
  const SystemStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.cameraStatus != current.cameraStatus ||
              previous.connectionStatus != current.connectionStatus ||
              previous.streamingStatus != current.streamingStatus ||
              previous.faceStatus != current.faceStatus,
      builder: (context, state) {
        return Card(
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
                _StatusRow(
                  title: 'Camera',
                  status:
                      state.cameraStatus
                          .toString()
                          .split('.')
                          .last
                          .toUpperCase(),
                  color:
                      state.cameraStatus == CameraStatus.operational
                          ? Colors.green
                          : Colors.grey,
                ),
                const SizedBox(height: 8),
                _StatusRow(
                  title: 'Connection',
                  status: state.connectionStatus.displayText,
                  color: state.connectionStatus.displayColor,
                ),
                const SizedBox(height: 8),
                _StatusRow(
                  title: 'Streaming',
                  status:
                      state.streamingStatus
                          .toString()
                          .split('.')
                          .last
                          .toUpperCase(),
                  color:
                      state.streamingStatus == StreamingStatus.active
                          ? Colors.green
                          : Colors.grey,
                ),
                const SizedBox(height: 8),
                _StatusRow(
                  title: 'Face Detection',
                  status: state.faceStatus.name.toUpperCase(),
                  color: state.faceStatus.displayColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Private widget for displaying individual status rows
class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.title,
    required this.status,
    required this.color,
  });

  final String title;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
