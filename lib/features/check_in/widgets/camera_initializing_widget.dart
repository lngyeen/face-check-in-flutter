import 'package:flutter/cupertino.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/generic_info_widget.dart';

class CameraInitializingWidget extends StatelessWidget {
  const CameraInitializingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericInfoWidget(
      title: 'Initializing Camera',
      message: 'Getting the camera ready. This will only take a moment.',
      child: CupertinoActivityIndicator(radius: 24, color: AppColors.primary),
    );
  }
}
