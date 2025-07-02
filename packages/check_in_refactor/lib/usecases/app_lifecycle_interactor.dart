import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'check_in_orchestrator.dart';

/// App lifecycle states
enum AppLifecycleState {
  resumed,
  paused,
  inactive,
  detached,
}

/// App lifecycle event data
class AppLifecycleEvent {
  final AppLifecycleState state;
  final DateTime timestamp;
  final String? reason;

  const AppLifecycleEvent({
    required this.state,
    required this.timestamp,
    this.reason,
  });

  factory AppLifecycleEvent.resumed([String? reason]) {
    return AppLifecycleEvent(
      state: AppLifecycleState.resumed,
      timestamp: DateTime.now(),
      reason: reason,
    );
  }

  factory AppLifecycleEvent.paused([String? reason]) {
    return AppLifecycleEvent(
      state: AppLifecycleState.paused,
      timestamp: DateTime.now(),
      reason: reason,
    );
  }

  factory AppLifecycleEvent.inactive([String? reason]) {
    return AppLifecycleEvent(
      state: AppLifecycleState.inactive,
      timestamp: DateTime.now(),
      reason: reason,
    );
  }

  factory AppLifecycleEvent.detached([String? reason]) {
    return AppLifecycleEvent(
      state: AppLifecycleState.detached,
      timestamp: DateTime.now(),
      reason: reason,
    );
  }
}

/// Handles app lifecycle events and resource management
///
/// Manages camera lifecycle based on app state, handles automatic
/// cleanup when app goes to background, and restores state when resuming.
@injectable
class AppLifecycleInteractor {
  final CheckInOrchestrator _orchestrator;

  final _lifecycleSubject = PublishSubject<AppLifecycleEvent>();

  AppLifecycleState _currentState = AppLifecycleState.resumed;
  bool _wasInitializedBeforePause = false;
  bool _wasStreamingBeforePause = false;
  bool _autoManageResources = true;

  StreamSubscription? _inactivitySubscription;
  Timer? _inactivityTimer;

  // Configurable timeouts
  Duration _inactivityTimeout = const Duration(minutes: 5);
  Duration _backgroundResourceCleanupDelay = const Duration(seconds: 2);

  /// Stream of lifecycle events
  Stream<AppLifecycleEvent> get lifecycleStream => _lifecycleSubject.stream;

  /// Current app lifecycle state
  AppLifecycleState get currentState => _currentState;

  /// Whether automatic resource management is enabled
  bool get autoManageResources => _autoManageResources;
  set autoManageResources(bool enabled) => _autoManageResources = enabled;

  /// Inactivity timeout duration
  Duration get inactivityTimeout => _inactivityTimeout;
  set inactivityTimeout(Duration timeout) {
    _inactivityTimeout = timeout;
    _setupInactivityMonitoring();
  }

  AppLifecycleInteractor(this._orchestrator) {
    _setupInactivityMonitoring();
  }

  /// Setup inactivity monitoring
  void _setupInactivityMonitoring() {
    _inactivitySubscription?.cancel();
    _inactivityTimer?.cancel();

    // Monitor orchestrator state for activity
    _inactivitySubscription = _orchestrator.stateStream
        .where((state) => state.isActive)
        .listen((_) => _resetInactivityTimer());
  }

  /// Reset inactivity timer
  void _resetInactivityTimer() {
    _inactivityTimer?.cancel();

    if (_currentState == AppLifecycleState.resumed && _autoManageResources) {
      _inactivityTimer = Timer(_inactivityTimeout, () {
        _handleInactivity();
      });
    }
  }

  /// Handle app becoming inactive due to no user activity
  void _handleInactivity() {
    if (_currentState == AppLifecycleState.resumed) {
      _lifecycleSubject.add(AppLifecycleEvent.inactive('User inactivity'));
      _handleInactiveState();
    }
  }

  /// Handle app resumed lifecycle event
  Future<void> handleAppResumed() async {
    if (_currentState == AppLifecycleState.resumed) return;

    _currentState = AppLifecycleState.resumed;
    _lifecycleSubject.add(AppLifecycleEvent.resumed());

    if (_autoManageResources) {
      await _restoreResourcesAfterResume();
    }

    _resetInactivityTimer();
  }

  /// Handle app paused lifecycle event
  Future<void> handleAppPaused() async {
    if (_currentState == AppLifecycleState.paused) return;

    _currentState = AppLifecycleState.paused;
    _lifecycleSubject.add(AppLifecycleEvent.paused());

    if (_autoManageResources) {
      await _saveStateAndCleanupResources();
    }

    _inactivityTimer?.cancel();
  }

  /// Handle app inactive state
  void handleAppInactive() {
    if (_currentState == AppLifecycleState.inactive) return;

    _currentState = AppLifecycleState.inactive;
    _lifecycleSubject.add(AppLifecycleEvent.inactive());

    _handleInactiveState();
  }

  /// Handle app detached lifecycle event
  Future<void> handleAppDetached() async {
    _currentState = AppLifecycleState.detached;
    _lifecycleSubject.add(AppLifecycleEvent.detached());

    await _cleanupAllResources();
    _inactivityTimer?.cancel();
  }

  /// Handle inactive state logic
  void _handleInactiveState() {
    if (_autoManageResources) {
      // Reduce resource usage during inactive state
      final currentState = _orchestrator.currentState;
      if (currentState.streamingState.isStreaming) {
        // Reduce FPS during inactivity
        _orchestrator.setStreamingFps(1);
      }
    }
  }

  /// Save current state and cleanup resources when going to background
  Future<void> _saveStateAndCleanupResources() async {
    final currentState = _orchestrator.currentState;

    // Remember what was running before pause
    _wasInitializedBeforePause = currentState.cameraState.isReady;
    _wasStreamingBeforePause = currentState.streamingState.isStreaming;

    // Add delay to allow for quick app switches
    await Future.delayed(_backgroundResourceCleanupDelay);

    // Only cleanup if still in paused state (user didn't quickly return)
    if (_currentState == AppLifecycleState.paused) {
      await _orchestrator.stopCamera();
    }
  }

  /// Restore resources after app resume
  Future<void> _restoreResourcesAfterResume() async {
    // Only restore if resources were active before pause
    if (_wasInitializedBeforePause) {
      await _orchestrator.initialize();

      // Restore FPS to normal if it was reduced
      if (_wasStreamingBeforePause) {
        _orchestrator.setStreamingFps(2); // Default FPS
      }
    }

    // Reset state tracking
    _wasInitializedBeforePause = false;
    _wasStreamingBeforePause = false;
  }

  /// Cleanup all resources (for app termination)
  Future<void> _cleanupAllResources() async {
    await _orchestrator.stopCamera();
    _orchestrator.clearErrors();
  }

  /// Manually trigger resource cleanup
  Future<void> forceCleanup() async {
    await _cleanupAllResources();
  }

  /// Manually trigger resource restoration
  Future<void> forceRestore() async {
    await _orchestrator.initialize();
  }

  /// Check if system should be active based on current state
  bool get shouldBeActive {
    switch (_currentState) {
      case AppLifecycleState.resumed:
        return true;
      case AppLifecycleState.paused:
        return false;
      case AppLifecycleState.inactive:
        return false; // Reduced activity
      case AppLifecycleState.detached:
        return false;
    }
  }

  /// Get resource management status
  Map<String, dynamic> getResourceStatus() {
    return {
      'currentState': _currentState.toString(),
      'autoManageResources': _autoManageResources,
      'inactivityTimeout': _inactivityTimeout.inMinutes,
      'wasInitializedBeforePause': _wasInitializedBeforePause,
      'wasStreamingBeforePause': _wasStreamingBeforePause,
      'shouldBeActive': shouldBeActive,
      'hasInactivityTimer': _inactivityTimer?.isActive ?? false,
    };
  }

  /// Reset all lifecycle tracking state
  void reset() {
    _wasInitializedBeforePause = false;
    _wasStreamingBeforePause = false;
    _inactivityTimer?.cancel();
    _resetInactivityTimer();
  }

  /// Dispose resources and cleanup
  void dispose() {
    _inactivitySubscription?.cancel();
    _inactivityTimer?.cancel();
    _lifecycleSubject.close();
  }
}
