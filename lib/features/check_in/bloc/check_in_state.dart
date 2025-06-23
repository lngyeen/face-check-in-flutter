part of 'check_in_bloc.dart';

/// Main state for the check-in feature
/// Contains all state information needed for camera, WebSocket, and UI management
@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState({
    /// Current camera status
    @Default(CameraStatus.initial) CameraStatus cameraStatus,

    /// Current permission status
    @Default(PermissionStatus.initial) PermissionStatus permissionStatus,

    /// Current WebSocket connection status
    @Default(ConnectionStatus.disconnected) ConnectionStatus connectionStatus,

    /// Current frame streaming status
    @Default(StreamingStatus.idle) StreamingStatus streamingStatus,

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

    /// Latest frame data for full response access - contains faces, annotatedImage, timestamp, etc.
    FaceDetectionData? latestFrameData,

    /// Current connection state from ConnectionManager
    @Default(
      conn.ConnectionSummary(
        networkConnected: true,
        webSocketStatus: ConnectionStatus.disconnected,
        isOperational: false,
        currentState: conn.ConnectionState.initializing,
      ),
    )
    conn.ConnectionSummary connectionSummary,
  }) = _CheckInState;

  const CheckInState._();

  /// Derived loading state from various status fields
  bool get isLoading =>
      cameraStatus == CameraStatus.initializing ||
      connectionStatus == ConnectionStatus.connecting;

  /// Check if full flow is active (camera operational and streaming active)
  bool get isFullFlowActive =>
      cameraStatus == CameraStatus.operational &&
      streamingStatus == StreamingStatus.active;

  /// Detected faces derived from latest frame data
  List<FaceDetectionResult> get detectedFaces =>
      (latestFrameData?.faces ?? [])
          .where((face) => face.isRecognized)
          .toList();

  /// Latest annotated image from backend for face overlay display
  String? get annotatedImage => latestFrameData?.annotatedImage;
}
