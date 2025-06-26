import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';

/// Widget displayed when front camera is not available on the device
/// Shows a user-friendly error message explaining why the app cannot function
class FrontCameraNotAvailableWidget extends StatelessWidget {
  const FrontCameraNotAvailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDesignTokens.spaceLarge),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.05),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Large camera icon
          Icon(Icons.camera_front_outlined, size: 80, color: AppColors.error),
          const SizedBox(height: AppDesignTokens.spaceLarge),

          // Main error title
          Text(
            'Front Camera Required',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDesignTokens.spaceMedium),

          // Detailed explanation
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.spaceXLarge,
            ),
            child: Text(
              'This app requires a front-facing camera for face check-in functionality. Your device does not appear to have a front camera.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.error,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spaceLarge),

          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.spaceMedium,
              vertical: AppDesignTokens.spaceSmall,
            ),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDesignTokens.radiusMedium),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: AppDesignTokens.iconSmall + 4,
                  color: AppColors.error,
                ),
                const SizedBox(width: AppDesignTokens.spaceSmall),
                Text(
                  'Feature unavailable on this device',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
