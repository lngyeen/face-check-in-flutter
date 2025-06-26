import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';

import 'generic_message_widget.dart';

class FrontCameraNotAvailableWidget extends StatelessWidget {
  const FrontCameraNotAvailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericMessageWidget(
      icon: Icons.camera_front_outlined,
      title: 'Front Camera Required',
      subtitle:
          'This app requires a front-facing camera for face check-in functionality. Your device does not appear to have a front camera available.',
      // No retry button since this is a hardware limitation
      iconColor: AppColors.error,
    );
  }
}
