import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/image_converter.dart';
import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/frame_data.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

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
  final _frameSubject = PublishSubject<FrameData>();
  StreamSubscription? _frameSubscription;

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
    _initializeFrameProcessing();
  }

  /// Initializes the stream processing pipeline with RxDart.
  void _initializeFrameProcessing() {
    _frameSubscription?.cancel();
    _frameSubscription = _frameSubject
        .throttleTime(_throttleDuration)
        .where((_) => _streamingStatusSubject.value == StreamingStatus.active)
        .asyncMap((frameData) {
          return Isolate.run(
            () => ImageConverter.convertCameraImageToProcessedFrameSync(
              frameData.image,
              sensorOrientation: frameData.sensorOrientation,
              lensDirection: frameData.lensDirection,
            ),
          );
        })
        .listen((ProcessedFrame? processedFrame) {
          _sendFrameToWebSocket(processedFrame);
        });
  }

  @override
  void setMaxFps(int maxFps) {
    if (maxFps < 1 || maxFps > 30) {
      throw ArgumentError('maxFps must be between 1 and 30');
    }
    _maxFps = maxFps;
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
              .where((c) => c.lensDirection == CameraLensDirection.front)
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
      _cameraStatusSubject.add(CameraStatus.ready);
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
        _frameSubject.add(
          FrameData(
            image: image,
            sensorOrientation: cameraController.description.sensorOrientation,
            lensDirection: cameraController.description.lensDirection,
          ),
        );
      });
      _streamingStatusSubject.add(StreamingStatus.active);
    } catch (e) {
      _cameraStatusSubject.add(CameraStatus.error);
      _streamingStatusSubject.add(StreamingStatus.error);
    }
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
    _cameraStatusSubject.close();
    _cameraControllerSubject.close();
    _streamingStatusSubject.close();
  }
}
