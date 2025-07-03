import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
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
        BlocBuilder<CheckInBlocV2, CheckInStateV2>(
          buildWhen:
              (p, c) => p.connectionState.status != c.connectionState.status,
          builder: (context, state) {
            return Text('WebSocket: ${state.connectionState.status.name}');
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
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Streaming: ${state.status.name}')],
            );
          },
        ),
      ],
    );
  }
}
