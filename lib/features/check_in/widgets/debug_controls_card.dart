import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

import '../bloc/check_in_bloc.dart';

/// Widget that provides debug controls for camera and streaming operations
class DebugControlsCard extends StatelessWidget {
  const DebugControlsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.permissionStatus != current.permissionStatus ||
              previous.cameraStatus != current.cameraStatus ||
              previous.connectionStatus != current.connectionStatus ||
              previous.streamingStatus != current.streamingStatus,
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
                ],
                const _WebSocketToggleButton(),
                const SizedBox(height: 8),
                // Always show streaming toggle - let BLoC handle validation
                const _StreamingToggleButton(),
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
      buildWhen:
          (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.isFullFlowActive != current.isFullFlowActive,
      builder: (context, state) {
        final isActive = state.isFullFlowActive;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed:
                state.isLoading
                    ? null
                    : () {
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

/// Button for toggling WebSocket connection on/off
class _WebSocketToggleButton extends StatelessWidget {
  const _WebSocketToggleButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.connectionStatus != current.connectionStatus,
      builder: (context, state) {
        final isConnected =
            state.connectionStatus == ConnectionStatus.connected;
        final isConnecting =
            state.connectionStatus == ConnectionStatus.connecting;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed:
                state.isLoading || isConnecting
                    ? null
                    : () {
                      final bloc = context.read<CheckInBloc>();
                      if (isConnected) {
                        bloc.add(const CheckInEvent.disconnectWebSocket());
                      } else {
                        bloc.add(const CheckInEvent.connectWebSocket());
                      }
                    },
            icon: Icon(
              isConnecting
                  ? Icons.sync
                  : isConnected
                  ? Icons.stop_circle
                  : Icons.play_circle,
            ),
            label: Text(
              isConnecting
                  ? 'Connecting...'
                  : isConnected
                  ? 'Disconnect WebSocket'
                  : 'Connect WebSocket',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isConnecting
                      ? Colors.orange
                      : isConnected
                      ? Colors.red
                      : Colors.green,
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
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.streamingStatus != current.streamingStatus,
      builder: (context, state) {
        final isActive = state.streamingStatus == StreamingStatus.active;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed:
                state.isLoading
                    ? null
                    : () {
                      final bloc = context.read<CheckInBloc>();
                      if (isActive) {
                        bloc.add(const CheckInEvent.stopStreaming());
                      } else {
                        bloc.add(const CheckInEvent.startStreaming());
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
