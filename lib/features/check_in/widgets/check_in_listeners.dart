import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/utils/ui_helper.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_event.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/success_info_dialog.dart';

/// Widget that handles BlocListeners for toast messages and error notifications
class CheckInListeners extends StatefulWidget {
  const CheckInListeners({super.key, required this.child});

  final Widget child;

  @override
  State<CheckInListeners> createState() => _CheckInListenersState();
}

class _CheckInListenersState extends State<CheckInListeners> {
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

  /// Determines if the listener should trigger based on face detection results.
  /// Acts as a dispatcher to specific handlers based on detection scenarios.
  bool _shouldListen(CheckInState previous, CheckInState current) {
    // Reset state on connection changes for robust recovery.
    if (previous.connectionState.status != current.connectionState.status) {
      _resetState();
      return false;
    }

    final faces = current.detectedFaces;
    if (faces.isEmpty) {
      return false;
    }

    final now = DateTime.now();

    if (faces.length > 1) {
      return _handleMultipleFaces(now);
    }

    final face = faces.first;
    if (face.isRecognized && face.faceId != null) {
      return _handleRecognizedFace(now, face);
    }

    return _handleUnrecognizedFace(now);
  }

  /// Debounces notifications for multiple detected faces.
  bool _handleMultipleFaces(DateTime now) {
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

  /// Debounces notifications for a single recognized face.
  bool _handleRecognizedFace(DateTime now, FaceDetectionResult face) {
    final isNewFace = _lastProcessedFaceId != face.faceId;
    final debounceTimePassed =
        _lastRecognizedShown == null ||
        now.difference(_lastRecognizedShown!) > _recognizedDebounce;

    if (isNewFace && debounceTimePassed) {
      _lastProcessedFaceId = face.faceId;
      _lastRecognizedShown = now;
      return true;
    }
    return false;
  }

  /// Debounces notifications for a single unrecognized face.
  bool _handleUnrecognizedFace(DateTime now) {
    final shouldShow =
        _lastUnrecognizedShown == null ||
        now.difference(_lastUnrecognizedShown!) > _unrecognizedDebounce;

    if (shouldShow) {
      _lastProcessedFaceId = null;
      _lastUnrecognizedShown = now;
      return true;
    }
    return false;
  }

  /// Routes the state to the appropriate UI feedback method.
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

  /// Resets single-face tracking state, typically when multiple faces are detected.
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

    UIHelper.showAppSnackBar(
      context: context,
      title: 'Multiple Faces Detected',
      message: message,
      type: SnackBarType.info,
    );
  }

  /// Show message for unrecognized face
  void _showUnrecognizedFaceMessage(BuildContext context) {
    UIHelper.showAppSnackBar(
      context: context,
      title: 'Face Not Recognized',
      message:
          'Face detected but not recognized. Ensure good lighting and face the camera directly.',
      type: SnackBarType.warning,
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

    context.read<CheckInBloc>().add(
      const BucketRestartableCheckInEvent.stopImageStream(),
    );

    // Show success dialog with new styled dialog
    final face = recognizedFaces.first;
    SuccessInfoDialog.show(
      context,
      faceId: face.faceId ?? 'Unknown',
      memoryImage:
          userImage != null
              ? base64Decode(userImage)
              : null, // Pass image as Base64 string
      confidence: face.confidence,
      onDialogClosed: () {
        context.read<CheckInBloc>().add(
          const BucketRestartableCheckInEvent.startImageStream(),
        );
      },
    );
  }
}
