import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/camera_service.dart';

part 'camera_state.freezed.dart';

/// Domain entity representing camera state
///
/// Extracted from CheckInState to follow Single Responsibility Principle.
/// Contains only camera-related state without UI or other concerns.
@freezed
class CameraState with _$CameraState {
  const factory CameraState({
    @Default(CameraStatus.initial) CameraStatus status,
    CameraController? controller,
    String? errorMessage,
    @Default(false) bool isInitializing,
    @Default(false) bool hasPermission,
  }) = _CameraState;

  const CameraState._();

  /// Business logic: Check if camera is ready for use
  bool get isReady =>
      status == CameraStatus.ready &&
      controller != null &&
      controller!.value.isInitialized;

  /// Business logic: Check if there's an error
  bool get hasError => status == CameraStatus.error || errorMessage != null;

  /// Business logic: Check if camera can start streaming
  bool get canStartStreaming => isReady && !hasError && !isInitializing;

  /// Business logic: Check if permission is denied
  bool get isPermissionDenied => status == CameraStatus.permissionDenied;

  /// Business logic: Check if front camera is unavailable
  bool get isFrontCameraUnavailable =>
      status == CameraStatus.frontCameraNotAvailable;

  /// Business logic: Get display message for current state
  String get displayMessage {
    switch (status) {
      case CameraStatus.initial:
        return 'Camera not initialized';
      case CameraStatus.initializing:
        return 'Initializing camera...';
      case CameraStatus.ready:
        return isReady ? 'Camera ready' : 'Opening camera...';
      case CameraStatus.permissionDenied:
        return 'Camera permission denied';
      case CameraStatus.frontCameraNotAvailable:
        return 'Front camera not available';
      case CameraStatus.error:
        return errorMessage ?? 'Camera error occurred';
    }
  }

  /// Create a copy with error information
  CameraState withError(String message) {
    return copyWith(
      status: CameraStatus.error,
      errorMessage: message,
      isInitializing: false,
    );
  }

  /// Create a copy clearing error information
  CameraState clearError() {
    return copyWith(
      errorMessage: null,
    );
  }
}
