import 'package:bloc_test/bloc_test.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart'
    as cpi;
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:face_check_in_flutter/domain/services/permission_service.dart'
    as ps;
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';

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

      blocTest<CheckInBloc, CheckInState>(
        'StreamingPaused should update status to paused when active',
        build: () => checkInBloc,
        seed: () => const CheckInState(streamingStatus: StreamingStatus.active),
        act: (bloc) => bloc.add(const CheckInEvent.streamingPaused()),
        expect:
            () => <CheckInState>[
              const CheckInState(streamingStatus: StreamingStatus.paused),
            ],
      );

      blocTest<CheckInBloc, CheckInState>(
        'StreamingPaused should not do anything when not active',
        build: () => checkInBloc,
        seed: () => const CheckInState(streamingStatus: StreamingStatus.idle),
        act: (bloc) => bloc.add(const CheckInEvent.streamingPaused()),
        expect: () => <CheckInState>[],
      );

      blocTest<CheckInBloc, CheckInState>(
        'StreamingResumed should update status to active when paused',
        build: () => checkInBloc,
        seed: () => const CheckInState(streamingStatus: StreamingStatus.paused),
        act: (bloc) => bloc.add(const CheckInEvent.streamingResumed()),
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
        'StreamingResumed should not do anything when not paused',
        build: () => checkInBloc,
        seed: () => const CheckInState(streamingStatus: StreamingStatus.active),
        act: (bloc) => bloc.add(const CheckInEvent.streamingResumed()),
        expect: () => <CheckInState>[],
      );

      blocTest<CheckInBloc, CheckInState>(
        'StreamingFailed should update status to error and set message',
        build: () => checkInBloc,
        act:
            (bloc) => bloc.add(const CheckInEvent.streamingFailed('error msg')),
        expect:
            () => <CheckInState>[
              const CheckInState(
                streamingStatus: StreamingStatus.error,
                errorMessage: 'error msg',
              ),
            ],
      );
    });

    group('WebSocketMessageReceived', () {
      blocTest<CheckInBloc, CheckInState>(
        'emits state with detectedFaces when a valid frameResult is received',
        build: () => checkInBloc,
        act:
            (bloc) => bloc.add(
              const CheckInEvent.webSocketMessageReceived(
                '{"type": "frameResult", "faces": [{"box": [10.0, 20.0, 30.0, 40.0], "confidence": 0.9}]}',
              ),
            ),
        expect:
            () => [
              predicate<CheckInState>((state) {
                if (state.detectedFaces.length != 1) return false;
                final face = state.detectedFaces.first;
                return face.boundingBox ==
                        const Rect.fromLTWH(10, 20, 30, 40) &&
                    face.confidence == 0.9 &&
                    state.lastRecognitionTime != null;
              }),
            ],
      );

      blocTest<CheckInBloc, CheckInState>(
        'emits error when frameResult has invalid "faces" data',
        build: () => checkInBloc,
        act:
            (bloc) => bloc.add(
              const CheckInEvent.webSocketMessageReceived(
                '{"type": "frameResult", "faces": "not-a-list"}',
              ),
            ),
        expect:
            () => <CheckInState>[
              const CheckInState(
                errorMessage: 'Invalid "faces" data in frameResult: not-a-list',
                toastStatus: ToastStatus.showing,
                toastMessage:
                    'Error: Invalid "faces" data in frameResult: not-a-list',
              ),
            ],
      );

      blocTest<CheckInBloc, CheckInState>(
        'emits error when json is malformed',
        build: () => checkInBloc,
        act:
            (bloc) => bloc.add(
              const CheckInEvent.webSocketMessageReceived(
                '{"type": "frameResult", "faces": [}',
              ),
            ),
        expect:
            () => [
              predicate<CheckInState>((state) {
                final hasError = state.errorMessage!.startsWith(
                  'Failed to decode WebSocket message:',
                );
                final hasToast = state.toastMessage!.startsWith(
                  'Error: Failed to decode WebSocket message:',
                );
                return hasError &&
                    hasToast &&
                    state.toastStatus == ToastStatus.showing;
              }),
            ],
      );

      blocTest<CheckInBloc, CheckInState>(
        'does not change state for unknown message type',
        build: () => checkInBloc,
        act:
            (bloc) => bloc.add(
              const CheckInEvent.webSocketMessageReceived(
                '{"type": "unknown_type"}',
              ),
            ),
        expect: () => <CheckInState>[],
      );

      blocTest<CheckInBloc, CheckInState>(
        'emits state with success for valid recognition_result',
        build: () => checkInBloc,
        act:
            (bloc) => bloc.add(
              const CheckInEvent.webSocketMessageReceived(
                '{"type": "recognition_result", "success": true, "message": "Welcome", "employeeName": "John Doe"}',
              ),
            ),
        expect:
            () => <CheckInState>[
              const CheckInState(
                successfulRecognitions: 1,
                toastStatus: ToastStatus.showing,
                toastMessage: 'Recognition success: John Doe',
              ),
            ],
      );

      blocTest<CheckInBloc, CheckInState>(
        'emits state with failure for failed recognition_result',
        build: () => checkInBloc,
        act:
            (bloc) => bloc.add(
              const CheckInEvent.webSocketMessageReceived(
                '{"type": "recognition_result", "success": false, "message": "Not recognized"}',
              ),
            ),
        expect:
            () => <CheckInState>[
              const CheckInState(
                failedRecognitions: 1,
                toastStatus: ToastStatus.showing,
                toastMessage: 'Recognition failed: Not recognized',
              ),
            ],
      );
    });
  });
}
