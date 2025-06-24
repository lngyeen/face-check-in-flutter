import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_status.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/features/connection/connection.dart'
    as conn;

import '../bloc/check_in_bloc.dart';
import '../bloc/check_in_event.dart';
import '../bloc/check_in_state.dart';

import 'checkin_success_toast.dart' show CheckInSuccessDialog;

/// Widget that handles BlocListeners for toast messages and error notifications
class CheckInListeners extends StatelessWidget {
  const CheckInListeners({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _ToastMessageListener(),
        _DebugModeListener(),
        _BackendErrorListener(),
        _PermissionDeniedListener(),
        _CheckInSuccessListener(),
      ],
      child: child,
    );
  }
}

/// Listener for state changes that should show toast messages
class _ToastMessageListener extends BlocListener<CheckInBloc, CheckInState> {
  _ToastMessageListener()
    : super(
        listenWhen: (previous, current) {
          // Listen for permission granted
          if (previous.permissionStatus != current.permissionStatus &&
              current.permissionStatus == PermissionStatus.granted) {
            return true;
          }
          // Listen for camera ready
          if (previous.cameraStatus != current.cameraStatus &&
              current.cameraStatus == CameraStatus.operational) {
            return true;
          }

          // Statistics reset is now handled by StreamService directly
          // No need to listen for it in BLoC state
          return false;
        },
        listener: (context, state) {
          String? message;

          // Determine message based on the specific state change that triggered this listener
          // We need to check the current state since listenWhen already filtered for us
          if (state.permissionStatus == PermissionStatus.granted) {
            message = 'Camera permission granted! Initializing...';
          } else if (state.cameraStatus == CameraStatus.operational) {
            message = 'Camera ready';
          }

          if (message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
      );
}

/// Listener for debug mode toggle
class _DebugModeListener extends BlocListener<CheckInBloc, CheckInState> {
  _DebugModeListener()
    : super(
        listenWhen:
            (previous, current) => previous.isDebugMode != current.isDebugMode,
        listener: (context, state) {
          final message =
              state.isDebugMode ? 'Debug mode enabled' : 'Debug mode disabled';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 3),
            ),
          );
        },
      );
}

/// Listener for backend error messages
class _BackendErrorListener extends BlocListener<CheckInBloc, CheckInState> {
  _BackendErrorListener()
    : super(
        listenWhen:
            (previous, current) =>
                previous.faceStatus != current.faceStatus &&
                current.faceStatus == FaceDetectionStatus.error,
        listener: (context, state) {
          if (state.responseError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Backend Error: ${state.responseError!.error}'
                  '${state.responseError!.message != null ? ' - ${state.responseError!.message}' : ''}',
                ),
                backgroundColor: Colors.redAccent,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        },
      );
}

/// Listener for camera permission denied guidance
class _PermissionDeniedListener
    extends BlocListener<CheckInBloc, CheckInState> {
  _PermissionDeniedListener()
    : super(
        listenWhen:
            (previous, current) =>
                previous.permissionStatus != current.permissionStatus &&
                (current.permissionStatus == PermissionStatus.denied ||
                    current.permissionStatus ==
                        PermissionStatus.permanentlyDenied),
        listener: (context, state) {
          if (state.permissionStatus == PermissionStatus.permanentlyDenied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Camera permission required. Opening device settings...',
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.orange,
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'OK',
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
            );
          } else if (state.permissionStatus == PermissionStatus.denied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.warning_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Camera access needed for face detection. Please try again.',
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.redAccent,
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<CheckInBloc>().add(
                      const CheckInEvent.requestCameraPermission(),
                    );
                  },
                ),
              ),
            );
          }
        },
      );
}

/// Listener for check-in success to show celebration dialog with clean streaming control
class _CheckInSuccessListener extends BlocListener<CheckInBloc, CheckInState> {
  _CheckInSuccessListener()
    : super(
        listenWhen:
            (previous, current) =>
                previous.faceStatus != current.faceStatus &&
                (current.faceStatus == FaceDetectionStatus.faceFound ||
                    current.faceStatus ==
                        FaceDetectionStatus
                            .faceUnrecognized), // TODO: Remove current.faceStatus == FaceDetectionStatus.faceUnrecognized this when backend is fixed
        listener: (context, state) {
          // Get all detected faces (both recognized and unrecognized)
          final detectedFaces = state.detectedFaces.toList();

          if (detectedFaces.isNotEmpty) {
            // Get annotated image if available for user display
            final userImage = state.annotatedImage;

            // Stop streaming during celebration to save resources and avoid confusion
            context.read<conn.ConnectionBloc>().add(
              const conn.ConnectionEvent.stopStreaming(),
            );

            // Show success dialog with all faces and callback to resume streaming
            CheckInSuccessDialog.show(
              context,
              detectedFaces, // Pass all faces instead of just the first one
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
