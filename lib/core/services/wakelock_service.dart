import 'package:injectable/injectable.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Service for managing screen wake lock to prevent device from sleeping
@singleton
class WakelockService {
  bool _isEnabled = false;

  /// Enable wake lock to keep screen on
  Future<void> enable() async {
    try {
      await WakelockPlus.enable();
      _isEnabled = true;
    } catch (e) {
      // Handle error silently in production
      _isEnabled = false;
    }
  }

  /// Disable wake lock to allow screen to sleep normally
  Future<void> disable() async {
    try {
      await WakelockPlus.disable();
      _isEnabled = false;
    } catch (e) {
      // Handle error silently in production
    }
  }

  /// Check if wake lock is currently enabled
  Future<bool> get isEnabled async {
    try {
      return await WakelockPlus.enabled;
    } catch (e) {
      return _isEnabled;
    }
  }

  /// Toggle wake lock state
  Future<void> toggle() async {
    final enabled = await isEnabled;
    if (enabled) {
      await disable();
    } else {
      await enable();
    }
  }
}
