import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_event.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/checkin_success_toast.dart';

/// Widget that handles BlocListeners for toast messages and error notifications
class CheckInListeners extends StatefulWidget {
  const CheckInListeners({super.key, required this.child});

  final Widget child;

  @override
  State<CheckInListeners> createState() => _CheckInListenersState();
}

class _CheckInListenersState extends State<CheckInListeners> {
  @override
  Widget build(BuildContext context) {
    return _CheckInSuccessListener(child: widget.child);
  }
}

/// Comprehensive listener for check-in events with proper edge case handling
class _CheckInSuccessListener extends StatefulWidget {
  const _CheckInSuccessListener({required this.child});

  final Widget child;

  @override
  State<_CheckInSuccessListener> createState() =>
      _CheckInSuccessListenerState();
}

class _CheckInSuccessListenerState extends State<_CheckInSuccessListener> {
  String? _lastProcessedFaceId;
  DateTime? _lastRecognizedShown;
  DateTime? _lastUnrecognizedShown;
  DateTime? _lastMultipleFacesShown;

  static const _recognizedDebounce = Duration(
    seconds: 2,
  ); // Shorter for better UX
  static const _unrecognizedDebounce = Duration(seconds: 3);
  static const _multipleFacesDebounce = Duration(seconds: 4);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckInBloc, CheckInState>(
      listenWhen: _shouldListen,
      listener: _handleListener,
      child: widget.child,
    );
  }

  /// Determine if listener should be triggered based on comprehensive edge case handling
  bool _shouldListen(CheckInState previous, CheckInState current) {
    final currFaces = current.detectedFaces;

    // Reset state on connection changes to handle reconnection scenarios
    if (previous.connectionState.status != current.connectionState.status) {
      _resetState();
      return false;
    }

    if (currFaces.isEmpty) return false;

    final now = DateTime.now();

    // Handle multiple faces with debounce
    if (currFaces.length > 1) {
      final shouldShow =
          _lastMultipleFacesShown == null ||
          now.difference(_lastMultipleFacesShown!) > _multipleFacesDebounce;

      if (shouldShow) {
        _lastMultipleFacesShown = now;
        _resetSingleFaceState();
        return true;
      }
      return false;
    }

    // Handle single face
    final face = currFaces.first;

    if (face.isRecognized && face.faceId != null) {
      // Recognized face - prevent rapid switching spam
      final isNewFace = _lastProcessedFaceId != face.faceId;
      final shouldShow =
          isNewFace &&
          (_lastRecognizedShown == null ||
              now.difference(_lastRecognizedShown!) > _recognizedDebounce);

      if (shouldShow) {
        _lastProcessedFaceId = face.faceId;
        _lastRecognizedShown = now;
        return true;
      }
    } else {
      // Unrecognized face - time-based debounce since faceId is null
      final shouldShow =
          _lastUnrecognizedShown == null ||
          now.difference(_lastUnrecognizedShown!) > _unrecognizedDebounce;

      if (shouldShow) {
        _lastProcessedFaceId = null;
        _lastUnrecognizedShown = now;
        return true;
      }
    }

    return false;
  }

  /// Handle the listener callback
  void _handleListener(BuildContext context, CheckInState state) {
    final faces = state.detectedFaces;

    if (faces.length > 1) {
      _showMultipleFacesMessage(context, faces);
    } else if (faces.first.isRecognized) {
      _showSuccessDialog(context, state, [faces.first]);
    } else {
      _showUnrecognizedFaceMessage(context);
    }
  }

  /// Reset all state - used on connection changes and app lifecycle events
  void _resetState() {
    _lastProcessedFaceId = null;
    _lastRecognizedShown = null;
    _lastUnrecognizedShown = null;
    _lastMultipleFacesShown = null;
  }

  /// Reset single face state when switching to multiple faces
  void _resetSingleFaceState() {
    _lastProcessedFaceId = null;
    _lastRecognizedShown = null;
    _lastUnrecognizedShown = null;
  }

  /// Show message for multiple faces with detailed information
  void _showMultipleFacesMessage(
    BuildContext context,
    List<FaceDetectionResult> faces,
  ) {
    final recognizedCount = faces.where((face) => face.isRecognized).length;
    final unrecognizedCount = faces.length - recognizedCount;

    String message;
    if (recognizedCount == 0) {
      message =
          'Multiple faces detected ($unrecognizedCount unknown). Please ensure only one person is visible.';
    } else if (unrecognizedCount == 0) {
      message =
          'Multiple faces detected ($recognizedCount recognized). Please ensure only one person is visible.';
    } else {
      message =
          'Multiple faces detected ($recognizedCount known, $unrecognizedCount unknown). Please ensure only one person is visible.';
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.orange,
        ),
      );
  }

  /// Show message for unrecognized face
  void _showUnrecognizedFaceMessage(BuildContext context) {
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
  }

  /// Show success dialog for recognized face(s)
  void _showSuccessDialog(
    BuildContext context,
    CheckInState state,
    List<FaceDetectionResult> recognizedFaces,
  ) {
    // Get annotated image if available for user display
    final userImage = state.annotatedImage;

    // Stop streaming during celebration to save resources and avoid confusion
    context.read<ConnectionBloc>().add(const ConnectionEvent.stopStreaming());

    // Show success dialog with all faces and callback to resume streaming
    CheckInSuccessDialog.show(
      context,
      recognizedFaces,
      userImage: userImage,
      onDialogClosed: () {
        // Resume streaming when dialog is closed - use ConnectionBloc
        context.read<ConnectionBloc>().add(
          const ConnectionEvent.startStreaming(),
        );
      },
    );
  }
}
