import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/camera_error_widget_v2.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/camera_initializing_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/connection_lost_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/front_camera_not_available_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/permission_denied_widget.dart';

class CameraPreviewWidgetV2 extends StatelessWidget {
  const CameraPreviewWidgetV2({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the connection status from the main orchestrator
    final connectionStatus = context.select(
      (CheckInBlocV2 bloc) => bloc.state.connectionState.status,
    );

    if (_shouldShowConnectionLost(connectionStatus)) {
      return const ConnectionLostWidget();
    }

    // Listen to the camera BLoC for camera-specific states
    return BlocBuilder<CameraBlocV2, CameraStateV2>(
      builder: (context, state) {
        switch (state.status) {
          case CameraStatus.initial:
          case CameraStatus.initializing:
            return const CameraInitializingWidget();
          case CameraStatus.permissionDenied:
            return const PermissionDeniedWidget();
          case CameraStatus.frontCameraNotAvailable:
            return const FrontCameraNotAvailableWidget();
          case CameraStatus.ready:
            final controller = state.controller;
            if (controller == null || !controller.value.isInitialized) {
              return const CameraInitializingWidget();
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
            return const CameraErrorWidgetV2();
        }
      },
    );
  }

  /// Determines if connection lost widget should be shown
  bool _shouldShowConnectionLost(AppConnectionStatus connectionStatus) {
    return connectionStatus == AppConnectionStatus.networkLost ||
        connectionStatus == AppConnectionStatus.failed ||
        connectionStatus == AppConnectionStatus.fastRetrying ||
        connectionStatus == AppConnectionStatus.backgroundRetrying;
  }
}
