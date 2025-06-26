import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_event.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';

import 'generic_message_widget.dart';

class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) => previous.cameraStatus != current.cameraStatus,
      builder: (context, state) {
        return GenericMessageWidget(
          icon: Icons.settings,
          title: 'Camera Permission Required',
          subtitle:
              'Face check-in needs camera access to detect your face. Please enable camera permission in your device settings.',
          retryButtonTitle: 'Open Settings',
          onRetry: () {
            context.read<CheckInBloc>().add(
              const CheckInEvent.openAppSettings(),
            );
          },
          buttonColor: AppColors.info,
          buttonTextColor: AppColors.textOnPrimary,
        );
      },
    );
  }
}
