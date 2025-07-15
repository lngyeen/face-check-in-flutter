import 'package:flutter/material.dart' hide ConnectionState;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';

/// Widget that displays the current system status using simple Text widgets.
class SystemStatusCardV2 extends StatelessWidget {
  const SystemStatusCardV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('System Status'),
        BlocBuilder<ConnectionBloc, ConnectionState>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            return Text('WebSocket: ${state.status.name}');
          },
        ),
        BlocBuilder<CameraBlocV2, CameraStateV2>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            return Text('Camera: ${state.status.name}');
          },
        ),
        BlocBuilder<StreamingBlocV2, StreamingStateV2>(
          // Rebuilds for both status and processingStatus changes
          buildWhen: (p, c) => p.streamingStatus != c.streamingStatus,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Streaming: ${state.streamingStatus.name}')],
            );
          },
        ),
      ],
    );
  }
}
