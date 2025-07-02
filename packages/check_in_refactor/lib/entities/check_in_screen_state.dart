import 'package:freezed_annotation/freezed_annotation.dart';

import 'camera_state.dart';
import 'streaming_state.dart';
import 'face_detection_state.dart';
import '../services/image_streaming_service.dart';
import '../services/face_detection_service.dart';
import '../usecases/notification_interactor.dart';

part 'check_in_screen_state.freezed.dart';

/// Domain entity representing the overall check-in screen state
///
/// Coordinates camera, streaming, and face detection states to provide
/// a unified view for the UI layer.
@freezed
class CheckInScreenState with _$CheckInScreenState {
  const factory CheckInScreenState({
    @Default(CameraState()) CameraState cameraState,
    @Default(StreamingState()) StreamingState streamingState,
    @Default(FaceDetectionState()) FaceDetectionState faceDetectionState,
    @Default(false) bool isDebugMode,
    @Default(false) bool showAnnotatedImage,
    @Default(false) bool isCheckingIn,
    String? checkInMessage,
    String? globalError,
    DateTime? lastActivityTime,
    NotificationData? pendingNotification,
    @Default(false) bool isFullScreen,
  }) = _CheckInScreenState;

  const CheckInScreenState._();

  /// Business logic: Check if the entire system is ready for check-in
  bool get isReadyForCheckIn =>
      cameraState.canStartStreaming &&
      streamingState.isStreaming &&
      faceDetectionState.isConnected &&
      !hasAnyError;

  /// Business logic: Check if any component has an error
  bool get hasAnyError =>
      cameraState.hasError ||
      streamingState.hasError ||
      faceDetectionState.hasError ||
      globalError != null;

  /// Business logic: Check if system is initializing
  bool get isInitializing =>
      cameraState.isInitializing ||
      streamingState.status == StreamingStatus.idle ||
      faceDetectionState.connectionStatus ==
          WebSocketConnectionStatus.connecting;

  /// Business logic: Check if check-in is possible (has recognized faces)
  bool get canCheckIn =>
      isReadyForCheckIn &&
      faceDetectionState.hasRecognizedFaces &&
      !isCheckingIn;

  /// Business logic: Get the primary error message to display
  String? get primaryErrorMessage {
    if (globalError != null) return globalError;
    if (cameraState.hasError) return cameraState.displayMessage;
    if (streamingState.hasError) return streamingState.displayMessage;
    if (faceDetectionState.hasError) return faceDetectionState.displayMessage;
    return null;
  }

  /// Business logic: Get the main status message for the UI
  String get mainStatusMessage {
    if (hasAnyError) {
      return primaryErrorMessage ?? 'System error occurred';
    }

    if (isCheckingIn) {
      return checkInMessage ?? 'Processing check-in...';
    }

    if (isInitializing) {
      if (cameraState.isInitializing) return 'Initializing camera...';
      if (streamingState.status == StreamingStatus.idle) {
        return 'Starting image streaming...';
      }
      if (faceDetectionState.connectionStatus ==
          WebSocketConnectionStatus.connecting) {
        return 'Connecting to face detection...';
      }
      return 'Initializing system...';
    }

    if (!isReadyForCheckIn) {
      if (!cameraState.canStartStreaming) return cameraState.displayMessage;
      if (!streamingState.isStreaming) return streamingState.displayMessage;
      if (!faceDetectionState.isConnected) {
        return faceDetectionState.displayMessage;
      }
      return 'System not ready';
    }

    if (faceDetectionState.hasFaces) {
      return faceDetectionState.displayMessage;
    }

    return 'Ready for face detection';
  }

  /// Business logic: Get system performance summary
  String get performanceSummary {
    if (!isReadyForCheckIn) return 'System not ready';

    return '${streamingState.performanceSummary} | ${faceDetectionState.detectionSummary}';
  }

  /// Business logic: Check if system is healthy overall
  bool get isSystemHealthy =>
      !hasAnyError &&
      streamingState.hasGoodPerformance &&
      faceDetectionState.isDetectionHealthy;

  /// Business logic: Get activity status (for timeout detection)
  bool get isActive {
    if (lastActivityTime == null) return false;

    final now = DateTime.now();
    final inactiveTime = now.difference(lastActivityTime!);

    // Consider active if there was activity in the last 5 minutes
    return inactiveTime.inMinutes < 5;
  }

  /// Create a copy with updated camera state
  CheckInScreenState withCameraState(CameraState newCameraState) {
    return copyWith(
      cameraState: newCameraState,
      lastActivityTime: DateTime.now(),
    );
  }

  /// Create a copy with updated streaming state
  CheckInScreenState withStreamingState(StreamingState newStreamingState) {
    return copyWith(
      streamingState: newStreamingState,
      lastActivityTime: DateTime.now(),
    );
  }

  /// Create a copy with updated face detection state
  CheckInScreenState withFaceDetectionState(
      FaceDetectionState newFaceDetectionState) {
    return copyWith(
      faceDetectionState: newFaceDetectionState,
      lastActivityTime: DateTime.now(),
    );
  }

  /// Create a copy with global error
  CheckInScreenState withGlobalError(String error) {
    return copyWith(
      globalError: error,
      isCheckingIn: false,
    );
  }

  /// Create a copy clearing global error
  CheckInScreenState clearGlobalError() {
    return copyWith(
      globalError: null,
    );
  }

  /// Create a copy starting check-in process
  CheckInScreenState startCheckIn([String? message]) {
    return copyWith(
      isCheckingIn: true,
      checkInMessage: message ?? 'Processing check-in...',
      globalError: null,
      lastActivityTime: DateTime.now(),
    );
  }

  /// Create a copy completing check-in process
  CheckInScreenState completeCheckIn([String? message]) {
    return copyWith(
      isCheckingIn: false,
      checkInMessage: message,
      lastActivityTime: DateTime.now(),
    );
  }

  /// Create a copy toggling debug mode
  CheckInScreenState toggleDebugMode() {
    return copyWith(
      isDebugMode: !isDebugMode,
    );
  }

  /// Create a copy toggling annotated image display
  CheckInScreenState toggleAnnotatedImage() {
    return copyWith(
      showAnnotatedImage: !showAnnotatedImage,
    );
  }

  /// Create a copy toggling full screen
  CheckInScreenState toggleFullScreen() {
    return copyWith(
      isFullScreen: !isFullScreen,
    );
  }

  /// Update activity timestamp
  CheckInScreenState updateActivity() {
    return copyWith(
      lastActivityTime: DateTime.now(),
    );
  }
}
