import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_event.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/generic_info_widget.dart';

class CameraErrorWidget extends StatelessWidget {
  const CameraErrorWidget({super.key, this.error, this.onRetry});

  final VoidCallback? onRetry;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return GenericInfoWidget(
      icon: Icons.error_outline_rounded,
      title: 'Camera Error',
      message:
          error ??
          'An unknown error occurred. Please try restarting the camera.',
      buttonText: 'Retry',
      buttonIcon: Icons.refresh_rounded,
      onButtonPressed: () {
        context.read<CheckInBloc>().add(
          const BucketRestartableCheckInEvent.startCamera(),
        );
      },
      iconColor: AppColors.error,
    );
  }
}
