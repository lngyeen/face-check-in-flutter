import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/generic_info_widget.dart';

/// Widget displayed when camera encounters an error in V2 implementation
class CameraErrorWidgetV2 extends StatelessWidget {
  const CameraErrorWidgetV2({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericInfoWidget(
      icon: Icons.error_outline_rounded,
      title: 'Camera Error',
      message: 'An unknown error occurred. Please try restarting the camera.',
      buttonText: 'Retry',
      buttonIcon: Icons.refresh_rounded,
      onButtonPressed: () {
        context.read<CameraBlocV2>().add(const CameraEventV2.startCamera());
      },
      iconColor: AppColors.error,
    );
  }
}
