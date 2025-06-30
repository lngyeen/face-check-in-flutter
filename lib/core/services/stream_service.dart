import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/image_converter.dart';
import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/core/services/worker_pool.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
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
  StreamingStatus get currentStreamingStatus;

  int get maxFps;

  Stream<CameraController?> get cameraControllerStream;

  Stream<CameraStatus> get cameraStatusStream;

  Stream<StreamingStatus> get streamingStatusStream;

  void setMaxFps(int maxFps);

  Future<void> startCamera();

  Future<void> stopCamera();

  Future<void> stopImageStream();

  Future<void> startImageStream();

  void dispose();
}

/// Stream service implementation for controlling image frame streaming to WebSocket
/// Uses RxDart for frame rate limiting and debouncing
@LazySingleton(as: StreamService)
class StreamServiceImpl implements StreamService {
  final WebSocketService _webSocketService;
  final PermissionService _permissionService;

  // Configuration
  int _maxFps = 2;
  Duration get _throttleDuration => Duration(milliseconds: 1000 ~/ _maxFps);

  // RxDart stream management
  final _frameSubject = PublishSubject<(CameraImage, int)>();
  StreamSubscription? _frameSubscription;

  // Isolate Pool Management
  final _workerPool = WorkerPool(2);

  // Stream state
  bool _isCameraActive = false;
  final _streamingStatusSubject = BehaviorSubject<StreamingStatus>.seeded(
    StreamingStatus.idle,
  );

  // Camera Management
  CameraController? _cameraController;
  final _cameraStatusSubject = BehaviorSubject<CameraStatus>.seeded(
    CameraStatus.initial,
  );
  final _cameraControllerSubject = BehaviorSubject<CameraController?>();

  @override
  StreamingStatus get currentStreamingStatus => _streamingStatusSubject.value;

  @override
  Stream<StreamingStatus> get streamingStatusStream =>
      _streamingStatusSubject.stream;

  @override
  Stream<CameraController?> get cameraControllerStream =>
      _cameraControllerSubject.stream;

  @override
  Stream<CameraStatus> get cameraStatusStream => _cameraStatusSubject.stream;

  StreamServiceImpl(this._webSocketService, this._permissionService) {
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
              _streamingStatusSubject.value == StreamingStatus.active &&
              _workerPool.isReady &&
              _workerPool.hasIdleWorker,
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
  Future<void> startCamera() async {
    if (_isCameraActive) return;
    try {
      _cameraStatusSubject.add(CameraStatus.initializing);

      final permissionStatus =
          await _permissionService.getCameraPermissionStatus();

      if (permissionStatus != PermissionStatus.granted) {
        final newStatus = await _permissionService.requestCameraPermission();
        if (newStatus != PermissionStatus.granted) {
          _cameraStatusSubject.add(CameraStatus.permissionDenied);
          return;
        }
      }

      final cameras = await availableCameras();
      final frontCameras =
          cameras
              .where(
                (camera) => camera.lensDirection == CameraLensDirection.front,
              )
              .toList();

      if (frontCameras.isEmpty) {
        _cameraStatusSubject.add(CameraStatus.frontCameraNotAvailable);
        return;
      }

      final cameraController = CameraController(
        frontCameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await cameraController.initialize();
      await cameraController.setFocusMode(FocusMode.auto);
      await cameraController.setExposureMode(ExposureMode.auto);

      _isCameraActive = true;
      _cameraController = cameraController;

      _cameraControllerSubject.add(cameraController);
      _cameraStatusSubject.add(CameraStatus.opening);
    } catch (e) {
      _cameraStatusSubject.add(CameraStatus.error);
      await stopCamera();
    }
  }

  @override
  Future<void> stopCamera() async {
    if (!_isCameraActive) return;
    _isCameraActive = false;

    await stopImageStream();

    try {
      if (_cameraController != null) {
        await _cameraController?.dispose();
      }
    } catch (e) {
      // Silent error
    }

    _cameraController = null;
    _cameraControllerSubject.add(null);
    _cameraStatusSubject.add(CameraStatus.initial);
  }

  @override
  Future<void> stopImageStream() async {
    final cameraController = _cameraController;

    if (currentStreamingStatus != StreamingStatus.active ||
        cameraController == null) {
      return;
    }

    try {
      if (cameraController.value.isStreamingImages) {
        await _cameraController!.stopImageStream();
      }
    } catch (e) {
      // Silent error
    }
    _streamingStatusSubject.add(StreamingStatus.idle);
  }

  @override
  Future<void> startImageStream() async {
    final cameraController = _cameraController;

    if (currentStreamingStatus == StreamingStatus.active ||
        cameraController == null ||
        !_isCameraActive) {
      return;
    }

    try {
      await cameraController.startImageStream((CameraImage image) {
        if (currentStreamingStatus != StreamingStatus.active) return;
        _frameSubject.add((
          image,
          cameraController.description.sensorOrientation,
        ));
      });
      _streamingStatusSubject.add(StreamingStatus.active);
    } catch (e) {
      _cameraStatusSubject.add(CameraStatus.error);
      _streamingStatusSubject.add(StreamingStatus.error);
    }
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
    stopCamera();
    _frameSubscription?.cancel();
    _frameSubject.close();
    _workerPool.dispose();
    _cameraStatusSubject.close();
    _cameraControllerSubject.close();
    _streamingStatusSubject.close();
  }
}
