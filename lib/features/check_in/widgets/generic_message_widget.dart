import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';

/// Generic message widget that can be reused for various message scenarios
///
/// This widget provides:
/// - Customizable icon, title, and subtitle
/// - Optional retry button with custom title and action
/// - Consistent styling and layout for all message scenarios
class GenericMessageWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? retryButtonTitle;
  final VoidCallback? onRetry;
  final Color? iconColor;
  final Color? buttonColor;
  final Color? buttonTextColor;

  const GenericMessageWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.retryButtonTitle,
    this.onRetry,
    this.iconColor,
    this.buttonColor,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spaceMedium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDesignTokens.iconLarge * 2,
              color: iconColor ?? theme.iconTheme.color?.withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppDesignTokens.spaceMedium),
            Text(
              title,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDesignTokens.spaceSmall),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spaceLarge),
            if (retryButtonTitle != null && onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryButtonTitle!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? theme.colorScheme.primary,
                  foregroundColor:
                      buttonTextColor ?? theme.colorScheme.onPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
