import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_event.dart';

import 'generic_message_widget.dart';

class CameraErrorWidget extends StatelessWidget {
  const CameraErrorWidget({super.key, this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    return GenericMessageWidget(
      icon: Icons.camera_alt_outlined,
      title: 'Camera Error',
      subtitle:
          error ??
          'An unknown camera error occurred. Please try restarting the camera.',
      retryButtonTitle: 'Retry Camera',
      onRetry: () {
        context.read<CheckInBloc>().add(const CheckInEvent.initializeCamera());
      },
      iconColor: AppColors.error,
      buttonColor: AppColors.error,
      buttonTextColor: AppColors.textOnPrimary,
    );
  }
}
