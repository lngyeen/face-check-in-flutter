import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart'
    as cpi;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart'
    as ps;
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';

// --- Mocks and Fakes ---

class MockCheckInBloc extends MockBloc<CheckInEvent, CheckInState>
    implements CheckInBloc {}

class MockPermissionService extends Mock implements ps.PermissionService {}

class MockWebSocketService extends Mock implements WebSocketService {}

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
  late FakeCameraPlatform fakeCameraPlatform;

  setUp(() {
    mockPermissionService = MockPermissionService();
    mockWebSocketService = MockWebSocketService();
    fakeCameraPlatform = FakeCameraPlatform();
    cpi.CameraPlatform.instance = fakeCameraPlatform;

    // Mock the connection status stream
    when(
      () => mockWebSocketService.connectionStatusStream,
    ).thenAnswer((_) => Stream.fromIterable([]));
    when(() => mockWebSocketService.initialize()).thenAnswer((_) {});
    when(() => mockWebSocketService.connect()).thenAnswer((_) async {});
    when(() => mockWebSocketService.disconnect()).thenAnswer((_) async {});

    checkInBloc = CheckInBloc(mockPermissionService, mockWebSocketService);
  });

  tearDown(() {
    checkInBloc.close();
  });

  group('CheckInBloc', () {
    test('initial state is correct', () {
      expect(checkInBloc.state, const CheckInState());
    });

    group('CameraPermissionRequested', () {
      blocTest<CheckInBloc, CheckInState>(
        'emits granted when permission is granted and initializes camera',
        build: () {
          when(
            () => mockPermissionService.requestCameraPermission(),
          ).thenAnswer((_) async => ps.PermissionStatus.granted);
          return checkInBloc;
        },
        act: (bloc) => bloc.add(const CheckInEvent.cameraPermissionRequested()),
        expect:
            () => [
              const CheckInState(
                cameraStatus: CameraStatus.permissionRequesting,
              ),
              const CheckInState(
                cameraStatus: CameraStatus.permissionRequesting,
                permissionStatus: PermissionStatus.granted,
              ),
              isA<CheckInState>()
                  .having(
                    (s) => s.cameraStatus,
                    'cameraStatus',
                    CameraStatus.initializing,
                  )
                  .having((s) => s.isLoading, 'isLoading', true)
                  .having(
                    (s) => s.permissionStatus,
                    'permissionStatus',
                    PermissionStatus.granted,
                  ),
              isA<CheckInState>()
                  .having(
                    (s) => s.cameraStatus,
                    'cameraStatus',
                    CameraStatus.ready,
                  )
                  .having((s) => s.isLoading, 'isLoading', false)
                  .having(
                    (s) => s.permissionStatus,
                    'permissionStatus',
                    PermissionStatus.granted,
                  )
                  .having(
                    (s) => s.toastStatus,
                    'toastStatus',
                    ToastStatus.showing,
                  )
                  .having((s) => s.toastMessage, 'toastMessage', 'Camera ready')
                  .having(
                    (s) => s.cameraController,
                    'cameraController',
                    isA<CameraController>(),
                  ),
            ],
        verify: (_) {
          verify(
            () => mockPermissionService.requestCameraPermission(),
          ).called(1);
        },
      );

      blocTest<CheckInBloc, CheckInState>(
        'emits denied when permission is denied',
        build: () {
          when(
            () => mockPermissionService.requestCameraPermission(),
          ).thenAnswer((_) async => ps.PermissionStatus.denied);
          return checkInBloc;
        },
        act: (bloc) => bloc.add(const CheckInEvent.cameraPermissionRequested()),
        expect:
            () => [
              const CheckInState(
                cameraStatus: CameraStatus.permissionRequesting,
              ),
              const CheckInState(
                cameraStatus: CameraStatus.permissionDenied,
                permissionStatus: PermissionStatus.denied,
              ),
            ],
      );
    });
  });

  blocTest<CheckInBloc, CheckInState>(
    'emits updated state on ConnectionRequested',
    build: () => checkInBloc,
    act: (bloc) => bloc.add(const CheckInEvent.connectionRequested()),
    verify: (_) {
      verify(() => mockWebSocketService.connect()).called(1);
    },
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
}
