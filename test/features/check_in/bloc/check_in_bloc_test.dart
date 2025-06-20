import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart'
    as cpi;
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/services/permission_service.dart'
    as ps;
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPermissionService extends Mock implements ps.PermissionService {}

class MockWebSocketService extends Mock implements WebSocketService {}

class FakeCameraPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements cpi.CameraPlatform {
  @override
  Future<List<cpi.CameraDescription>> availableCameras() async {
    return [
      const cpi.CameraDescription(
        name: 'cam',
        lensDirection: cpi.CameraLensDirection.front,
        sensorOrientation: 90,
      ),
    ];
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
  Future<void> initializeCamera(
    int cameraId, {
    cpi.ImageFormatGroup? imageFormatGroup,
  }) async {}

  @override
  Stream<cpi.CameraInitializedEvent> onCameraInitialized(int cameraId) {
    return Stream.value(
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
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CheckInBloc checkInBloc;
  late MockPermissionService mockPermissionService;
  late MockWebSocketService mockWebSocketService;

  setUpAll(() {
    cpi.CameraPlatform.instance = FakeCameraPlatform();
  });

  setUp(() {
    mockPermissionService = MockPermissionService();
    mockWebSocketService = MockWebSocketService();

    when(
      () => mockWebSocketService.connectionStatusStream,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => mockWebSocketService.messageStream,
    ).thenAnswer((_) => const Stream.empty());
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
        'emits [permissionDenied] when permission is denied',
        setUp: () {
          when(
            () => mockPermissionService.requestCameraPermission(),
          ).thenAnswer((_) async => ps.PermissionStatus.denied);
        },
        build: () => checkInBloc,
        act: (bloc) => bloc.add(const CheckInEvent.cameraPermissionRequested()),
        expect:
            () => <CheckInState>[
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

    group('Streaming', () {
      blocTest<CheckInBloc, CheckInState>(
        'StreamingStarted should update status to active and camera to streaming',
        build: () => checkInBloc,
        act: (bloc) => bloc.add(const CheckInEvent.streamingStarted()),
        expect:
            () => <CheckInState>[
              const CheckInState(streamingStatus: StreamingStatus.active),
              const CheckInState(
                streamingStatus: StreamingStatus.active,
                cameraStatus: CameraStatus.streaming,
              ),
            ],
      );

      blocTest<CheckInBloc, CheckInState>(
        'StreamingStopped should update status to idle',
        build: () => checkInBloc,
        seed:
            () => const CheckInState(
              cameraStatus: CameraStatus.streaming,
              streamingStatus: StreamingStatus.active,
            ),
        act: (bloc) => bloc.add(const CheckInEvent.streamingStopped()),
        expect:
            () => <CheckInState>[
              const CheckInState(
                cameraStatus: CameraStatus.streaming,
                streamingStatus: StreamingStatus.idle,
              ),
            ],
      );
    });
  });
}
