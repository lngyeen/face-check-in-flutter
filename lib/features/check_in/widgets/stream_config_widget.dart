import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_event.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/di.dart';
import '../../../core/services/stream_service.dart';

/// Widget for configuring stream settings
class StreamConfigWidget extends StatelessWidget {
  const StreamConfigWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final streamService = getIt<StreamService>();
    final currentMaxFps = streamService.maxFps;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stream Configuration',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Current FPS setting
            Row(
              children: [
                const Text('Max FPS: '),
                Text(
                  '$currentMaxFps',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // FPS preset buttons
            Wrap(
              spacing: 8,
              children: [
                _FpsButton(
                  label: 'Low (2 FPS)',
                  fps: 2,
                  isSelected: currentMaxFps == 2,
                ),
                _FpsButton(
                  label: 'Normal (5 FPS)',
                  fps: 5,
                  isSelected: currentMaxFps == 5,
                ),
                _FpsButton(
                  label: 'High (10 FPS)',
                  fps: 10,
                  isSelected: currentMaxFps == 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FpsButton extends StatelessWidget {
  final String label;
  final int fps;
  final bool isSelected;

  const _FpsButton({
    required this.label,
    required this.fps,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<ConnectionBloc>().add(
          ConnectionEvent.configureStream(maxFps: fps),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).primaryColor : null,
        foregroundColor: isSelected ? Colors.white : null,
      ),
      child: Text(label),
    );
  }
}
