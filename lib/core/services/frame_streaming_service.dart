import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/frame_capture_service.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/core/utils/image_converter.dart';

/// Enum for streaming status
enum StreamingStatus { idle, starting, active, paused, stopping, error }

/// Service for streaming camera frames to the backend via WebSocket
///
/// This service manages the frame streaming pipeline:
/// 1. Captures frames from FrameCaptureService
/// 2. Converts frames to Base64 using ImageConverter
/// 3. Sends frames to backend via WebSocketService
/// 4. Manages streaming state and performance metrics
@lazySingleton
class FrameStreamingService {
  final FrameCaptureService _frameCaptureService;
  final WebSocketService _webSocketService;

  // Streaming state
  StreamingStatus _currentStatus = StreamingStatus.idle;
  StreamSubscription<ProcessedFrame?>? _frameSubscription;
  Timer? _streamingTimer;

  // Performance tracking
  int _framesProcessed = 0;
  int _framesSent = 0;
  int _framesDropped = 0;
  DateTime? _streamingStartTime;
  DateTime? _lastFrameSent;

  // Configuration - reduced frame rate for better performance
  static const Duration _frameDuration = Duration(
    milliseconds: 333,
  ); // 3 FPS for optimal performance and minimal resource usage

  // Stream controllers
  final StreamController<StreamingStatus> _statusController =
      StreamController<StreamingStatus>.broadcast();
  final StreamController<FrameMetrics> _metricsController =
      StreamController<FrameMetrics>.broadcast();

  FrameStreamingService(this._frameCaptureService, this._webSocketService);

  /// Current streaming status
  StreamingStatus get currentStatus => _currentStatus;

  /// Stream of streaming status changes
  Stream<StreamingStatus> get statusStream => _statusController.stream;

  /// Stream of frame metrics for monitoring performance
  Stream<FrameMetrics> get metricsStream => _metricsController.stream;

  /// Current frame metrics
  FrameMetrics get currentMetrics {
    final now = DateTime.now();
    final duration =
        _streamingStartTime != null
            ? now.difference(_streamingStartTime!)
            : Duration.zero;

    final averageFPS =
        duration.inMilliseconds > 0
            ? (_framesSent * 1000) / duration.inMilliseconds
            : 0.0;

    return FrameMetrics(
      framesProcessed: _framesProcessed,
      framesSent: _framesSent,
      framesDropped: _framesDropped,
      averageFPS: averageFPS,
      lastFrameSent: _lastFrameSent,
      streamingDuration: duration,
      isActive: _currentStatus == StreamingStatus.active,
    );
  }

  /// Start streaming frames to the backend
  Future<void> startStreaming() async {
    if (_currentStatus == StreamingStatus.active) {
      debugPrint('⚠️ FrameStreamingService: Already streaming');
      return;
    }

    try {
      _updateStatus(StreamingStatus.starting);
      debugPrint('🚀 FrameStreamingService: Starting frame streaming...');

      // Ensure WebSocket is connected
      if (!_webSocketService.isConnected) {
        debugPrint('📡 FrameStreamingService: Connecting to WebSocket...');
        final connected = await _webSocketService.connect();
        if (!connected) {
          throw Exception('Failed to connect to WebSocket');
        }
      }

      // Start frame capture
      await _frameCaptureService.startCapture();

      // Initialize metrics
      _resetMetrics();
      _streamingStartTime = DateTime.now();

      // Subscribe to frame stream with throttling
      _frameSubscription = _frameCaptureService.frameStream
          .asyncMap((frame) => _processFrame(frame))
          .listen(
            _handleProcessedFrame,
            onError: _handleStreamError,
            onDone: _handleStreamDone,
          );

      _updateStatus(StreamingStatus.active);
      debugPrint(
        '✅ FrameStreamingService: Frame streaming started successfully',
      );
    } catch (e) {
      _updateStatus(StreamingStatus.error);
      debugPrint('❌ FrameStreamingService: Failed to start streaming: $e');
      rethrow;
    }
  }

  /// Stop streaming frames
  Future<void> stopStreaming() async {
    if (_currentStatus == StreamingStatus.idle) {
      debugPrint('⚠️ FrameStreamingService: Already stopped');
      return;
    }

    try {
      _updateStatus(StreamingStatus.stopping);
      debugPrint('🛑 FrameStreamingService: Stopping frame streaming...');

      // Cancel frame subscription
      await _frameSubscription?.cancel();
      _frameSubscription = null;

      // Stop frame capture
      await _frameCaptureService.stopCapture();

      // Cancel any pending timers
      _streamingTimer?.cancel();
      _streamingTimer = null;

      _updateStatus(StreamingStatus.idle);
      debugPrint('✅ FrameStreamingService: Frame streaming stopped');
    } catch (e) {
      _updateStatus(StreamingStatus.error);
      debugPrint('❌ FrameStreamingService: Error stopping streaming: $e');
      rethrow;
    }
  }

  /// Pause streaming (keeps capture running but stops sending frames)
  Future<void> pauseStreaming() async {
    if (_currentStatus != StreamingStatus.active) {
      return;
    }

    _updateStatus(StreamingStatus.paused);
    await _frameSubscription?.cancel();
    _frameSubscription = null;
    debugPrint('⏸️ FrameStreamingService: Streaming paused');
  }

  /// Resume streaming from paused state
  Future<void> resumeStreaming() async {
    if (_currentStatus != StreamingStatus.paused) {
      return;
    }

    _frameSubscription = _frameCaptureService.frameStream
        .asyncMap((frame) => _processFrame(frame))
        .listen(
          _handleProcessedFrame,
          onError: _handleStreamError,
          onDone: _handleStreamDone,
        );

    _updateStatus(StreamingStatus.active);
    debugPrint('▶️ FrameStreamingService: Streaming resumed');
  }

  /// Process a single camera frame
  Future<ProcessedFrame?> _processFrame(CameraImage frame) async {
    if (_currentStatus != StreamingStatus.active) {
      return null;
    }

    try {
      _framesProcessed++;

      // Check if we should drop this frame for performance
      if (_shouldDropFrame()) {
        _framesDropped++;
        return null;
      }

      // Convert frame to Base64 with error handling
      final base64Frame = await ImageConverter.convertCameraImageToBase64(
        frame,
      );

      // Validate base64 output
      if (base64Frame.startsWith('Exception') ||
          base64Frame.startsWith('Error') ||
          base64Frame.startsWith('RangeError') ||
          base64Frame.length < 100) {
        debugPrint(
          '❌ FrameStreamingService: Invalid base64 conversion: ${base64Frame.substring(0, 50)}...',
        );
        return null; // Skip this frame
      }

      return ProcessedFrame(
        frameId:
            'frame_${_framesProcessed}_${DateTime.now().millisecondsSinceEpoch}',
        base64Data: base64Frame,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      debugPrint('❌ FrameStreamingService: Error processing frame: $e');
      return null;
    }
  }

  /// Handle processed frame by sending to WebSocket
  void _handleProcessedFrame(ProcessedFrame? processedFrame) {
    if (processedFrame == null || _currentStatus != StreamingStatus.active) {
      return;
    }

    try {
      // Send frame via WebSocket
      final success = _webSocketService.sendImageFrame(
        processedFrame.base64Data,
      );

      if (success) {
        _framesSent++;
        _lastFrameSent = processedFrame.timestamp;

        // Emit metrics periodically with more debug info
        if (_framesSent % 5 == 0) {
          _metricsController.add(currentMetrics);
          debugPrint(
            '📊 FrameStreamingService: Metrics - ${currentMetrics.toString()}',
          );
        }

        // More frequent debug logging for better monitoring
        if (_framesSent % 3 == 0) {
          debugPrint(
            '📤 FrameStreamingService: Frame #${_framesSent} sent - ${processedFrame.frameId}, size: ${processedFrame.base64Data.length} chars',
          );
        }
      } else {
        debugPrint(
          '❌ FrameStreamingService: Failed to send frame - ${processedFrame.frameId}',
        );
      }
    } catch (e) {
      debugPrint('❌ FrameStreamingService: Error sending frame: $e');
    }
  }

  /// Handle stream errors
  void _handleStreamError(dynamic error) {
    debugPrint('❌ FrameStreamingService: Stream error: $error');
    _updateStatus(StreamingStatus.error);
  }

  /// Handle stream completion
  void _handleStreamDone() {
    debugPrint('ℹ️ FrameStreamingService: Frame stream completed');
    _updateStatus(StreamingStatus.idle);
  }

  /// Check if frame should be dropped for performance
  bool _shouldDropFrame() {
    final now = DateTime.now();

    // Drop frame if too soon since last frame (FPS limiting)
    if (_lastFrameSent != null) {
      final timeSinceLastFrame = now.difference(_lastFrameSent!);
      if (timeSinceLastFrame < _frameDuration) {
        return true;
      }
    }

    // Could add more sophisticated dropping logic here
    // e.g., based on WebSocket send queue, CPU usage, etc.

    return false;
  }

  /// Update streaming status and notify listeners
  void _updateStatus(StreamingStatus newStatus) {
    if (_currentStatus != newStatus) {
      _currentStatus = newStatus;
      // Check if controller is still open before adding events
      if (!_statusController.isClosed) {
        _statusController.add(newStatus);
      }
      debugPrint(
        '📊 FrameStreamingService: Status changed to ${newStatus.name}',
      );
    }
  }

  /// Reset performance metrics
  void _resetMetrics() {
    _framesProcessed = 0;
    _framesSent = 0;
    _framesDropped = 0;
    _lastFrameSent = null;
    _streamingStartTime = null;
  }

  /// Dispose resources
  void dispose() {
    // Stop streaming without updating status to avoid "Bad state" error
    _frameSubscription?.cancel();
    _frameSubscription = null;
    _frameCaptureService.stopCapture();
    _streamingTimer?.cancel();
    _streamingTimer = null;

    // Close controllers
    _statusController.close();
    _metricsController.close();
  }
}

/// Data class for a processed camera frame
class ProcessedFrame {
  final String frameId;
  final String base64Data;
  final DateTime timestamp;

  ProcessedFrame({
    required this.frameId,
    required this.base64Data,
    required this.timestamp,
  });
}

/// Data class for frame streaming metrics
class FrameMetrics {
  final int framesProcessed;
  final int framesSent;
  final int framesDropped;
  final double averageFPS;
  final DateTime? lastFrameSent;
  final Duration streamingDuration;
  final bool isActive;

  FrameMetrics({
    required this.framesProcessed,
    required this.framesSent,
    required this.framesDropped,
    required this.averageFPS,
    required this.lastFrameSent,
    required this.streamingDuration,
    required this.isActive,
  });

  @override
  String toString() =>
      'FrameMetrics(processed: $framesProcessed, sent: $framesSent, '
      'dropped: $framesDropped, fps: ${averageFPS.toStringAsFixed(1)}, '
      'active: $isActive)';
}
