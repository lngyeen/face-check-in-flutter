import 'package:flutter/material.dart';

/// Simplified success dialog for check-in completion
class CheckInSuccessDialog extends StatelessWidget {
  final String faceId;
  final DateTime checkInTime;
  final double confidence;
  final VoidCallback? onClose;

  const CheckInSuccessDialog({
    super.key,
    required this.faceId,
    required this.checkInTime,
    required this.confidence,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Format time as hh:mm - DD/MM
    final timeStr =
        '${checkInTime.hour.toString().padLeft(2, '0')}:${checkInTime.minute.toString().padLeft(2, '0')}';
    final dateStr =
        '${checkInTime.day.toString().padLeft(2, '0')}/${checkInTime.month.toString().padLeft(2, '0')}';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white, Colors.green.shade50],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Title (removed icon, adjusted text size)
            Text(
              '✅ Check-in Thành Công!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Information Card (removed face image)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Face ID (changed from employee name)
                  _buildInfoItem(
                    icon: Icons.face,
                    label: 'Tên nhân viên',
                    value: faceId,
                    iconColor: Colors.blue.shade600,
                  ),
                  const SizedBox(height: 16),

                  // Check-in Time (updated format)
                  _buildInfoItem(
                    icon: Icons.access_time,
                    label: 'Thời gian check-in',
                    value: '$timeStr - $dateStr',
                    iconColor: Colors.green.shade600,
                  ),
                  const SizedBox(height: 16),

                  // Confidence
                  _buildInfoItem(
                    icon: Icons.psychology,
                    label: 'Độ chính xác nhận diện',
                    value: '${(confidence * 100).toStringAsFixed(1)}%',
                    iconColor: Colors.orange.shade600,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Close Button (fixed functionality)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onClose != null) {
                    onClose!();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade500,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Đóng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 24, color: iconColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
