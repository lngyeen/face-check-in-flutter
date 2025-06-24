import 'package:camera/camera.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          case CameraStatus.permissionRequesting:
          case CameraStatus.initializing:
            return const Center(child: CircularProgressIndicator());
          case CameraStatus.permissionDenied:
            return const PermissionDeniedWidget();
          case CameraStatus.ready:
          case CameraStatus.streaming:
          case CameraStatus.paused:
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
            return CameraErrorWidget(error: state.errorMessage);
        }
      },
    );
  }
}

class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Camera Permission Denied',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'To continue, please grant camera permissions in your device settings.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CameraErrorWidget extends StatelessWidget {
  const CameraErrorWidget({super.key, this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Camera Error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              error ?? 'An unknown camera error occurred.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
