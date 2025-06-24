import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_event.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';

class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.permissionStatus != current.permissionStatus,
      builder: (context, state) {
        final isPermanentlyDenied =
            state.permissionStatus == PermissionStatus.permanentlyDenied;

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPermanentlyDenied
                      ? Icons.settings
                      : Icons.camera_alt_outlined,
                  size: 64,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  isPermanentlyDenied
                      ? 'Camera Permission Required'
                      : 'Camera Permission Denied',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  isPermanentlyDenied
                      ? 'Face check-in requires camera access. Please enable camera permission in your device settings.'
                      : 'Face check-in needs camera access to detect your face. Please grant permission to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),
                if (isPermanentlyDenied) ...[
                  ElevatedButton.icon(
                    onPressed: () {
                      // Open app settings directly
                      context.read<CheckInBloc>().add(
                        const CheckInEvent.openAppSettings(),
                      );
                    },
                    icon: const Icon(Icons.settings),
                    label: const Text('Open Settings'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ] else ...[
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CheckInBloc>().add(
                        const CheckInEvent.requestCameraPermission(),
                      );
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Grant Permission'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
