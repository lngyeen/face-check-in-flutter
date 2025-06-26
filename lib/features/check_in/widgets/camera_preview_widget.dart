import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/widgets/loading_widget.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';

import 'camera_error_widget.dart';
import 'front_camera_not_available_widget.dart';
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
            return const FrontCameraNotAvailableWidget();
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
