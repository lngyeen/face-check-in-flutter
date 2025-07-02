import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';

enum SnackBarType { success, warning, error, info }

/// A helper class for showing consistently styled UI components, like SnackBars.
class UIHelper {
  /// Shows a consistently styled SnackBar across the app.
  ///
  /// [context]: The BuildContext to find the ScaffoldMessenger.
  /// [title]: The main title of the SnackBar.
  /// [message]: The detailed message content.
  /// [type]: The type of SnackBar, which determines its color and icon.
  static void showAppSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required SnackBarType type,
  }) {
    final theme = Theme.of(context);
    final iconColor = _getColorForType(type);
    final icon = _getIconForType(type);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: iconColor, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(message, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.background,
          behavior: SnackBarBehavior.fixed,
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          elevation: 0,
          duration: const Duration(seconds: 4),
        ),
      );
  }

  static Color _getColorForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.warning:
        return AppColors.warning;
      case SnackBarType.error:
        return AppColors.error;
      case SnackBarType.info:
        return AppColors.info;
    }
  }

  static IconData _getIconForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline_rounded;
      case SnackBarType.warning:
        return Icons.info_outline_rounded;
      case SnackBarType.error:
        return Icons.error_outline_rounded;
      case SnackBarType.info:
        return Icons.help_outline_rounded;
    }
  }
}
