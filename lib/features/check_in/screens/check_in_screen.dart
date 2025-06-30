import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_event.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/camera_preview_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/check_in_listeners.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_information_card.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_toggle_button.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/system_status_card.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CheckInBloc>().add(
      const SeparatedSequentialCheckInEvent.initialize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CheckInListeners(child: _buildBody()));
  }

  /// Builds the main body with full-screen camera and floating debug button
  Widget _buildBody() {
    return BlocBuilder<CheckInBloc, CheckInState>(
      builder: (context, state) {
        return Column(
          children: [
            // Full-screen camera section with floating debug button
            Expanded(child: _buildCameraWithFloatingButton(state)),

            // Debug sections at bottom (only visible in debug mode)
            if (state.isDebugMode) _buildDebugSection(),
          ],
        );
      },
    );
  }

  /// Builds camera section with floating debug button overlay
  Widget _buildCameraWithFloatingButton(CheckInState state) {
    return Stack(
      children: [
        // Full-screen camera
        const Positioned.fill(child: CameraPreviewWidget()),

        // Floating debug toggle button in top-right corner
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 16,
          child: Column(
            children: [
              Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const DebugToggleButton(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds scrollable debug section at the bottom
  Widget _buildDebugSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            // System Status Section
            SystemStatusCard(),
            SizedBox(height: 16),

            // Debug Information Section
            DebugInformationCard(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
