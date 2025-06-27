import 'package:flutter/material.dart' hide ConnectionState;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_event.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';

import 'generic_message_widget.dart';

class ConnectionLostWidget extends StatelessWidget {
  const ConnectionLostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, ConnectionState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final connectionStatus = state.status;

        return GenericMessageWidget(
          icon: _getIconForStatus(connectionStatus),
          title: _getTitleForStatus(connectionStatus),
          subtitle: _getSubtitleForStatus(connectionStatus),
          retryButtonTitle:
              _shouldShowRetryButton(connectionStatus) ? 'Retry Now' : null,
          onRetry:
              _shouldShowRetryButton(connectionStatus)
                  ? () {
                    context.read<ConnectionBloc>().add(
                      const ConnectionEvent.initialize(),
                    );
                  }
                  : null,
          iconColor: _getIconColorForStatus(connectionStatus),
          buttonColor: AppColors.warning,
          buttonTextColor: AppColors.textOnPrimary,
        );
      },
    );
  }

  IconData _getIconForStatus(AppConnectionStatus status) {
    switch (status) {
      case AppConnectionStatus.networkLost:
        return Icons.wifi_off;
      case AppConnectionStatus.failed:
        return Icons.error_outline;
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        return Icons.sync_problem;
      default:
        return Icons.cloud_off;
    }
  }

  String _getTitleForStatus(AppConnectionStatus status) {
    switch (status) {
      case AppConnectionStatus.networkLost:
        return 'Network Connection Lost';
      case AppConnectionStatus.failed:
        return 'Connection Failed';
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        return 'Reconnecting...';
      default:
        return 'Connection Lost';
    }
  }

  String _getSubtitleForStatus(AppConnectionStatus status) {
    switch (status) {
      case AppConnectionStatus.networkLost:
        return 'Unable to connect to server. Please check your network connection and try again.';
      case AppConnectionStatus.failed:
        return 'Unable to connect to server. Please try again later.';
      case AppConnectionStatus.fastRetrying:
        return 'Attempting to reconnect. Please wait a moment...';
      case AppConnectionStatus.backgroundRetrying:
        return 'Trying to reconnect in the background. You can try connecting manually.';
      default:
        return 'Connection to server has been lost. Please try reconnecting.';
    }
  }

  Color _getIconColorForStatus(AppConnectionStatus status) {
    switch (status) {
      case AppConnectionStatus.networkLost:
        return AppColorsExtensions.disconnected;
      case AppConnectionStatus.failed:
        return AppColors.error;
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        return AppColorsExtensions.connecting;
      default:
        return AppColors.textSecondary;
    }
  }

  /// Show retry button for certain connection statuses
  bool _shouldShowRetryButton(AppConnectionStatus status) {
    return status == AppConnectionStatus.backgroundRetrying ||
        status == AppConnectionStatus.failed ||
        status == AppConnectionStatus.networkLost;
  }
}
