import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
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
          (previous, current) =>
              previous.permissionStatus != current.permissionStatus,
      builder: (context, state) {
        final isPermanentlyDenied =
            state.permissionStatus == PermissionStatus.permanentlyDenied;

        return GenericMessageWidget(
          icon:
              isPermanentlyDenied ? Icons.settings : Icons.camera_alt_outlined,
          title:
              isPermanentlyDenied
                  ? 'Camera Permission Required'
                  : 'Camera Permission Denied',
          subtitle:
              isPermanentlyDenied
                  ? 'Face check-in requires camera access. Please enable camera permission in your device settings.'
                  : 'Face check-in needs camera access to detect your face. Please grant permission to continue.',
          retryButtonTitle:
              isPermanentlyDenied ? 'Open Settings' : 'Grant Permission',
          onRetry: () {
            if (isPermanentlyDenied) {
              context.read<CheckInBloc>().add(
                const CheckInEvent.openAppSettings(),
              );
            } else {
              context.read<CheckInBloc>().add(
                const CheckInEvent.requestCameraPermission(),
              );
            }
          },
          buttonColor: isPermanentlyDenied ? AppColors.info : AppColors.success,
          buttonTextColor: AppColors.textOnPrimary,
        );
      },
    );
  }
}
