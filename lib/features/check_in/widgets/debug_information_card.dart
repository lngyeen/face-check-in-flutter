import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_status.dart';

import '../bloc/check_in_bloc.dart';
import '../bloc/check_in_state.dart';

class DebugInformationCard extends StatelessWidget {
  const DebugInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, state),
            const SizedBox(height: AppDesignTokens.spaceMedium),
            _buildStatisticsOverview(context, state),
            const SizedBox(height: AppDesignTokens.spaceMedium),
            const _AnnotatedImagePreview(),
            const SizedBox(height: AppDesignTokens.spaceMedium),
            _buildDetailedFaceInformation(context, state),
            const SizedBox(height: AppDesignTokens.spaceMedium),
            const _ResponseErrorInfo(),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, CheckInState state) {
    final statusColor = _getStatusColor(state.faceStatus);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppDesignTokens.spaceSmall),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusMedium),
          ),
          child: Icon(
            _getStatusIcon(state.faceStatus),
            color: statusColor,
            size: AppDesignTokens.iconMedium,
          ),
        ),
        const SizedBox(width: AppDesignTokens.spaceMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Debug Information',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                _getStatusDisplayName(state.faceStatus),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsOverview(BuildContext context, CheckInState state) {
    final totalFaces = state.detectedFaces.length;
    final recognizedFaces =
        state.detectedFaces.where((face) => face.isRecognized).length;
    final unrecognizedFaces = totalFaces - recognizedFaces;

    return Container(
      padding: const EdgeInsets.all(AppDesignTokens.spaceMedium),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMedium),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detection Statistics',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spaceSmall),
          Wrap(
            spacing: AppDesignTokens.spaceSmall,
            runSpacing: AppDesignTokens.spaceXSmall,
            children: [
              _StatChip(
                icon: Icons.face,
                label: 'Total: $totalFaces',
                color:
                    totalFaces > 0 ? AppColors.info : AppColors.textSecondary,
              ),
              if (recognizedFaces > 0)
                _StatChip(
                  icon: Icons.verified_user,
                  label: 'Recognized: $recognizedFaces',
                  color: AppColors.success,
                ),
              if (unrecognizedFaces > 0)
                _StatChip(
                  icon: Icons.help_outline,
                  label: 'Unknown: $unrecognizedFaces',
                  color: AppColors.warning,
                ),
              _StatChip(
                icon: Icons.analytics,
                label: 'Status: ${state.faceStatus.name}',
                color: _getStatusColor(state.faceStatus),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedFaceInformation(
    BuildContext context,
    CheckInState state,
  ) {
    if (state.detectedFaces.isEmpty) {
      return _buildNoFacesPlaceholder(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Face Information',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spaceSmall),
        ...state.detectedFaces.asMap().entries.map((entry) {
          final index = entry.key;
          final face = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom:
                  index < state.detectedFaces.length - 1
                      ? AppDesignTokens.spaceSmall
                      : 0,
            ),
            child: _DetailedFaceCard(
              face: face,
              index: index + 1,
              showIndex: state.detectedFaces.length > 1,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildNoFacesPlaceholder(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDesignTokens.spaceLarge),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMedium),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.face_retouching_off,
              size: AppDesignTokens.iconLarge,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppDesignTokens.spaceSmall),
            Text(
              'No faces detected',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Point camera at a face to see detection details',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.faceFound:
        return AppColors.success;
      case FaceDetectionStatus.faceUnrecognized:
        return AppColors.warning;
      case FaceDetectionStatus.multipleFaces:
        return AppColors.info;
      case FaceDetectionStatus.noFace:
        return AppColors.textSecondary;
      case FaceDetectionStatus.error:
        return AppColors.error;
      case FaceDetectionStatus.none:
        return AppColors.textSecondary;
    }
  }

  IconData _getStatusIcon(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.faceFound:
        return Icons.verified_user;
      case FaceDetectionStatus.faceUnrecognized:
        return Icons.help_outline;
      case FaceDetectionStatus.multipleFaces:
        return Icons.people;
      case FaceDetectionStatus.noFace:
        return Icons.face_retouching_off;
      case FaceDetectionStatus.error:
        return Icons.error_outline;
      case FaceDetectionStatus.none:
        return Icons.face;
    }
  }

  String _getStatusDisplayName(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.faceFound:
        return 'Face Recognized';
      case FaceDetectionStatus.faceUnrecognized:
        return 'Face Detected (Unrecognized)';
      case FaceDetectionStatus.multipleFaces:
        return 'Multiple Faces Detected';
      case FaceDetectionStatus.noFace:
        return 'No Face Detected';
      case FaceDetectionStatus.error:
        return 'Processing Error';
      case FaceDetectionStatus.none:
        return 'Idle';
    }
  }
}

/// Helper widget for displaying statistics chips
class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spaceSmall,
        vertical: AppDesignTokens.spaceXSmall,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDesignTokens.iconSmall, color: color),
          const SizedBox(width: AppDesignTokens.spaceXSmall),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying detailed face information card
class _DetailedFaceCard extends StatelessWidget {
  const _DetailedFaceCard({
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
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMedium),
        color: statusColor.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme, statusColor),
          const SizedBox(height: AppDesignTokens.spaceSmall),
          _buildFaceIdSection(theme),
          const SizedBox(height: AppDesignTokens.spaceSmall),
          _buildBoundingBoxInfo(theme),
          const SizedBox(height: AppDesignTokens.spaceSmall),
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
                fontFamily: 'Courier',
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

  Widget _buildBoundingBoxInfo(ThemeData theme) {
    if (face.bbox.length < 4) return const SizedBox.shrink();

    final x = face.bbox[0].toInt();
    final y = face.bbox[1].toInt();
    final width = face.bbox[2].toInt();
    final height = face.bbox[3].toInt();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spaceSmall + 4,
        vertical: AppDesignTokens.spaceSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMedium),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.crop_free,
            size: AppDesignTokens.iconSmall + 2,
            color: AppColors.info,
          ),
          const SizedBox(width: AppDesignTokens.spaceSmall),
          Text(
            'Bbox: ',
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.info,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              '($x, $y) $width×$height',
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppColors.textPrimary,
                fontFamily: 'Courier',
              ),
            ),
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

/// Widget that displays the annotated image with face detection overlays if available
class _AnnotatedImagePreview extends StatelessWidget {
  const _AnnotatedImagePreview();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.annotatedImage != current.annotatedImage,
      builder: (context, state) {
        if (state.annotatedImage == null || state.annotatedImage!.isEmpty) {
          return const SizedBox.shrink();
        }

        try {
          final bytes = base64Decode(state.annotatedImage!);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Annotated Image Preview',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showFullSizeImage(context, bytes),
                    icon: Icon(
                      Icons.fullscreen,
                      size: AppDesignTokens.iconSmall + 2,
                      color: AppColors.secondary,
                    ),
                    tooltip: 'View full size',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: AppDesignTokens.spaceSmall),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 400, // Increased height for better visibility
                  minHeight: 200, // Ensure minimum height
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppDesignTokens.radiusMedium,
                  ),
                  border: Border.all(color: AppColors.border),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppDesignTokens.radiusMedium,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.memory(
                      bytes,
                      fit:
                          BoxFit
                              .contain, // Changed to contain to show full image
                      gaplessPlayback: true,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          padding: const EdgeInsets.all(
                            AppDesignTokens.spaceMedium,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              AppDesignTokens.radiusMedium,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.broken_image,
                                  color: AppColors.error,
                                  size: AppDesignTokens.iconMedium,
                                ),
                                const SizedBox(
                                  height: AppDesignTokens.spaceXSmall,
                                ),
                                Text(
                                  'Failed to load image',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        } catch (e) {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void _showFullSizeImage(BuildContext context, Uint8List bytes) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black87,
          child: Stack(
            children: [
              // Full size image
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: InteractiveViewer(
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.contain,
                    gaplessPlayback: true,
                  ),
                ),
              ),
              // Close button
              Positioned(
                top: AppDesignTokens.spaceMedium,
                right: AppDesignTokens.spaceMedium,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(
                      AppDesignTokens.radiusLarge,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                    tooltip: 'Close',
                  ),
                ),
              ),
              // Info overlay
              Positioned(
                bottom: AppDesignTokens.spaceMedium,
                left: AppDesignTokens.spaceMedium,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDesignTokens.spaceMedium,
                    vertical: AppDesignTokens.spaceSmall,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(
                      AppDesignTokens.radiusMedium,
                    ),
                  ),
                  child: Text(
                    'Pinch to zoom • Drag to pan',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Widget that displays enhanced response error information if available
class _ResponseErrorInfo extends StatelessWidget {
  const _ResponseErrorInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.responseError != current.responseError,
      builder: (context, state) {
        if (state.responseError == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Error Information',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spaceSmall),
            Container(
              padding: const EdgeInsets.all(AppDesignTokens.spaceMedium),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(
                  AppDesignTokens.radiusMedium,
                ),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: AppDesignTokens.iconSmall + 2,
                      ),
                      const SizedBox(width: AppDesignTokens.spaceSmall),
                      Expanded(
                        child: Text(
                          state.responseError!.error,
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state.responseError!.message != null) ...[
                    const SizedBox(height: AppDesignTokens.spaceSmall),
                    Container(
                      padding: const EdgeInsets.all(AppDesignTokens.spaceSmall),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppDesignTokens.radiusSmall,
                        ),
                      ),
                      child: Text(
                        state.responseError!.message!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: AppDesignTokens.spaceSmall),
                  _InfoChip(
                    icon: Icons.bug_report,
                    label: 'Check logs for details',
                    color: AppColors.error,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
