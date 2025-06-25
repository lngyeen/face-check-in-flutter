import 'package:camera/camera.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_status.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/features/connection/connection.dart'
    as conn;
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';

part 'check_in_state.freezed.dart';

/// Main state for the check-in feature
/// Contains all state information needed for camera, WebSocket, and UI management
@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState({
    /// Current camera status
    @Default(CameraStatus.initial) CameraStatus cameraStatus,

    /// Current permission status
    @Default(PermissionStatus.initial) PermissionStatus permissionStatus,

    /// Current error, if any
    CheckInError? currentError,

    /// Camera controller instance
    CameraController? cameraController,

    /// Whether debug mode is enabled
    @Default(false) bool isDebugMode,

    /// Face detection status and confidence
    @Default(FaceDetectionStatus.none) FaceDetectionStatus faceStatus,

    /// Backend error information
    BackendError? responseError,

    /// Connection state
    @Default(ConnectionState()) ConnectionState connectionState,

    /// Latest frame data for full response access - contains faces, annotatedImage, timestamp, etc.
    FaceDetectionData? latestFrameData,
  }) = _CheckInState;

  const CheckInState._();

  bool get isFullFlowActive =>
      cameraStatus == CameraStatus.operational && connectionState.canStream;

  /// Detected faces derived from latest frame data
  List<FaceDetectionResult> get detectedFaces => latestFrameData?.faces ?? [];

  /// Latest annotated image from backend for face overlay display
  String? get annotatedImage => latestFrameData?.annotatedImage;
}
