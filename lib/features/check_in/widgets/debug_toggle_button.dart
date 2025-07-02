import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_in_refactor/blocs/screen/check_in_screen_bloc.dart';
import 'package:check_in_refactor/blocs/screen/check_in_screen_event.dart';

class DebugToggleButton extends StatelessWidget {
  const DebugToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.bug_report),
      tooltip: 'Toggle Debug Panel',
      onPressed: () {
        context.read<CheckInScreenBloc>().add(
          const CheckInScreenEvent.toggleDebugMode(),
        );
      },
    );
  }
}
