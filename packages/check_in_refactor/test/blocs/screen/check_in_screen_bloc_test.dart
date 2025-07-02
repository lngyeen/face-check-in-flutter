import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:check_in_refactor/blocs/screen/check_in_screen_bloc.dart';
import 'package:check_in_refactor/blocs/screen/check_in_screen_event.dart';
import 'package:check_in_refactor/entities/check_in_screen_state.dart';
import 'package:check_in_refactor/usecases/check_in_orchestrator.dart';
import 'package:check_in_refactor/usecases/notification_interactor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationInteractor extends Mock
    implements NotificationInteractor {}

class MockCheckInOrchestrator extends Mock implements CheckInOrchestrator {}

void main() {
  group('CheckInScreenBloc', () {
    late NotificationInteractor mockNotificationInteractor;
    late CheckInOrchestrator mockCheckInOrchestrator;
    late StreamController<NotificationData> notificationStreamController;
    late StreamController<CheckInScreenState> orchestratorStateController;

    setUp(() {
      mockNotificationInteractor = MockNotificationInteractor();
      mockCheckInOrchestrator = MockCheckInOrchestrator();
      notificationStreamController =
          StreamController<NotificationData>.broadcast();
      orchestratorStateController =
          StreamController<CheckInScreenState>.broadcast();

      when(() => mockNotificationInteractor.notificationStream)
          .thenAnswer((_) => notificationStreamController.stream);
      when(() => mockCheckInOrchestrator.stateStream)
          .thenAnswer((_) => orchestratorStateController.stream);
      when(() => mockCheckInOrchestrator.initialize()).thenAnswer((_) async {});
      when(() => mockCheckInOrchestrator.performCheckIn())
          .thenAnswer((_) async {});
    });

    tearDown(() {
      notificationStreamController.close();
      orchestratorStateController.close();
    });

    test('initial state is CheckInScreenState()', () {
      expect(
          CheckInScreenBloc(mockNotificationInteractor, mockCheckInOrchestrator)
              .state,
          const CheckInScreenState());
    });

    blocTest<CheckInScreenBloc, CheckInScreenState>(
      'emits state with new notification when notificationStream emits',
      build: () => CheckInScreenBloc(
          mockNotificationInteractor, mockCheckInOrchestrator),
      act: (bloc) {
        final notification = NotificationData(
          type: NotificationType.faceDetected,
          message: 'test',
          timestamp: DateTime.now(),
        );
        notificationStreamController.add(notification);
      },
      expect: () => [
        isA<CheckInScreenState>().having(
          (s) => s.pendingNotification,
          'pendingNotification',
          isA<NotificationData>(),
        ),
      ],
    );

    blocTest<CheckInScreenBloc, CheckInScreenState>(
      'emits state with isDebugMode toggled on ToggleDebugMode event',
      build: () => CheckInScreenBloc(
          mockNotificationInteractor, mockCheckInOrchestrator),
      act: (bloc) => bloc.add(const CheckInScreenEvent.toggleDebugMode()),
      expect: () => [const CheckInScreenState(isDebugMode: true)],
    );

    blocTest<CheckInScreenBloc, CheckInScreenState>(
      'emits state with isFullScreen toggled on ToggleFullScreen event',
      build: () => CheckInScreenBloc(
          mockNotificationInteractor, mockCheckInOrchestrator),
      act: (bloc) => bloc.add(const CheckInScreenEvent.toggleFullScreen()),
      expect: () => [const CheckInScreenState(isFullScreen: true)],
    );

    final notification = NotificationData(
      type: NotificationType.faceDetected,
      message: 'test',
      timestamp: DateTime.now(),
    );

    blocTest<CheckInScreenBloc, CheckInScreenState>(
      'emits state with pending notification on ShowNotification event',
      build: () => CheckInScreenBloc(
          mockNotificationInteractor, mockCheckInOrchestrator),
      act: (bloc) =>
          bloc.add(CheckInScreenEvent.showNotification(notification)),
      expect: () => [
        isA<CheckInScreenState>().having(
          (s) => s.pendingNotification,
          'pendingNotification',
          notification,
        ),
      ],
    );

    blocTest<CheckInScreenBloc, CheckInScreenState>(
      'emits state with null pending notification on DismissNotification event',
      build: () => CheckInScreenBloc(
          mockNotificationInteractor, mockCheckInOrchestrator),
      seed: () => CheckInScreenState(pendingNotification: notification),
      act: (bloc) => bloc.add(const CheckInScreenEvent.dismissNotification()),
      expect: () => [
        isA<CheckInScreenState>().having(
          (s) => s.pendingNotification,
          'pendingNotification',
          null,
        ),
      ],
    );
  });
}
