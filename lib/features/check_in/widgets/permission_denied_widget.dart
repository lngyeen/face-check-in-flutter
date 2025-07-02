import 'package:face_check_in_flutter/core/di/di.dart';
import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/generic_info_widget.dart';
import 'package:flutter/material.dart';

class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericInfoWidget(
      icon: Icons.camera_alt_rounded,
      title: 'Camera Permission Required',
      message:
          'Face check-in needs camera access to function. Please enable camera permission in your device settings.',
      buttonText: 'Open Settings',
      buttonIcon: Icons.settings,
      onButtonPressed: () async {
        await getIt<PermissionService>().openAppSettings();
      },
      iconColor: AppColors.info,
    );
  }
}
