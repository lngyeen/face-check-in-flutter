import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../entities/check_in_screen_state.dart';
import '../../usecases/check_in_orchestrator.dart';
import '../../usecases/notification_interactor.dart';

import 'check_in_screen_event.dart';

@injectable
class CheckInScreenBloc extends Bloc<CheckInScreenEvent, CheckInScreenState> {
  final NotificationInteractor _notificationInteractor;
  final CheckInOrchestrator _orchestrator;
  StreamSubscription? _notificationSubscription;
  StreamSubscription? _orchestratorSubscription;

  CheckInScreenBloc(this._notificationInteractor, this._orchestrator)
      : super(const CheckInScreenState()) {
    on<CheckInScreenEvent>(_handleEvent);
    _listenToNotifications();
    _listenToOrchestrator();
  }

  void _listenToNotifications() {
    _notificationSubscription =
        _notificationInteractor.notificationStream.listen(
      (notification) => add(CheckInScreenEvent.showNotification(notification)),
    );
  }

  void _listenToOrchestrator() {
    _orchestratorSubscription = _orchestrator.stateStream.listen(
      (newState) => add(CheckInScreenEvent.orchestratorStateChanged(newState)),
    );
  }

  void _handleEvent(
      CheckInScreenEvent event, Emitter<CheckInScreenState> emit) {
    event.when(
      start: _orchestrator.initialize,
      orchestratorStateChanged: (newState) => emit(newState),
      toggleDebugMode: () => _handleToggleDebugMode(emit),
      showNotification: (data) => _handleShowNotification(data, emit),
      dismissNotification: () => _handleDismissNotification(emit),
      toggleFullScreen: () => _handleToggleFullScreen(emit),
    );
  }

  void _handleToggleDebugMode(Emitter<CheckInScreenState> emit) {
    emit(state.toggleDebugMode());
  }

  void _handleShowNotification(
      NotificationData data, Emitter<CheckInScreenState> emit) {
    emit(state.copyWith(pendingNotification: data));
  }

  void _handleDismissNotification(Emitter<CheckInScreenState> emit) {
    emit(state.copyWith(pendingNotification: null));
  }

  void _handleToggleFullScreen(Emitter<CheckInScreenState> emit) {
    emit(state.toggleFullScreen());
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    _orchestratorSubscription?.cancel();
    return super.close();
  }
}
