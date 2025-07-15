import 'package:flutter/material.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/domain/entities/app_notification.dart';

class NotificationTextWidget extends StatelessWidget {
  const NotificationTextWidget({super.key, required this.statusStream});

  final Stream<StatusUpdate> statusStream;

  Color _getBackgroundColor(StatusType type) {
    switch (type) {
      case StatusType.info:
        return AppColors.info.withValues(alpha: 0.9);
      case StatusType.success:
        return AppColors.success.withValues(alpha: 0.9);
      case StatusType.warning:
        return AppColors.warning.withValues(alpha: 0.9);
      case StatusType.error:
        return AppColors.error.withValues(alpha: 0.9);
    }
  }

  Color _getTextColor(StatusType type) {
    return AppColors.textOnPrimary;
  }

  IconData? _getIcon(StatusType type) {
    switch (type) {
      case StatusType.info:
        return Icons.info_outline;
      case StatusType.success:
        return Icons.check_circle;
      case StatusType.warning:
        return Icons.warning_amber_rounded;
      case StatusType.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StatusUpdate>(
      stream: statusStream,
      builder: (context, snapshot) {
        final statusUpdate = snapshot.data;

        if (statusUpdate == null) {
          return const SizedBox.shrink();
        }

        final message = statusUpdate.message;
        final type = statusUpdate.type;

        if (message.isEmpty) return const SizedBox.shrink();

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.3),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(message),
            margin: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              color: _getBackgroundColor(type),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_getIcon(type), color: _getTextColor(type), size: 20.0),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _getTextColor(type),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
