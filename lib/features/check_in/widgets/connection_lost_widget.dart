import 'package:flutter/material.dart' hide ConnectionState;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/theme/app_colors.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/generic_info_widget.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_event.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';

class ConnectionLostWidget extends StatelessWidget {
  const ConnectionLostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, ConnectionState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final status = state.status;
        final showButton = _shouldShowRetryButton(status);

        return GenericInfoWidget(
          icon: _getIconForStatus(status),
          title: _getTitleForStatus(status),
          message: _getSubtitleForStatus(status),
          iconColor: _getIconColorForStatus(status),
          buttonText: showButton ? 'Retry Now' : null,
          buttonIcon: showButton ? Icons.refresh_rounded : null,
          onButtonPressed:
              showButton
                  ? () => context.read<ConnectionBloc>().add(
                    const ConnectionEvent.retryConnection(),
                  )
                  : null,
        );
      },
    );
  }

  IconData _getIconForStatus(AppConnectionStatus status) {
    switch (status) {
      case AppConnectionStatus.networkLost:
        return Icons.wifi_off_rounded;
      case AppConnectionStatus.failed:
        return Icons.error_outline_rounded;
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        return Icons.sync_problem_rounded;
      default:
        return Icons.cloud_off_rounded;
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
        return 'Unable to connect to the server. Please check your network connection and try again.';
      case AppConnectionStatus.failed:
        return 'Failed to establish a connection with the server. Please try again later.';
      case AppConnectionStatus.fastRetrying:
        return 'Attempting to reconnect. This should only take a moment.';
      case AppConnectionStatus.backgroundRetrying:
        return 'Trying to reconnect in the background. You can also try connecting manually.';
      default:
        return 'The connection to the server has been lost. Please try reconnecting.';
    }
  }

  Color _getIconColorForStatus(AppConnectionStatus status) {
    switch (status) {
      case AppConnectionStatus.networkLost:
      case AppConnectionStatus.failed:
        return AppColors.error;
      case AppConnectionStatus.fastRetrying:
      case AppConnectionStatus.backgroundRetrying:
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  /// Show retry button for certain connection statuses
  bool _shouldShowRetryButton(AppConnectionStatus status) {
    return status == AppConnectionStatus.backgroundRetrying ||
        status == AppConnectionStatus.failed;
  }
}
