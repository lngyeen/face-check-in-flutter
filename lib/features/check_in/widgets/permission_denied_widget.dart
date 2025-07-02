import 'package:flutter/material.dart';
import 'package:face_check_in_flutter/core/di/di.dart';
import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/core/theme/app_colors.dart';

import 'generic_message_widget.dart';

class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericMessageWidget(
      icon: Icons.settings,
      title: 'Camera Permission Required',
      subtitle:
          'Face check-in needs camera access to detect your face. Please enable camera permission in your device settings.',
      retryButtonTitle: 'Open Settings',
      onRetry: () async {
        await getIt<PermissionService>().openAppSettings();
      },
      buttonColor: AppColors.info,
      buttonTextColor: AppColors.textOnPrimary,
    );
  }
}
