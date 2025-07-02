# 🏗️ **Flutter Check-In Refactor Plan**

## **📋 Overview**

**Goal**: Refactor từ 1 monolithic CheckInBloc thành 4 specialized BLoCs + Services theo Clean Architecture

**Current Issues**:
- CheckInBloc vi phạm Single Responsibility Principle  
- Business logic lẫn trong UI layer
- StreamService làm quá nhiều việc
- Tight coupling giữa các components

**Target Architecture**:
```
BLoCs (4):          Services (4):           UseCases (3):
├── CameraBloc      ├── CameraService       ├── CheckInOrchestrator  
├── ConnectionBloc  ├── StreamingService    ├── NotificationInteractor
├── FaceDetection   ├── FaceDetectionSvc    └── AppLifecycleInteractor
└── ScreenBloc      └── WebSocketService    
```

---

## **🎯 Phase 1: Foundation Services**

### **1.1 Camera Service**

```dart
// 📄 NEW: lib/core/services/camera_service.dart
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/permission_service.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/permission_status.dart';

abstract class CameraService {
  Stream<CameraController?> get controllerStream;
  Stream<CameraStatus> get statusStream;
  CameraController? get currentController;
  Future<void> start();
  Future<void> stop();
  void dispose();
}

@LazySingleton(as: CameraService)
class CameraServiceImpl implements CameraService {
  final PermissionService _permissionService;
  
  CameraController? _controller;
  final _controllerSubject = BehaviorSubject<CameraController?>();
  final _statusSubject = BehaviorSubject<CameraStatus>.seeded(CameraStatus.initial);
  
  @override
  Stream<CameraController?> get controllerStream => _controllerSubject.stream;
  @override
  Stream<CameraStatus> get statusStream => _statusSubject.stream;
  @override
  CameraController? get currentController => _controller;
  
  CameraServiceImpl(this._permissionService);
  
  @override
  Future<void> start() async {
    if (_controller != null) return;
    
    try {
      _statusSubject.add(CameraStatus.initializing);
      
      // Check permissions
      final permissionStatus = await _permissionService.getCameraPermissionStatus();
      if (permissionStatus != PermissionStatus.granted) {
        final newStatus = await _permissionService.requestCameraPermission();
        if (newStatus != PermissionStatus.granted) {
          _statusSubject.add(CameraStatus.permissionDenied);
          return;
        }
      }
      
      // Get cameras
      final cameras = await availableCameras();
      final frontCameras = cameras.where((c) => c.lensDirection == CameraLensDirection.front).toList();
      
      if (frontCameras.isEmpty) {
        _statusSubject.add(CameraStatus.frontCameraNotAvailable);
        return;
      }
      
      // Initialize camera
      _controller = CameraController(
        frontCameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      
      await _controller!.initialize();
      await _controller!.setFocusMode(FocusMode.auto);
      await _controller!.setExposureMode(ExposureMode.auto);
      
      _controllerSubject.add(_controller);
      _statusSubject.add(CameraStatus.opening);
      
    } catch (e) {
      _statusSubject.add(CameraStatus.error);
      await stop();
    }
  }
  
  @override
  Future<void> stop() async {
    try {
      await _controller?.dispose();
    } catch (e) {
      // Silent error
    }
    
    _controller = null;
    _controllerSubject.add(null);
    _statusSubject.add(CameraStatus.initial);
  }
  
  @override
  void dispose() {
    stop();
    _controllerSubject.close();
    _statusSubject.close();
  }
}
```

### **1.2 Image Streaming Service**

```dart
// 📄 NEW: lib/core/services/image_streaming_service.dart
import 'dart:async';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/image_converter.dart';
import 'package:face_check_in_flutter/domain/entities/frame_data.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

abstract class ImageStreamingService {
  Stream<StreamingStatus> get statusStream;
  Stream<ProcessedFrame> get processedFrameStream;
  StreamingStatus get currentStatus;
  int get maxFps;
  
  void setMaxFps(int fps);
  Future<void> start(CameraController controller);
  Future<void> stop();
  void dispose();
}

@LazySingleton(as: ImageStreamingService)
class ImageStreamingServiceImpl implements ImageStreamingService {
  int _maxFps = 2;
  Duration get _throttleDuration => Duration(milliseconds: 1000 ~/ _maxFps);
  
  final _frameSubject = PublishSubject<FrameData>();
  final _statusSubject = BehaviorSubject<StreamingStatus>.seeded(StreamingStatus.idle);
  final _processedFrameSubject = PublishSubject<ProcessedFrame>();
  
  StreamSubscription? _frameSubscription;
  CameraController? _currentController;
  
  @override
  Stream<StreamingStatus> get statusStream => _statusSubject.stream;
  @override
  Stream<ProcessedFrame> get processedFrameStream => _processedFrameSubject.stream;
  @override
  StreamingStatus get currentStatus => _statusSubject.value;
  @override
  int get maxFps => _maxFps;
  
  ImageStreamingServiceImpl() {
    _initializeFrameProcessing();
  }
  
  void _initializeFrameProcessing() {
    _frameSubscription?.cancel();
    _frameSubscription = _frameSubject
        .throttleTime(_throttleDuration)
        .where((_) => _statusSubject.value == StreamingStatus.active)
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
          if (processedFrame != null) {
            _processedFrameSubject.add(processedFrame);
          }
        });
  }
  
  @override
  void setMaxFps(int fps) {
    if (fps < 1 || fps > 30) {
      throw ArgumentError('maxFps must be between 1 and 30');
    }
    _maxFps = fps;
    _initializeFrameProcessing();
  }
  
  @override
  Future<void> start(CameraController controller) async {
    if (currentStatus == StreamingStatus.active || !controller.value.isInitialized) {
      return;
    }
    
    try {
      _currentController = controller;
      
      await controller.startImageStream((CameraImage image) {
        if (currentStatus != StreamingStatus.active) return;
        
        _frameSubject.add(FrameData(
          image: image,
          sensorOrientation: controller.description.sensorOrientation,
          lensDirection: controller.description.lensDirection,
        ));
      });
      
      _statusSubject.add(StreamingStatus.active);
    } catch (e) {
      _statusSubject.add(StreamingStatus.error);
    }
  }
  
  @override
  Future<void> stop() async {
    if (currentStatus != StreamingStatus.active || _currentController == null) {
      return;
    }
    
    try {
      if (_currentController!.value.isStreamingImages) {
        await _currentController!.stopImageStream();
      }
    } catch (e) {
      // Silent error
    }
    
    _currentController = null;
    _statusSubject.add(StreamingStatus.idle);
  }
  
  @override
  void dispose() {
    stop();
    _frameSubscription?.cancel();
    _frameSubject.close();
    _statusSubject.close();
    _processedFrameSubject.close();
  }
}
```

### **1.3 Face Detection Service**

```dart
// 📄 NEW: lib/core/services/face_detection_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

abstract class FaceDetectionService {
  Stream<FaceDetectionData> get detectionStream;
  void processFrame(ProcessedFrame frame);
  void dispose();
}

@LazySingleton(as: FaceDetectionService)
class FaceDetectionServiceImpl implements FaceDetectionService {
  final WebSocketService _webSocketService;
  final _detectionSubject = PublishSubject<FaceDetectionData>();
  
  StreamSubscription? _messageSubscription;
  
  @override
  Stream<FaceDetectionData> get detectionStream => _detectionSubject.stream;
  
  FaceDetectionServiceImpl(this._webSocketService) {
    _listenToWebSocketMessages();
  }
  
  void _listenToWebSocketMessages() {
    _messageSubscription = _webSocketService.messageStream.listen((dynamic data) {
      try {
        if (data is String) {
          final Map<String, dynamic> jsonData = json.decode(data);
          if (jsonData['type'] == 'faceDetectionResult') {
            final faceData = FaceDetectionData.fromJson(jsonData['data']);
            _detectionSubject.add(faceData);
          }
        }
      } catch (e) {
        // Log error but don't break the stream
      }
    });
  }
  
  @override
  void processFrame(ProcessedFrame frame) {
    if (_webSocketService.currentStatus != WebSocketConnectionStatus.connected) {
      return;
    }
    
    final payload = {
      'type': 'processFrame',
      'image': frame.base64Image,
    };
    
    _webSocketService.sendMessage(json.encode(payload));
  }
  
  @override
  void dispose() {
    _messageSubscription?.cancel();
    _detectionSubject.close();
  }
}
```

---

## **🎯 Phase 2: Domain Layer**

### **2.1 Domain Entities**

```dart
// 📄 NEW: lib/domain/entities/camera_state.dart
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';

part 'camera_state.freezed.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState({
    @Default(CameraStatus.initial) CameraStatus status,
    CameraController? controller,
    CheckInError? error,
    @Default(false) bool isInitializing,
  }) = _CameraState;
  
  const CameraState._();
  
  bool get isReady => status == CameraStatus.opening && controller != null;
  bool get hasError => error != null;
  bool get canStartStreaming => isReady && !hasError;
}
```

```dart
// 📄 NEW: lib/domain/entities/face_detection_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_error.dart';

part 'face_detection_state.freezed.dart';

@freezed
class FaceDetectionState with _$FaceDetectionState {
  const factory FaceDetectionState({
    @Default([]) List<FaceDetectionResult> detectedFaces,
    String? annotatedImage,
    @Default(false) bool isProcessing,
    DateTime? lastDetectionTime,
    CheckInError? error,
  }) = _FaceDetectionState;
  
  const FaceDetectionState._();
  
  bool get hasFaces => detectedFaces.isNotEmpty;
  bool get hasMultipleFaces => detectedFaces.length > 1;
  bool get hasRecognizedFace => detectedFaces.any((face) => face.isRecognized);
  
  FaceDetectionResult? get primaryFace => 
      detectedFaces.isNotEmpty ? detectedFaces.first : null;
}
```

```dart
// 📄 NEW: lib/domain/entities/check_in_screen_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:face_check_in_flutter/domain/entities/notification_data.dart';

part 'check_in_screen_state.freezed.dart';

@freezed
class CheckInScreenState with _$CheckInScreenState {
  const factory CheckInScreenState({
    @Default(false) bool isDebugMode,
    @Default(false) bool showSystemStatus,
    NotificationData? pendingNotification,
    @Default(false) bool isFullScreen,
  }) = _CheckInScreenState;
}
```

```dart
// 📄 NEW: lib/domain/entities/notification_data.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'notification_data.freezed.dart';

@freezed
class NotificationData with _$NotificationData {
  const factory NotificationData({
    required String message,
    required NotificationType type,
    @Default(Duration(seconds: 3)) Duration duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) = _NotificationData;
}

enum NotificationType {
  success,
  warning,
  error,
  info,
}

extension NotificationTypeExt on NotificationType {
  Color get color {
    switch (this) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.error:
        return Colors.red;
      case NotificationType.info:
        return Colors.blue;
    }
  }
}
```

### **2.2 Use Cases**

```dart
// 📄 NEW: lib/core/usecases/check_in_orchestrator.dart
import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/camera_service.dart';
import 'package:face_check_in_flutter/core/services/image_streaming_service.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/core/services/face_detection_service.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

enum CheckInPhase {
  idle,
  initializing,
  connecting,
  cameraStarting,
  ready,
  streaming,
  processing,
  completed,
  error,
}

@LazySingleton()
class CheckInOrchestrator {
  final CameraService _cameraService;
  final ImageStreamingService _streamingService;
  final WebSocketService _webSocketService;
  final FaceDetectionService _faceDetectionService;
  
  final _phaseSubject = BehaviorSubject<CheckInPhase>.seeded(CheckInPhase.idle);
  final _errorSubject = PublishSubject<String>();
  
  StreamSubscription? _cameraSubscription;
  StreamSubscription? _connectionSubscription;
  StreamSubscription? _streamingSubscription;
  StreamSubscription? _frameSubscription;
  
  Stream<CheckInPhase> get phaseStream => _phaseSubject.stream;
  Stream<String> get errorStream => _errorSubject.stream;
  CheckInPhase get currentPhase => _phaseSubject.value;
  
  CheckInOrchestrator(
    this._cameraService,
    this._streamingService,
    this._webSocketService,
    this._faceDetectionService,
  ) {
    _setupSubscriptions();
  }
  
  void _setupSubscriptions() {
    // Listen to processed frames and send to face detection
    _frameSubscription = _streamingService.processedFrameStream.listen(
      (frame) => _faceDetectionService.processFrame(frame),
    );
  }
  
  Future<void> startCheckIn() async {
    if (currentPhase != CheckInPhase.idle) return;
    
    try {
      _phaseSubject.add(CheckInPhase.initializing);
      
      // 1. Ensure WebSocket connection
      if (_webSocketService.currentStatus != WebSocketConnectionStatus.connected) {
        _phaseSubject.add(CheckInPhase.connecting);
        _webSocketService.connect();
        
        await _webSocketService.statusStream
            .where((status) => status == WebSocketConnectionStatus.connected)
            .first
            .timeout(const Duration(seconds: 10));
      }
      
      // 2. Start camera
      _phaseSubject.add(CheckInPhase.cameraStarting);
      await _cameraService.start();
      
      final controller = await _cameraService.controllerStream
          .where((controller) => controller != null)
          .first
          .timeout(const Duration(seconds: 5));
      
      // 3. Start streaming
      if (controller != null) {
        await _streamingService.start(controller);
        _phaseSubject.add(CheckInPhase.ready);
        _phaseSubject.add(CheckInPhase.streaming);
      }
      
    } catch (e) {
      _phaseSubject.add(CheckInPhase.error);
      _errorSubject.add('Failed to start check-in: ${e.toString()}');
    }
  }
  
  Future<void> stopCheckIn() async {
    await _streamingService.stop();
    await _cameraService.stop();
    _phaseSubject.add(CheckInPhase.idle);
  }
  
  Future<void> restartCheckIn() async {
    await stopCheckIn();
    await Future.delayed(const Duration(milliseconds: 500));
    await startCheckIn();
  }
  
  void dispose() {
    _cameraSubscription?.cancel();
    _connectionSubscription?.cancel();
    _streamingSubscription?.cancel();
    _frameSubscription?.cancel();
    _phaseSubject.close();
    _errorSubject.close();
  }
}
```

---

## **📦 Local Package Strategy**

### **Why Local Package Approach?**
- ✅ **No Breaking Changes**: Main app continues working
- ✅ **Safe Development**: Can test new architecture independently  
- ✅ **Easy Rollback**: Just remove package if issues
- ✅ **Gradual Migration**: Replace components one by one
- ✅ **Context Preservation**: Clear progress tracking

### **Package Structure**
```
packages/
└── check_in_refactor/
    ├── pubspec.yaml
    ├── lib/
    │   ├── check_in_refactor.dart          # Main export
    │   ├── services/
    │   │   ├── camera_service.dart
    │   │   ├── image_streaming_service.dart  
    │   │   └── face_detection_service.dart
    │   ├── usecases/
    │   │   ├── check_in_orchestrator.dart
    │   │   └── notification_interactor.dart
    │   ├── blocs/
    │   │   ├── camera/
    │   │   ├── face_detection/
    │   │   └── screen/
    │   ├── entities/
    │   │   ├── camera_state.dart
    │   │   ├── face_detection_state.dart
    │   │   └── notification_data.dart
    │   └── widgets/
    │       ├── refactored_camera_preview.dart
    │       └── refactored_check_in_listeners.dart
    └── test/
        ├── services/
        ├── usecases/
        └── blocs/
```

---

## **📅 Implementation Checklist**

### **Phase 0: Local Package Setup** ✅ **COMPLETED**
- [x] Create local package structure
- [x] Setup pubspec.yaml with dependencies
- [x] Create export files and basic structure
- [x] Add package to main app dependencies
- [x] Verify package can be imported

### **Phase 1: Foundation Services** ✅
- [x] Create `CameraService` in package
- [x] Create `ImageStreamingService` in package
- [x] Create `FaceDetectionService` in package
- [x] Write unit tests for services
- [x] Export services from package

### **Phase 2 Checklist** ✅  
- [x] Create domain entities
- [x] Create `CheckInOrchestrator`
- [x] Create `NotificationInteractor` 
- [x] Create `AppLifecycleInteractor`
- [x] Write unit tests for entities and use cases

### **Phase 3 Checklist** (Next)
- [ ] Create `CameraBloc`
- [ ] Create `FaceDetectionBloc` 
- [ ] Create `CheckInScreenBloc`
- [ ] Update `ConnectionBloc` if needed

### **Phase 4 Checklist** (Final)
- [ ] Refactor `CheckInScreen`
- [ ] Refactor `CheckInListeners`
- [ ] Update app-level BLoC providers
- [ ] Remove old files
- [ ] Integration testing
- [ ] Performance testing

---

## **🏃‍♂️ Next Steps**

1. **Start with Phase 1** - Create foundation services
2. **Test each service independently** before moving to next phase  
3. **Update DI configuration** after each phase
4. **Maintain backward compatibility** until Phase 4
5. **Run existing tests** to ensure no regression

---

## **🎯 Phase 3: New BLoCs**

### **3.1 Camera BLoC**

```dart
// 📄 NEW: lib/features/check_in/blocs/camera/camera_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_event.freezed.dart';

@freezed
class CameraEvent with _$CameraEvent {
  const factory CameraEvent.initialize() = InitializeCamera;
  const factory CameraEvent.start() = StartCamera;
  const factory CameraEvent.stop() = StopCamera;
  const factory CameraEvent.dispose() = DisposeCamera;
  const factory CameraEvent.requestPermission() = RequestCameraPermission;
}
```

```dart
// 📄 NEW: lib/features/check_in/blocs/camera/camera_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/camera_service.dart';
import 'package:face_check_in_flutter/domain/entities/camera_state.dart';
import 'camera_event.dart';

@injectable
class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraService _cameraService;
  StreamSubscription? _statusSubscription;
  StreamSubscription? _controllerSubscription;

  CameraBloc(this._cameraService) : super(const CameraState()) {
    on<CameraEvent>(_handleEvent);
    _listenToCameraService();
  }

  void _listenToCameraService() {
    _statusSubscription = _cameraService.statusStream.listen(
      (status) => add(const CameraEvent.initialize()),
    );
    
    _controllerSubscription = _cameraService.controllerStream.listen(
      (controller) {
        emit(state.copyWith(controller: controller));
      },
    );
  }

  Future<void> _handleEvent(CameraEvent event, Emitter<CameraState> emit) async {
    await event.when(
      initialize: () => _handleInitialize(emit),
      start: () => _handleStart(emit),
      stop: () => _handleStop(emit),
      dispose: () => _handleDispose(emit),
      requestPermission: () => _handleRequestPermission(emit),
    );
  }

  Future<void> _handleStart(Emitter<CameraState> emit) async {
    emit(state.copyWith(isInitializing: true, error: null));
    try {
      await _cameraService.start();
    } catch (e) {
      emit(state.copyWith(
        isInitializing: false,
        error: CheckInError.camera(message: e.toString()),
      ));
    }
  }

  Future<void> _handleStop(Emitter<CameraState> emit) async {
    await _cameraService.stop();
    emit(state.copyWith(controller: null, error: null));
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _controllerSubscription?.cancel();
    return super.close();
  }
}
```

### **3.2 Face Detection BLoC**

```dart
// 📄 NEW: lib/features/check_in/blocs/face_detection/face_detection_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_response.dart';

part 'face_detection_event.freezed.dart';

@freezed
class FaceDetectionEvent with _$FaceDetectionEvent {
  const factory FaceDetectionEvent.frameProcessed(FaceDetectionData data) = FrameProcessed;
  const factory FaceDetectionEvent.clearResults() = ClearResults;
  const factory FaceDetectionEvent.startProcessing() = StartProcessing;
  const factory FaceDetectionEvent.stopProcessing() = StopProcessing;
}
```

```dart
// 📄 NEW: lib/features/check_in/blocs/face_detection/face_detection_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/face_detection_service.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_state.dart';
import 'face_detection_event.dart';

@injectable
class FaceDetectionBloc extends Bloc<FaceDetectionEvent, FaceDetectionState> {
  final FaceDetectionService _faceDetectionService;
  StreamSubscription? _detectionSubscription;

  FaceDetectionBloc(this._faceDetectionService) : super(const FaceDetectionState()) {
    on<FaceDetectionEvent>(_handleEvent);
    _listenToFaceDetectionService();
  }

  void _listenToFaceDetectionService() {
    _detectionSubscription = _faceDetectionService.detectionStream.listen(
      (data) => add(FaceDetectionEvent.frameProcessed(data)),
    );
  }

  Future<void> _handleEvent(FaceDetectionEvent event, Emitter<FaceDetectionState> emit) async {
    await event.when(
      frameProcessed: (data) => _handleFrameProcessed(data, emit),
      clearResults: () => _handleClearResults(emit),
      startProcessing: () => _handleStartProcessing(emit),
      stopProcessing: () => _handleStopProcessing(emit),
    );
  }

  void _handleFrameProcessed(FaceDetectionData data, Emitter<FaceDetectionState> emit) {
    emit(state.copyWith(
      detectedFaces: data.faces,
      annotatedImage: data.annotatedImage,
      lastDetectionTime: DateTime.now(),
      isProcessing: false,
    ));
  }

  void _handleClearResults(Emitter<FaceDetectionState> emit) {
    emit(state.copyWith(
      detectedFaces: [],
      annotatedImage: null,
      lastDetectionTime: null,
    ));
  }

  @override
  Future<void> close() {
    _detectionSubscription?.cancel();
    return super.close();
  }
}
```

### **3.3 Screen BLoC**

```dart
// 📄 NEW: lib/features/check_in/blocs/screen/check_in_screen_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:face_check_in_flutter/domain/entities/notification_data.dart';

part 'check_in_screen_event.freezed.dart';

@freezed
class CheckInScreenEvent with _$CheckInScreenEvent {
  const factory CheckInScreenEvent.toggleDebugMode() = ToggleDebugMode;
  const factory CheckInScreenEvent.showNotification(NotificationData data) = ShowNotification;
  const factory CheckInScreenEvent.dismissNotification() = DismissNotification;
  const factory CheckInScreenEvent.toggleFullScreen() = ToggleFullScreen;
}
```

```dart
// 📄 NEW: lib/features/check_in/blocs/screen/check_in_screen_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/usecases/notification_interactor.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_screen_state.dart';
import 'check_in_screen_event.dart';

@injectable
class CheckInScreenBloc extends Bloc<CheckInScreenEvent, CheckInScreenState> {
  final NotificationInteractor _notificationInteractor;
  StreamSubscription? _notificationSubscription;

  CheckInScreenBloc(this._notificationInteractor) : super(const CheckInScreenState()) {
    on<CheckInScreenEvent>(_handleEvent);
    _listenToNotifications();
  }

  void _listenToNotifications() {
    _notificationSubscription = _notificationInteractor.notificationStream.listen(
      (notification) => add(CheckInScreenEvent.showNotification(notification)),
    );
  }

  Future<void> _handleEvent(CheckInScreenEvent event, Emitter<CheckInScreenState> emit) async {
    await event.when(
      toggleDebugMode: () => _handleToggleDebugMode(emit),
      showNotification: (data) => _handleShowNotification(data, emit),
      dismissNotification: () => _handleDismissNotification(emit),
      toggleFullScreen: () => _handleToggleFullScreen(emit),
    );
  }

  void _handleToggleDebugMode(Emitter<CheckInScreenState> emit) {
    emit(state.copyWith(isDebugMode: !state.isDebugMode));
  }

  void _handleShowNotification(NotificationData data, Emitter<CheckInScreenState> emit) {
    emit(state.copyWith(pendingNotification: data));
  }

  void _handleDismissNotification(Emitter<CheckInScreenState> emit) {
    emit(state.copyWith(pendingNotification: null));
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }
}
```

---

## **🎯 Phase 4: UI Integration**

### **4.1 Updated Check-in Screen**

```dart
// 📄 MAJOR REFACTOR: lib/features/check_in/screens/check_in_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:face_check_in_flutter/features/check_in/blocs/camera/camera_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/blocs/face_detection/face_detection_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/blocs/screen/check_in_screen_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/camera_preview_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/check_in_listeners.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_information_card.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_toggle_button.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/system_status_card.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CameraBloc>(
          create: (context) => GetIt.instance<CameraBloc>()
            ..add(const CameraEvent.initialize()),
        ),
        BlocProvider<FaceDetectionBloc>(
          create: (context) => GetIt.instance<FaceDetectionBloc>(),
        ),
        BlocProvider<CheckInScreenBloc>(
          create: (context) => GetIt.instance<CheckInScreenBloc>(),
        ),
        BlocProvider<ConnectionBloc>(
          create: (context) => GetIt.instance<ConnectionBloc>(),
        ),
      ],
      child: const CheckInScreenView(),
    );
  }
}

class CheckInScreenView extends StatefulWidget {
  const CheckInScreenView({super.key});

  @override
  State<CheckInScreenView> createState() => _CheckInScreenViewState();
}

class _CheckInScreenViewState extends State<CheckInScreenView> {
  @override
  void initState() {
    super.initState();
    // Start the check-in flow
    context.read<CameraBloc>().add(const CameraEvent.start());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckInListeners(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CheckInScreenBloc, CheckInScreenState>(
      builder: (context, screenState) {
        return Column(
          children: [
            // Full-screen camera section
            Expanded(
              child: _buildCameraWithFloatingButton(screenState),
            ),

            // Debug sections (only visible in debug mode)
            if (screenState.isDebugMode) _buildDebugSection(),
          ],
        );
      },
    );
  }

  Widget _buildCameraWithFloatingButton(CheckInScreenState screenState) {
    return Stack(
      children: [
        // Full-screen camera
        const Positioned.fill(child: CameraPreviewWidget()),

        // Floating debug toggle button
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 16,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
              ),
              child: IconButton(
                onPressed: () => context
                    .read<CheckInScreenBloc>()
                    .add(const CheckInScreenEvent.toggleDebugMode()),
                icon: Icon(
                  screenState.isDebugMode ? Icons.bug_report : Icons.bug_report_outlined,
                  color: screenState.isDebugMode ? Colors.orange : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDebugSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SystemStatusCard(),
            SizedBox(height: 16),
            DebugInformationCard(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
```

### **4.2 Updated Check-in Listeners**

```dart
// 📄 MAJOR REFACTOR: lib/features/check_in/widgets/check_in_listeners.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/features/check_in/blocs/camera/camera_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/blocs/face_detection/face_detection_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/blocs/screen/check_in_screen_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/domain/entities/camera_state.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_state.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_screen_state.dart';
import 'package:face_check_in_flutter/domain/entities/notification_data.dart';

class CheckInListeners extends StatelessWidget {
  final Widget child;

  const CheckInListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Camera error handling
        BlocListener<CameraBloc, CameraState>(
          listenWhen: (prev, curr) => prev.error != curr.error && curr.hasError,
          listener: _handleCameraError,
        ),

        // Face detection results
        BlocListener<FaceDetectionBloc, FaceDetectionState>(
          listenWhen: (prev, curr) => prev.detectedFaces != curr.detectedFaces,
          listener: _handleFaceDetectionResults,
        ),

        // Screen notifications
        BlocListener<CheckInScreenBloc, CheckInScreenState>(
          listenWhen: (prev, curr) => 
              prev.pendingNotification != curr.pendingNotification &&
              curr.pendingNotification != null,
          listener: _handleNotification,
        ),
      ],
      child: child,
    );
  }

  void _handleCameraError(BuildContext context, CameraState state) {
    if (state.error != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.error!.message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => context.read<CameraBloc>().add(const CameraEvent.start()),
            ),
          ),
        );
    }
  }

  void _handleFaceDetectionResults(BuildContext context, FaceDetectionState state) {
    // This is now handled by NotificationInteractor
    // We just need to trigger the interactor
    if (state.hasFaces) {
      // The NotificationInteractor will handle debouncing and business rules
    }
  }

  void _handleNotification(BuildContext context, CheckInScreenState state) {
    final notification = state.pendingNotification;
    if (notification != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(notification.message),
            backgroundColor: notification.type.color,
            duration: notification.duration,
            action: notification.actionLabel != null
                ? SnackBarAction(
                    label: notification.actionLabel!,
                    onPressed: notification.onAction ?? () {},
                  )
                : null,
          ),
        );

      // Dismiss notification after showing
      context.read<CheckInScreenBloc>().add(const CheckInScreenEvent.dismissNotification());
    }
  }
}
```

---

## **📋 Updated DI Configuration**

```dart
// 📄 MODIFY: lib/core/di/di.dart
// Add new registrations

// Services
@module
abstract class ServiceModule {
  @LazySingleton(as: CameraService)
  CameraServiceImpl get cameraService;
  
  @LazySingleton(as: ImageStreamingService)
  ImageStreamingServiceImpl get imageStreamingService;
  
  @LazySingleton(as: FaceDetectionService)
  FaceDetectionServiceImpl get faceDetectionService;
}

// UseCases
@module
abstract class UseCaseModule {
  @LazySingleton()
  CheckInOrchestrator get checkInOrchestrator;
  
  @LazySingleton()
  NotificationInteractor get notificationInteractor;
}

// BLoCs
@module
abstract class BlocModule {
  @injectable
  CameraBloc get cameraBloc;
  
  @injectable
  FaceDetectionBloc get faceDetectionBloc;
  
  @injectable
  CheckInScreenBloc get checkInScreenBloc;
}
```

---

## **📝 Files to DELETE after migration**

```bash
# Old files to remove in Phase 4
lib/features/check_in/bloc/check_in_bloc.dart
lib/features/check_in/bloc/check_in_state.dart
lib/features/check_in/bloc/check_in_event.dart
lib/features/check_in/bloc/check_in_state.freezed.dart
lib/features/check_in/bloc/check_in_event.freezed.dart
lib/core/services/stream_service.dart
```

---

## **🧪 Testing Strategy**

### **Unit Tests**
```dart
// 📄 NEW: test/core/services/camera_service_test.dart
// 📄 NEW: test/core/services/image_streaming_service_test.dart
// 📄 NEW: test/core/usecases/check_in_orchestrator_test.dart
// 📄 NEW: test/features/check_in/blocs/camera_bloc_test.dart
```

### **Integration Tests**
```dart
// 📄 NEW: integration_test/check_in_flow_test.dart
// Test complete check-in flow with all BLoCs
```

---

## **🚀 Performance Considerations**

1. **Memory Management**: Dispose all streams properly
2. **Frame Rate Control**: Limit to 2 FPS by default
3. **Error Recovery**: Automatic restart on failures
4. **Background Processing**: Use Isolates for image processing
5. **State Optimization**: Only rebuild when necessary

---

## **🔄 Widget Refactoring Details**

### **📱 CameraPreviewWidget - Before vs After**

#### **Before (Current)**
```dart
// 📄 CURRENT: lib/features/check_in/widgets/camera_preview_widget.dart
class CameraPreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen: (previous, current) =>
          previous.cameraStatus != current.cameraStatus ||
          previous.cameraController != current.cameraController ||
          previous.connectionState.status != current.connectionState.status,
      builder: (context, state) {
        // ❌ Accessing mixed concerns from single state
        if (_shouldShowConnectionLost(state)) {
          return const ConnectionLostWidget();
        }

        switch (state.cameraStatus) {
          case CameraStatus.opening:
            final controller = state.cameraController; // ❌ Technical object in state
            // ... render camera preview
        }
      },
    );
  }
}
```

#### **After (Refactored)**
```dart
// 📄 REFACTORED: lib/features/check_in/widgets/camera_preview_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/widgets/loading_widget.dart';
import 'package:face_check_in_flutter/domain/entities/app_connection_status.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/features/check_in/blocs/camera/camera_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/domain/entities/camera_state.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_state.dart';

import 'camera_error_widget.dart';
import 'connection_lost_widget.dart';
import 'front_camera_not_available_widget.dart';
import 'permission_denied_widget.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Separate concerns: Connection + Camera
    return MultiBlocBuilder(
      builder: (context, state) {
        final connectionState = context.select((ConnectionBloc bloc) => bloc.state);
        final cameraState = context.select((CameraBloc bloc) => bloc.state);

        // ✅ Clear separation: Connection concerns first
        if (_shouldShowConnectionLost(connectionState)) {
          return const ConnectionLostWidget();
        }

        // ✅ Then camera concerns
        return _buildCameraContent(cameraState);
      },
    );
  }

  Widget _buildCameraContent(CameraState cameraState) {
    switch (cameraState.status) {
      case CameraStatus.initial:
      case CameraStatus.initializing:
        return const LoadingWidget();
        
      case CameraStatus.permissionDenied:
        return const PermissionDeniedWidget();
        
      case CameraStatus.frontCameraNotAvailable:
        return const FrontCameraNotAvailableWidget();
        
      case CameraStatus.opening:
        final controller = cameraState.controller; // ✅ Clean state access
        if (controller == null || !controller.value.isInitialized) {
          return const Center(child: Text('Camera not available.'));
        }

        return FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller.value.previewSize?.height ?? 1,
            height: controller.value.previewSize?.width ?? 1,
            child: CameraPreview(controller),
          ),
        );
        
      case CameraStatus.error:
        return CameraErrorWidget(error: cameraState.error?.message);
    }
  }

  /// ✅ Pure function - only checks connection status
  bool _shouldShowConnectionLost(ConnectionState connectionState) {
    final status = connectionState.status;
    return status == AppConnectionStatus.networkLost ||
        status == AppConnectionStatus.failed ||
        status == AppConnectionStatus.fastRetrying ||
        status == AppConnectionStatus.backgroundRetrying;
  }
}
```

### **🎧 CheckInListeners - Before vs After**

#### **Before (Current)**
```dart
// 📄 CURRENT: lib/features/check_in/widgets/check_in_listeners.dart
class _CheckInListenersState extends State<CheckInListeners> {
  // ❌ Business logic in UI layer
  String? _lastProcessedFaceId;
  DateTime? _lastRecognizedShown;
  DateTime? _lastUnrecognizedShown;
  DateTime? _lastMultipleFacesShown;

  static const _recognizedDebounce = Duration(seconds: 2);
  static const _unrecognizedDebounce = Duration(seconds: 3);
  static const _multipleFacesDebounce = Duration(seconds: 4);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckInBloc, CheckInState>( // ❌ Single monolithic BLoC
      listenWhen: _shouldListen, // ❌ Complex business logic
      listener: _handleListener,
      child: widget.child,
    );
  }

  // ❌ 80+ lines of business logic in UI
  bool _shouldListen(CheckInState previous, CheckInState current) {
    // Complex debouncing logic...
  }

  bool _handleMultipleFaces(DateTime now) {
    // Business rules in UI...
  }

  bool _handleRecognizedFace(DateTime now, FaceDetectionResult face) {
    // Face recognition logic in UI...
  }

  void _showSuccessDialog(BuildContext context, CheckInState state, List<FaceDetectionResult> faces) {
    // ❌ Direct BLoC interaction from UI
    context.read<CheckInBloc>().add(const BucketRestartableCheckInEvent.stopImageStream());
  }
}
```

#### **After (Refactored)**
```dart
// 📄 REFACTORED: lib/features/check_in/widgets/check_in_listeners.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/features/check_in/blocs/camera/camera_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/blocs/face_detection/face_detection_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/blocs/screen/check_in_screen_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/domain/entities/camera_state.dart';
import 'package:face_check_in_flutter/domain/entities/face_detection_state.dart';
import 'package:face_check_in_flutter/domain/entities/check_in_screen_state.dart';
import 'package:face_check_in_flutter/domain/entities/notification_data.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/checkin_success_toast.dart';

/// ✅ Pure UI Listener - No business logic
class CheckInListeners extends StatelessWidget {
  final Widget child;

  const CheckInListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // ✅ Camera errors - Clear responsibility
        BlocListener<CameraBloc, CameraState>(
          listenWhen: (prev, curr) => prev.error != curr.error && curr.hasError,
          listener: _handleCameraError,
        ),

        // ✅ Face detection results - Delegate to domain
        BlocListener<FaceDetectionBloc, FaceDetectionState>(
          listenWhen: (prev, curr) => prev.detectedFaces != curr.detectedFaces,
          listener: _handleFaceDetectionResults,
        ),

        // ✅ Screen notifications - Simple UI updates
        BlocListener<CheckInScreenBloc, CheckInScreenState>(
          listenWhen: (prev, curr) => 
              prev.pendingNotification != curr.pendingNotification &&
              curr.pendingNotification != null,
          listener: _handleNotification,
        ),

        // ✅ Connection state changes
        BlocListener<ConnectionBloc, ConnectionState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: _handleConnectionChange,
        ),
      ],
      child: child,
    );
  }

  /// ✅ Simple error display - No business logic
  void _handleCameraError(BuildContext context, CameraState state) {
    if (state.error != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.error!.message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => context.read<CameraBloc>().add(const CameraEvent.start()),
            ),
          ),
        );
    }
  }

  /// ✅ Delegate to domain layer - No debouncing logic here
  void _handleFaceDetectionResults(BuildContext context, FaceDetectionState state) {
    if (state.hasFaces) {
      // Business logic is handled by NotificationInteractor
      // This just triggers UI updates when needed
      
      if (state.hasRecognizedFace && state.detectedFaces.length == 1) {
        _showSuccessDialog(context, state);
      }
    }
  }

  /// ✅ Pure notification display
  void _handleNotification(BuildContext context, CheckInScreenState state) {
    final notification = state.pendingNotification;
    if (notification != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(notification.message),
            backgroundColor: notification.type.color,
            duration: notification.duration,
            action: notification.actionLabel != null
                ? SnackBarAction(
                    label: notification.actionLabel!,
                    onPressed: notification.onAction ?? () {},
                  )
                : null,
          ),
        );

      // Dismiss notification after showing
      context.read<CheckInScreenBloc>().add(
        const CheckInScreenEvent.dismissNotification(),
      );
    }
  }

  /// ✅ Handle connection state changes
  void _handleConnectionChange(BuildContext context, ConnectionState state) {
    // Reset camera if connection lost
    if (!state.isConnected) {
      context.read<CameraBloc>().add(const CameraEvent.stop());
    }
  }

  /// ✅ Simplified success dialog - No complex state management
  void _showSuccessDialog(BuildContext context, FaceDetectionState state) {
    final recognizedFaces = state.detectedFaces.where((face) => face.isRecognized).toList();
    
    if (recognizedFaces.isEmpty) return;

    // Stop streaming during dialog
    context.read<FaceDetectionBloc>().add(const FaceDetectionEvent.stopProcessing());

    CheckInSuccessDialog.show(
      context,
      recognizedFaces,
      userImage: state.annotatedImage,
      onDialogClosed: () {
        // Resume streaming when dialog closes
        context.read<FaceDetectionBloc>().add(const FaceDetectionEvent.startProcessing());
      },
    );
  }
}
```

### **📊 Key Improvements Summary**

#### **CameraPreviewWidget**
| Aspect | Before | After |
|--------|--------|-------|
| **BLoC Dependencies** | 1 monolithic CheckInBloc | 2 specialized BLoCs |
| **State Access** | Mixed concerns in single state | Separated camera + connection states |
| **Responsibility** | Camera + Connection + Streaming | Pure camera preview display |
| **Technical Objects** | CameraController in business state | CameraController in camera state only |

#### **CheckInListeners**  
| Aspect | Before | After |
|--------|--------|-------|
| **Lines of Code** | ~212 lines | ~120 lines |
| **Business Logic** | 80+ lines in UI | 0 lines - moved to domain |
| **State Management** | Complex widget state | Stateless - domain handles state |
| **Debouncing** | Manual timing logic | NotificationInteractor handles it |
| **BLoC Events** | Direct CheckInBloc events | Specific BLoC events |
| **Error Handling** | Mixed with business logic | Pure UI error display |

#### **Benefits**
- ✅ **Single Responsibility**: Each widget has one clear purpose
- ✅ **Testability**: UI widgets can be tested without business logic
- ✅ **Maintainability**: Business changes don't affect UI code
- ✅ **Performance**: Targeted rebuilds only when needed
- ✅ **Readability**: Clear separation of concerns

---

**Ready to implement Phase 1?** 🚀 