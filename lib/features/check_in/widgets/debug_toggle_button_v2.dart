import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';

class DebugToggleButtonV2 extends StatelessWidget {
  const DebugToggleButtonV2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBlocV2, CheckInStateV2>(
      // Rebuild only when debug mode changes
      buildWhen: (p, c) => p.isDebugMode != c.isDebugMode,
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            state.isDebugMode ? Icons.bug_report : Icons.bug_report_outlined,
            color: state.isDebugMode ? Colors.blue : Colors.grey,
          ),
          onPressed: () {
            context.read<CheckInBlocV2>().add(
              const CheckInEventV2.toggleDebugMode(),
            );
          },
        );
      },
    );
  }
}
