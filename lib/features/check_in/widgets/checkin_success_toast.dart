import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';

/// Data model for title display configuration
class _TitleData {
  const _TitleData({required this.title, required this.color, this.subtitle});

  final String title;
  final String? subtitle;
  final Color color;
}

/// Data model for icon display configuration
class _IconData {
  const _IconData({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}

/// Dialog widget that displays check-in success information for multiple faces
class CheckInSuccessDialog extends StatelessWidget {
  const CheckInSuccessDialog({
    super.key,
    required this.detectedFaces,
    this.userImage,
  });

  final List<FaceDetectionResult> detectedFaces;
  final String? userImage; // Base64 encoded user image if available

  /// Static function to show check-in success dialog with auto-close timer
  static void show(
    BuildContext context,
    List<FaceDetectionResult> detectedFaces, {
    String? userImage, // Base64 encoded user image if available
    Duration autoCloseDuration = const Duration(
      seconds: 5,
    ), // Increased time for multiple faces
    VoidCallback? onDialogClosed, // Callback when dialog is closed
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return CheckInSuccessDialog(
          detectedFaces: detectedFaces,
          userImage: userImage,
        );
      },
    ).then((_) {
      // Call callback when dialog is closed (either by timer or user action)
      onDialogClosed?.call();
    });

    // Auto-close timer
    Timer(autoCloseDuration, () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(AppDesignTokens.spaceLarge),
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dynamic status icon
            _buildStatusIcon(detectedFaces),
            const SizedBox(height: AppDesignTokens.spaceLarge),

            // Title with face count
            _buildTitle(theme, detectedFaces.length),
            const SizedBox(height: AppDesignTokens.spaceMedium),

            // User image (if available)
            if (userImage != null) ...[
              _buildUserImage(userImage!),
              const SizedBox(height: AppDesignTokens.spaceMedium),
            ],

            // Faces list
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < detectedFaces.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDesignTokens.spaceSmall,
                        ),
                        child: _FaceInfoCard(
                          face: detectedFaces[i],
                          index: i + 1,
                          showIndex: detectedFaces.length > 1,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(List<FaceDetectionResult> faces) {
    final recognizedCount = faces.where((face) => face.isRecognized).length;
    final unrecognizedCount = faces.length - recognizedCount;

    // Determine icon and color based on recognition status
    final iconData = _getStatusIconData(
      faces.length,
      recognizedCount,
      unrecognizedCount,
    );

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: iconData.color, shape: BoxShape.circle),
      child: Icon(iconData.icon, color: AppColors.textOnPrimary, size: 50),
    );
  }

  /// Get icon data based on face detection results
  _IconData _getStatusIconData(
    int totalFaces,
    int recognizedCount,
    int unrecognizedCount,
  ) {
    if (totalFaces == 1) {
      if (recognizedCount == 1) {
        return _IconData(icon: Icons.verified_user, color: AppColors.success);
      } else {
        return _IconData(icon: Icons.help_outline, color: AppColors.warning);
      }
    } else {
      // Multiple faces
      if (unrecognizedCount == 0) {
        return _IconData(icon: Icons.group, color: AppColors.success);
      } else if (recognizedCount == 0) {
        return _IconData(icon: Icons.group_add, color: AppColors.warning);
      } else {
        return _IconData(icon: Icons.people, color: AppColors.secondary);
      }
    }
  }

  Widget _buildTitle(ThemeData theme, int faceCount) {
    final recognizedFaces =
        detectedFaces.where((face) => face.isRecognized).toList();
    final unrecognizedCount = faceCount - recognizedFaces.length;

    // Determine title based on recognition status
    final titleData = _getTitleData(
      faceCount,
      recognizedFaces.length,
      unrecognizedCount,
    );

    return Column(
      children: [
        // Main title (clean text-only)
        Text(
          titleData.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: titleData.color,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        // Subtitle with additional context
        if (titleData.subtitle != null) ...[
          const SizedBox(height: AppDesignTokens.spaceXSmall),
          Text(
            titleData.subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: titleData.color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  /// Get title data based on face detection results
  _TitleData _getTitleData(
    int totalFaces,
    int recognizedCount,
    int unrecognizedCount,
  ) {
    if (totalFaces == 1) {
      if (recognizedCount == 1) {
        return _TitleData(
          title: 'Face Recognized!',
          subtitle: 'Welcome back',
          color: AppColors.success,
        );
      } else {
        return _TitleData(
          title: 'Face Detected',
          subtitle: 'Unknown person',
          color: AppColors.warning,
        );
      }
    } else {
      // Multiple faces
      if (unrecognizedCount == 0) {
        return _TitleData(
          title: 'All Faces Recognized!',
          subtitle: '$recognizedCount people identified',
          color: AppColors.success,
        );
      } else if (recognizedCount == 0) {
        return _TitleData(
          title: 'Multiple Faces Detected',
          subtitle: 'No recognized individuals',
          color: AppColors.warning,
        );
      } else {
        return _TitleData(
          title: 'Mixed Recognition',
          subtitle: '$recognizedCount known, $unrecognizedCount unknown',
          color: AppColors.secondary,
        );
      }
    }
  }

  Widget _buildUserImage(String userImage) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200, // Reasonable max height for dialog
        maxWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
        child: Image.memory(
          base64Decode(userImage),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 120,
              color: AppColors.surfaceVariant,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image,
                      size: AppDesignTokens.iconLarge,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppDesignTokens.spaceSmall),
                    Text(
                      'Image Error',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Widget for displaying individual face information
class _FaceInfoCard extends StatelessWidget {
  const _FaceInfoCard({
    required this.face,
    required this.index,
    required this.showIndex,
  });

  final FaceDetectionResult face;
  final int index;
  final bool showIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRecognized = face.isRecognized;
    final statusColor = isRecognized ? AppColors.success : AppColors.warning;

    return Container(
      padding: const EdgeInsets.all(AppDesignTokens.spaceMedium),
      decoration: BoxDecoration(
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
        color: statusColor.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with face index and recognition status
          _buildHeader(theme, statusColor),
          const SizedBox(height: AppDesignTokens.spaceSmall),

          // Face ID (always displayed)
          _buildFaceIdSection(theme),
          const SizedBox(height: AppDesignTokens.spaceSmall),

          // Additional info chips
          _buildInfoChips(),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, Color statusColor) {
    return Row(
      children: [
        if (showIndex) ...[
          Container(
            width: AppDesignTokens.iconMedium,
            height: AppDesignTokens.iconMedium,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDesignTokens.spaceSmall),
        ],
        Expanded(
          child: Text(
            face.isRecognized ? 'Recognized Face' : 'Unrecognized Face',
            style: theme.textTheme.titleSmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Recognition status icon
        Icon(
          face.isRecognized ? Icons.verified_user : Icons.help_outline,
          size: AppDesignTokens.iconSmall + 4,
          color: statusColor,
        ),
      ],
    );
  }

  Widget _buildFaceIdSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spaceSmall + 4,
        vertical: AppDesignTokens.spaceSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMedium),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.badge,
            size: AppDesignTokens.iconSmall + 2,
            color: AppColors.secondary,
          ),
          const SizedBox(width: AppDesignTokens.spaceSmall),
          Text(
            'Face ID: ',
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              face.faceId ?? 'Not Available',
              style: theme.textTheme.labelMedium?.copyWith(
                color:
                    face.faceId != null
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                fontFamily: 'Courier', // Monospace font for ID
              ),
            ),
          ),
          if (face.faceId != null)
            Icon(
              Icons.verified,
              size: AppDesignTokens.iconSmall,
              color: AppColors.secondary,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChips() {
    return Wrap(
      spacing: AppDesignTokens.spaceSmall,
      runSpacing: AppDesignTokens.spaceXSmall + 2,
      children: [
        // Confidence
        _InfoChip(
          icon: Icons.verified,
          label: '${(face.confidence * 100).toStringAsFixed(1)}%',
          color: _getConfidenceColor(face.confidence),
        ),
        // Gender
        if (face.gender != null)
          _InfoChip(
            icon: Icons.person,
            label: face.gender!,
            color: AppColors.secondary,
          ),
        // Age
        if (face.age != null)
          _InfoChip(
            icon: Icons.cake,
            label: '${face.age} years',
            color: AppColors.info,
          ),
        // Mask
        if (face.mask)
          _InfoChip(
            icon: Icons.masks,
            label: 'Mask detected',
            color: AppColors.warning,
          ),
      ],
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return AppColors.success;
    if (confidence >= 0.6) return AppColors.warning;
    return AppColors.error;
  }
}

/// Helper widget for displaying information chips
class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipColor = color ?? AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spaceSmall,
        vertical: AppDesignTokens.spaceXSmall,
      ),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
        border: Border.all(color: chipColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDesignTokens.iconSmall, color: chipColor),
          const SizedBox(width: AppDesignTokens.spaceXSmall),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
