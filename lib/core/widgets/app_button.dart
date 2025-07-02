import 'package:flutter/material.dart' hide ConnectionState;

import 'package:face_check_in_flutter/core/theme/app_colors.dart';

///
/// This button is designed with elevation and ensures high
/// contrast for text and icons against its background color.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.isFullWidth = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final Color? backgroundColor;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.primary;

    // Automatically determine text/icon color for good contrast
    final textColor =
        ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
            ? AppColors.textOnPrimary
            : AppColors.textPrimary;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: textColor,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spaceLarge, // 24
        vertical: AppDesignTokens.spaceSmall + 6, // 14
      ),
      shape: const StadiumBorder(), // Circle radius
      elevation: 4, // Restore shadow
      shadowColor: AppColors.greyDark.withAlpha(102),
      minimumSize: isFullWidth ? const Size(double.infinity, 52) : null,
      textStyle: theme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );

    if (icon != null) {
      return ElevatedButton.icon(
        style: buttonStyle,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: AppDesignTokens.iconMedium - 2,
          color: textColor,
        ),
        label: Text(text),
      );
    }

    return ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
