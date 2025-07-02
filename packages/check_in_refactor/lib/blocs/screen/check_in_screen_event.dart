import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../entities/check_in_screen_state.dart';
import '../../../usecases/notification_interactor.dart';

part 'check_in_screen_event.freezed.dart';

@freezed
class CheckInScreenEvent with _$CheckInScreenEvent {
  const factory CheckInScreenEvent.start() = Start;
  const factory CheckInScreenEvent.orchestratorStateChanged(
      CheckInScreenState newState) = OrchestratorStateChanged;
  const factory CheckInScreenEvent.toggleDebugMode() = ToggleDebugMode;
  const factory CheckInScreenEvent.showNotification(NotificationData data) =
      ShowNotification;
  const factory CheckInScreenEvent.dismissNotification() = DismissNotification;
  const factory CheckInScreenEvent.toggleFullScreen() = ToggleFullScreen;
}
