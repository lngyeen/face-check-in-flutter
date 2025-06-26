import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';

import 'checkin_success_toast.dart';

/// Preview screen for testing CheckInSuccessDialog layouts
class CheckInSuccessPreviewScreen extends StatelessWidget {
  const CheckInSuccessPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckIn Success Dialog Preview'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spaceMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              'Test CheckIn Success Dialog Layouts',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDesignTokens.spaceLarge),

            // Test buttons
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTestButton(
                      context,
                      'Single Recognized Face',
                      'Test dialog with one recognized face',
                      () => _showSingleRecognizedFace(context),
                      AppColors.success,
                    ),
                    const SizedBox(height: AppDesignTokens.spaceMedium),

                    _buildTestButton(
                      context,
                      'Single Unrecognized Face',
                      'Test dialog with one unrecognized face',
                      () => _showSingleUnrecognizedFace(context),
                      AppColors.warning,
                    ),
                    const SizedBox(height: AppDesignTokens.spaceMedium),

                    _buildTestButton(
                      context,
                      'Multiple Mixed Faces',
                      'Test dialog with multiple faces (recognized + unrecognized)',
                      () => _showMultipleMixedFaces(context),
                      AppColors.secondary,
                    ),
                    const SizedBox(height: AppDesignTokens.spaceMedium),

                    _buildTestButton(
                      context,
                      'Multiple Recognized Faces',
                      'Test dialog with multiple recognized faces',
                      () => _showMultipleRecognizedFaces(context),
                      AppColors.info,
                    ),
                    const SizedBox(height: AppDesignTokens.spaceMedium),

                    _buildTestButton(
                      context,
                      'Face with All Info',
                      'Test dialog with face containing all possible information',
                      () => _showFaceWithAllInfo(context),
                      AppColors.primary,
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

  Widget _buildTestButton(
    BuildContext context,
    String title,
    String description,
    VoidCallback onPressed,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
        color: color.withValues(alpha: 0.05),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusLarge),
          child: Padding(
            padding: const EdgeInsets.all(AppDesignTokens.spaceMedium),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(
                      AppDesignTokens.radiusMedium,
                    ),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.textOnPrimary,
                    size: AppDesignTokens.iconMedium,
                  ),
                ),
                const SizedBox(width: AppDesignTokens.spaceMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppDesignTokens.spaceXSmall),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: color,
                  size: AppDesignTokens.iconMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSingleRecognizedFace(BuildContext context) {
    final face = _createSampleFace(
      faceId: 'USER_001_2023',
      isRecognized: true,
      confidence: 0.95,
      gender: 'Male',
      age: 28,
      mask: false,
    );

    CheckInSuccessDialog.show(context, [
      face,
    ], autoCloseDuration: const Duration(seconds: 10));
  }

  void _showSingleUnrecognizedFace(BuildContext context) {
    final face = _createSampleFace(
      faceId: null,
      isRecognized: false,
      confidence: 0.72,
      gender: 'Female',
      age: 25,
      mask: true,
    );

    CheckInSuccessDialog.show(context, [
      face,
    ], autoCloseDuration: const Duration(seconds: 10));
  }

  void _showMultipleMixedFaces(BuildContext context) {
    final faces = [
      _createSampleFace(
        faceId: 'EMPLOYEE_001',
        isRecognized: true,
        confidence: 0.92,
        gender: 'Male',
        age: 32,
        mask: false,
      ),
      _createSampleFace(
        faceId: null,
        isRecognized: false,
        confidence: 0.68,
        gender: 'Female',
        age: 27,
        mask: true,
      ),
      _createSampleFace(
        faceId: 'VISITOR_2023_001',
        isRecognized: true,
        confidence: 0.88,
        gender: 'Male',
        age: 45,
        mask: false,
      ),
    ];

    CheckInSuccessDialog.show(
      context,
      faces,
      autoCloseDuration: const Duration(seconds: 15),
    );
  }

  void _showMultipleRecognizedFaces(BuildContext context) {
    final faces = [
      _createSampleFace(
        faceId: 'ADMIN_001',
        isRecognized: true,
        confidence: 0.96,
        gender: 'Female',
        age: 35,
        mask: false,
      ),
      _createSampleFace(
        faceId: 'MANAGER_002',
        isRecognized: true,
        confidence: 0.91,
        gender: 'Male',
        age: 42,
        mask: false,
      ),
    ];

    CheckInSuccessDialog.show(
      context,
      faces,
      autoCloseDuration: const Duration(seconds: 12),
    );
  }

  void _showFaceWithAllInfo(BuildContext context) {
    final face = _createSampleFace(
      faceId: 'SUPER_USER_PREMIUM_001_2023_DECEMBER',
      isRecognized: true,
      confidence: 0.99,
      gender: 'Non-binary',
      age: 30,
      mask: true,
    );

    CheckInSuccessDialog.show(context, [
      face,
    ], autoCloseDuration: const Duration(seconds: 10));
  }

  FaceDetectionResult _createSampleFace({
    String? faceId,
    required bool isRecognized,
    required double confidence,
    String? gender,
    int? age,
    bool mask = false,
  }) {
    return FaceDetectionResult(
      faceId: faceId,
      isRecognized: isRecognized,
      confidence: confidence,
      gender: gender,
      age: age,
      mask: mask,
      bbox: [100, 100, 200, 200], // [x, y, width, height]
    );
  }
}
