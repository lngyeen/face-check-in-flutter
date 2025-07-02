import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/camera_state.dart';
import '../entities/check_in_screen_state.dart';
import '../entities/streaming_state.dart';
import '../services/camera_service.dart';
import '../services/face_detection_service.dart';
import '../services/image_streaming_service.dart';

/// Central orchestrator for check-in business logic
///
/// Coordinates camera, streaming, and face detection services to provide
/// a unified business logic layer. Extracted from CheckInBloc to follow
/// Single Responsibility Principle and Clean Architecture.
@injectable
class CheckInOrchestrator {
  final CameraService _cameraService;
  final ImageStreamingService _streamingService;
  final FaceDetectionService _faceDetectionService;

  // Internal state management
  final _stateSubject = BehaviorSubject<CheckInScreenState>.seeded(
    const CheckInScreenState(),
  );

  // Subscriptions for service coordination
  StreamSubscription? _cameraSubscription;
  StreamSubscription? _streamingSubscription;
  StreamSubscription? _faceDetectionSubscription;
  StreamSubscription? _processedFrameSubscription;

  // Synchronization flags to prevent race conditions
  bool _isInitializing = false;
  bool _isStopping = false;
  bool _isStartingStreaming = false;

  // Circuit breaker for error recovery
  int _failureCount = 0;
  static const _maxFailures = 3;
  DateTime? _lastFailureTime;
  static const _backoffDuration = Duration(minutes: 1);

  /// Current check-in screen state
  CheckInScreenState get currentState => _stateSubject.value;

  /// Stream of check-in screen state changes
  Stream<CheckInScreenState> get stateStream => _stateSubject.stream;

  CheckInOrchestrator(
    this._cameraService,
    this._streamingService,
    this._faceDetectionService,
  ) {
    _setupServiceListeners();
  }

  /// Setup listeners to coordinate all services
  void _setupServiceListeners() {
    // Listen to camera service changes
    _cameraSubscription = _cameraService.statusStream
        .map((status) => CameraState(
            status: status, controller: _cameraService.currentController))
        .listen((cameraState) {
      _updateState(currentState.withCameraState(cameraState));
      _handleCameraStateChange(cameraState);
    });

    // Listen to streaming service changes
    _streamingSubscription = _streamingService.statusStream
        .map((status) =>
            StreamingState(status: status, maxFps: _streamingService.maxFps))
        .listen((streamingState) {
      _updateState(currentState.withStreamingState(streamingState));
      _handleStreamingStateChange(streamingState);
    });

    // Listen to face detection service changes
    _faceDetectionSubscription =
        _faceDetectionService.detectionStream.listen((detectionData) {
      final newFaceState =
          currentState.faceDetectionState.withDetectionData(detectionData);
      _updateState(currentState.withFaceDetectionState(newFaceState));
    });

    // Connect processed frames to face detection
    _processedFrameSubscription =
        _streamingService.processedFrameStream.listen((frame) {
      _faceDetectionService.processFrame(frame);

      // Update streaming state with new frame
      final newStreamingState = currentState.streamingState.withNewFrame(frame);
      _updateState(currentState.withStreamingState(newStreamingState));
    });
  }

  /// Handle camera state changes and coordinate with streaming
  void _handleCameraStateChange(CameraState cameraState) {
    // Prevent multiple concurrent streaming starts
    if (_isStartingStreaming || _isStopping) return;

    // Auto-start streaming when camera is ready
    if (cameraState.canStartStreaming &&
        currentState.streamingState.isIdle &&
        cameraState.controller != null &&
        !_isInBackoffPeriod()) {
      startStreaming();
    }

    // Stop streaming when camera is not available
    if (!cameraState.canStartStreaming &&
        currentState.streamingState.isStreaming) {
      stopStreaming();
    }
  }

  /// Handle streaming state changes
  void _handleStreamingStateChange(StreamingState streamingState) {
    // Reset failure count on successful streaming
    if (streamingState.isStreaming) {
      _resetFailureCount();
    }

    // Handle streaming errors
    if (streamingState.hasError) {
      _recordFailure();
    }
  }

  /// Check if system is in backoff period due to failures
  bool _isInBackoffPeriod() {
    if (_lastFailureTime == null) return false;

    final timeSinceLastFailure = DateTime.now().difference(_lastFailureTime!);
    return _failureCount >= _maxFailures &&
        timeSinceLastFailure < _backoffDuration;
  }

  /// Record a failure and implement circuit breaker logic
  void _recordFailure() {
    _failureCount++;
    _lastFailureTime = DateTime.now();

    if (_failureCount >= _maxFailures) {
      _updateState(currentState.withGlobalError(
          'System temporarily disabled due to repeated failures. Retrying in ${_backoffDuration.inMinutes} minutes.'));
    }
  }

  /// Reset failure count on successful operation
  void _resetFailureCount() {
    _failureCount = 0;
    _lastFailureTime = null;
  }

  /// Update internal state and emit to listeners
  void _updateState(CheckInScreenState newState) {
    _stateSubject.add(newState);
  }

  /// Initialize the entire check-in system
  Future<void> initialize() async {
    if (_isInitializing || _isInBackoffPeriod()) return;

    _isInitializing = true;

    try {
      _updateState(currentState.withGlobalError('Initializing system...'));

      // Start camera first
      await _cameraService.start();

      // Camera will auto-trigger streaming via _handleCameraStateChange
      _resetFailureCount();
    } catch (e) {
      _recordFailure();
      _updateState(currentState
          .withGlobalError('Failed to initialize: ${e.toString()}'));
    } finally {
      _isInitializing = false;
    }
  }

  /// Start image streaming with safeguards
  Future<void> startStreaming() async {
    if (_isStartingStreaming || _isStopping || _isInBackoffPeriod()) return;

    final controller = _cameraService.currentController;
    if (controller == null) {
      _updateState(
          currentState.withGlobalError('Camera not available for streaming'));
      return;
    }

    _isStartingStreaming = true;

    try {
      await _streamingService.start(controller);
    } catch (e) {
      _recordFailure();
      _updateState(currentState
          .withGlobalError('Failed to start streaming: ${e.toString()}'));
    } finally {
      _isStartingStreaming = false;
    }
  }

  /// Stop image streaming
  Future<void> stopStreaming() async {
    if (_isStopping) return;

    try {
      await _streamingService.stop();
    } catch (e) {
      _updateState(currentState
          .withGlobalError('Failed to stop streaming: ${e.toString()}'));
    }
  }

  /// Stop camera and all related services
  Future<void> stopCamera() async {
    if (_isStopping) return;

    _isStopping = true;

    try {
      // Stop in reverse order of dependencies
      await stopStreaming();
      await _cameraService.stop();
    } catch (e) {
      _updateState(currentState
          .withGlobalError('Failed to stop camera: ${e.toString()}'));
    } finally {
      _isStopping = false;
    }
  }

  /// Set streaming frame rate
  void setStreamingFps(int fps) {
    try {
      _streamingService.setMaxFps(fps);

      // Update state with new FPS
      final newStreamingState =
          currentState.streamingState.copyWith(maxFps: fps);
      _updateState(currentState.withStreamingState(newStreamingState));
    } catch (e) {
      _updateState(
          currentState.withGlobalError('Invalid FPS setting: ${e.toString()}'));
    }
  }

  /// Perform check-in with recognized faces
  Future<void> performCheckIn() async {
    if (!currentState.canCheckIn) {
      _updateState(currentState.withGlobalError(
          'Cannot check in - system not ready or no recognized faces'));
      return;
    }

    final recognizedFaces = currentState.faceDetectionState.recognizedFaces;
    if (recognizedFaces.isEmpty) {
      _updateState(currentState.withGlobalError('No recognized faces found'));
      return;
    }

    try {
      _updateState(currentState.startCheckIn('Processing check-in...'));

      // Get the highest confidence face for check-in
      final primaryFace = currentState.faceDetectionState.highestConfidenceFace;

      if (primaryFace?.name != null) {
        // Simulate check-in process
        await Future.delayed(const Duration(seconds: 2));

        _updateState(currentState
            .completeCheckIn('Check-in successful for ${primaryFace!.name}'));

        // Clear the success message after a delay
        Timer(const Duration(seconds: 3), () {
          _updateState(currentState.completeCheckIn(null));
        });
      } else {
        _updateState(currentState
            .withGlobalError('Face recognized but no name available'));
      }
    } catch (e) {
      _updateState(
          currentState.withGlobalError('Check-in failed: ${e.toString()}'));
    }
  }

  /// Toggle debug mode
  void toggleDebugMode() {
    _updateState(currentState.toggleDebugMode());
  }

  /// Toggle annotated image display
  void toggleAnnotatedImage() {
    _updateState(currentState.toggleAnnotatedImage());
  }

  /// Clear all errors
  void clearErrors() {
    _updateState(currentState.clearGlobalError());
  }

  /// Send custom message to face detection service
  void sendCustomMessage(Map<String, dynamic> message) {
    try {
      _faceDetectionService.sendCustomMessage(message);
    } catch (e) {
      _updateState(currentState
          .withGlobalError('Failed to send message: ${e.toString()}'));
    }
  }

  /// Get system performance metrics
  Map<String, dynamic> getPerformanceMetrics() {
    final state = currentState;

    return {
      'isSystemHealthy': state.isSystemHealthy,
      'isReadyForCheckIn': state.isReadyForCheckIn,
      'camera': {
        'status': state.cameraState.status.toString(),
        'isReady': state.cameraState.isReady,
        'hasError': state.cameraState.hasError,
      },
      'streaming': {
        'status': state.streamingState.status.toString(),
        'actualFps': state.streamingState.actualFps,
        'maxFps': state.streamingState.maxFps,
        'frameDropRatio': state.streamingState.frameDropRatio,
        'processedFrames': state.streamingState.processedFrameCount,
      },
      'faceDetection': {
        'isConnected': state.faceDetectionState.isConnected,
        'detectedFaces': state.faceDetectionState.detectedFaces.length,
        'recognizedFaces': state.faceDetectionState.recognizedFaces.length,
        'recognitionRate': state.faceDetectionState.recognitionRate,
        'isHealthy': state.faceDetectionState.isDetectionHealthy,
      },
    };
  }

  /// Dispose orchestrator and cleanup all subscriptions
  void dispose() {
    // Cancel all subscriptions first
    _cameraSubscription?.cancel();
    _streamingSubscription?.cancel();
    _faceDetectionSubscription?.cancel();
    _processedFrameSubscription?.cancel();

    // Dispose services synchronously to prevent hanging
    _streamingService.dispose();
    _cameraService.dispose();
    _faceDetectionService.dispose();

    // Close state subject
    _stateSubject.close();
  }
}
