import 'package:injectable/injectable.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract class WakelockService {
  Future<void> enable();

  Future<void> disable();

  Future<bool> get isEnabled;

  Future<void> toggle();
}

@LazySingleton(as: WakelockService)
class WakelockServiceImpl implements WakelockService {
  bool _isEnabled = false;

  @override
  Future<void> enable() async {
    try {
      await WakelockPlus.enable();
      _isEnabled = true;
    } catch (e) {
      // Handle error silently in production
      _isEnabled = false;
    }
  }

  @override
  Future<void> disable() async {
    try {
      await WakelockPlus.disable();
      _isEnabled = false;
    } catch (e) {
      // Handle error silently in production
    }
  }

  @override
  Future<bool> get isEnabled async {
    try {
      return await WakelockPlus.enabled;
    } catch (e) {
      return _isEnabled;
    }
  }

  @override
  Future<void> toggle() async {
    final enabled = await isEnabled;
    if (enabled) {
      await disable();
    } else {
      await enable();
    }
  }
}
