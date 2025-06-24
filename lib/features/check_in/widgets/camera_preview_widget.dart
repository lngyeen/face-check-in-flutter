import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/widgets/loading_widget.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';

import 'camera_error_widget.dart';
import 'permission_denied_widget.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.cameraStatus != current.cameraStatus ||
              previous.cameraController != current.cameraController,
      builder: (context, state) {
        switch (state.cameraStatus) {
          case CameraStatus.initial:
          case CameraStatus.initializing:
            return const LoadingWidget();
          case CameraStatus.permissionDenied:
            return const PermissionDeniedWidget();
          case CameraStatus.frontCameraNotAvailable:
            return const _FrontCameraNotAvailableWidget();
          case CameraStatus.operational:
            final controller = state.cameraController;
            if (controller == null || !controller.value.isInitialized) {
              return const Center(child: Text('Camera not available.'));
            }

            return FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.previewSize?.height ?? 1,
                height: controller.value.previewSize?.width ?? 1,
                child: CameraPreview(controller),
              ),
            );
          case CameraStatus.error:
            return CameraErrorWidget(error: state.currentError?.message);
        }
      },
    );
  }
}

/// Widget displayed when front camera is not available on the device
class _FrontCameraNotAvailableWidget extends StatelessWidget {
  const _FrontCameraNotAvailableWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border.all(color: Colors.red[300]!, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_front_outlined, size: 80, color: Colors.red[400]),
          const SizedBox(height: 24),
          Text(
            'Front Camera Required',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'This app requires a front-facing camera for face check-in functionality. Your device does not appear to have a front camera.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red[300]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, size: 20, color: Colors.red[700]),
                const SizedBox(width: 8),
                Text(
                  'Feature unavailable on this device',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
