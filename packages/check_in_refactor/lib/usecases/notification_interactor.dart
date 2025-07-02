import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/check_in_screen_state.dart';
import '../services/face_detection_service.dart';

/// Notification types for different check-in events
enum NotificationType {
  faceDetected,
  faceRecognized,
  checkInSuccess,
  systemError,
  connectionLost,
  cameraError,
  performanceWarning,
}

/// Notification data structure
class NotificationData {
  final NotificationType type;
  final String message;
  final String? title;
  final Duration? duration;
  final Map<String, dynamic>? data;
  final DateTime timestamp;

  const NotificationData({
    required this.type,
    required this.message,
    this.title,
    this.duration,
    this.data,
    required this.timestamp,
  });

  /// Create notification for face detection
  factory NotificationData.faceDetected(int faceCount) {
    return NotificationData(
      type: NotificationType.faceDetected,
      message: faceCount == 1 ? 'Face detected' : '$faceCount faces detected',
      duration: const Duration(seconds: 2),
      timestamp: DateTime.now(),
    );
  }

  /// Create notification for face recognition
  factory NotificationData.faceRecognized(String name, double confidence) {
    return NotificationData(
      type: NotificationType.faceRecognized,
      message: 'Welcome, $name!',
      title: 'Face Recognized',
      duration: const Duration(seconds: 3),
      data: {
        'name': name,
        'confidence': confidence,
      },
      timestamp: DateTime.now(),
    );
  }

  /// Create notification for check-in success
  factory NotificationData.checkInSuccess(String name) {
    return NotificationData(
      type: NotificationType.checkInSuccess,
      message: 'Check-in successful for $name',
      title: 'Check-in Complete',
      duration: const Duration(seconds: 4),
      data: {
        'name': name,
      },
      timestamp: DateTime.now(),
    );
  }

  /// Create notification for system error
  factory NotificationData.systemError(String error) {
    return NotificationData(
      type: NotificationType.systemError,
      message: error,
      title: 'System Error',
      duration: const Duration(seconds: 5),
      timestamp: DateTime.now(),
    );
  }

  /// Create notification for connection lost
  factory NotificationData.connectionLost() {
    return NotificationData(
      type: NotificationType.connectionLost,
      message: 'Connection to face detection service lost',
      title: 'Connection Lost',
      duration: const Duration(seconds: 4),
      timestamp: DateTime.now(),
    );
  }

  /// Create notification for camera error
  factory NotificationData.cameraError(String error) {
    return NotificationData(
      type: NotificationType.cameraError,
      message: 'Camera error: $error',
      title: 'Camera Error',
      duration: const Duration(seconds: 4),
      timestamp: DateTime.now(),
    );
  }

  /// Create notification for performance warning
  factory NotificationData.performanceWarning(String warning) {
    return NotificationData(
      type: NotificationType.performanceWarning,
      message: warning,
      title: 'Performance Warning',
      duration: const Duration(seconds: 3),
      timestamp: DateTime.now(),
    );
  }
}

/// Handles notification logic for check-in events
///
/// Extracted from CheckInListeners to follow Single Responsibility Principle.
/// Manages notification triggers, filtering, and business rules.
@injectable
class NotificationInteractor {
  final _notificationSubject = PublishSubject<NotificationData>();

  StreamSubscription? _stateSubscription;
  CheckInScreenState? _previousState;

  // Notification settings
  bool _notificationsEnabled = true;
  Duration _minTimeBetweenNotifications = const Duration(milliseconds: 500);
  DateTime? _lastNotificationTime;

  /// Stream of notifications to display
  Stream<NotificationData> get notificationStream =>
      _notificationSubject.stream;

  /// Enable or disable notifications
  bool get notificationsEnabled => _notificationsEnabled;
  set notificationsEnabled(bool enabled) => _notificationsEnabled = enabled;

  /// Set minimum time between notifications to prevent spam
  void setMinTimeBetweenNotifications(Duration duration) {
    _minTimeBetweenNotifications = duration;
  }

  /// Start listening to check-in state changes
  void startListening(Stream<CheckInScreenState> stateStream) {
    _stateSubscription?.cancel();
    _stateSubscription = stateStream.listen(_handleStateChange);
  }

  /// Handle state changes and generate appropriate notifications
  void _handleStateChange(CheckInScreenState newState) {
    if (!_notificationsEnabled) return;

    // Check for face detection changes
    _checkFaceDetectionChanges(newState);

    // Check for error state changes
    _checkErrorStateChanges(newState);

    // Check for check-in completion
    _checkCheckInCompletion(newState);

    // Check for connection status changes
    _checkConnectionChanges(newState);

    // Check for performance issues
    _checkPerformanceIssues(newState);

    _previousState = newState;
  }

  /// Check for face detection related changes
  void _checkFaceDetectionChanges(CheckInScreenState newState) {
    final currentFaces = newState.faceDetectionState.detectedFaces;
    final previousFaces =
        _previousState?.faceDetectionState.detectedFaces ?? [];

    // Face detection - new faces appeared
    if (currentFaces.length > previousFaces.length) {
      _emitNotification(NotificationData.faceDetected(currentFaces.length));
    }

    // Face recognition - new recognized faces
    final currentRecognized = newState.faceDetectionState.recognizedFaces;
    final previousRecognized =
        _previousState?.faceDetectionState.recognizedFaces ?? [];

    if (currentRecognized.length > previousRecognized.length) {
      final newlyRecognized = currentRecognized
          .where((face) =>
              !previousRecognized.any((prev) => prev.faceId == face.faceId))
          .toList();

      for (final face in newlyRecognized) {
        if (face.name != null) {
          _emitNotification(
              NotificationData.faceRecognized(face.name!, face.confidence));
        }
      }
    }
  }

  /// Check for error state changes
  void _checkErrorStateChanges(CheckInScreenState newState) {
    // Camera errors
    if (newState.cameraState.hasError &&
        !(_previousState?.cameraState.hasError ?? false)) {
      _emitNotification(NotificationData.cameraError(
          newState.cameraState.errorMessage ?? 'Unknown camera error'));
    }

    // Global system errors
    if (newState.globalError != null &&
        newState.globalError != _previousState?.globalError) {
      _emitNotification(NotificationData.systemError(newState.globalError!));
    }
  }

  /// Check for check-in completion
  void _checkCheckInCompletion(CheckInScreenState newState) {
    final wasCheckingIn = _previousState?.isCheckingIn ?? false;
    final isCheckingIn = newState.isCheckingIn;

    // Check-in just completed
    if (wasCheckingIn && !isCheckingIn && newState.checkInMessage != null) {
      // Extract name from success message if possible
      final message = newState.checkInMessage!;
      if (message.contains('successful for ')) {
        final name = message.split('successful for ').last;
        _emitNotification(NotificationData.checkInSuccess(name));
      }
    }
  }

  /// Check for connection status changes
  void _checkConnectionChanges(CheckInScreenState newState) {
    final currentConnectionStatus =
        newState.faceDetectionState.connectionStatus;
    final previousConnectionStatus =
        _previousState?.faceDetectionState.connectionStatus;

    // Connection lost
    if (previousConnectionStatus == WebSocketConnectionStatus.connected &&
        currentConnectionStatus != WebSocketConnectionStatus.connected) {
      _emitNotification(NotificationData.connectionLost());
    }
  }

  /// Check for performance issues
  void _checkPerformanceIssues(CheckInScreenState newState) {
    // Low FPS warning
    if (newState.streamingState.isStreaming) {
      final actualFps = newState.streamingState.actualFps;
      final maxFps = newState.streamingState.maxFps;

      if (actualFps < maxFps * 0.5) {
        // Less than 50% of target FPS
        _emitNotification(NotificationData.performanceWarning(
            'Low frame rate: ${actualFps.toStringAsFixed(1)} FPS'));
      }
    }

    // High frame drop ratio warning
    if (newState.streamingState.frameDropRatio > 0.3) {
      // More than 30% drops
      _emitNotification(NotificationData.performanceWarning(
          'High frame drop ratio: ${(newState.streamingState.frameDropRatio * 100).toStringAsFixed(1)}%'));
    }

    // Face detection health warning
    if (!newState.faceDetectionState.isDetectionHealthy &&
        newState.faceDetectionState.isConnected) {
      _emitNotification(NotificationData.performanceWarning(
          'Face detection service may be unresponsive'));
    }
  }

  /// Emit notification with throttling
  void _emitNotification(NotificationData notification) {
    final now = DateTime.now();

    // Check if enough time has passed since last notification
    if (_lastNotificationTime != null) {
      final timeSinceLastNotification = now.difference(_lastNotificationTime!);
      if (timeSinceLastNotification < _minTimeBetweenNotifications) {
        return; // Skip this notification due to throttling
      }
    }

    _lastNotificationTime = now;
    _notificationSubject.add(notification);
  }

  /// Manually trigger a custom notification
  void triggerCustomNotification(NotificationData notification) {
    _emitNotification(notification);
  }

  /// Clear notification history and reset state
  void reset() {
    _previousState = null;
    _lastNotificationTime = null;
  }

  /// Dispose resources and cleanup
  void dispose() {
    _stateSubscription?.cancel();
    _notificationSubject.close();
  }
}
