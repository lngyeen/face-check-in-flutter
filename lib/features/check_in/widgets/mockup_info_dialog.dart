import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';

class MockupInfoDialog extends StatelessWidget {
  const MockupInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss, dd/MM/yyyy').format(now);
    final theme = Theme.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(204),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white.withAlpha(26), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 30.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              width: 80,
              height: 80,
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
                size: 50,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              'Check-in Thành Công',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // User Info
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                'https://st2.depositphotos.com/1011382/7491/i/450/depositphotos_74914105-stock-photo-real-man-face-looking-at.jpg',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'David Nguyen',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text('Developer', style: theme.textTheme.bodyMedium),

            const SizedBox(height: 20),
            Divider(color: AppColors.border),
            const SizedBox(height: 12),

            // Time Info
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(formattedTime, style: theme.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
