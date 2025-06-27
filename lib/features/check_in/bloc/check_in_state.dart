import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';

part 'check_in_state.freezed.dart';

/// Main state for the check-in feature
/// Contains all state information needed for camera, WebSocket, and UI management
@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState({
    /// Current camera status
    @Default(CameraStatus.initial) CameraStatus cameraStatus,

    /// Camera controller instance
    CameraController? cameraController,

    /// Connection state
    @Default(ConnectionState()) ConnectionState connectionState,

    /// Latest frame data for full response access - contains faces, annotatedImage, timestamp, etc.
    FaceDetectionData? latestFrameData,

    /// Current error (combines camera, permission, and backend errors)
    CheckInError? currentError,

    /// Whether debug mode is enabled
    @Default(false) bool isDebugMode,
  }) = _CheckInState;

  const CheckInState._();

  /// Detected faces derived from latest frame data
  List<FaceDetectionResult> get detectedFaces => latestFrameData?.faces ?? [];

  /// Latest annotated image from backend for face overlay display
  String? get annotatedImage => latestFrameData?.annotatedImage;
}
