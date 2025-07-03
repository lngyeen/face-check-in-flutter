import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/di/di.dart';
import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/camera_preview_widget_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/check_in_listeners_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_information_card_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_toggle_button_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/system_status_card_v2.dart';
import 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';
import 'package:face_check_in_flutter/gen/assets.gen.dart';

class CheckInScreenV2 extends StatelessWidget {
  const CheckInScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => getIt<CheckInBlocV2>()..add(const CheckInEventV2.start()),
        ),
        BlocProvider(create: (_) => getIt<CameraBlocV2>()),
        BlocProvider(create: (_) => getIt<StreamingBlocV2>()),
      ],
      child: CheckInListenersV2(
        child: BlocBuilder<CheckInBlocV2, CheckInStateV2>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  const Positioned.fill(child: CameraPreviewWidgetV2()),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: _buildHeader(context),
                  ),
                ],
              ),
              bottomSheet:
                  state.isDebugMode ? _buildDebugBottomSheet(context) : null,
            );
          },
        ),
      ),
    );
  }

  /// Builds the header bar with OWT logo and debug button
  Widget _buildHeader(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          color: AppColors.surface.withAlpha(191),
          child: Row(
            children: [
              if (kDebugMode) const Expanded(child: SizedBox()),

              Expanded(
                flex: kDebugMode ? 2 : 1,
                child: Center(
                  child: Assets.images.owtLogo.image(
                    height: 36,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              if (kDebugMode)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: const DebugToggleButtonV2(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDebugBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SystemStatusCardV2(),
              SizedBox(height: 16),
              DebugInformationCardV2(),
            ],
          ),
        ),
      ),
    );
  }
}
