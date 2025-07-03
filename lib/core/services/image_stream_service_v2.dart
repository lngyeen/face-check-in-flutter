import 'dart:async';
import 'dart:convert' show json;
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/image_converter.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/frame_data.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

/// Abstract interface for complete image streaming and processing service
abstract class ImageStreamServiceV2 {
  Stream<StreamingStatus> get statusStream;
  StreamingStatus get currentStatus;
  int get maxFps;

  Future<void> startStreaming(CameraController controller);
  Future<void> stopStreaming();
  void setMaxFps(int fps);
  void dispose();
}

/// Complete image streaming and processing service implementation
/// Handles camera streaming, frame processing, and WebSocket communication
@LazySingleton(as: ImageStreamServiceV2)
class ImageStreamServiceV2Impl implements ImageStreamServiceV2 {
  final WebSocketService _webSocketService;

  // Configuration
  int _maxFps = 2;
  Duration get _throttleDuration => Duration(milliseconds: 1000 ~/ _maxFps);

  // Stream management
  CameraController? _activeController;
  bool get _isStreaming => _statusSubject.value == StreamingStatus.active;

  // Status subjects
  final _statusSubject = BehaviorSubject<StreamingStatus>.seeded(
    StreamingStatus.idle,
  );

  // Processing pipeline
  final _frameThrottleSubject = PublishSubject<FrameData>();
  StreamSubscription? _throttleSubscription;

  @override
  Stream<StreamingStatus> get statusStream => _statusSubject.stream;

  @override
  StreamingStatus get currentStatus => _statusSubject.value;

  @override
  int get maxFps => _maxFps;

  ImageStreamServiceV2Impl(this._webSocketService) {
    _initializeStreaming();
  }

  void _initializeStreaming() {
    _throttleSubscription?.cancel();
    _throttleSubscription = _frameThrottleSubject
        .throttleTime(_throttleDuration)
        .where((_) => _statusSubject.value == StreamingStatus.active)
        .asyncMap(
          (frameData) => Isolate.run(
            () => ImageConverter.convertCameraImageToProcessedFrameSync(
              frameData.image,
              sensorOrientation: frameData.sensorOrientation,
              lensDirection: frameData.lensDirection,
            ),
          ),
        )
        .listen((processedFrame) {
          if (processedFrame != null) {
            _sendFrameToWebSocket(processedFrame);
          }
        });
  }

  @override
  void setMaxFps(int maxFps) {
    if (maxFps < 1 || maxFps > 30) {
      throw ArgumentError('maxFps must be between 1 and 30');
    }

    _maxFps = maxFps;

    final wasActive = currentStatus == StreamingStatus.active;
    if (wasActive) {
      _initializeStreaming();
    }
  }

  @override
  Future<void> startStreaming(CameraController controller) async {
    if (_isStreaming || _activeController != null) {
      return;
    }

    try {
      _activeController = controller;
      _statusSubject.add(StreamingStatus.active);

      await controller.startImageStream((CameraImage image) {
        if (!_isStreaming || _statusSubject.value != StreamingStatus.active) {
          return;
        }

        _frameThrottleSubject.add(
          FrameData(
            image: image,
            sensorOrientation: controller.description.sensorOrientation,
            lensDirection: controller.description.lensDirection,
          ),
        );
      });
    } catch (e) {
      _statusSubject.add(StreamingStatus.error);
      await stopStreaming();
    }
  }

  @override
  Future<void> stopStreaming() async {
    final controller = _activeController;
    if (!_isStreaming || controller == null) {
      return;
    }

    try {
      if (controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
    } catch (e) {
      // Silent error handling
    }

    _activeController = null;
    _statusSubject.add(StreamingStatus.idle);
  }

  void _sendFrameToWebSocket(ProcessedFrame frame) {
    if (_webSocketService.currentStatus !=
        WebSocketConnectionStatus.connected) {
      return;
    }

    try {
      final payload = {'type': 'processFrame', 'image': frame.base64Image};
      _webSocketService.sendMessage(json.encode(payload));
    } catch (e) {
      // Silent error handling for WebSocket sending
    }
  }

  @override
  void dispose() {
    stopStreaming();
    _throttleSubscription?.cancel();
    _statusSubject.close();
    _frameThrottleSubject.close();
  }
}
