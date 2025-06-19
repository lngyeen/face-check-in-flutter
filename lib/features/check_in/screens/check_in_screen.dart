import 'package:face_check_in_flutter/core/di/di.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/view/face_detection_painter.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/face_detection_debug_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';

import '../widgets/debug_view_container.dart';
import '../../../core/services/debug_log_service.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<CheckInBloc>()..add(const CheckInEvent.appStarted()),
      child: const CheckInView(),
    );
  }
}

class CheckInView extends StatefulWidget {
  const CheckInView({super.key});

  @override
  State<CheckInView> createState() => _CheckInViewState();
}

class _CheckInViewState extends State<CheckInView> {
  final _debugLogService = DebugLogService();

  @override
  void initState() {
    super.initState();
    _debugLogService.logInfo('CheckInScreen initialized');
    context.read<CheckInBloc>().add(
      const CheckInEvent.cameraPermissionRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DebugViewContainer(
      child: Scaffold(
        appBar: AppBar(title: const Text('Face Check-in')),
        body: BlocBuilder<CheckInBloc, CheckInState>(
          builder: (context, state) {
            if (state.cameraController == null ||
                !state.cameraController!.value.isInitialized) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(state.cameraController!),
                if (state.detectedFaces.isNotEmpty)
                  CustomPaint(
                    painter: FaceDetectionPainter(
                      faces: state.detectedFaces,
                      imageSize: state.cameraController!.value.previewSize!,
                    ),
                  ),
                FaceDetectionDebugWidget(state: state),
              ],
            );
          },
        ),
      ),
    );
  }
}
