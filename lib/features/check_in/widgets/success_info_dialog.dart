import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';

/// A dialog to display after a successful check-in.
class SuccessInfoDialog extends StatelessWidget {
  const SuccessInfoDialog({
    super.key,
    required this.faceId,
    this.imageUrl,
    this.memoryImage,
    this.confidence,
    this.age,
    this.gender,
    this.mask,
  });

  final String faceId;
  final String? imageUrl;
  final Uint8List? memoryImage;
  final double? confidence;
  final int? age;
  final String? gender;
  final bool? mask;

  /// Static function to show the dialog.
  static void show(
    BuildContext context, {
    required String faceId,
    String? imageUrl,
    Uint8List? memoryImage,
    double? confidence,
    int? age,
    String? gender,
    bool? mask,
    Duration autoCloseDuration = const Duration(seconds: 5),
    VoidCallback? onDialogClosed,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return SuccessInfoDialog(
          faceId: faceId,
          imageUrl: imageUrl,
          memoryImage: memoryImage,
          confidence: confidence,
          age: age,
          gender: gender,
          mask: mask,
        );
      },
    ).then((_) {
      onDialogClosed?.call();
    });

    // Auto-close timer
    if (autoCloseDuration != Duration.zero) {
      Timer(autoCloseDuration, () {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}, ${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    ImageProvider? backgroundImage;
    if (memoryImage != null) {
      try {
        backgroundImage = MemoryImage(memoryImage!);
      } catch (_) {
        backgroundImage = null;
      }
    } else if (imageUrl != null) {
      backgroundImage = NetworkImage(imageUrl!);
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isTablet ? 540 : 400),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.surface,
                  Color.lerp(AppColors.surface, AppColors.background, 0.4)!,
                ],
                center: Alignment.center,
                radius: 0.8,
              ),
              borderRadius: BorderRadius.circular(
                AppDesignTokens.radiusXLarge,
              ), // 16
              border: Border.all(color: AppColors.border.withAlpha(128)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withAlpha(26),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success.withAlpha(102),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.textOnPrimary,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Check-in Successful',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // User Info
                CircleAvatar(
                  radius: 56,
                  backgroundColor: AppColors.primary.withAlpha(26),
                  backgroundImage: backgroundImage,
                  child:
                      backgroundImage == null
                          ? Icon(
                            Icons.person_outline_rounded,
                            size: 56,
                            color: AppColors.primary,
                          )
                          : null,
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Face ID',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      faceId,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildDetectionDetails(theme),
                const SizedBox(height: 16),

                const Divider(color: AppColors.border, height: 1),
                const SizedBox(height: 16),

                // Time Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_filled_rounded,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(formattedTime, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetectionDetails(ThemeData theme) {
    if (confidence == null && age == null && gender == null && mask == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withAlpha(204),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
      ),
      child: Wrap(
        spacing: 24,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          if (confidence != null)
            _InfoChip(
              icon: Icons.thumb_up_alt_rounded,
              label: 'Confidence: ${(confidence! * 100).toStringAsFixed(0)}%',
              color: AppColors.info,
            ),
          if (age != null)
            _InfoChip(
              icon: Icons.cake_rounded,
              label: 'Age: $age',
              color: AppColors.textSecondary,
            ),
          if (gender != null)
            _InfoChip(
              icon:
                  gender!.toLowerCase() == 'male'
                      ? Icons.male_rounded
                      : Icons.female_rounded,
              label: gender!,
              color: AppColors.textSecondary,
            ),
          if (mask != null)
            _InfoChip(
              icon: Icons.masks_rounded,
              label: mask! ? 'Mask On' : 'No Mask',
              color: mask! ? AppColors.info : AppColors.warning,
            ),
        ],
      ),
    );
  }
}

/// A small widget to display a detail item with an icon and a label.
class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
