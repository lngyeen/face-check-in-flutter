import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/generic_info_widget.dart';
import 'package:flutter/material.dart';

class FrontCameraNotAvailableWidget extends StatelessWidget {
  const FrontCameraNotAvailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericInfoWidget(
      icon: Icons.no_photography_rounded,
      title: 'Front Camera Not Available',
      message:
          'This app requires a front-facing camera to function, but it appears your device does not have one.',
      iconColor: AppColors.error,
    );
  }
}
