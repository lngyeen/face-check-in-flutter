import 'dart:async';
import 'dart:developer' as developer;
import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import '../models/frame_data.dart';
import '../enums/frame_capture_status.dart';
import 'frame_processor.dart';

/// Exception thrown when frame capture operations fail
class FrameCaptureException implements Exception {
  const FrameCaptureException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'FrameCaptureException: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

/// Service responsible for capturing camera frames at 30 FPS with performance monitoring
@injectable
class FrameCaptureService {
  FrameCaptureService(this._frameProcessor);

  final FrameProcessor _frameProcessor;

  // Constants
  static const Duration _targetFrameInterval = Duration(
    milliseconds: 33,
  ); // 30 FPS
  static const int _maxQueueSize = 10; // Prevent memory overflow
  static const int _performanceHistorySize = 100; // Track recent performance

  // State management
  FrameCaptureStatus _status = FrameCaptureStatus.idle;
  Timer? _captureTimer;
  CameraController? _cameraController;
  StreamSubscription<CameraImage>? _imageSubscription;

  // Performance tracking
  final List<FrameData> _recentFrames = [];
  FrameCaptureMetrics _metrics = const FrameCaptureMetrics();

  // Frame queue for processing
  final List<CameraImage> _frameQueue = [];
  bool _isProcessing = false;

  // Stream controllers
  final StreamController<FrameCaptureStatus> _statusController =
      StreamController<FrameCaptureStatus>.broadcast();
  final StreamController<FrameData> _frameController =
      StreamController<FrameData>.broadcast();
  final StreamController<FrameCaptureMetrics> _metricsController =
      StreamController<FrameCaptureMetrics>.broadcast();
  final StreamController<FrameCaptureException> _errorController =
      StreamController<FrameCaptureException>.broadcast();

  // Getters
  FrameCaptureStatus get status => _status;
  FrameCaptureMetrics get metrics => _metrics;

  // Streams
  Stream<FrameCaptureStatus> get statusStream => _statusController.stream;
  Stream<FrameData> get frameStream => _frameController.stream;
  Stream<FrameCaptureMetrics> get metricsStream => _metricsController.stream;
  Stream<FrameCaptureException> get errorStream => _errorController.stream;

  /// Starts frame capture with the provided camera controller
  Future<void> startCapture(CameraController cameraController) async {
    try {
      if (!_status.canStart) {
        throw FrameCaptureException(
          'Cannot start capture from current status: ${_status.description}',
        );
      }

      _updateStatus(FrameCaptureStatus.initializing);

      // Validate camera controller
      if (!cameraController.value.isInitialized) {
        throw FrameCaptureException('Camera controller is not initialized');
      }

      _cameraController = cameraController;

      // Reset metrics
      _metrics = FrameCaptureMetrics(sessionStartTime: DateTime.now());
      _recentFrames.clear();
      _frameQueue.clear();

      // Start image streaming
      await _startImageStream();

      // Start capture timer for 30 FPS
      _startCaptureTimer();

      _updateStatus(FrameCaptureStatus.active);
      _updateMetrics();

      developer.log(
        'Frame capture started successfully',
        name: 'FrameCaptureService',
        level: 800,
      );
    } catch (e, stackTrace) {
      _updateStatus(FrameCaptureStatus.error);
      final exception = FrameCaptureException('Failed to start capture', e);
      _errorController.add(exception);
      developer.log(
        'Failed to start frame capture',
        name: 'FrameCaptureService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
      throw exception;
    }
  }

  /// Stops frame capture
  Future<void> stopCapture() async {
    try {
      if (!_status.canStop) {
        developer.log(
          'Cannot stop capture from current status: ${_status.description}',
          name: 'FrameCaptureService',
          level: 900,
        );
        return;
      }

      _updateStatus(FrameCaptureStatus.stopping);

      // Stop timer and image stream
      _captureTimer?.cancel();
      _captureTimer = null;

      await _imageSubscription?.cancel();
      _imageSubscription = null;

      // Clear frame queue
      _frameQueue.clear();
      _isProcessing = false;

      _updateStatus(FrameCaptureStatus.stopped);
      _updateMetrics();

      developer.log(
        'Frame capture stopped successfully',
        name: 'FrameCaptureService',
        level: 800,
      );
    } catch (e, stackTrace) {
      _updateStatus(FrameCaptureStatus.error);
      final exception = FrameCaptureException('Failed to stop capture', e);
      _errorController.add(exception);
      developer.log(
        'Failed to stop frame capture',
        name: 'FrameCaptureService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
      throw exception;
    }
  }

  /// Pauses frame capture
  Future<void> pauseCapture() async {
    if (!_status.canPause) {
      throw FrameCaptureException(
        'Cannot pause capture from current status: ${_status.description}',
      );
    }

    _captureTimer?.cancel();
    _captureTimer = null;

    _updateStatus(FrameCaptureStatus.paused);
    _updateMetrics();

    developer.log(
      'Frame capture paused',
      name: 'FrameCaptureService',
      level: 800,
    );
  }

  /// Resumes frame capture
  Future<void> resumeCapture() async {
    if (!_status.canResume) {
      throw FrameCaptureException(
        'Cannot resume capture from current status: ${_status.description}',
      );
    }

    _startCaptureTimer();
    _updateStatus(FrameCaptureStatus.active);
    _updateMetrics();

    developer.log(
      'Frame capture resumed',
      name: 'FrameCaptureService',
      level: 800,
    );
  }

  /// Gets current recommended frame rate based on performance
  double getRecommendedFrameRate() {
    return _frameProcessor.getRecommendedFrameRate(_recentFrames);
  }

  /// Checks if performance is acceptable
  bool get isPerformanceAcceptable {
    if (_recentFrames.isEmpty) return true;

    final recentSuccessfulFrames =
        _recentFrames
            .where((frame) => _frameProcessor.isPerformanceAcceptable(frame))
            .length;

    return recentSuccessfulFrames / _recentFrames.length >
        0.8; // 80% success rate
  }

  /// Disposes resources
  void dispose() {
    _captureTimer?.cancel();
    _imageSubscription?.cancel();
    _statusController.close();
    _frameController.close();
    _metricsController.close();
    _errorController.close();
    _frameQueue.clear();
    _recentFrames.clear();
  }

  // Private methods

  /// Starts the camera image stream
  Future<void> _startImageStream() async {
    if (_cameraController == null) {
      throw FrameCaptureException('Camera controller is null');
    }

    try {
      await _cameraController!.startImageStream(_onCameraImage);
    } catch (e) {
      throw FrameCaptureException('Failed to start image stream', e);
    }
  }

  /// Starts the capture timer for 30 FPS
  void _startCaptureTimer() {
    _captureTimer = Timer.periodic(_targetFrameInterval, (_) async {
      if (_frameQueue.isNotEmpty && !_isProcessing) {
        await _processNextFrame();
      }
    });
  }

  /// Handles camera image from stream
  void _onCameraImage(CameraImage image) {
    if (_status != FrameCaptureStatus.active) return;

    // Add to queue if not full
    if (_frameQueue.length < _maxQueueSize) {
      _frameQueue.add(image);
    } else {
      // Queue is full, remove oldest frame to prevent memory issues
      _frameQueue.removeAt(0);
      _frameQueue.add(image);

      // Update metrics for dropped frames
      _metrics = _metrics.copyWith(failedFrames: _metrics.failedFrames + 1);
    }
  }

  /// Processes the next frame in queue
  Future<void> _processNextFrame() async {
    if (_frameQueue.isEmpty || _isProcessing) return;

    _isProcessing = true;

    try {
      final image = _frameQueue.removeAt(0);
      final frameData = await _frameProcessor.processFrame(image);

      // Add to recent frames history
      _recentFrames.add(frameData);
      if (_recentFrames.length > _performanceHistorySize) {
        _recentFrames.removeAt(0);
      }

      // Update metrics
      _updateFrameMetrics(frameData);

      // Emit frame data
      _frameController.add(frameData);
    } catch (e, stackTrace) {
      final exception = FrameCaptureException('Frame processing failed', e);
      _errorController.add(exception);

      // Update failure metrics
      _metrics = _metrics.copyWith(failedFrames: _metrics.failedFrames + 1);

      developer.log(
        'Frame processing failed',
        name: 'FrameCaptureService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    } finally {
      _isProcessing = false;
    }
  }

  /// Updates capture status
  void _updateStatus(FrameCaptureStatus newStatus) {
    if (_status != newStatus) {
      _status = newStatus;
      _statusController.add(_status);
    }
  }

  /// Updates metrics
  void _updateMetrics() {
    final now = DateTime.now();

    _metrics = _metrics.copyWith(
      lastFrameTimestamp: now,
      currentFps: _calculateCurrentFps(),
      averageFps: _calculateAverageFps(),
    );

    _metricsController.add(_metrics);
  }

  /// Updates metrics with frame data
  void _updateFrameMetrics(FrameData frameData) {
    final now = DateTime.now();

    _metrics = _metrics.copyWith(
      totalFrames: _metrics.totalFrames + 1,
      successfulFrames: _metrics.successfulFrames + 1,
      lastFrameTimestamp: now,
      totalBytesProcessed: _metrics.totalBytesProcessed + frameData.encodedSize,
      averageProcessingTimeMs: _calculateAverageProcessingTime(),
      maxProcessingTimeMs: _updateMaxProcessingTime(frameData.processingTimeMs),
      currentFps: _calculateCurrentFps(),
      averageFps: _calculateAverageFps(),
    );

    _metricsController.add(_metrics);
  }

  /// Calculates current FPS based on recent frames
  double _calculateCurrentFps() {
    if (_recentFrames.length < 2) return 0.0;

    final recentFrames = _recentFrames.take(10).toList();
    if (recentFrames.length < 2) return 0.0;

    final timeSpan =
        recentFrames.first.timestamp
            .difference(recentFrames.last.timestamp)
            .inMilliseconds;

    if (timeSpan == 0) return 0.0;

    return (recentFrames.length * 1000) / timeSpan;
  }

  /// Calculates average FPS for entire session
  double _calculateAverageFps() {
    if (_metrics.sessionStartTime == null || _metrics.totalFrames == 0) {
      return 0.0;
    }

    final sessionDuration =
        DateTime.now().difference(_metrics.sessionStartTime!).inMilliseconds;

    if (sessionDuration == 0) return 0.0;

    return (_metrics.totalFrames * 1000) / sessionDuration;
  }

  /// Calculates average processing time
  double _calculateAverageProcessingTime() {
    if (_recentFrames.isEmpty) return 0.0;

    final validFrames =
        _recentFrames.where((frame) => frame.processingTimeMs != null).toList();

    if (validFrames.isEmpty) return 0.0;

    final totalTime = validFrames
        .map((frame) => frame.processingTimeMs!)
        .fold(0, (sum, time) => sum + time);

    return totalTime / validFrames.length;
  }

  /// Updates maximum processing time
  double _updateMaxProcessingTime(int? processingTime) {
    if (processingTime == null) return _metrics.maxProcessingTimeMs;

    return processingTime > _metrics.maxProcessingTimeMs
        ? processingTime.toDouble()
        : _metrics.maxProcessingTimeMs;
  }
}
