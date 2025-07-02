import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/face_detection_service.dart';

part 'face_detection_state.freezed.dart';

/// Domain entity representing face detection state
///
/// Manages detected faces, annotated images, and face recognition results.
/// Separated from camera and streaming concerns.
@freezed
class FaceDetectionState with _$FaceDetectionState {
  const factory FaceDetectionState({
    @Default([]) List<FaceDetectionResult> detectedFaces,
    @Default(WebSocketConnectionStatus.disconnected)
    WebSocketConnectionStatus connectionStatus,
    String? annotatedImage,
    String? errorMessage,
    DateTime? lastDetectionTime,
    @Default(false) bool isProcessing,
    @Default(0) int totalDetectedFrames,
    @Default(0) int recognizedFacesCount,
  }) = _FaceDetectionState;

  const FaceDetectionState._();

  /// Business logic: Check if connected to face detection service
  bool get isConnected =>
      connectionStatus == WebSocketConnectionStatus.connected;

  /// Business logic: Check if there are any detected faces
  bool get hasFaces => detectedFaces.isNotEmpty;

  /// Business logic: Check if there are recognized faces
  bool get hasRecognizedFaces => detectedFaces.any((face) => face.isRecognized);

  /// Business logic: Check if has error
  bool get hasError =>
      connectionStatus == WebSocketConnectionStatus.error ||
      errorMessage != null;

  /// Business logic: Get recognized faces only
  List<FaceDetectionResult> get recognizedFaces =>
      detectedFaces.where((face) => face.isRecognized).toList();

  /// Business logic: Get unrecognized faces only
  List<FaceDetectionResult> get unrecognizedFaces =>
      detectedFaces.where((face) => !face.isRecognized).toList();

  /// Business logic: Get the highest confidence face
  FaceDetectionResult? get highestConfidenceFace {
    if (detectedFaces.isEmpty) return null;

    return detectedFaces.reduce((a, b) => a.confidence > b.confidence ? a : b);
  }

  /// Business logic: Get recognition rate percentage
  double get recognitionRate {
    if (totalDetectedFrames == 0) return 0.0;
    return (recognizedFacesCount / totalDetectedFrames) * 100;
  }

  /// Business logic: Check if face detection is working well
  bool get isDetectionHealthy =>
      isConnected &&
      !hasError &&
      lastDetectionTime != null &&
      DateTime.now().difference(lastDetectionTime!).inSeconds < 30;

  /// Business logic: Get display message for current state
  String get displayMessage {
    if (hasError) {
      return errorMessage ?? 'Face detection error';
    }

    switch (connectionStatus) {
      case WebSocketConnectionStatus.disconnected:
        return 'Face detection disconnected';
      case WebSocketConnectionStatus.connecting:
        return 'Connecting to face detection...';
      case WebSocketConnectionStatus.connected:
        if (isProcessing) {
          return 'Processing face detection...';
        } else if (hasFaces) {
          final recognizedCount = recognizedFaces.length;
          final totalCount = detectedFaces.length;
          return 'Detected $totalCount face(s), $recognizedCount recognized';
        } else {
          return 'Face detection ready - no faces detected';
        }
      case WebSocketConnectionStatus.error:
        return 'Face detection connection error';
    }
  }

  /// Business logic: Get face detection summary
  String get detectionSummary {
    if (!isConnected) return 'Not connected';

    return 'Frames: $totalDetectedFrames, '
        'Recognition rate: ${recognitionRate.toStringAsFixed(1)}%, '
        'Current faces: ${detectedFaces.length}';
  }

  /// Create a copy with new face detection data
  FaceDetectionState withDetectionData(FaceDetectionData data) {
    return copyWith(
      detectedFaces: data.faces,
      annotatedImage: data.annotatedImage,
      lastDetectionTime: data.timestamp,
      isProcessing: false,
      totalDetectedFrames: totalDetectedFrames + 1,
      recognizedFacesCount: recognizedFacesCount +
          data.faces.where((face) => face.isRecognized).length,
      errorMessage: null, // Clear any previous errors
    );
  }

  /// Create a copy with error information
  FaceDetectionState withError(String message) {
    return copyWith(
      errorMessage: message,
      isProcessing: false,
    );
  }

  /// Create a copy clearing error information
  FaceDetectionState clearError() {
    return copyWith(
      errorMessage: null,
    );
  }

  /// Create a copy clearing detected faces
  FaceDetectionState clearFaces() {
    return copyWith(
      detectedFaces: [],
      annotatedImage: null,
    );
  }

  /// Reset detection counters
  FaceDetectionState resetCounters() {
    return copyWith(
      totalDetectedFrames: 0,
      recognizedFacesCount: 0,
      lastDetectionTime: null,
    );
  }

  /// Update connection status
  FaceDetectionState withConnectionStatus(WebSocketConnectionStatus status) {
    return copyWith(
      connectionStatus: status,
      errorMessage:
          status == WebSocketConnectionStatus.error ? null : errorMessage,
    );
  }
}
