import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';

import '../../../core/di/di.dart';
import '../../../core/services/stream_service.dart';

/// Widget for configuring stream settings
class StreamConfigWidget extends StatefulWidget {
  const StreamConfigWidget({super.key});

  @override
  State<StreamConfigWidget> createState() => _StreamConfigWidgetState();
}

class _StreamConfigWidgetState extends State<StreamConfigWidget> {
  late double _currentMaxFps;

  @override
  void initState() {
    super.initState();
    final streamService = getIt<StreamService>();
    _currentMaxFps = streamService.maxFps.toDouble();
  }

  void _updateFps(double newFps) {
    setState(() {
      _currentMaxFps = newFps;
    });
    context.read<CheckInBloc>().setStreamMaxFps(newFps.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stream Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Max FPS: '),
                Text(
                  _currentMaxFps.round().toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _FpsButton(
                  label: 'Low (2 FPS)',
                  fps: 2,
                  isSelected: _currentMaxFps == 2,
                  onPressed: () => _updateFps(2),
                ),
                _FpsButton(
                  label: 'Normal (5 FPS)',
                  fps: 5,
                  isSelected: _currentMaxFps == 5,
                  onPressed: () => _updateFps(5),
                ),
                _FpsButton(
                  label: 'High (10 FPS)',
                  fps: 10,
                  isSelected: _currentMaxFps == 10,
                  onPressed: () => _updateFps(10),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Max FPS'),
            Slider(
              value: _currentMaxFps,
              min: 1,
              max: 30,
              divisions: 29,
              label: _currentMaxFps.round().toString(),
              onChanged: (double value) {
                _updateFps(value);
              },
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
  final VoidCallback onPressed;

  const _FpsButton({
    required this.label,
    required this.fps,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
