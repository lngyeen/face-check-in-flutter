import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import '../config/websocket_config.dart';
import '../config/debug_config.dart';
import '../../features/check_in/bloc/check_in_bloc.dart';

// Add a type definition for the connector function for clarity and ease of use.
typedef WebSocketConnector = WebSocketChannel Function(Uri uri);

/// Enhanced WebSocket service for Story 2.1
/// Handles connection, reconnection, and message exchange with face recognition backend
/// Supports timeout, retrying, and configuration management
@singleton
class WebSocketService {
  WebSocketChannel? _channel;
  WebSocketConfig _config = WebSocketConfig.current;
  bool _isConnected = false;
  int _retryCount = 0;
  bool _isDisposed = false;
  Timer? _timeoutTimer;
  Timer? _retryTimer;
  Timer? _heartbeatTimer;

  // Enhanced connection status tracking for Story 2.1
  ConnectionStatus _currentStatus = ConnectionStatus.disconnected;
  DateTime? _lastConnectionAttempt;
  String? _lastError;

  // Stream controllers for enhanced status tracking
  final StreamController<ConnectionStatus> _connectionStatusController =
      StreamController<ConnectionStatus>.broadcast();
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<ConnectionMetrics> _metricsController =
      StreamController<ConnectionMetrics>.broadcast();

  // Expose a way to override the connector for testing purposes.
  @visibleForTesting
  WebSocketConnector connector = _createWebSocketChannel;

  /// Create WebSocket channel with SSL certificate handling
  static WebSocketChannel _createWebSocketChannel(Uri uri) {
    if (kDebugMode && uri.scheme == 'wss') {
      // In debug mode, allow self-signed certificates for testing
      debugPrint(
        '🔒 WebSocketService: Creating WSS connection with relaxed SSL for debug',
      );
      return IOWebSocketChannel.connect(
        uri,
        customClient:
            HttpClient()..badCertificateCallback = (cert, host, port) => true,
      );
    }
    return WebSocketChannel.connect(uri);
  }

  /// Constructor with debug logging
  WebSocketService() {
    debugPrint(
      '🔥 WebSocketService: Constructor called - instance: ${hashCode}',
    );
    debugPrint('🔥 WebSocketService: Stream controllers initialized');
  }

  /// Stream of enhanced connection status changes
  Stream<ConnectionStatus> get connectionStatus =>
      _connectionStatusController.stream;

  /// Stream of incoming messages from backend
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  /// Stream of connection metrics
  Stream<ConnectionMetrics> get metrics => _metricsController.stream;

  /// Current connection status
  ConnectionStatus get currentStatus => _currentStatus;

  /// Whether currently connected
  bool get isConnected => _isConnected;

  /// Current WebSocket configuration
  WebSocketConfig get config => _config;

  /// Last connection attempt timestamp
  DateTime? get lastConnectionAttempt => _lastConnectionAttempt;

  /// Last error message
  String? get lastError => _lastError;

  /// Update WebSocket configuration
  void updateConfig(WebSocketConfig newConfig) {
    _config = newConfig;
    if (_config.enableLogging) {
      debugPrint(
        '🔧 WebSocketService: Configuration updated - ${_config.toString()}',
      );
    }
  }

  /// Test WebSocket connection without establishing persistent connection
  Future<bool> testConnection({String? testUrl}) async {
    final urlToTest = testUrl ?? _config.fullUrl;
    if (_config.enableLogging) {
      debugPrint('🧪 WebSocketService: Testing connection to $urlToTest');
    }

    try {
      final testChannel = WebSocketChannel.connect(Uri.parse(urlToTest));
      await testChannel.ready.timeout(_config.timeout);

      // Send test message
      testChannel.sink.add('{"type": "test", "message": "connection_test"}');
      await Future.delayed(const Duration(milliseconds: 500));
      await testChannel.sink.close();

      if (_config.enableLogging) {
        debugPrint('✅ WebSocketService: Connection test successful');
      }
      return true;
    } catch (e) {
      if (_config.enableLogging) {
        debugPrint('❌ WebSocketService: Connection test failed: $e');
      }
      return false;
    }
  }

  /// Test real WebSocket server connection (for debugging)
  Future<void> testRealServerConnection() async {
    if (_config.enableLogging) {
      debugPrint(
        '🌐 WebSocketService: Testing real server connection to ${_config.fullUrl}',
      );
    }

    try {
      final testChannel = WebSocketChannel.connect(Uri.parse(_config.fullUrl));
      await testChannel.ready.timeout(_config.timeout);

      if (_config.enableLogging) {
        debugPrint('✅ WebSocketService: Real server connection successful');
      }

      // Send test frame
      final testFrame = {
        'type': 'frame',
        'data': 'test_image_data',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      testChannel.sink.add(jsonEncode(testFrame));

      // Listen for response for 10 seconds
      final responseCompleter = Completer<void>();
      late StreamSubscription subscription;

      subscription = testChannel.stream.listen(
        (message) {
          if (_config.enableLogging) {
            debugPrint('📥 WebSocketService: Real server response: $message');
          }
          subscription.cancel();
          if (!responseCompleter.isCompleted) {
            responseCompleter.complete();
          }
        },
        onError: (error) {
          if (_config.enableLogging) {
            debugPrint('❌ WebSocketService: Real server error: $error');
          }
          subscription.cancel();
          if (!responseCompleter.isCompleted) {
            responseCompleter.completeError(error);
          }
        },
      );

      // Wait for response with timeout
      await responseCompleter.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          subscription.cancel();
          if (_config.enableLogging) {
            debugPrint('⏰ WebSocketService: Real server response timeout');
          }
        },
      );

      await testChannel.sink.close();
    } catch (e) {
      if (_config.enableLogging) {
        debugPrint('❌ WebSocketService: Real server test failed: $e');
      }
    }
  }

  /// Test if server responds to ping messages
  Future<bool> testServerResponse() async {
    if (!_isConnected) {
      debugPrint('❌ WebSocketService: Cannot test server - not connected');
      return false;
    }

    debugPrint('🧪 WebSocketService: Testing server response with ping...');

    final pingId = DateTime.now().millisecondsSinceEpoch;
    bool responseReceived = false;

    // Listen for any response for 10 seconds
    late StreamSubscription testSubscription;
    final completer = Completer<bool>();

    testSubscription = _messageController.stream.listen((message) {
      debugPrint(
        '🧪 WebSocketService: Response received during ping test: $message',
      );
      responseReceived = true;
      testSubscription.cancel();
      if (!completer.isCompleted) completer.complete(true);
    });

    // Send ping
    final pingSuccess = sendMessage({
      'type': 'ping',
      'id': pingId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    if (!pingSuccess) {
      testSubscription.cancel();
      if (!completer.isCompleted) completer.complete(false);
      return false;
    }

    // Wait for response or timeout
    Timer(const Duration(seconds: 10), () {
      testSubscription.cancel();
      if (!responseReceived && !completer.isCompleted) {
        debugPrint(
          '⏰ WebSocketService: Server ping test timeout - no response',
        );
        completer.complete(false);
      }
    });

    return completer.future;
  }

  /// Test server with different message formats
  void runServerTests() {
    debugPrint('🧪 WebSocketService: Starting server format tests...');
    testServerFormats();
  }

  /// Test server responsiveness with simple message formats
  void testServerFormats() {
    if (!_isConnected || _channel == null) {
      debugPrint('❌ WebSocketService: Cannot test - not connected');
      return;
    }

    // Test different message formats
    final testMessages = [
      'hello',
      '{"message": "test"}',
      '{"type": "test"}',
      '{"type": "ping"}',
      '{"action": "face_detection", "data": "test"}',
    ];

    for (int i = 0; i < testMessages.length; i++) {
      Future.delayed(Duration(seconds: i * 2), () {
        if (_isConnected && _channel != null) {
          _channel!.sink.add(testMessages[i]);
          debugPrint('🧪 TEST MESSAGE ${i + 1}: ${testMessages[i]}');
        }
      });
    }
  }

  /// Enhanced connect method with full Story 2.1 support
  Future<bool> connect({String? customUrl}) async {
    if (_isConnected) {
      if (_config.enableLogging) {
        debugPrint('⚠️ WebSocketService: Already connected');
      }
      return true;
    }

    if (_isDisposed) {
      if (_config.enableLogging) {
        debugPrint('⚠️ WebSocketService: Cannot connect, service is disposed');
      }
      return false;
    }

    final urlToConnect = customUrl ?? _config.fullUrl;
    _lastConnectionAttempt = DateTime.now();
    _updateStatus(ConnectionStatus.connecting);

    if (_config.enableLogging) {
      debugPrint(
        '🌐 WebSocketService: Connecting to $urlToConnect (attempt ${_retryCount + 1})',
      );
    }

    try {
      debugPrint('🔍 WebSocketService: Parsing URL: $urlToConnect');
      final uri = Uri.parse(urlToConnect);
      debugPrint(
        '🔍 WebSocketService: Parsed URI - scheme: ${uri.scheme}, host: ${uri.host}, port: ${uri.port}',
      );

      // Setup timeout timer
      _timeoutTimer = Timer(_config.timeout, () {
        if (!_isConnected) {
          debugPrint(
            '⏰ WebSocketService: Connection timeout after ${_config.timeout.inSeconds}s',
          );
          _handleTimeout();
        }
      });

      debugPrint('🔍 WebSocketService: Creating WebSocket channel...');
      _channel = connector(uri);
      debugPrint(
        '🔍 WebSocketService: Channel created, waiting for ready state...',
      );

      await _channel!.ready.timeout(_config.timeout);

      // Connection successful
      _isConnected = true;
      _retryCount = 0;
      _lastError = null;
      _updateStatus(ConnectionStatus.connected);
      _timeoutTimer?.cancel();

      // Setup heartbeat if enabled
      if (_config.enableHeartbeat) {
        _startHeartbeat();
      }

      // Listen for incoming messages
      _channel!.stream.listen(
        (message) {
          final messageStr = message.toString();
          debugPrint(
            '🔥 WebSocketService: RAW MESSAGE RECEIVED (${messageStr.length} chars): ${messageStr.substring(0, messageStr.length > 300 ? 300 : messageStr.length)}...',
          );

          // Try to detect message type
          try {
            final parsed = jsonDecode(messageStr);
            debugPrint(
              '🔍 WebSocketService: Message type detected: ${parsed['type'] ?? parsed['action'] ?? 'unknown'}',
            );
          } catch (e) {
            debugPrint(
              '🔍 WebSocketService: Non-JSON message or parsing error: $e',
            );
          }

          _handleMessage(message);
        },
        onError: (error) {
          debugPrint('🔥 WebSocketService: STREAM ERROR: $error');
          _handleError(error);
        },
        onDone: () {
          debugPrint(
            '🔥 WebSocketService: STREAM DONE (connection closed by server)',
          );
          _handleDisconnection();
        },
      );

      if (_config.enableLogging) {
        debugPrint('✅ WebSocketService: Connected successfully');
      }

      _updateMetrics();
      return true;
    } catch (e) {
      _timeoutTimer?.cancel();
      _lastError = e.toString();

      if (_config.enableLogging) {
        debugPrint('❌ WebSocketService: Connection failed: $e');
      }

      _isConnected = false;
      _updateStatus(ConnectionStatus.failed);

      // Attempt retry if enabled and within retry limit
      if (_config.enableAutoReconnect && _retryCount < _config.maxRetries) {
        _scheduleRetry();
      }

      _updateMetrics();
      return false;
    }
  }

  /// Handle connection timeout
  void _handleTimeout() {
    if (_config.enableLogging) {
      debugPrint('⏰ WebSocketService: Connection timeout occurred');
    }

    _lastError =
        'Connection timeout after ${_config.timeout.inSeconds} seconds';
    _isConnected = false;
    _updateStatus(ConnectionStatus.timeout);

    // Cancel connection attempt
    _channel?.sink.close();
    _channel = null;

    // Attempt retry if enabled
    if (_config.enableAutoReconnect && _retryCount < _config.maxRetries) {
      _scheduleRetry();
    }

    _updateMetrics();
  }

  /// Schedule retry with exponential backoff
  void _scheduleRetry() {
    _retryCount++;
    final delay = _config.getRetryDelay(_retryCount);

    if (_config.enableLogging) {
      debugPrint(
        '🔄 WebSocketService: Scheduling retry $_retryCount/${_config.maxRetries} in ${delay.inSeconds}s',
      );
    }

    _updateStatus(ConnectionStatus.retrying);

    _retryTimer = Timer(delay, () {
      if (!_isDisposed && !_isConnected) {
        connect();
      }
    });
  }

  /// Enhanced disconnect method
  Future<void> disconnect() async {
    if (!_isConnected) {
      if (_config.enableLogging) {
        debugPrint('⚠️ WebSocketService: Already disconnected');
      }
      return;
    }

    if (_config.enableLogging) {
      debugPrint('🌐 WebSocketService: Disconnecting...');
    }

    _cleanup();
    _updateStatus(ConnectionStatus.disconnected);

    if (_config.enableLogging) {
      debugPrint('✅ WebSocketService: Disconnected');
    }

    _updateMetrics();
  }

  /// Cleanup all resources
  void _cleanup() {
    _isConnected = false;
    _retryCount = 0;
    _lastError = null;

    _timeoutTimer?.cancel();
    _retryTimer?.cancel();
    _heartbeatTimer?.cancel();

    _timeoutTimer = null;
    _retryTimer = null;
    _heartbeatTimer = null;

    try {
      _channel?.sink.close();
    } catch (e) {
      if (_config.enableLogging) {
        debugPrint('⚠️ WebSocketService: Error during cleanup: $e');
      }
    }

    _channel = null;
  }

  /// Start heartbeat timer
  void _startHeartbeat() {
    _heartbeatTimer = Timer.periodic(_config.heartbeatInterval, (timer) {
      if (_isConnected && !_isDisposed) {
        sendMessage({
          'type': 'ping',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      }
    });
  }

  /// Enhanced message sending with error handling
  /// Supports both Map<String, dynamic> and String messages
  bool sendMessage(dynamic message) {
    if (!_isConnected || _channel == null) {
      if (_config.enableLogging) {
        debugPrint('❌ WebSocketService: Cannot send message - not connected');
      }
      return false;
    }

    try {
      late String messageToSend;
      late String messageType;

      if (message is Map<String, dynamic>) {
        messageToSend = jsonEncode(message);
        messageType = message['type']?.toString() ?? 'unknown';
      } else if (message is String) {
        messageToSend = message;
        messageType = 'raw_string';
      } else {
        messageToSend = message.toString();
        messageType = 'converted_string';
      }

      _channel!.sink.add(messageToSend);

      if (_config.enableLogging) {
        debugPrint('📤 WebSocketService: Message sent: $messageType');
      }
      return true;
    } catch (e) {
      if (_config.enableLogging) {
        debugPrint('❌ WebSocketService: Failed to send message: $e');
      }
      return false;
    }
  }

  /// Send base64 encoded image frame to backend
  bool sendImageFrame(String base64Image) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    if (!_isConnected || _channel == null) {
      debugPrint('❌ WebSocketService: Cannot send frame - not connected');
      return false;
    }

    try {
      // Enhanced Debug: Check base64 content safely
      try {
        final sample =
            base64Image.length > 50
                ? base64Image.substring(0, 50)
                : base64Image;
        debugPrint(
          '🔍 WebSocketService: Base64 length: ${base64Image.length} chars',
        );
        debugPrint('🔍 WebSocketService: Base64 sample: ${sample}...');

        // Validate base64 format and estimate image size
        if (base64Image.isEmpty) {
          debugPrint('❌ WebSocketService: Base64 image is empty');
          return false;
        }

        // Estimate image size (base64 is ~4/3 times larger than original)
        final estimatedImageBytes = (base64Image.length * 3) ~/ 4;
        debugPrint(
          '📏 WebSocketService: Estimated image size: ${estimatedImageBytes} bytes (${(estimatedImageBytes / 1024).toStringAsFixed(1)} KB)',
        );

        // Basic JPEG/PNG base64 validation
        if (base64Image.startsWith('/9j/')) {
          debugPrint('✅ WebSocketService: Valid JPEG base64 detected');
        } else if (base64Image.startsWith('iVBOR')) {
          debugPrint('✅ WebSocketService: Valid PNG base64 detected');
        } else {
          debugPrint('⚠️ WebSocketService: Unknown image format detected');
          debugPrint(
            '🔍 WebSocketService: First 20 chars: ${base64Image.substring(0, base64Image.length > 20 ? 20 : base64Image.length)}',
          );
        }

        // Check if base64 is well-formed
        if (base64Image.length % 4 == 0) {
          debugPrint('✅ WebSocketService: Base64 padding is correct');
        } else {
          debugPrint('⚠️ WebSocketService: Base64 padding may be incorrect');
        }
      } catch (e) {
        debugPrint('⚠️ WebSocketService: Base64 validation error: $e');
      }

      // Use EXACT format from API documentation
      final frameMessage = {
        'type': 'processFrame',
        'image': base64Image,
        'timestamp': timestamp,
        'cameraId': 'mobile_camera_1',
      };

      bool success = sendMessage(frameMessage);

      if (success) {
        debugPrint('📤 WebSocketService: Message sent: processFrame');
        debugPrint(
          '🔍 WebSocketService: Full message keys: ${frameMessage.keys.toList()}',
        );
        debugPrint(
          '📡 WebSocketService: Frame sent at $timestamp - waiting for response...',
        );
        debugPrint(
          '🔥 WebSocketService: Expected server response format: {"type":"frameResult","data":{"faces":[...]}}',
        );
      } else {
        debugPrint('❌ WebSocketService: Failed to send frame message');
      }

      return success;
    } catch (e) {
      debugPrint('❌ WebSocketService: Error sending frame: $e');
      return false;
    }
  }

  /// Generate mock face detection response for testing
  void _generateMockResponse() {
    debugPrint('🧪 WebSocketService: Generating mock response...');

    // Simulate backend processing delay
    Timer(const Duration(milliseconds: 500), () {
      if (!_isDisposed && _isConnected) {
        debugPrint(
          '🧪 WebSocketService: Mock timer triggered, generating response',
        );

        // Generate different scenarios randomly
        final scenarios = [
          // Scenario 1: Face found with high confidence (API doc format)
          {
            'type': 'frameResult',
            'data': {
              'faces': [
                {
                  'faceId': 'person_001',
                  'isRecognized': true,
                  'confidence': 0.92,
                  'gender': 'male',
                  'age': 28,
                  'mask': false,
                  'bbox': [150, 120, 250, 220],
                },
              ],
              'faceImagePath':
                  'https://storage.example.com/faces/camera1-2024-03-20T10:30:00.jpg',
              'cameraId': 'camera_001',
              'timestamp': '2024-03-20T10:30:00.000Z',
              'processingTime': 250,
              'isCheckinSent': true,
            },
          },
          // Scenario 2: No face detected (API doc format)
          {
            'type': 'frameResult',
            'data': {
              'faces': [],
              'faceImagePath': '',
              'cameraId': '1',
              'timestamp': '2025-06-12T09:00:00.000Z',
              'processingTime': 1000,
              'isCheckinSent': false,
            },
          },
          // Scenario 3: Face found but not recognized
          {
            'type': 'frameResult',
            'data': {
              'frameId': 'frame_${DateTime.now().millisecondsSinceEpoch}',
              'timestamp': DateTime.now().toIso8601String(),
              'status': 'face_found',
              'faces': [
                {
                  'faceId': 'face_002',
                  'box': [0.25, 0.15, 0.5, 0.7],
                  'confidence': 0.85,
                  'isRecognized': false,
                  'personId': null,
                  'employeeName': null,
                },
              ],
              'processingTime': 52,
              'originalSize': 115000,
              'processedSize': 17000,
            },
          },
          // Scenario 4: Multiple faces
          {
            'type': 'frameResult',
            'data': {
              'frameId': 'frame_${DateTime.now().millisecondsSinceEpoch}',
              'timestamp': DateTime.now().toIso8601String(),
              'status': 'multiple_faces',
              'faces': [
                {
                  'faceId': 'face_003',
                  'box': [0.2, 0.1, 0.3, 0.5],
                  'confidence': 0.88,
                  'isRecognized': false,
                  'personId': null,
                  'employeeName': null,
                },
                {
                  'faceId': 'face_004',
                  'box': [0.6, 0.2, 0.3, 0.5],
                  'confidence': 0.82,
                  'isRecognized': false,
                  'personId': null,
                  'employeeName': null,
                },
              ],
              'processingTime': 67,
              'originalSize': 115000,
              'processedSize': 17000,
            },
          },
          // Scenario 5: Detecting (processing)
          {
            'type': 'frameResult',
            'data': {
              'frameId': 'frame_${DateTime.now().millisecondsSinceEpoch}',
              'timestamp': DateTime.now().toIso8601String(),
              'status': 'detecting',
              'faces': [],
              'processingTime': 25,
              'originalSize': 115000,
              'processedSize': 17000,
            },
          },
        ];

        // Randomly select a scenario (weighted towards face_found and no_face)
        final random = DateTime.now().millisecond % 100;
        final Map<String, dynamic> mockResponse;

        if (random < 40) {
          mockResponse = scenarios[0]; // 40% face found with recognition
        } else if (random < 70) {
          mockResponse = scenarios[1]; // 30% no face
        } else if (random < 85) {
          mockResponse = scenarios[2]; // 15% face found without recognition
        } else if (random < 95) {
          mockResponse = scenarios[4]; // 10% detecting
        } else {
          mockResponse = scenarios[3]; // 5% multiple faces
        }

        debugPrint(
          '🧪 WebSocketService: Mock response created: ${mockResponse['type']} - status: ${mockResponse['data']['status']}',
        );

        // Simulate receiving the response
        final jsonResponse = jsonEncode(mockResponse);
        debugPrint(
          '🧪 WebSocketService: Calling _handleMessage with mock data',
        );
        debugPrint(
          '🧪 WebSocketService: Mock response JSON: ${jsonResponse.substring(0, jsonResponse.length > 200 ? 200 : jsonResponse.length)}...',
        );
        _handleMessage(jsonResponse);
      } else {
        debugPrint(
          '🧪 WebSocketService: Mock timer triggered but service disposed or disconnected',
        );
      }
    });
  }

  /// Update connection status and notify listeners
  void _updateStatus(ConnectionStatus status) {
    if (_currentStatus != status) {
      _currentStatus = status;
      if (!_isDisposed) {
        _connectionStatusController.add(status);
      }
    }
  }

  /// Update and broadcast metrics
  void _updateMetrics() {
    if (!_isDisposed) {
      final metrics = ConnectionMetrics(
        isConnected: _isConnected,
        currentStatus: _currentStatus,
        url: _config.fullUrl,
        retryCount: _retryCount,
        maxRetries: _config.maxRetries,
        lastConnectionAttempt: _lastConnectionAttempt,
        lastError: _lastError,
        config: _config,
      );
      _metricsController.add(metrics);
    }
  }

  /// Handle incoming messages from backend
  void _handleMessage(dynamic message) {
    if (_isDisposed) return;

    debugPrint(
      '🔥 WebSocketService: _handleMessage called with: ${message.toString().substring(0, message.toString().length > 100 ? 100 : message.toString().length)}...',
    );

    try {
      final Map<String, dynamic> parsedMessage = jsonDecode(message.toString());

      if (_config.enableLogging) {
        debugPrint(
          '📥 WebSocketService: Message received: ${parsedMessage['type'] ?? 'unknown'}',
        );
      }

      debugPrint(
        '🔥 WebSocketService: About to emit message to stream controller',
      );
      debugPrint(
        '🔥 WebSocketService: Message controller has listeners: ${_messageController.hasListener}',
      );

      _messageController.add(parsedMessage);

      debugPrint('🔥 WebSocketService: Message emitted to stream successfully');
    } catch (e) {
      if (_config.enableLogging) {
        debugPrint('❌ WebSocketService: Failed to parse message: $e');
      }
    }
  }

  /// Handle WebSocket errors
  void _handleError(dynamic error) {
    if (_isDisposed) return;

    if (_config.enableLogging) {
      debugPrint('❌ WebSocketService: WebSocket error: $error');
    }

    _lastError = error.toString();
    _isConnected = false;
    _updateStatus(ConnectionStatus.failed);

    // Attempt reconnection if enabled
    if (_config.enableAutoReconnect && _retryCount < _config.maxRetries) {
      _scheduleRetry();
    }

    _updateMetrics();
  }

  /// Handle WebSocket disconnection
  void _handleDisconnection() {
    if (_isDisposed) return;

    if (_config.enableLogging) {
      debugPrint('🔴 WebSocketService: WebSocket disconnected');
    }

    _isConnected = false;
    _channel = null;
    _updateStatus(ConnectionStatus.disconnected);
    _updateMetrics();
  }

  /// Dispose of the service and clean up resources
  void dispose() {
    if (_config.enableLogging) {
      debugPrint('🔴 WebSocketService: Disposing...');
    }

    _isDisposed = true;
    _cleanup();
    _connectionStatusController.close();
    _messageController.close();
    _metricsController.close();
  }

  /// Send a test frame and wait for response (for debugging)
  Future<void> sendTestFrame() async {
    if (!_isConnected) {
      if (_config.enableLogging) {
        debugPrint(
          '❌ WebSocketService: Cannot send test frame - not connected',
        );
      }
      return;
    }

    if (_config.enableLogging) {
      debugPrint('🧪 WebSocketService: Sending test frame to server...');
    }

    final testFrame = {
      'type': 'frame',
      'data':
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==', // 1x1 pixel PNG
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    final success = sendMessage(testFrame);

    if (_config.enableLogging) {
      if (success) {
        debugPrint('✅ WebSocketService: Test frame sent successfully');
        debugPrint('⏳ WebSocketService: Waiting for server response...');
      } else {
        debugPrint('❌ WebSocketService: Failed to send test frame');
      }
    }
  }

  /// Send test message to verify server connectivity
  bool sendTestMessage() {
    if (!_isConnected || _channel == null) {
      debugPrint('❌ WebSocketService: Cannot send test - not connected');
      return false;
    }

    try {
      // Create a simple test message
      final testMessage = {
        'type': 'ping',
        'data': {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'clientId': 'flutter-test-client',
        },
      };

      final jsonMessage = json.encode(testMessage);
      _channel!.sink.add(jsonMessage);

      debugPrint('🧪 WebSocketService: Test message sent');
      return true;
    } catch (e) {
      debugPrint('❌ WebSocketService: Failed to send test message: $e');
      return false;
    }
  }
}

/// Connection metrics class for debugging and monitoring
class ConnectionMetrics {
  final bool isConnected;
  final ConnectionStatus currentStatus;
  final String url;
  final int retryCount;
  final int maxRetries;
  final DateTime? lastConnectionAttempt;
  final String? lastError;
  final WebSocketConfig config;

  const ConnectionMetrics({
    required this.isConnected,
    required this.currentStatus,
    required this.url,
    required this.retryCount,
    required this.maxRetries,
    required this.lastConnectionAttempt,
    required this.lastError,
    required this.config,
  });

  Map<String, dynamic> toMap() {
    return {
      'isConnected': isConnected,
      'currentStatus': currentStatus.name,
      'url': url,
      'retryCount': retryCount,
      'maxRetries': maxRetries,
      'lastConnectionAttempt': lastConnectionAttempt?.toIso8601String(),
      'lastError': lastError,
      'config': config.toMap(),
    };
  }

  @override
  String toString() {
    return 'ConnectionMetrics(status: ${currentStatus.name}, connected: $isConnected, retries: $retryCount/$maxRetries)';
  }
}
