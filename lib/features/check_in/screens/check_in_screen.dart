import 'package:flutter/material.dart';
import '../widgets/debug_view_container.dart';
import '../../../core/services/debug_log_service.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final _debugLogService = DebugLogService();

  @override
  void initState() {
    super.initState();
    _debugLogService.logInfo('CheckInScreen initialized');
  }

  @override
  Widget build(BuildContext context) {
    return DebugViewContainer(
      child: Scaffold(
        appBar: AppBar(title: const Text('Face Check-in')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Camera Preview will be here'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _debugLogService.logDebug('Test button pressed');
                },
                child: const Text('Test Debug Log'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
