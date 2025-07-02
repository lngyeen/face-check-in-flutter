import 'package:camera/camera.dart';
import 'package:face_check_in_flutter/core/widgets/loading_widget.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart'
    as app_conn;
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_in_refactor/check_in_refactor.dart';

import 'camera_error_widget.dart';
import 'connection_lost_widget.dart';
import 'front_camera_not_available_widget.dart';
import 'permission_denied_widget.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cameraState = context.watch<CameraBloc>().state;
    final connectionState = context.watch<ConnectionBloc>().state;

    if (_shouldShowConnectionLost(connectionState)) {
      return const ConnectionLostWidget();
    }

    return _buildCameraContent(context, cameraState);
  }

  Widget _buildCameraContent(BuildContext context, CameraState cameraState) {
    switch (cameraState.status) {
      case CameraStatus.initial:
      case CameraStatus.initializing:
        return const LoadingWidget();

      case CameraStatus.permissionDenied:
        return const PermissionDeniedWidget();

      case CameraStatus.frontCameraNotAvailable:
        return const FrontCameraNotAvailableWidget();

      case CameraStatus.ready:
        final controller = cameraState.controller;
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
        return CameraErrorWidget(error: cameraState.errorMessage);
    }
  }

  bool _shouldShowConnectionLost(ConnectionState connectionState) {
    final status = connectionState.status;
    return status == app_conn.AppConnectionStatus.networkLost ||
        status == app_conn.AppConnectionStatus.failed ||
        status == app_conn.AppConnectionStatus.fastRetrying ||
        status == app_conn.AppConnectionStatus.backgroundRetrying;
  }
}
