import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart' as cpi;
import 'package:camera_platform_interface/camera_platform_interface.dart'
    as cpi;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart'
    as ps;
import 'package:face_check_in_flutter/domain/services/camera_service.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/core/services/frame_streaming_service.dart'
    as streaming;

// --- Mocks and Fakes ---

class MockPermissionService extends Mock implements ps.PermissionService {}

class MockWebSocketService extends Mock implements WebSocketService {}

class MockCameraService extends Mock implements CameraService {}

class MockCameraController extends Mock implements cpi.CameraController {}

class MockFrameStreamingService extends Mock
    implements streaming.FrameStreamingService {}

class MockCheckInBloc extends MockBloc<CheckInEvent, CheckInState>
    implements CheckInBloc {}

class FakeCameraDescription extends Fake implements cpi.CameraDescription {
  @override
  final String name = 'fake';
  @override
  final cpi.CameraLensDirection lensDirection = cpi.CameraLensDirection.front;
  @override
  final int sensorOrientation = 0;
}

class FakeCameraPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements cpi.CameraPlatform {
  List<cpi.CameraDescription> cameras = [FakeCameraDescription()];
  bool isCameraInitialized = false;
  bool isPreviewStreaming = false;
  final StreamController<cpi.CameraEvent> _cameraEventStreamController =
      StreamController<cpi.CameraEvent>.broadcast();

  @override
  Future<List<cpi.CameraDescription>> availableCameras() async {
    return cameras;
  }

  @override
  Future<int> createCamera(
    cpi.CameraDescription cameraDescription,
    cpi.ResolutionPreset? resolutionPreset, {
    bool enableAudio = false,
  }) async {
    return 1;
  }

  @override
  Future<int> createCameraWithSettings(
    cpi.CameraDescription cameraDescription,
    dynamic settings,
  ) async {
    return 1;
  }

  @override
  Future<void> initializeCamera(
    int cameraId, {
    cpi.ImageFormatGroup? imageFormatGroup,
  }) async {
    isCameraInitialized = true;
    _cameraEventStreamController.add(
      cpi.CameraInitializedEvent(
        cameraId,
        1920,
        1080,
        cpi.ExposureMode.auto,
        true,
        cpi.FocusMode.auto,
        true,
      ),
    );
  }

  Stream<cpi.CameraEvent> cameraEvents(int cameraId) {
    return _cameraEventStreamController.stream;
  }

  @override
  Future<void> dispose(int cameraId) async {
    isCameraInitialized = false;
  }

  Future<void> startImageStream(int cameraId) async {
    isPreviewStreaming = true;
  }

  Future<void> stopImageStream(int cameraId) async {
    isPreviewStreaming = false;
  }

  @override
  Stream<cpi.DeviceOrientationChangedEvent> onDeviceOrientationChanged() {
    return const Stream.empty();
  }

  @override
  Future<void> pausePreview(int cameraId) async {}

  @override
  Future<void> resumePreview(int cameraId) async {}

  @override
  Future<cpi.XFile> takePicture(int cameraId) async {
    return cpi.XFile('');
  }

  @override
  Widget buildPreview(int cameraId) {
    return const SizedBox();
  }

  // Add all other methods from CameraPlatform with empty implementations
  @override
  Future<double> getExposureOffsetStepSize(int cameraId) async => 0.0;

  @override
  Future<double> getMaxExposureOffset(int cameraId) async => 1.0;

  @override
  Future<double> getMinExposureOffset(int cameraId) async => -1.0;

  @override
  Future<double> getMaxZoomLevel(int cameraId) async => 1.0;

  @override
  Future<double> getMinZoomLevel(int cameraId) async => 1.0;

  @override
  Future<void> lockCaptureOrientation(
    int cameraId,
    dynamic orientation,
  ) async {}

  @override
  Stream<cpi.CameraClosingEvent> onCameraClosing(int cameraId) =>
      const Stream.empty();

  @override
  Stream<cpi.CameraErrorEvent> onCameraError(int cameraId) =>
      const Stream.empty();

  @override
  Stream<cpi.CameraInitializedEvent> onCameraInitialized(int cameraId) =>
      cameraEvents(cameraId).whereType<cpi.CameraInitializedEvent>();

  @override
  Stream<cpi.CameraResolutionChangedEvent> onCameraResolutionChanged(
    int cameraId,
  ) => const Stream.empty();

  @override
  Stream<cpi.VideoRecordedEvent> onVideoRecordedEvent(int cameraId) =>
      const Stream.empty();

  @override
  Future<void> pauseVideoRecording(int cameraId) async {}

  @override
  Future<void> resumeVideoRecording(int cameraId) async {}

  @override
  Future<double> setExposureOffset(int cameraId, double offset) async => offset;

  @override
  Future<void> setExposureMode(int cameraId, cpi.ExposureMode mode) async {}

  @override
  Future<void> setExposurePoint(int cameraId, Point<double>? point) async {}

  @override
  Future<void> setFocusMode(int cameraId, cpi.FocusMode mode) async {}

  @override
  Future<void> setFocusPoint(int cameraId, Point<double>? point) async {}

  @override
  Future<void> setZoomLevel(int cameraId, double zoom) async {}

  @override
  Future<void> startVideoRecording(
    int cameraId, {
    Duration? maxVideoDuration,
  }) async {}

  @override
  Future<cpi.XFile> stopVideoRecording(int cameraId) async => cpi.XFile('');

  @override
  Future<void> unlockCaptureOrientation(int cameraId) async {}
}

// --- Main Test Suite ---
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CheckInBloc checkInBloc;
  late MockPermissionService mockPermissionService;
  late MockWebSocketService mockWebSocketService;
  late MockCameraService mockCameraService;
  late MockCameraController mockCameraController;
  late MockFrameStreamingService mockFrameStreamingService;
  late FakeCameraPlatform fakeCameraPlatform;

  // Stream controllers for mocks
  late StreamController<ConnectionStatus> connectionStatusController;
  late StreamController<Map<String, dynamic>> messagesController;
  late StreamController<ConnectionMetrics> metricsController;
  late StreamController<cpi.CameraImage> imageStreamController;
  late StreamController<streaming.StreamingStatus> statusStreamController;
  late StreamController<streaming.FrameMetrics> frameMetricsController;

  setUp(() {
    // Initialize mock services
    mockPermissionService = MockPermissionService();
    mockWebSocketService = MockWebSocketService();
    mockCameraService = MockCameraService();
    mockCameraController = MockCameraController();
    mockFrameStreamingService = MockFrameStreamingService();

    // Initialize stream controllers
    connectionStatusController = StreamController<ConnectionStatus>.broadcast();
    messagesController = StreamController<Map<String, dynamic>>.broadcast();
    metricsController = StreamController<ConnectionMetrics>.broadcast();
    imageStreamController = StreamController<cpi.CameraImage>.broadcast();
    statusStreamController =
        StreamController<streaming.StreamingStatus>.broadcast();
    frameMetricsController =
        StreamController<streaming.FrameMetrics>.broadcast();

    // Mock the streams for WebSocketService
    when(
      () => mockWebSocketService.connectionStatus,
    ).thenAnswer((_) => connectionStatusController.stream);
    when(
      () => mockWebSocketService.messages,
    ).thenAnswer((_) => messagesController.stream);
    when(
      () => mockWebSocketService.metrics,
    ).thenAnswer((_) => metricsController.stream);

    // Mock the streams for CameraService
    when(
      () => mockCameraService.imageStream,
    ).thenAnswer((_) => imageStreamController.stream);

    // Mock the streams for FrameStreamingService
    when(
      () => mockFrameStreamingService.statusStream,
    ).thenAnswer((_) => statusStreamController.stream);
    when(
      () => mockFrameStreamingService.metricsStream,
    ).thenAnswer((_) => frameMetricsController.stream);

    // Mock CameraController dispose method
    when(() => mockCameraController.dispose()).thenAnswer((_) async {});

    fakeCameraPlatform = FakeCameraPlatform();
    cpi.CameraPlatform.instance = fakeCameraPlatform;

    // Create the BLoC after all mocks are set up
    checkInBloc = CheckInBloc(
      mockPermissionService,
      mockWebSocketService,
      mockCameraService,
      mockFrameStreamingService,
    );
  });

  tearDown(() {
    checkInBloc.close();
    connectionStatusController.close();
    messagesController.close();
    metricsController.close();
    imageStreamController.close();
    statusStreamController.close();
    frameMetricsController.close();
  });

  test('initial state is correct', () {
    expect(checkInBloc.state, const CheckInState());
  });

  blocTest<CheckInBloc, CheckInState>(
    'emits [permissionRequesting, granted, initializing, ready, connecting] when camera permission is granted',
    build: () {
      when(
        () => mockPermissionService.requestCameraPermission(),
      ).thenAnswer((_) async => ps.PermissionStatus.granted);
      when(() => mockCameraService.initialize()).thenAnswer((_) async {});
      when(() => mockCameraService.controller).thenReturn(mockCameraController);
      when(
        () => mockCameraController.value,
      ).thenReturn(cpi.CameraValue.uninitialized(FakeCameraDescription()));
      when(() => mockWebSocketService.connect()).thenAnswer((_) async => true);
      return checkInBloc;
    },
    act: (bloc) => bloc.add(const CheckInEvent.cameraPermissionRequested()),
    expect:
        () => [
          const CheckInState(cameraStatus: CameraStatus.permissionRequesting),
          const CheckInState(
            cameraStatus: CameraStatus.permissionRequesting,
            permissionStatus: ps.PermissionStatus.granted,
          ),
          const CheckInState(
            cameraStatus: CameraStatus.initializing,
            permissionStatus: ps.PermissionStatus.granted,
            isLoading: true,
          ),
          isA<CheckInState>()
              .having((s) => s.cameraStatus, 'cameraStatus', CameraStatus.ready)
              .having((s) => s.isLoading, 'isLoading', false),
          isA<CheckInState>().having(
            (s) => s.connectionStatus,
            'connectionStatus',
            ConnectionStatus.connecting,
          ),
        ],
  );

  blocTest<CheckInBloc, CheckInState>(
    'emits [connecting, connected] state on ConnectionRequested',
    build: () {
      when(() => mockWebSocketService.connect()).thenAnswer((_) async => true);
      return checkInBloc;
    },
    act: (bloc) => bloc.add(const CheckInEvent.connectionRequested()),
    wait: const Duration(milliseconds: 2100),
    expect:
        () => [
          const CheckInState(
            connectionStatus: ConnectionStatus.connecting,
            isLoading: true,
          ),
          const CheckInState(
            connectionStatus: ConnectionStatus.connected,
            isLoading: false,
            toastStatus: ToastStatus.showing,
            toastMessage: 'Connected to backend (placeholder)',
          ),
        ],
  );

  blocTest<CheckInBloc, CheckInState>(
    'emits debug mode toggled state',
    build: () => checkInBloc,
    act: (bloc) => bloc.add(const CheckInEvent.debugModeToggled()),
    expect:
        () => [
          const CheckInState(
            isDebugMode: true,
            toastStatus: ToastStatus.showing,
            toastMessage: 'Debug mode enabled',
          ),
        ],
  );

  blocTest<CheckInBloc, CheckInState>(
    'resets statistics on StatisticsReset',
    build: () => checkInBloc,
    seed: () => const CheckInState(framesProcessed: 10),
    act: (bloc) => bloc.add(const CheckInEvent.statisticsReset()),
    expect:
        () => [
          const CheckInState(
            framesProcessed: 0,
            lastRecognitionTime: null,
            toastStatus: ToastStatus.showing,
            toastMessage: 'Statistics reset',
          ),
        ],
  );

  group('Phase 2 - Frame Streaming Integration Tests', () {
    blocTest<CheckInBloc, CheckInState>(
      'handles ConnectionStatusChanged events from WebSocket service',
      build: () => checkInBloc,
      act: (bloc) {
        // Simulate WebSocket connection status change
        connectionStatusController.add(ConnectionStatus.connected);
      },
      expect:
          () => [
            const CheckInState(connectionStatus: ConnectionStatus.connected),
          ],
    );

    blocTest<CheckInBloc, CheckInState>(
      'handles StreamingStatusChanged events from FrameStreaming service',
      build: () => checkInBloc,
      act: (bloc) {
        // Simulate streaming status change
        statusStreamController.add(streaming.StreamingStatus.active);
      },
      expect:
          () => [const CheckInState(streamingStatus: StreamingStatus.active)],
    );

    blocTest<CheckInBloc, CheckInState>(
      'calls startStreaming when StreamingStartRequested with camera ready',
      build: () {
        when(
          () => mockFrameStreamingService.startStreaming(),
        ).thenAnswer((_) async {});
        return checkInBloc;
      },
      seed:
          () => const CheckInState(
            cameraStatus: CameraStatus.ready,
            connectionStatus: ConnectionStatus.connected,
          ),
      act: (bloc) => bloc.add(const CheckInEvent.streamingStartRequested()),
      verify: (_) {
        verify(() => mockFrameStreamingService.startStreaming()).called(1);
      },
    );

    blocTest<CheckInBloc, CheckInState>(
      'handles frame streaming start error when camera not ready',
      build: () => checkInBloc,
      act: (bloc) => bloc.add(const CheckInEvent.streamingStartRequested()),
      expect:
          () => [
            isA<CheckInState>()
                .having(
                  (s) => s.streamingStatus,
                  'streamingStatus',
                  StreamingStatus.error,
                )
                .having(
                  (s) => s.errorMessage,
                  'errorMessage',
                  contains('Camera not ready'),
                ),
          ],
    );

    blocTest<CheckInBloc, CheckInState>(
      'calls stopStreaming when StreamingStopRequested',
      build: () {
        when(
          () => mockFrameStreamingService.stopStreaming(),
        ).thenAnswer((_) async {});
        return checkInBloc;
      },
      seed:
          () => const CheckInState(
            streamingStatus: StreamingStatus.active,
            cameraStatus: CameraStatus.ready,
          ),
      act: (bloc) => bloc.add(const CheckInEvent.streamingStopRequested()),
      verify: (_) {
        verify(() => mockFrameStreamingService.stopStreaming()).called(1);
      },
    );

    blocTest<CheckInBloc, CheckInState>(
      'handles WebSocket messages correctly but does not emit state',
      build: () => checkInBloc,
      act: (bloc) {
        // Simulate WebSocket message
        messagesController.add({'type': 'test', 'data': 'message'});
      },
      // WebSocketMessageReceived doesn't emit state directly - it only logs
      expect: () => [],
      wait: const Duration(milliseconds: 100),
    );

    // Test for stream listening integration
    blocTest<CheckInBloc, CheckInState>(
      'integrates properly with streaming status changes from service',
      build: () => checkInBloc,
      act: (bloc) async {
        // First add frame streaming status change
        statusStreamController.add(streaming.StreamingStatus.active);
        await Future.delayed(const Duration(milliseconds: 50));

        // Then add idle status
        statusStreamController.add(streaming.StreamingStatus.idle);
      },
      expect:
          () => [
            const CheckInState(streamingStatus: StreamingStatus.active),
            const CheckInState(streamingStatus: StreamingStatus.idle),
          ],
    );

    // Test for WebSocket connection integration
    blocTest<CheckInBloc, CheckInState>(
      'integrates properly with WebSocket connection status changes',
      build: () => checkInBloc,
      act: (bloc) async {
        // First connecting
        connectionStatusController.add(ConnectionStatus.connecting);
        await Future.delayed(const Duration(milliseconds: 50));

        // Then connected
        connectionStatusController.add(ConnectionStatus.connected);
      },
      expect:
          () => [
            const CheckInState(connectionStatus: ConnectionStatus.connecting),
            const CheckInState(connectionStatus: ConnectionStatus.connected),
          ],
    );
  });
}
