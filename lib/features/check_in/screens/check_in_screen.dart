import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/check_in_bloc.dart';
import '../bloc/check_in_event.dart' as ci;
import '../bloc/check_in_state.dart';
import '../widgets/camera_section.dart';
import '../widgets/check_in_listeners.dart';
import '../widgets/debug_controls_card.dart';
import '../widgets/debug_information_card.dart';
import '../widgets/debug_toggle_button.dart';
import '../widgets/system_status_card.dart';

/// Main check-in screen that displays camera preview and face detection interface
///
/// This screen provides:
/// - System status monitoring (camera, connection, streaming, face detection)
/// - Camera preview with face detection
/// - Debug controls and information when debug mode is enabled
/// - Loading indicators and error handling
/// - Proper lifecycle management for resource cleanup
class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  /// Initializes camera permissions on screen load
  void _initializeCamera() {
    context.read<CheckInBloc>().add(const ci.CheckInEvent.initializeCamera());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: CheckInListeners(child: _buildBody()),
    );
  }

  /// Builds the app bar with title and debug toggle
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Face Check-In'),
      actions: const [DebugToggleButton()],
    );
  }

  /// Builds the main body content with all sections
  Widget _buildBody() {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) => previous.isDebugMode != current.isDebugMode,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // System Status Section
              const SystemStatusCard(),
              const SizedBox(height: 16),

              // Camera Preview Section
              const CameraSection(),
              const SizedBox(height: 16),

              // Debug Sections (only visible in debug mode)
              if (state.isDebugMode) ...[
                const DebugControlsCard(),
                const SizedBox(height: 16),
                const DebugInformationCard(),
                const SizedBox(height: 16),
              ],
            ],
          ),
        );
      },
    );
  }
}
