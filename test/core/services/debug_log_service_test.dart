import 'package:flutter_test/flutter_test.dart';
import 'package:face_check_in_flutter/core/services/debug_log_service.dart';

void main() {
  late DebugLogService debugLogService;
  const maxMessages = 200; // Match the value in DebugLogService

  setUp(() {
    debugLogService = DebugLogService();
  });

  tearDown(() {
    debugLogService.clear();
  });

  test('DebugLogService is singleton', () {
    final instance1 = DebugLogService();
    final instance2 = DebugLogService();
    expect(instance1, equals(instance2));
  });

  test('DebugLogService formats messages correctly', () async {
    final messages = <List<String>>[];
    final subscription = debugLogService.debugStream.listen(messages.add);

    debugLogService.logDebug('Test debug message');
    debugLogService.logInfo('Test info message');
    debugLogService.logWarning('Test warning message');
    debugLogService.logError('Test error message');

    // Wait for stream to process messages
    await Future.delayed(const Duration(milliseconds: 100));

    expect(messages.length, 4);
    expect(
      messages[0].last,
      matches(
        r'\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]\[DEBUG\] Test debug message',
      ),
    );
    expect(
      messages[1].last,
      matches(
        r'\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]\[INFO\] Test info message',
      ),
    );
    expect(
      messages[2].last,
      matches(
        r'\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]\[WARNING\] Test warning message',
      ),
    );
    expect(
      messages[3].last,
      matches(
        r'\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]\[ERROR\] Test error message',
      ),
    );

    await subscription.cancel();
  });

  test('DebugLogService respects message limit', () async {
    final messages = <List<String>>[];
    final subscription = debugLogService.debugStream.listen(messages.add);

    // Add more messages than the limit
    for (var i = 0; i < maxMessages + 10; i++) {
      debugLogService.logInfo('Message $i');
    }

    // Wait for stream to process messages
    await Future.delayed(const Duration(milliseconds: 100));

    expect(messages.last.length, maxMessages);
    expect(
      messages.last.last,
      matches(r'\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]\[INFO\] Message \d+'),
    );

    await subscription.cancel();
  });

  test('DebugLogService clear removes all messages', () async {
    final messages = <List<String>>[];
    final subscription = debugLogService.debugStream.listen(messages.add);

    debugLogService.logInfo('Test message 1');
    debugLogService.logInfo('Test message 2');

    // Wait for stream to process messages
    await Future.delayed(const Duration(milliseconds: 100));
    expect(messages.length, 2);

    debugLogService.clear();
    // Wait for stream to process clear
    await Future.delayed(const Duration(milliseconds: 100));
    expect(messages.last.length, 0);

    await subscription.cancel();
  });
}
