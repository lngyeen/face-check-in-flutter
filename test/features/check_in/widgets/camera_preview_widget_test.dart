import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/camera_preview_widget.dart';

class MockCheckInBloc extends MockBloc<CheckInEvent, CheckInState>
    implements CheckInBloc {}

class MockCameraController extends Mock implements CameraController {
  @override
  CameraValue get value => _cameraValue;

  static final _cameraValue = CameraValue(
    isInitialized: true,
    isStreamingImages: false,
    isTakingPicture: false,
    isRecordingVideo: false,
    isRecordingPaused: false,
    flashMode: FlashMode.off,
    exposureMode: ExposureMode.auto,
    focusMode: FocusMode.auto,
    deviceOrientation: DeviceOrientation.portraitUp,
    previewSize: const Size(1, 1),
    errorDescription: null,
    exposurePointSupported: true,
    focusPointSupported: true,
    description: MockCameraDescription(),
  );

  @override
  Widget buildPreview() {
    return const SizedBox();
  }
}

class MockCameraDescription extends Mock implements CameraDescription {}

void main() {
  late MockCheckInBloc mockCheckInBloc;
  late MockCameraController mockCameraController;

  setUp(() {
    mockCheckInBloc = MockCheckInBloc();
    mockCameraController = MockCameraController();
    when(
      () => mockCheckInBloc.state,
    ).thenReturn(const CheckInState()); // Default state
  });

  Widget createTestWidget(Widget child) {
    return BlocProvider<CheckInBloc>.value(
      value: mockCheckInBloc,
      child: MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('CameraPreviewWidget', () {
    testWidgets(
      'renders CircularProgressIndicator for initial, permissionRequesting, and initializing states',
      (tester) async {
        final states = [
          CameraStatus.initial,
          CameraStatus.permissionRequesting,
          CameraStatus.initializing,
        ];

        for (final status in states) {
          when(
            () => mockCheckInBloc.state,
          ).thenReturn(CheckInState(cameraStatus: status));

          await tester.pumpWidget(
            createTestWidget(const CameraPreviewWidget()),
          );

          expect(
            find.byType(CircularProgressIndicator),
            findsOneWidget,
            reason: 'Failed for state: $status',
          );
        }
      },
    );

    testWidgets('renders PermissionDeniedWidget when permission is denied', (
      tester,
    ) async {
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(cameraStatus: CameraStatus.permissionDenied),
      );

      await tester.pumpWidget(createTestWidget(const CameraPreviewWidget()));

      expect(find.byType(PermissionDeniedWidget), findsOneWidget);
      expect(find.text('Camera Permission Denied'), findsOneWidget);
    });

    testWidgets('renders CameraErrorWidget when camera state is error', (
      tester,
    ) async {
      const errorMessage = 'Test Error';
      when(() => mockCheckInBloc.state).thenReturn(
        const CheckInState(
          cameraStatus: CameraStatus.error,
          errorMessage: errorMessage,
        ),
      );

      await tester.pumpWidget(createTestWidget(const CameraPreviewWidget()));

      expect(find.byType(CameraErrorWidget), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('renders CameraPreview when camera is ready', (tester) async {
      when(() => mockCheckInBloc.state).thenReturn(
        CheckInState(
          cameraStatus: CameraStatus.ready,
          cameraController: mockCameraController,
        ),
      );

      await tester.pumpWidget(createTestWidget(const CameraPreviewWidget()));

      expect(find.byType(CameraPreview), findsOneWidget);
    });

    testWidgets(
      'renders "Camera not available." when controller is null in ready state',
      (tester) async {
        when(() => mockCheckInBloc.state).thenReturn(
          const CheckInState(
            cameraStatus: CameraStatus.ready,
            cameraController: null,
          ),
        );

        await tester.pumpWidget(createTestWidget(const CameraPreviewWidget()));

        expect(find.text('Camera not available.'), findsOneWidget);
      },
    );
  });
}
