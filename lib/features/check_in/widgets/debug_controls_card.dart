import 'package:flutter/material.dart' hide ConnectionState;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/connection.dart';

import '../bloc/check_in_bloc.dart';
import '../bloc/check_in_state.dart';

/// Widget that provides debug controls for camera and streaming operations
class DebugControlsCard extends StatelessWidget {
  const DebugControlsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      builder: (context, state) {
        return Card(
          color: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Debug Controls',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 12),
                // Only show restart camera when permission is granted
                if (state.permissionStatus == PermissionStatus.granted) ...[
                  const _FullFlowToggleButton(),
                  const SizedBox(height: 8),
                  // Always show streaming toggle - let BLoC handle validation
                  const _StreamingToggleButton(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Button for toggling full flow on/off (camera + WebSocket + streaming)
class _FullFlowToggleButton extends StatelessWidget {
  const _FullFlowToggleButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      builder: (context, state) {
        final isActive = state.isFullFlowActive;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              final bloc = context.read<CheckInBloc>();
              if (isActive) {
                bloc.stopFullFlow();
              } else {
                bloc.startFullFlow();
              }
            },
            icon: Icon(isActive ? Icons.stop_circle : Icons.play_circle),
            label: Text(isActive ? 'Stop Full Flow' : 'Start Full Flow'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

/// Button for toggling streaming on/off
class _StreamingToggleButton extends StatelessWidget {
  const _StreamingToggleButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, ConnectionState>(
      buildWhen:
          (previous, current) =>
              previous.streamingStatus != current.streamingStatus,
      builder: (context, state) {
        final isActive = state.streamingStatus == StreamingStatus.active;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              final connectionBloc = context.read<ConnectionBloc>();
              if (isActive) {
                connectionBloc.add(const ConnectionEvent.stopStreaming());
              } else {
                connectionBloc.add(const ConnectionEvent.startStreaming());
              }
            },
            icon: Icon(isActive ? Icons.stop_circle : Icons.play_circle),
            label: Text(isActive ? 'Stop Streaming' : 'Start Streaming'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
