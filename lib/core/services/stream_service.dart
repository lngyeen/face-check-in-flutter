import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/image_converter.dart';

import '../../domain/entities/connection_status.dart';

import 'websocket_service.dart';

/// Stream service for controlling image frame streaming to WebSocket
/// Uses RxDart for frame rate limiting and debouncing
@lazySingleton
class StreamService {
  final WebSocketService _webSocketService;

  // Configuration
  int _maxFps = 5; // Default 5 FPS
  Duration get _throttleDuration => Duration(milliseconds: 1000 ~/ _maxFps);

  // RxDart subjects for frame processing
  final _frameSubject = PublishSubject<CameraImage>();
  StreamSubscription? _frameSubscription;

  // Stream state
  bool _isStreaming = false;

  StreamService(this._webSocketService) {
    _initializeFrameProcessing();
  }

  /// Initialize frame processing pipeline with throttling
  void _initializeFrameProcessing() {
    _frameSubscription = _frameSubject
        .throttleTime(_throttleDuration)
        .where((_) => _isStreaming)
        .asyncMap(_processFrame)
        .listen(_sendFrameToWebSocket);
  }

  /// Configure maximum frames per second
  void setMaxFps(int maxFps) {
    if (maxFps < 1 || maxFps > 30) {
      throw ArgumentError('maxFps must be between 1 and 30');
    }

    _maxFps = maxFps;
    _restartFrameProcessing();
  }

  /// Get current max FPS setting
  int get maxFps => _maxFps;

  /// Restart frame processing with new configuration
  void _restartFrameProcessing() {
    _frameSubscription?.cancel();
    _initializeFrameProcessing();
  }

  /// Start streaming frames
  Future<void> startStream() async {
    if (_isStreaming) return;
    _isStreaming = true;
  }

  /// Stop streaming frames
  Future<void> stopStream() async {
    if (!_isStreaming) return;
    _isStreaming = false;
  }

  /// Add frame to processing queue
  void addFrame(CameraImage frame) {
    if (!_isStreaming) return;
    _frameSubject.add(frame);
  }

  /// Process camera image and convert to format suitable for WebSocket
  Future<ProcessedFrame> _processFrame(CameraImage cameraImage) async {
    try {
      // Use the new method that returns ProcessedFrame directly
      final processedFrame =
          await ImageConverter.convertCameraImageToProcessedFrame(cameraImage);

      if (processedFrame == null) {
        throw Exception('Failed to convert camera image');
      }

      return processedFrame;
    } catch (e) {
      throw Exception('Frame processing failed: $e');
    }
  }

  /// Send processed frame to WebSocket
  void _sendFrameToWebSocket(ProcessedFrame frame) {
    if (_webSocketService.currentStatus !=
        WebSocketConnectionStatus.connected) {
      return;
    }

    final payload = {
      'type': 'processFrame',
      'image': frame.base64Image,
      'timestamp': frame.timestamp.millisecondsSinceEpoch,
    };

    _webSocketService.sendMessage(json.encode(payload));
  }

  /// Check if currently streaming
  bool get isStreaming => _isStreaming;

  /// Dispose resources
  void dispose() {
    _frameSubscription?.cancel();
    _frameSubject.close();
  }
}
