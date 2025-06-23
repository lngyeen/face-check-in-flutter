import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/check_in_bloc.dart';

/// Widget that provides a toggle button for debug mode in the app bar
class DebugToggleButton extends StatelessWidget {
  const DebugToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:
          () => context.read<CheckInBloc>().add(
            const CheckInEvent.toggleDebugMode(),
          ),
      icon: const Icon(Icons.bug_report),
      tooltip: 'Toggle Debug Mode',
    );
  }
}
