import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

/// A reusable widget for displaying full-screen status information,
/// such as errors, permissions, or loading states.
class FullScreenInfoWidget extends StatelessWidget {
  const FullScreenInfoWidget({
    super.key,
    this.icon,
    required this.title,
    required this.message,
    this.iconColor,
    this.buttonText,
    this.buttonIcon,
    this.onButtonPressed,
    this.child,
  }) : assert(
         icon != null || child != null,
         'Either icon or child must be provided.',
       );

  final IconData? icon;
  final Widget? child;
  final Color? iconColor;
  final String title;
  final String message;
  final String? buttonText;
  final IconData? buttonIcon;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ?? theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon or a custom child widget
                if (child != null)
                  child!
                else
                  Icon(icon!, size: 80, color: effectiveIconColor),
                const SizedBox(height: 24),

                // Title
                Text(
                  title,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Message
                Text(
                  message,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Button
                if (buttonText != null && onButtonPressed != null) ...[
                  const SizedBox(height: 40),
                  AppButton(
                    onPressed: onButtonPressed,
                    text: buttonText!,
                    icon: buttonIcon,
                    backgroundColor: effectiveIconColor,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
