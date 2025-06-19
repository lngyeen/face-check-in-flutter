import 'dart:async';
import 'dart:developer' as developer;
import 'package:injectable/injectable.dart';
import 'frame_capture_service.dart';
import 'websocket_service.dart';
import 'response_processor.dart';
import 'face_detection_history.dart';
import 'response_error_handler.dart';
import '../models/frame_data.dart';
import '../../features/check_in/bloc/check_in_bloc.dart';

/// Exception thrown when frame streaming operations fail
class FrameStreamingException implements Exception {
  const FrameStreamingException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'FrameStreamingException: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

/// Extension for StreamingStatus utility methods
extension StreamingStatusExtension on StreamingStatus {
  bool get canStart =>
      this == StreamingStatus.idle || this == StreamingStatus.error;
  bool get canStop =>
      this == StreamingStatus.active || this == StreamingStatus.paused;
  bool get canPause => this == StreamingStatus.active;
  bool get canResume => this == StreamingStatus.paused;
  bool get isActive => this == StreamingStatus.active;

  String get description {
    switch (this) {
      case StreamingStatus.idle:
        return 'Ready to start streaming';
      case StreamingStatus.starting:
        return 'Starting frame streaming...';
      case StreamingStatus.active:
        return 'Streaming frames';
      case StreamingStatus.paused:
        return 'Frame streaming paused';
      case StreamingStatus.stopping:
        return 'Stopping frame streaming...';
      case StreamingStatus.error:
        return 'Frame streaming error';
    }
  }
}

/// Metrics for frame streaming performance
class FrameStreamingMetrics {
  const FrameStreamingMetrics({
    this.totalFramesStreamed = 0,
    this.successfulFrames = 0,
    this.failedFrames = 0,
    this.currentStreamingFps = 0.0,
    this.averageStreamingLatency = 0.0,
    this.totalBytesStreamed = 0,
    this.connectionUptime = Duration.zero,
    this.lastFrameStreamedAt,
    this.sessionStartTime,
  });

  final int totalFramesStreamed;
  final int successfulFrames;
  final int failedFrames;
  final double currentStreamingFps;
  final double averageStreamingLatency;
  final int totalBytesStreamed;
  final Duration connectionUptime;
  final DateTime? lastFrameStreamedAt;
  final DateTime? sessionStartTime;

  double get successRate =>
      totalFramesStreamed > 0
          ? (successfulFrames / totalFramesStreamed) * 100
          : 0.0;

  double get failureRate =>
      totalFramesStreamed > 0
          ? (failedFrames / totalFramesStreamed) * 100
          : 0.0;

  String get throughputString {
    if (connectionUptime.inSeconds == 0) return '0 B/s';
    final bytesPerSecond = totalBytesStreamed / connectionUptime.inSeconds;
    if (bytesPerSecond < 1024) {
      return '${bytesPerSecond.toStringAsFixed(1)} B/s';
    }
    if (bytesPerSecond < 1024 * 1024) {
      return '${(bytesPerSecond / 1024).toStringAsFixed(1)} KB/s';
    }
    return '${(bytesPerSecond / (1024 * 1024)).toStringAsFixed(1)} MB/s';
  }

  FrameStreamingMetrics copyWith({
    int? totalFramesStreamed,
    int? successfulFrames,
    int? failedFrames,
    double? currentStreamingFps,
    double? averageStreamingLatency,
    int? totalBytesStreamed,
    Duration? connectionUptime,
    DateTime? lastFrameStreamedAt,
    DateTime? sessionStartTime,
  }) {
    return FrameStreamingMetrics(
      totalFramesStreamed: totalFramesStreamed ?? this.totalFramesStreamed,
      successfulFrames: successfulFrames ?? this.successfulFrames,
      failedFrames: failedFrames ?? this.failedFrames,
      currentStreamingFps: currentStreamingFps ?? this.currentStreamingFps,
      averageStreamingLatency:
          averageStreamingLatency ?? this.averageStreamingLatency,
      totalBytesStreamed: totalBytesStreamed ?? this.totalBytesStreamed,
      connectionUptime: connectionUptime ?? this.connectionUptime,
      lastFrameStreamedAt: lastFrameStreamedAt ?? this.lastFrameStreamedAt,
      sessionStartTime: sessionStartTime ?? this.sessionStartTime,
    );
  }
}

/// Service responsible for streaming captured frames to backend via WebSocket
@injectable
class FrameStreamingService {
  FrameStreamingService(
    this._frameCaptureService,
    this._webSocketService,
    this._responseProcessor,
    this._faceDetectionHistory,
    this._errorHandler,
  );

  final FrameCaptureService _frameCaptureService;
  final WebSocketService _webSocketService;
  final ResponseProcessor _responseProcessor;
  final FaceDetectionHistory _faceDetectionHistory;
  final ResponseErrorHandler _errorHandler;

  // State management
  StreamingStatus _status = StreamingStatus.idle;
  FrameStreamingMetrics _metrics = const FrameStreamingMetrics();

  // Frame streaming control
  Timer? _metricsTimer;
  StreamSubscription<FrameData>? _frameSubscription;
  StreamSubscription<ConnectionStatus>? _connectionSubscription;
  StreamSubscription<dynamic>? _responseSubscription;

  // Performance tracking
  final List<DateTime> _frameSentTimes = [];
  final List<double> _latencyHistory = [];
  static const int _historySize = 50;

  // Stream controllers
  final StreamController<StreamingStatus> _statusController =
      StreamController<StreamingStatus>.broadcast();
  final StreamController<FrameStreamingMetrics> _metricsController =
      StreamController<FrameStreamingMetrics>.broadcast();
  final StreamController<FrameStreamingException> _errorController =
      StreamController<FrameStreamingException>.broadcast();
  final StreamController<FaceDetectionResponse> _faceDetectionController =
      StreamController<FaceDetectionResponse>.broadcast();

  // Getters
  StreamingStatus get status => _status;
  FrameStreamingMetrics get metrics => _metrics;

  // Streams
  Stream<StreamingStatus> get statusStream => _statusController.stream;
  Stream<FrameStreamingMetrics> get metricsStream => _metricsController.stream;
  Stream<FrameStreamingException> get errorStream => _errorController.stream;
  Stream<FaceDetectionResponse> get faceDetectionStream =>
      _faceDetectionController.stream;

  /// Starts frame streaming
  Future<void> startStreaming() async {
    try {
      if (!_status.canStart) {
        throw FrameStreamingException(
          'Cannot start streaming from current status: ${_status.description}',
        );
      }

      _updateStatus(StreamingStatus.starting);

      // Ensure WebSocket connection is established
      if (_webSocketService.currentStatus != ConnectionStatus.connected) {
        developer.log(
          'WebSocket not connected, attempting to connect...',
          name: 'FrameStreamingService',
          level: 800,
        );

        await _webSocketService.connect();

        // Wait for connection establishment
        final connectionCompleter = Completer<void>();
        late StreamSubscription subscription;

        subscription = _webSocketService.connectionStatus.listen((status) {
          if (status == ConnectionStatus.connected) {
            subscription.cancel();
            connectionCompleter.complete();
          } else if (status == ConnectionStatus.disconnected) {
            subscription.cancel();
            connectionCompleter.completeError(
              FrameStreamingException(
                'Failed to establish WebSocket connection',
              ),
            );
          }
        });

        // Timeout after 10 seconds
        await connectionCompleter.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            subscription.cancel();
            throw FrameStreamingException('WebSocket connection timeout');
          },
        );
      }

      // Reset metrics
      _metrics = FrameStreamingMetrics(sessionStartTime: DateTime.now());
      _frameSentTimes.clear();
      _latencyHistory.clear();

      // Subscribe to frame capture stream
      _frameSubscription = _frameCaptureService.frameStream.listen(
        _onFrameReceived,
        onError: _onFrameError,
        onDone: _onFrameStreamDone,
      );

      // Monitor WebSocket connection status
      _connectionSubscription = _webSocketService.connectionStatus.listen(
        _onConnectionStatusChanged,
        onError: (error) {
          developer.log(
            'WebSocket connection error: $error',
            name: 'FrameStreamingService',
            level: 1000,
          );
        },
      );

      // Subscribe to WebSocket responses for face detection
      _responseSubscription = _webSocketService.messages.listen(
        _onResponseReceived,
        onError: _onResponseError,
      );

      // Start face detection session
      _faceDetectionHistory.startNewSession();

      // Start metrics tracking
      _startMetricsTracking();

      _updateStatus(StreamingStatus.active);
      _updateMetrics();

      developer.log(
        'Frame streaming started successfully',
        name: 'FrameStreamingService',
        level: 800,
      );
    } catch (e, stackTrace) {
      _updateStatus(StreamingStatus.error);
      final exception = FrameStreamingException('Failed to start streaming', e);
      _errorController.add(exception);

      developer.log(
        'Failed to start frame streaming',
        name: 'FrameStreamingService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );

      throw exception;
    }
  }

  /// Stops frame streaming
  Future<void> stopStreaming() async {
    try {
      if (!_status.canStop) {
        developer.log(
          'Cannot stop streaming from current status: ${_status.description}',
          name: 'FrameStreamingService',
          level: 900,
        );
        return;
      }

      _updateStatus(StreamingStatus.stopping);

      // Cancel subscriptions
      await _frameSubscription?.cancel();
      await _connectionSubscription?.cancel();
      await _responseSubscription?.cancel();
      _frameSubscription = null;
      _connectionSubscription = null;
      _responseSubscription = null;

      // Stop metrics tracking
      _metricsTimer?.cancel();
      _metricsTimer = null;

      _updateStatus(StreamingStatus.idle);
      _updateMetrics();

      developer.log(
        'Frame streaming stopped successfully',
        name: 'FrameStreamingService',
        level: 800,
      );
    } catch (e, stackTrace) {
      _updateStatus(StreamingStatus.error);
      final exception = FrameStreamingException('Failed to stop streaming', e);
      _errorController.add(exception);

      developer.log(
        'Failed to stop frame streaming',
        name: 'FrameStreamingService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );

      throw exception;
    }
  }

  /// Pauses frame streaming
  Future<void> pauseStreaming() async {
    if (!_status.canPause) {
      throw FrameStreamingException(
        'Cannot pause streaming from current status: ${_status.description}',
      );
    }

    await _frameSubscription?.cancel();
    _frameSubscription = null;

    _updateStatus(StreamingStatus.paused);
    _updateMetrics();

    developer.log(
      'Frame streaming paused',
      name: 'FrameStreamingService',
      level: 800,
    );
  }

  /// Resumes frame streaming
  Future<void> resumeStreaming() async {
    if (!_status.canResume) {
      throw FrameStreamingException(
        'Cannot resume streaming from current status: ${_status.description}',
      );
    }

    // Re-subscribe to frame capture stream
    _frameSubscription = _frameCaptureService.frameStream.listen(
      _onFrameReceived,
      onError: _onFrameError,
      onDone: _onFrameStreamDone,
    );

    _updateStatus(StreamingStatus.active);
    _updateMetrics();

    developer.log(
      'Frame streaming resumed',
      name: 'FrameStreamingService',
      level: 800,
    );
  }

  /// Disposes resources
  void dispose() {
    _frameSubscription?.cancel();
    _connectionSubscription?.cancel();
    _responseSubscription?.cancel();
    _metricsTimer?.cancel();
    _statusController.close();
    _metricsController.close();
    _errorController.close();
    _faceDetectionController.close();
    _frameSentTimes.clear();
    _latencyHistory.clear();
  }

  // Private methods

  void _onFrameReceived(FrameData frameData) {
    if (_status != StreamingStatus.active) return;

    _sendFrameToBackend(frameData);
  }

  void _onFrameError(Object error) {
    developer.log(
      'Frame capture error during streaming: $error',
      name: 'FrameStreamingService',
      level: 1000,
    );

    final exception = FrameStreamingException('Frame capture error', error);
    _errorController.add(exception);
  }

  void _onFrameStreamDone() {
    developer.log(
      'Frame capture stream ended',
      name: 'FrameStreamingService',
      level: 900,
    );

    // Stop streaming if frame capture is done
    stopStreaming();
  }

  void _onConnectionStatusChanged(ConnectionStatus status) {
    developer.log(
      'WebSocket connection status changed: $status',
      name: 'FrameStreamingService',
      level: 800,
    );

    if (status == ConnectionStatus.disconnected && _status.isActive) {
      // Pause streaming if connection is lost
      pauseStreaming();
    } else if (status == ConnectionStatus.connected &&
        _status == StreamingStatus.paused) {
      // Resume streaming if connection is re-established
      resumeStreaming();
    }
  }

  Future<void> _sendFrameToBackend(FrameData frameData) async {
    final startTime = DateTime.now();

    try {
      // Create frame message for backend
      final frameMessage = {
        'type': 'frame',
        'frameId': frameData.id,
        'timestamp': frameData.timestamp.millisecondsSinceEpoch,
        'width': frameData.width,
        'height': frameData.height,
        'format': frameData.format,
        'data': frameData.base64Data,
      };

      // Send frame via WebSocket
      final sent = _webSocketService.sendMessage(frameMessage);
      if (!sent) {
        throw FrameStreamingException('Failed to send frame via WebSocket');
      }

      // Track successful transmission
      final endTime = DateTime.now();
      final latency = endTime.difference(startTime).inMilliseconds.toDouble();

      _trackFrameSent(frameData.encodedSize, latency);

      developer.log(
        'Frame sent: ${frameData.id} (${frameData.encodedSize} bytes, ${latency.toStringAsFixed(1)}ms)',
        name: 'FrameStreamingService',
        level: 700,
      );
    } catch (e) {
      // Track failed transmission
      _trackFrameFailed();

      developer.log(
        'Failed to send frame ${frameData.id}: $e',
        name: 'FrameStreamingService',
        level: 1000,
      );

      final exception = FrameStreamingException('Failed to send frame', e);
      _errorController.add(exception);
    }
  }

  void _trackFrameSent(int frameSize, double latency) {
    final now = DateTime.now();

    _frameSentTimes.add(now);
    _latencyHistory.add(latency);

    // Keep only recent history
    if (_frameSentTimes.length > _historySize) {
      _frameSentTimes.removeAt(0);
    }
    if (_latencyHistory.length > _historySize) {
      _latencyHistory.removeAt(0);
    }

    // Update metrics
    _metrics = _metrics.copyWith(
      totalFramesStreamed: _metrics.totalFramesStreamed + 1,
      successfulFrames: _metrics.successfulFrames + 1,
      totalBytesStreamed: _metrics.totalBytesStreamed + frameSize,
      lastFrameStreamedAt: now,
      currentStreamingFps: _calculateCurrentFps(),
      averageStreamingLatency: _calculateAverageLatency(),
    );
  }

  void _trackFrameFailed() {
    _metrics = _metrics.copyWith(
      totalFramesStreamed: _metrics.totalFramesStreamed + 1,
      failedFrames: _metrics.failedFrames + 1,
    );
  }

  double _calculateCurrentFps() {
    if (_frameSentTimes.length < 2) return 0.0;

    final recent = _frameSentTimes.take(10).toList();
    if (recent.length < 2) return 0.0;

    final timeSpan = recent.first.difference(recent.last).inMilliseconds;
    if (timeSpan == 0) return 0.0;

    return (recent.length * 1000) / timeSpan;
  }

  double _calculateAverageLatency() {
    if (_latencyHistory.isEmpty) return 0.0;

    return _latencyHistory.reduce((a, b) => a + b) / _latencyHistory.length;
  }

  void _startMetricsTracking() {
    _metricsTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _updateMetrics();
    });
  }

  void _updateStatus(StreamingStatus newStatus) {
    if (_status != newStatus) {
      _status = newStatus;
      _statusController.add(_status);
    }
  }

  void _updateMetrics() {
    final now = DateTime.now();

    if (_metrics.sessionStartTime != null) {
      final uptime = now.difference(_metrics.sessionStartTime!);
      _metrics = _metrics.copyWith(connectionUptime: uptime);
    }

    _metricsController.add(_metrics);
  }

  /// Handle WebSocket response messages for face detection
  void _onResponseReceived(Map<String, dynamic> message) {
    if (_status != StreamingStatus.active) return;

    try {
      final startTime = DateTime.now();

      // Process response with error handling
      _errorHandler
          .processResponseSafely(
            message: message,
            processor: _responseProcessor,
          )
          .then((response) {
            final processingTime = DateTime.now().difference(startTime);

            if (response != null) {
              // Add to history
              _faceDetectionHistory.addDetectionResult(
                response: response,
                processingTime: processingTime,
                frameId: response.frameId,
              );

              // Emit face detection event
              _faceDetectionController.add(response);

              developer.log(
                'Face detection response processed: ${response.faceCount} faces, confidence: ${response.overallConfidence.toStringAsFixed(2)}',
                name: 'FrameStreamingService',
                level: 700,
              );
            }
          })
          .catchError((error) {
            developer.log(
              'Failed to process response: $error',
              name: 'FrameStreamingService',
              level: 1000,
            );
          });
    } catch (e, stackTrace) {
      developer.log(
        'Error in response handler: $e',
        name: 'FrameStreamingService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }

  /// Handle WebSocket response errors
  void _onResponseError(Object error) {
    developer.log(
      'WebSocket response error: $error',
      name: 'FrameStreamingService',
      level: 1000,
    );

    final exception = FrameStreamingException(
      'WebSocket response error',
      error,
    );
    _errorController.add(exception);
  }
}
