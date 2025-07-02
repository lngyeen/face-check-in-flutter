import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'image_streaming_service.dart';

/// WebSocket connection status for face detection service
enum WebSocketConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
}

/// Face detection result for individual faces
class FaceDetectionResult {
  final String? faceId;
  final bool isRecognized;
  final double confidence;
  final Map<String, double> boundingBox;
  final String? name;
  final Map<String, dynamic>? metadata;

  const FaceDetectionResult({
    this.faceId,
    required this.isRecognized,
    required this.confidence,
    required this.boundingBox,
    this.name,
    this.metadata,
  });

  factory FaceDetectionResult.fromJson(Map<String, dynamic> json) {
    return FaceDetectionResult(
      faceId: json['faceId'] as String?,
      isRecognized: json['isRecognized'] as bool? ?? false,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      boundingBox: Map<String, double>.from(json['boundingBox'] ?? {}),
      name: json['name'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'faceId': faceId,
      'isRecognized': isRecognized,
      'confidence': confidence,
      'boundingBox': boundingBox,
      'name': name,
      'metadata': metadata,
    };
  }
}

/// Face detection data containing detected faces and annotated image
class FaceDetectionData {
  final List<FaceDetectionResult> faces;
  final String? annotatedImage;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  const FaceDetectionData({
    required this.faces,
    this.annotatedImage,
    required this.timestamp,
    this.metadata,
  });

  factory FaceDetectionData.fromJson(Map<String, dynamic> json) {
    final facesJson = json['faces'] as List<dynamic>? ?? [];
    final faces = facesJson
        .map((face) =>
            FaceDetectionResult.fromJson(face as Map<String, dynamic>))
        .toList();

    return FaceDetectionData(
      faces: faces,
      annotatedImage: json['annotatedImage'] as String?,
      timestamp: DateTime.now(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'faces': faces.map((face) => face.toJson()).toList(),
      'annotatedImage': annotatedImage,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }
}

/// WebSocket service interface for communication
///
/// This is a simplified interface that the FaceDetectionService depends on.
/// It should match the existing WebSocketService interface.
abstract class WebSocketService {
  Stream<dynamic> get messageStream;
  Stream<WebSocketConnectionStatus> get connectionStatusStream;
  WebSocketConnectionStatus get currentStatus;
  void sendMessage(String message);
}

/// Abstract interface for face detection services
///
/// Handles communication with face detection backend and processing results.
/// Manages WebSocket messaging and face detection data streams.
abstract class FaceDetectionService {
  /// Stream of face detection results
  Stream<FaceDetectionData> get detectionStream;

  /// Stream of WebSocket connection status
  Stream<WebSocketConnectionStatus> get connectionStatusStream;

  /// Current connection status
  WebSocketConnectionStatus get currentConnectionStatus;

  /// Process a frame for face detection
  ///
  /// Sends frame to backend for processing via WebSocket
  void processFrame(ProcessedFrame frame);

  /// Send custom message to face detection backend
  void sendCustomMessage(Map<String, dynamic> message);

  /// Dispose service and cleanup resources
  void dispose();
}

/// Implementation of FaceDetectionService
///
/// Extracted from CheckInBloc to follow Single Responsibility Principle.
/// Manages only face detection communication and data processing.
@LazySingleton(as: FaceDetectionService)
class FaceDetectionServiceImpl implements FaceDetectionService {
  final WebSocketService _webSocketService;

  final _detectionSubject = PublishSubject<FaceDetectionData>();
  final _connectionStatusSubject =
      BehaviorSubject<WebSocketConnectionStatus>.seeded(
    WebSocketConnectionStatus.disconnected,
  );

  StreamSubscription? _messageSubscription;
  StreamSubscription? _connectionStatusSubscription;

  @override
  Stream<FaceDetectionData> get detectionStream => _detectionSubject.stream;

  @override
  Stream<WebSocketConnectionStatus> get connectionStatusStream =>
      _connectionStatusSubject.stream;

  @override
  WebSocketConnectionStatus get currentConnectionStatus =>
      _connectionStatusSubject.value;

  FaceDetectionServiceImpl(this._webSocketService) {
    _listenToWebSocketMessages();
    _listenToWebSocketConnectionStatus();
  }

  /// Listen to WebSocket messages and process face detection results
  void _listenToWebSocketMessages() {
    _messageSubscription = _webSocketService.messageStream.listen(
      (dynamic data) {
        try {
          if (data is String) {
            final Map<String, dynamic> jsonData = json.decode(data);
            _processWebSocketMessage(jsonData);
          } else {
            dev.log(
              'Received non-string message: ${data.runtimeType}',
              name: 'FaceDetectionService',
            );
          }
        } catch (e, stackTrace) {
          // Proper logging for message processing errors
          dev.log(
            'Error processing WebSocket message: $e',
            name: 'FaceDetectionService',
            error: e,
            stackTrace: stackTrace,
          );
        }
      },
      onError: (error, stackTrace) {
        // Proper error handling for WebSocket stream errors
        dev.log(
          'WebSocket stream error in FaceDetectionService: $error',
          name: 'FaceDetectionService',
          error: error,
          stackTrace: stackTrace,
        );
        _connectionStatusSubject.add(WebSocketConnectionStatus.error);
      },
    );
  }

  /// Listen to WebSocket connection status changes
  void _listenToWebSocketConnectionStatus() {
    // Set initial status
    _connectionStatusSubject.add(_webSocketService.currentStatus);

    // Subscribe to ongoing status changes
    _connectionStatusSubscription =
        _webSocketService.connectionStatusStream.listen(
      (status) {
        _connectionStatusSubject.add(status);
        dev.log(
          'WebSocket connection status changed to: $status',
          name: 'FaceDetectionService',
        );
      },
      onError: (error) {
        dev.log(
          'Error monitoring WebSocket connection status: $error',
          name: 'FaceDetectionService',
          error: error,
        );
      },
    );
  }

  /// Process WebSocket message and emit face detection data
  void _processWebSocketMessage(Map<String, dynamic> jsonData) {
    try {
      // Validate basic message structure
      if (!jsonData.containsKey('type')) {
        dev.log(
          'Invalid message: missing type field',
          name: 'FaceDetectionService',
        );
        return;
      }

      final messageType = jsonData['type'] as String?;

      switch (messageType) {
        case 'faceDetectionResult':
          final resultData = jsonData['data'] as Map<String, dynamic>?;
          if (resultData != null) {
            // Validate face detection data structure
            if (_isValidFaceDetectionData(resultData)) {
              final faceDetectionData = FaceDetectionData.fromJson(resultData);
              _detectionSubject.add(faceDetectionData);
              dev.log(
                'Face detection result processed successfully',
                name: 'FaceDetectionService',
              );
            } else {
              dev.log(
                'Invalid face detection data structure',
                name: 'FaceDetectionService',
              );
            }
          } else {
            dev.log(
              'Face detection result data is null',
              name: 'FaceDetectionService',
            );
          }
          break;

        case 'connectionStatus':
          final status = jsonData['status'] as String?;
          _updateConnectionStatus(status);
          break;

        case 'error':
          final errorMessage = jsonData['message'] as String?;
          _handleError(errorMessage ?? 'Unknown error');
          break;

        default:
          dev.log(
            'Unknown message type received: $messageType',
            name: 'FaceDetectionService',
          );
          break;
      }
    } catch (e, stackTrace) {
      // Proper error handling and logging for message processing
      dev.log(
        'Error processing WebSocket message: $e',
        name: 'FaceDetectionService',
        error: e,
        stackTrace: stackTrace,
      );
      _connectionStatusSubject.add(WebSocketConnectionStatus.error);
    }
  }

  /// Validate face detection data structure
  bool _isValidFaceDetectionData(Map<String, dynamic> data) {
    // Basic validation - can be enhanced based on actual data structure
    return data.containsKey('faces') || data.containsKey('timestamp');
  }

  /// Update connection status based on message
  void _updateConnectionStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'connected':
        _connectionStatusSubject.add(WebSocketConnectionStatus.connected);
        break;
      case 'connecting':
        _connectionStatusSubject.add(WebSocketConnectionStatus.connecting);
        break;
      case 'disconnected':
        _connectionStatusSubject.add(WebSocketConnectionStatus.disconnected);
        break;
      case 'error':
        _connectionStatusSubject.add(WebSocketConnectionStatus.error);
        break;
      default:
        // Unknown status - keep current status
        break;
    }
  }

  /// Handle error messages from WebSocket
  void _handleError(String errorMessage) {
    // Proper error handling with logging
    dev.log(
      'WebSocket error received: $errorMessage',
      name: 'FaceDetectionService',
      level: 1000, // Severe level
    );
    _connectionStatusSubject.add(WebSocketConnectionStatus.error);
  }

  @override
  void processFrame(ProcessedFrame frame) {
    final currentStatus = _webSocketService.currentStatus;

    if (currentStatus != WebSocketConnectionStatus.connected) {
      dev.log(
        'Cannot process frame - WebSocket status: $currentStatus',
        name: 'FaceDetectionService',
      );
      return;
    }

    try {
      final payload = {
        'type': 'processFrame',
        'image': frame.base64Image,
        'timestamp': frame.timestamp.toIso8601String(),
        'metadata': {
          'width': frame.width,
          'height': frame.height,
        },
      };

      _webSocketService.sendMessage(json.encode(payload));
    } catch (e) {
      dev.log(
        'Error sending frame for processing: $e',
        name: 'FaceDetectionService',
        error: e,
      );
    }
  }

  @override
  void sendCustomMessage(Map<String, dynamic> message) {
    final currentStatus = _webSocketService.currentStatus;

    if (currentStatus != WebSocketConnectionStatus.connected) {
      dev.log(
        'Cannot send custom message - WebSocket status: $currentStatus',
        name: 'FaceDetectionService',
      );
      return;
    }

    try {
      _webSocketService.sendMessage(json.encode(message));
    } catch (e) {
      dev.log(
        'Error sending custom message: $e',
        name: 'FaceDetectionService',
        error: e,
      );
    }
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _connectionStatusSubscription?.cancel();
    _detectionSubject.close();
    _connectionStatusSubject.close();
  }
}
