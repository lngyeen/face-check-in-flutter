import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart'
    as cpi;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart'
    as ph;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';

// --- Mocks and Fakes ---

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
  Completer<void> cameraInitialized = Completer<void>();

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
    cameraInitialized.complete();
  }

  @override
  Stream<cpi.CameraEvent> cameraEvents(int cameraId) {
    return cameraInitialized.future.asStream().map(
      (_) => cpi.CameraInitializedEvent(
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

  @override
  Future<void> dispose(int cameraId) async {
    isCameraInitialized = false;
  }

  @override
  Future<void> startImageStream(int cameraId) async {
    isPreviewStreaming = true;
  }

  @override
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

class FakePermissionHandler extends Fake
    with MockPlatformInterfaceMixin
    implements ph.PermissionHandlerPlatform {
  ph.PermissionStatus _permissionStatus = ph.PermissionStatus.denied;

  void setPermissionStatus(ph.PermissionStatus status) {
    _permissionStatus = status;
  }

  @override
  Future<Map<ph.Permission, ph.PermissionStatus>> requestPermissions(
    List<ph.Permission> permissions,
  ) async {
    return {for (var p in permissions) p: _permissionStatus};
  }

  @override
  Future<ph.PermissionStatus> checkPermissionStatus(
    ph.Permission permission,
  ) async {
    return _permissionStatus;
  }

  @override
  Future<bool> openAppSettings() async => true;
}

// --- Main Test Suite ---

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CheckInBloc checkInBloc;
  late FakePermissionHandler fakePermissionHandler;
  late FakeCameraPlatform fakeCameraPlatform;

  setUp(() {
    fakePermissionHandler = FakePermissionHandler();
    ph.PermissionHandlerPlatform.instance = fakePermissionHandler;

    fakeCameraPlatform = FakeCameraPlatform();
    cpi.CameraPlatform.instance = fakeCameraPlatform;

    checkInBloc = CheckInBloc();
  });

  tearDown(() {
    checkInBloc.close();
  });

  test('initial state is correct', () {
    expect(checkInBloc.state, const CheckInState());
  });

  group('AppStarted Event', () {
    blocTest<CheckInBloc, CheckInState>(
      'requests camera permission and initializes camera when granted',
      setUp: () {
        fakePermissionHandler.setPermissionStatus(ph.PermissionStatus.granted);
      },
      build: () => checkInBloc,
      act: (bloc) => bloc.add(const CheckInEvent.appStarted()),
      expect:
          () => <Matcher>[
            isA<CheckInState>().having((s) => s.isLoading, 'isLoading', true),
            isA<CheckInState>()
                .having(
                  (s) => s.toastMessage,
                  'toastMessage',
                  'App initialized successfully',
                )
                .having((s) => s.isLoading, 'isLoading', false),
            isA<CheckInState>().having(
              (s) => s.cameraStatus,
              'cameraStatus',
              CameraStatus.permissionRequesting,
            ),
            isA<CheckInState>().having(
              (s) => s.permissionStatus,
              'permissionStatus',
              PermissionStatus.granted,
            ),
            isA<CheckInState>()
                .having(
                  (s) => s.cameraStatus,
                  'cameraStatus',
                  CameraStatus.initializing,
                )
                .having((s) => s.isLoading, 'isLoading', true),
            isA<CheckInState>()
                .having(
                  (s) => s.cameraStatus,
                  'cameraStatus',
                  CameraStatus.ready,
                )
                .having((s) => s.isLoading, 'isLoading', false)
                .having(
                  (s) => s.cameraController,
                  'cameraController',
                  isNotNull,
                ),
          ],
      verify: (_) {
        expect(fakeCameraPlatform.isCameraInitialized, isTrue);
      },
    );

    blocTest<CheckInBloc, CheckInState>(
      'sets camera status to permissionDenied when permission is denied',
      setUp: () {
        fakePermissionHandler.setPermissionStatus(ph.PermissionStatus.denied);
      },
      build: () => checkInBloc,
      act: (bloc) => bloc.add(const CheckInEvent.appStarted()),
      expect:
          () => <Matcher>[
            isA<CheckInState>().having((s) => s.isLoading, 'isLoading', true),
            isA<CheckInState>()
                .having(
                  (s) => s.toastMessage,
                  'toastMessage',
                  'App initialized successfully',
                )
                .having((s) => s.isLoading, 'isLoading', false),
            isA<CheckInState>().having(
              (s) => s.cameraStatus,
              'cameraStatus',
              CameraStatus.permissionRequesting,
            ),
            isA<CheckInState>()
                .having(
                  (s) => s.permissionStatus,
                  'permissionStatus',
                  PermissionStatus.denied,
                )
                .having(
                  (s) => s.cameraStatus,
                  'cameraStatus',
                  CameraStatus.permissionDenied,
                ),
          ],
      verify: (_) {
        expect(fakeCameraPlatform.isCameraInitialized, isFalse);
      },
    );
  });

  group('camera related', () {
    blocTest<CheckInBloc, CheckInState>(
      'emits updated state on CameraInitRequested',
      setUp: () {
        fakePermissionHandler.setPermissionStatus(ph.PermissionStatus.granted);
      },
      build: () => checkInBloc,
      act: (bloc) {
        bloc.add(const CheckInEvent.appStarted());
      },
      skip: 4,
      expect:
          () => <Matcher>[
            isA<CheckInState>()
                .having(
                  (s) => s.cameraStatus,
                  'cameraStatus',
                  CameraStatus.initializing,
                )
                .having((s) => s.isLoading, 'isLoading', true),
            isA<CheckInState>()
                .having(
                  (s) => s.cameraStatus,
                  'cameraStatus',
                  CameraStatus.ready,
                )
                .having((s) => s.isLoading, 'isLoading', false)
                .having(
                  (s) => s.cameraController,
                  'cameraController',
                  isNotNull,
                ),
          ],
    );
  });

  blocTest<CheckInBloc, CheckInState>(
    'emits updated state on ConnectionRequested',
    build: () => checkInBloc,
    act: (bloc) => bloc.add(const CheckInEvent.connectionRequested()),
    wait: const Duration(milliseconds: 2000),
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
}
