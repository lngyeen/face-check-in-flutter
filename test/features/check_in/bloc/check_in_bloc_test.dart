import 'package:bloc_test/bloc_test.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_event.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckInBloc', () {
    late CheckInBloc checkInBloc;

    setUp(() {
      checkInBloc = CheckInBloc();
    });

    tearDown(() {
      checkInBloc.close();
    });

    test('initial state is correct', () {
      expect(checkInBloc.state, const CheckInState());
    });

    blocTest<CheckInBloc, CheckInState>(
      'emits [isLoading: true] and then [isLoading: false, toastStatus: showing] on AppStarted',
      build: () => checkInBloc,
      act: (bloc) => bloc.add(const CheckInEvent.appStarted()),
      expect:
          () => [
            const CheckInState(isLoading: true),
            const CheckInState(
              isLoading: false,
              toastStatus: ToastStatus.showing,
              toastMessage: 'App initialized successfully',
            ),
          ],
    );

    blocTest<CheckInBloc, CheckInState>(
      'emits updated state on CameraInitRequested',
      build: () => checkInBloc,
      act: (bloc) => bloc.add(const CheckInEvent.cameraInitRequested()),
      wait: const Duration(milliseconds: 1000),
      expect:
          () => [
            const CheckInState(
              cameraStatus: CameraStatus.initial,
              isLoading: true,
            ),
            const CheckInState(
              cameraStatus: CameraStatus.ready,
              isLoading: false,
              toastStatus: ToastStatus.showing,
              toastMessage: 'Camera ready (placeholder)',
            ),
          ],
    );

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
  });
}
