import 'package:face_check_in_flutter/features/check_in/widgets/checkin_success_toast.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/face_detection_status.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';
import 'package:face_check_in_flutter/features/connection/connection.dart'
    as conn;

/// Widget that handles BlocListeners for toast messages and error notifications
class CheckInListeners extends StatelessWidget {
  const CheckInListeners({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [_CheckInSuccessListener()],
      child: child,
    );
  }
}

/// Listener for check-in success to show celebration dialog with clean streaming control
class _CheckInSuccessListener extends BlocListener<CheckInBloc, CheckInState> {
  _CheckInSuccessListener()
    : super(
        listenWhen:
            (previous, current) =>
                previous.faceStatus != current.faceStatus &&
                (current.faceStatus == FaceDetectionStatus.faceFound ||
                    current.faceStatus == FaceDetectionStatus.faceUnrecognized),
        listener: (context, state) {
          // Get all detected faces (both recognized and unrecognized)

          if (state.detectedFaces.isNotEmpty) {
            final recognizedFaces =
                state.detectedFaces.where((face) => face.isRecognized).toList();
            if (recognizedFaces.isEmpty) {
              // If no recognized faces, show a toast for unrecognized face
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      'Face detected but not recognized. Ensure good lighting and face the camera directly.',
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              return;
            }

            // Get annotated image if available for user display
            final userImage = state.annotatedImage;

            // Stop streaming during celebration to save resources and avoid confusion
            context.read<conn.ConnectionBloc>().add(
              const conn.ConnectionEvent.stopStreaming(),
            );

            // Show success dialog with all faces and callback to resume streaming
            CheckInSuccessDialog.show(
              context,
              recognizedFaces,
              userImage: userImage,
              onDialogClosed: () {
                // Resume streaming when dialog is closed - use ConnectionBloc
                context.read<conn.ConnectionBloc>().add(
                  const conn.ConnectionEvent.startStreaming(),
                );
              },
            );
          }
        },
      );
}
