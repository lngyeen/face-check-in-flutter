import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_event.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/camera_preview_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/check_in_listeners.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_information_card.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_toggle_button.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/system_status_card.dart';
import 'package:face_check_in_flutter/gen/assets.gen.dart';

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
    return Scaffold(
      body: CheckInListeners(
        child: BlocBuilder<CheckInBloc, CheckInState>(
          buildWhen: (p, c) => p.isDebugMode != c.isDebugMode,
          builder: (context, state) {
            return Stack(
              children: [
                // Camera preview will handle showing its own state
                // (initializing, errors, etc.)
                const Positioned.fill(child: CameraPreviewWidget()),

                // Header bar
                Positioned(top: 0, left: 0, right: 0, child: _buildHeader()),

                // Debug sections at bottom (only visible in debug mode)
                if (state.isDebugMode)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildDebugSection(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Builds the header bar with OWT logo and debug button
  Widget _buildHeader() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16,
            bottom: 16,
            left: 32,
            right: 32,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface.withAlpha(191),
            border: Border(
              bottom: BorderSide(color: AppColors.border.withAlpha(51)),
            ),
          ),
          child: Row(
            children: [
              // Left spacer for centering logo
              if (kDebugMode) const Expanded(child: SizedBox()),

              // Center logo
              Expanded(
                flex: kDebugMode ? 2 : 1,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      // Optional: Add logo tap functionality here
                    },
                    child: Assets.images.owtLogo.image(
                      height: 36,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Right debug button (only in debug mode)
              if (kDebugMode)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surface.withAlpha(230),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const DebugToggleButton(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
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
