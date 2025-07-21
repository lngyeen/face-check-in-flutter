import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/liveness_config.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';

class ThrottleManager {
  final BehaviorSubject<Duration> _throttleSubject;

  ThrottleManager()
    : _throttleSubject = BehaviorSubject<Duration>.seeded(
        ThrottleManager.fpsToDuration(ImageStreamConfig.waitingForFaceFps),
      );

  Stream<Duration> get throttleStream => _throttleSubject.stream;

  Duration get currentThrottle => _throttleSubject.value;

  void updateThrottle(ProcessingStatus status) {
    final newDuration = _getThrottleForStatus(status);
    if (_throttleSubject.value != newDuration) {
      _throttleSubject.add(newDuration);
    }
  }

  Duration _getThrottleForStatus(ProcessingStatus status) {
    return switch (status) {
      ProcessingStatus.waitingForFace => fpsToDuration(
        ImageStreamConfig.waitingForFaceFps,
      ),
      ProcessingStatus.livenessChecking => fpsToDuration(
        ImageStreamConfig.livenessCheckingFps,
      ),
      ProcessingStatus.readyForCheckIn => fpsToDuration(
        ImageStreamConfig.readyForCheckInFps,
      ),
      ProcessingStatus.completed => fpsToDuration(0), // Stop processing
      ProcessingStatus.error => fpsToDuration(
        ImageStreamConfig.waitingForFaceFps,
      ),
    };
  }

  static Duration fpsToDuration(int fps) {
    if (fps <= 0) return const Duration(milliseconds: 1000);
    return Duration(milliseconds: (1000 / fps).round());
  }

  void dispose() {
    _throttleSubject.close();
  }
}
