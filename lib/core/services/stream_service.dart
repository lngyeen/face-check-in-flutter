import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/image_converter.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/core/services/worker_pool.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

/// Data sent from the main isolate to a worker isolate.
class _ProcessRequest {
  final CameraImage image;
  final int sensorOrientation;

  _ProcessRequest(this.image, this.sensorOrientation);
}

/// Data sent from a worker isolate back to the main isolate.
class _ProcessResponse {
  final ProcessedFrame? frame;
  final int workerId; // To know which worker is now free.

  _ProcessResponse(this.frame, this.workerId);
}

/// Data payload sent to a worker to dispatch a job.
class _WorkerDispatchPayload {
  final _ProcessRequest request;
  final int workerId;

  _WorkerDispatchPayload(this.request, this.workerId);
}

/// The entry point for each worker isolate.
void _workerEntryPoint(SendPort mainSendPort) {
  final workerReceivePort = ReceivePort();
  mainSendPort.send(workerReceivePort.sendPort);

  workerReceivePort.listen((dynamic message) {
    if (message is _WorkerDispatchPayload) {
      final request = message.request;
      final workerId = message.workerId;

      // This is where all the heavy lifting happens, inside the worker isolate.
      // Call the new SYNCHRONOUS converter.
      final ProcessedFrame? processedFrame =
          ImageConverter.convertCameraImageToProcessedFrameSync(
            request.image,
            request.sensorOrientation,
          );

      mainSendPort.send(_ProcessResponse(processedFrame, workerId));
    }
  });
}

/// Extension method to provide domain-specific functionality to the generic pool.
extension WorkerPoolImageDispatch on WorkerPool {
  void dispatchImageJob(CameraImage frame, int sensorOrientation) {
    if (!hasIdleWorker) return;

    final worker = dispatchJob();
    final request = _ProcessRequest(frame, sensorOrientation);
    final payload = _WorkerDispatchPayload(request, worker.id);
    worker.sendPort.send(payload);
  }
}

/// Abstract interface for stream service
abstract class StreamService {
  bool get isStreaming;

  int get maxFps;

  void setMaxFps(int maxFps);

  Future<void> startStream();

  Future<void> stopStream();

  void addFrame(CameraImage frame, int sensorOrientation);

  void dispose();
}

/// Stream service implementation for controlling image frame streaming to WebSocket
/// Uses RxDart for frame rate limiting and debouncing
@LazySingleton(as: StreamService)
class StreamServiceImpl implements StreamService {
  final WebSocketService _webSocketService;

  // Configuration
  int _maxFps = 2;
  Duration get _throttleDuration => Duration(milliseconds: 1000 ~/ _maxFps);

  // RxDart stream management
  final _frameSubject = PublishSubject<(CameraImage, int)>();
  StreamSubscription? _frameSubscription;

  // Isolate Pool Management
  final _workerPool = WorkerPool(2);

  // Stream state
  bool _isStreaming = false;

  @override
  bool get isStreaming => _isStreaming;

  StreamServiceImpl(this._webSocketService) {
    _initializeIsolates();
    _initializeFrameProcessing();
  }

  /// Initializes the stream processing pipeline with RxDart.
  void _initializeFrameProcessing() {
    _frameSubscription?.cancel();
    _frameSubscription = _frameSubject
        .throttleTime(_throttleDuration)
        .where(
          (_) =>
              _isStreaming && _workerPool.isReady && _workerPool.hasIdleWorker,
        )
        .listen((frameData) {
          final (frame, sensorOrientation) = frameData;
          _dispatchFrame(frame, sensorOrientation);
        });
  }

  /// Initializes the isolate pool.
  Future<void> _initializeIsolates() async {
    final mainReceivePort = ReceivePort();

    mainReceivePort.listen((dynamic message) {
      if (message is SendPort) {
        // A new worker has sent its SendPort.
        _workerPool.addWorker(Isolate(message), message);
      } else if (message is _ProcessResponse) {
        // A worker has finished its job.
        _sendFrameToWebSocket(message.frame);
        // Mark the worker as idle again.
        _workerPool.completeJob(message.workerId);
      }
    });

    for (int i = 0; i < _workerPool.size; i++) {
      await Isolate.spawn(_workerEntryPoint, mainReceivePort.sendPort);
    }
  }

  @override
  void setMaxFps(int maxFps) {
    if (maxFps < 1 || maxFps > 30) {
      throw ArgumentError('maxFps must be between 1 and 30');
    }
    _maxFps = maxFps;
    // Re-initialize the stream with the new throttle duration.
    _initializeFrameProcessing();
  }

  @override
  int get maxFps => _maxFps;

  @override
  Future<void> startStream() async {
    if (_isStreaming) return;
    _isStreaming = true;
  }

  @override
  Future<void> stopStream() async {
    if (!_isStreaming) return;
    _isStreaming = false;
  }

  @override
  void addFrame(CameraImage frame, int sensorOrientation) {
    if (!_isStreaming) {
      return;
    }
    // Add the frame to the stream. RxDart will handle throttling.
    _frameSubject.add((frame, sensorOrientation));
  }

  void _dispatchFrame(CameraImage frame, int sensorOrientation) {
    _workerPool.dispatchImageJob(frame, sensorOrientation);
  }

  void _sendFrameToWebSocket(ProcessedFrame? frame) {
    if (frame == null ||
        _webSocketService.currentStatus !=
            WebSocketConnectionStatus.connected) {
      return;
    }

    final payload = {'type': 'processFrame', 'image': frame.base64Image};

    _webSocketService.sendMessage(json.encode(payload));
  }

  @override
  void dispose() {
    _frameSubscription?.cancel();
    _frameSubject.close();
    _workerPool.dispose();
  }
}
