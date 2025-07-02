import 'package:bloc_test/bloc_test.dart';
import 'package:check_in_refactor/blocs/camera/camera_bloc.dart';
import 'package:check_in_refactor/blocs/camera/camera_event.dart';
import 'package:check_in_refactor/entities/camera_state.dart';
import 'package:check_in_refactor/services/camera_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCameraService extends Mock implements CameraService {}

void main() {
  late CameraBloc cameraBloc;
  late MockCameraService mockCameraService;

  setUp(() {
    mockCameraService = MockCameraService();
    when(() => mockCameraService.statusStream)
        .thenAnswer((_) => const Stream.empty());
    when(() => mockCameraService.dispose()).thenAnswer((_) async {});
    cameraBloc = CameraBloc(mockCameraService);
  });

  tearDown(() {
    cameraBloc.close();
  });

  group('CameraBloc', () {
    test('initial state is correct', () {
      expect(cameraBloc.state, const CameraState());
    });

    blocTest<CameraBloc, CameraState>(
      'calls start on CameraService when Initialize event is added',
      build: () {
        when(() => mockCameraService.start()).thenAnswer((_) async {});
        return cameraBloc;
      },
      act: (bloc) => bloc.add(const CameraEvent.initialize()),
      verify: (_) {
        verify(() => mockCameraService.start()).called(1);
      },
    );

    blocTest<CameraBloc, CameraState>(
      'calls stop on CameraService when Stop event is added',
      build: () {
        when(() => mockCameraService.stop()).thenAnswer((_) async {});
        return cameraBloc;
      },
      act: (bloc) => bloc.add(const CameraEvent.stop()),
      verify: (_) {
        verify(() => mockCameraService.stop()).called(1);
      },
    );
  });
}
