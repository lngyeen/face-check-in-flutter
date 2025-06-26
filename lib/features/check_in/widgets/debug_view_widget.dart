import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/config/debug_config.dart';
import '../../../core/services/debug_log_service.dart';
import '../../../core/services/websocket_service.dart';
import '../../../core/di/di.dart';
import '../bloc/check_in_bloc.dart';

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

  void _testServerConnection() async {
    final webSocketService = getIt<WebSocketService>();
    await webSocketService.testRealServerConnection();
  }

  void _toggleMockMode() {
    setState(() {
      DebugConfig.useMockWebSocketResponses =
          !DebugConfig.useMockWebSocketResponses;
    });
  }

  void _sendTestFrame() async {
    final webSocketService = getIt<WebSocketService>();
    await webSocketService.sendTestFrame();
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
              maxHeight: MediaQuery.of(context).size.height * 0.25,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                // Debug control buttons
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _testServerConnection(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(80, 30),
                        ),
                        child: const Text('Test Server'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _sendTestFrame(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(80, 30),
                        ),
                        child: const Text('Ping Server'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _toggleMockMode(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              DebugConfig.useMockWebSocketResponses
                                  ? Colors.orange
                                  : Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(80, 30),
                        ),
                        child: Text(
                          DebugConfig.useMockWebSocketResponses
                              ? 'Mock ON'
                              : 'Real Server',
                        ),
                      ),
                    ],
                  ),
                ),

                // System Status section
                BlocBuilder<CheckInBloc, CheckInState>(
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'System Status',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildStatusRow(
                            'Camera',
                            state.cameraStatus.displayText,
                            state.cameraStatus.displayColor,
                          ),
                          const SizedBox(height: 4),
                          _buildStatusRow(
                            'Connection',
                            state.connectionStatus.displayText,
                            state.connectionStatus.displayColor,
                          ),
                          const SizedBox(height: 4),
                          _buildStatusRow(
                            'Streaming',
                            state.streamingStatus.displayText,
                            state.streamingStatus.displayColor,
                          ),
                          const SizedBox(height: 4),
                          _buildStatusRow(
                            'Mock Mode',
                            DebugConfig.useMockWebSocketResponses
                                ? 'ON'
                                : 'OFF',
                            DebugConfig.useMockWebSocketResponses
                                ? Colors.orange
                                : Colors.green,
                          ),
                          if (state.notificationMessage != null) ...[
                            const SizedBox(height: 4),
                            _buildStatusRow(
                              'Last Notification',
                              state.notificationMessage!.length > 30
                                  ? '${state.notificationMessage!.substring(0, 30)}...'
                                  : state.notificationMessage!,
                              Colors.cyan,
                            ),
                          ],
                          const SizedBox(height: 4),
                          _buildStatusRow(
                            'Frames Processed',
                            '${state.framesProcessed}',
                            Colors.lightBlue,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Debug log stream
                Expanded(
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
            ),
          ),
      ],
    );
  }

  /// Helper method to build status rows for debug view
  Widget _buildStatusRow(String label, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withAlpha(70)),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
