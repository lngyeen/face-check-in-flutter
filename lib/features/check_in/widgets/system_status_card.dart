import 'package:flutter/material.dart' hide ConnectionState;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';

import '../bloc/check_in_bloc.dart';
import '../bloc/check_in_state.dart';

import 'status_extensions.dart';

/// Widget that displays the current system status (camera, connection, streaming, face detection)
class SystemStatusCard extends StatelessWidget {
  const SystemStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Status',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        BlocBuilder<CheckInBloc, CheckInState>(
          builder: (context, state) {
            return _StatusRow(
              title: 'Camera',
              status:
                  state.cameraStatus.toString().split('.').last.toUpperCase(),
              color:
                  state.cameraStatus == CameraStatus.opening
                      ? Colors.green
                      : Colors.grey,
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ConnectionBloc, ConnectionState>(
          builder: (context, state) {
            return _StatusRow(
              title: 'WebSocket',
              status: state.status.displayText,
              color: state.status.displayColor,
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ConnectionBloc, ConnectionState>(
          builder: (context, state) {
            return _StatusRow(
              title: 'Streaming',
              status: state.streamingStatus.displayText,
              color: state.streamingStatus.displayColor,
            );
          },
        ),
      ],
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
