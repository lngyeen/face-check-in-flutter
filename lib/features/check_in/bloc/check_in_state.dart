import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';

part 'check_in_state.freezed.dart';

@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState({
    @Default(CameraStatus.initial) CameraStatus cameraStatus,
    CameraController? cameraController,
    @Default(ConnectionState()) ConnectionState connectionState,
    FaceDetectionData? latestFrameData,
    CheckInError? currentError,
    @Default(false) bool isDebugMode,
  }) = _CheckInState;

  const CheckInState._();

  List<FaceDetectionResult> get detectedFaces => latestFrameData?.faces ?? [];

  String? get annotatedImage => latestFrameData?.annotatedImage;
}
