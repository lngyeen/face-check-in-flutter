import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';

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
    final recognizedFaces =
        detectedFaces.where((face) => face.isRecognized).toList();
    final unrecognizedCount = detectedFaces.length - recognizedFaces.length;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success icon
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 20),

            // Title with face count
            Text(
              detectedFaces.length == 1
                  ? 'Face Detected!'
                  : 'Multiple Faces Detected!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Summary info
            if (detectedFaces.length > 1) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '${detectedFaces.length} faces total${recognizedFaces.isNotEmpty ? ' • ${recognizedFaces.length} recognized' : ''}${unrecognizedCount > 0 ? ' • $unrecognizedCount unrecognized' : ''}',
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // User image (if available)
            if (userImage != null) ...[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: Colors.grey[300]!, width: 3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(57),
                  child: Image.memory(
                    // Convert base64 to bytes
                    base64Decode(userImage!),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Image.memory(
                // Convert base64 to bytes
                base64Decode(userImage!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],

            // Faces list
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < detectedFaces.length; i++)
                      _FaceInfoCard(
                        face: detectedFaces[i],
                        index: i + 1,
                        showIndex: detectedFaces.length > 1,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              face.isRecognized
                  ? Colors.green.withValues(alpha: 0.3)
                  : Colors.orange.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
        color:
            face.isRecognized
                ? Colors.green.withValues(alpha: 0.05)
                : Colors.orange.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with face index and recognition status
          Row(
            children: [
              if (showIndex) ...[
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: face.isRecognized ? Colors.green : Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  face.isRecognized ? 'Recognized Face' : 'Unrecognized Face',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        face.isRecognized
                            ? Colors.green[700]
                            : Colors.orange[700],
                  ),
                ),
              ),
              // Recognition status icon
              Icon(
                face.isRecognized ? Icons.verified_user : Icons.help_outline,
                size: 20,
                color: face.isRecognized ? Colors.green : Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Face ID (if available)
          if (face.faceId != null) ...[
            Row(
              children: [
                const Icon(Icons.badge, size: 16, color: Colors.blue),
                const SizedBox(width: 6),
                Text(
                  'ID: ${face.faceId}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Additional info chips
          Wrap(
            spacing: 8,
            runSpacing: 6,
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
                  color: Colors.purple,
                ),
              // Age
              if (face.age != null)
                _InfoChip(
                  icon: Icons.cake,
                  label: '${face.age} years',
                  color: Colors.teal,
                ),
              // Mask
              if (face.mask)
                _InfoChip(
                  icon: Icons.masks,
                  label: 'Mask detected',
                  color: Colors.indigo,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.6) return Colors.orange;
    return Colors.red;
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
    final chipColor = color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: chipColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: chipColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
