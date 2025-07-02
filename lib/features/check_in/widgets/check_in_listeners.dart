import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart'
    as old;
import 'package:face_check_in_flutter/features/check_in/widgets/checkin_success_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_in_refactor/check_in_refactor.dart';

/// Widget that handles BlocListeners for toast messages and error notifications
class CheckInListeners extends StatelessWidget {
  const CheckInListeners({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Camera error handling
        BlocListener<CameraBloc, CameraState>(
          listenWhen:
              (prev, curr) =>
                  prev.errorMessage != curr.errorMessage && curr.hasError,
          listener: _handleCameraError,
        ),

        // Face detection results - now handled by NotificationInteractor,
        // but we might still want to trigger dialogs from here.
        BlocListener<FaceDetectionBloc, FaceDetectionState>(
          listenWhen:
              (prev, curr) =>
                  prev.detectedFaces != curr.detectedFaces &&
                  curr.hasRecognizedFaces &&
                  curr.detectedFaces.length == 1,
          listener: (context, state) {
            _showSuccessDialog(context, state);
          },
        ),

        // Screen notifications driven by NotificationInteractor
        BlocListener<CheckInScreenBloc, CheckInScreenState>(
          listenWhen:
              (prev, curr) =>
                  prev.pendingNotification != curr.pendingNotification &&
                  curr.pendingNotification != null,
          listener: _handleNotification,
        ),
      ],
      child: child,
    );
  }

  void _handleCameraError(BuildContext context, CameraState state) {
    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              onPressed:
                  () =>
                      context.read<CameraBloc>().add(const CameraEvent.start()),
            ),
          ),
        );
    }
  }

  void _handleNotification(BuildContext context, CheckInScreenState state) {
    final notification = state.pendingNotification;
    if (notification != null) {
      // Simple factory to map notification data to a UI widget (e.g., SnackBar)
      // This part can be expanded to show different kinds of notifications
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(notification.message),
            backgroundColor: _getNotificationColor(notification.type),
            duration: notification.duration ?? const Duration(seconds: 3),
          ),
        );

      // Dismiss notification after showing
      context.read<CheckInScreenBloc>().add(
        const CheckInScreenEvent.dismissNotification(),
      );
    }
  }

  void _showSuccessDialog(BuildContext context, FaceDetectionState state) {
    final recognizedFaces = state.recognizedFaces;

    if (recognizedFaces.isEmpty) return;

    // Stop processing during dialog
    context.read<FaceDetectionBloc>().add(
      const FaceDetectionEvent.stopProcessing(),
    );

    CheckInSuccessDialog.show(
      context,
      recognizedFaces
          .map(
            (e) => old.FaceDetectionResult(
              isRecognized: e.isRecognized,
              confidence: e.confidence,
              faceId: e.faceId,
              bbox: [
                (e.boundingBox['x'] ?? 0).toInt(),
                (e.boundingBox['y'] ?? 0).toInt(),
                (e.boundingBox['width'] ?? 0).toInt(),
                (e.boundingBox['height'] ?? 0).toInt(),
              ],
            ),
          )
          .toList(),
      userImage: state.annotatedImage,
      onDialogClosed: () {
        // Resume processing when dialog closes
        context.read<FaceDetectionBloc>().add(
          const FaceDetectionEvent.startProcessing(),
        );
      },
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.faceDetected:
        return Colors.blue;
      case NotificationType.faceRecognized:
        return Colors.green;
      case NotificationType.checkInSuccess:
        return Colors.green.shade700;
      case NotificationType.systemError:
      case NotificationType.cameraError:
        return Colors.red;
      case NotificationType.connectionLost:
        return Colors.orange;
      case NotificationType.performanceWarning:
        return Colors.deepOrange;
    }
  }
}
