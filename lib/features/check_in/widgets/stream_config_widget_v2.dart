import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';

/// Widget for configuring stream settings in V2 implementation
class StreamConfigWidgetV2 extends StatelessWidget {
  const StreamConfigWidgetV2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StreamingBlocV2, StreamingStateV2>(
      buildWhen: (p, c) => p.maxFps != c.maxFps,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stream Config'),
            Text('Max FPS: ${state.maxFps}'),
            Slider(
              value: state.maxFps.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: state.maxFps.toString(),
              onChanged: (value) {
                context.read<CheckInBlocV2>().add(
                  CheckInEventV2.setMaxFps(value.toInt()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
