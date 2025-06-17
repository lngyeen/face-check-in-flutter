import 'package:flutter/material.dart';
import '../../../core/config/debug_config.dart';
import '../../../core/services/debug_log_service.dart';

/// A widget that displays debug messages in a scrollable view
class DebugViewWidget extends StatefulWidget {
  const DebugViewWidget({super.key});

  @override
  State<DebugViewWidget> createState() => _DebugViewWidgetState();
}

class _DebugViewWidgetState extends State<DebugViewWidget> {
  final _scrollController = ScrollController();
  final _debugLogService = DebugLogService();
  bool _isVisible = DebugConfig.showDebugViewByDefault;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!DebugConfig.isDebugViewEnabled) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (DebugConfig.isDebugToggleEnabled)
          GestureDetector(
            onTap: () => setState(() => _isVisible = !_isVisible),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  const Text(
                    'Debug View',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        if (_isVisible)
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              border: Border.all(color: Colors.grey),
            ),
            child: StreamBuilder<List<String>>(
              stream: _debugLogService.debugStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _scrollToBottom(),
                  );
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Text(
                        snapshot.data![index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
      ],
    );
  }
}
