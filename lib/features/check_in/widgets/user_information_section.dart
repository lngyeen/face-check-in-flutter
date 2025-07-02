import 'dart:ui';

import 'package:check_in_refactor/blocs/screen/check_in_screen_bloc.dart';
import 'package:check_in_refactor/entities/check_in_screen_state.dart';
import 'package:check_in_refactor/services/face_detection_service.dart';
import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInformationSection extends StatelessWidget {
  const UserInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInScreenBloc, CheckInScreenState>(
      buildWhen:
          (prev, curr) =>
              prev.faceDetectionState.highestConfidenceFace !=
              curr.faceDetectionState.highestConfidenceFace,
      builder: (context, state) {
        final face = state.faceDetectionState.highestConfidenceFace;

        if (face == null || !face.isRecognized) {
          return const SizedBox.shrink();
        }

        return Positioned(
          top: 32,
          left: 0,
          right: 0,
          child: Center(child: _buildUserInfoCard(context, face)),
        );
      },
    );
  }

  Widget _buildUserInfoCard(BuildContext context, FaceDetectionResult face) {
    final theme = Theme.of(context);

    // Extract actual user data from face detection metadata
    final userName = _extractUserName(face);
    final userRole = _extractUserRole(face);
    final userImageUrl = _extractUserImageUrl(face);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withAlpha(102)),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                // Use actual user image if available, otherwise fallback to default
                backgroundImage:
                    userImageUrl != null
                        ? NetworkImage(userImageUrl)
                        : const NetworkImage(
                          'https://st2.depositphotos.com/1011382/7491/i/450/depositphotos_74914105-stock-photo-real-man-face-looking-at.jpg',
                        ),
              ),
              const SizedBox(height: 12),
              Text(
                userName,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userRole,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Extract user name from face detection result
  String _extractUserName(FaceDetectionResult face) {
    // Priority: name -> faceId -> fallback
    if (face.name != null && face.name!.isNotEmpty) {
      return face.name!;
    }

    if (face.faceId != null && face.faceId!.isNotEmpty) {
      return face.faceId!;
    }

    return 'Unknown User';
  }

  /// Extract user role from face detection metadata
  String _extractUserRole(FaceDetectionResult face) {
    // Try to extract role from metadata if available
    final metadata = face.metadata;

    if (metadata != null) {
      // Look for common role fields in metadata
      final role =
          metadata['role'] ??
          metadata['position'] ??
          metadata['title'] ??
          metadata['department'];

      if (role != null && role.toString().isNotEmpty) {
        return role.toString();
      }
    }

    // Fallback to generic role
    return 'Employee';
  }

  /// Extract user image URL from face detection metadata
  String? _extractUserImageUrl(FaceDetectionResult face) {
    // Try to extract image URL from metadata if available
    final metadata = face.metadata;

    if (metadata != null) {
      // Look for common image URL fields in metadata
      final imageUrl =
          metadata['imageUrl'] ??
          metadata['image_url'] ??
          metadata['profileImage'] ??
          metadata['profile_image'] ??
          metadata['avatar'] ??
          metadata['photo'];

      if (imageUrl != null && imageUrl.toString().isNotEmpty) {
        return imageUrl.toString();
      }
    }

    // Return null to use default image
    return null;
  }
}
