import 'dart:convert';
import 'dart:developer' as developer;
import 'package:injectable/injectable.dart';
import '../models/face_detection_result.dart';
import '../../features/check_in/bloc/check_in_bloc.dart';

/// Exception thrown when response processing operations fail
class ResponseProcessingException implements Exception {
  const ResponseProcessingException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'ResponseProcessingException: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

/// Response message types from backend
enum ResponseMessageType { frameResult, error, heartbeat, unknown }

/// Face detection response from backend
class FaceDetectionResponse {
  const FaceDetectionResponse({
    required this.type,
    required this.faces,
    this.frameId,
    this.timestamp,
    this.confidence,
    this.processingTime,
    this.error,
  });

  final ResponseMessageType type;
  final List<FaceDetectionResult> faces;
  final String? frameId;
  final DateTime? timestamp;
  final double? confidence;
  final double? processingTime;
  final String? error;

  /// Overall confidence score (max confidence from all faces)
  double get overallConfidence {
    if (faces.isEmpty) return 0.0;
    return faces.map((face) => face.confidence).reduce((a, b) => a > b ? a : b);
  }

  /// Number of faces detected
  int get faceCount => faces.length;

  /// Whether this is a successful detection
  bool get isSuccess =>
      type == ResponseMessageType.frameResult && error == null;

  /// Whether multiple faces were detected
  bool get hasMultipleFaces => faces.length > 1;

  /// Primary face (highest confidence)
  FaceDetectionResult? get primaryFace {
    if (faces.isEmpty) return null;
    return faces.reduce((a, b) => a.confidence > b.confidence ? a : b);
  }

  factory FaceDetectionResponse.fromJson(Map<String, dynamic> json) {
    try {
      final type = _parseMessageType(json['type'] as String?);

      // Handle error responses
      if (json.containsKey('error')) {
        return FaceDetectionResponse(
          type: ResponseMessageType.error,
          faces: [],
          error: json['error'] as String?,
          frameId: json['frameId'] as String?,
          timestamp: _parseTimestamp(json['timestamp']),
        );
      }

      // Parse faces array
      final facesJson = json['faces'] as List<dynamic>? ?? [];
      final faces =
          facesJson
              .map(
                (faceJson) => FaceDetectionResult.fromJson(
                  faceJson as Map<String, dynamic>,
                ),
              )
              .toList();

      return FaceDetectionResponse(
        type: type,
        faces: faces,
        frameId: json['frameId'] as String?,
        timestamp: _parseTimestamp(json['timestamp']),
        confidence: (json['confidence'] as num?)?.toDouble(),
        processingTime: (json['processingTime'] as num?)?.toDouble(),
      );
    } catch (e) {
      throw ResponseProcessingException(
        'Failed to parse face detection response',
        e,
      );
    }
  }

  static ResponseMessageType _parseMessageType(String? type) {
    switch (type?.toLowerCase()) {
      case 'frameresult':
      case 'frame_result':
        return ResponseMessageType.frameResult;
      case 'error':
        return ResponseMessageType.error;
      case 'heartbeat':
      case 'pong':
        return ResponseMessageType.heartbeat;
      default:
        return ResponseMessageType.unknown;
    }
  }

  static DateTime? _parseTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;

    try {
      if (timestamp is String) {
        return DateTime.parse(timestamp);
      } else if (timestamp is int) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
    } catch (e) {
      developer.log(
        'Failed to parse timestamp: $timestamp',
        name: 'ResponseProcessor',
        level: 900,
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'faces': faces.map((face) => face.toJson()).toList(),
      if (frameId != null) 'frameId': frameId,
      if (timestamp != null) 'timestamp': timestamp!.toIso8601String(),
      if (confidence != null) 'confidence': confidence,
      if (processingTime != null) 'processingTime': processingTime,
      if (error != null) 'error': error,
    };
  }
}

/// Service responsible for processing WebSocket responses from backend
@injectable
class ResponseProcessor {
  /// Process incoming WebSocket message and return face detection response
  FaceDetectionResponse? processMessage(dynamic message) {
    try {
      developer.log(
        'Processing WebSocket message: ${message.runtimeType}',
        name: 'ResponseProcessor',
        level: 700,
      );

      // Handle string messages (JSON)
      if (message is String) {
        if (message.trim().isEmpty) {
          developer.log(
            'Received empty message, ignoring',
            name: 'ResponseProcessor',
            level: 700,
          );
          return null;
        }

        final json = jsonDecode(message);
        return _processJsonMessage(json);
      }

      // Handle map messages (already parsed JSON)
      if (message is Map<String, dynamic>) {
        return _processJsonMessage(message);
      }

      // Handle other message types
      developer.log(
        'Unsupported message type: ${message.runtimeType}',
        name: 'ResponseProcessor',
        level: 900,
      );

      return null;
    } catch (e, stackTrace) {
      developer.log(
        'Failed to process WebSocket message',
        name: 'ResponseProcessor',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );

      throw ResponseProcessingException('Failed to process message', e);
    }
  }

  /// Process JSON message and return appropriate response
  FaceDetectionResponse? _processJsonMessage(Map<String, dynamic> json) {
    final messageType = json['type'] as String?;

    developer.log(
      'Processing JSON message type: $messageType',
      name: 'ResponseProcessor',
      level: 700,
    );

    switch (messageType?.toLowerCase()) {
      case 'frameresult':
      case 'frame_result':
        return _processFrameResultMessage(json);

      case 'error':
        return _processErrorMessage(json);

      case 'heartbeat':
      case 'pong':
        return _processHeartbeatMessage(json);

      default:
        developer.log(
          'Unknown message type: $messageType, ignoring',
          name: 'ResponseProcessor',
          level: 900,
        );
        return null;
    }
  }

  /// Process frame result message
  FaceDetectionResponse _processFrameResultMessage(Map<String, dynamic> json) {
    try {
      final response = FaceDetectionResponse.fromJson(json);

      developer.log(
        'Frame result processed: ${response.faceCount} faces, confidence: ${response.overallConfidence.toStringAsFixed(2)}',
        name: 'ResponseProcessor',
        level: 800,
      );

      return response;
    } catch (e) {
      throw ResponseProcessingException(
        'Failed to process frame result message',
        e,
      );
    }
  }

  /// Process error message
  FaceDetectionResponse _processErrorMessage(Map<String, dynamic> json) {
    final error = json['error'] as String? ?? 'Unknown error';

    developer.log(
      'Backend error received: $error',
      name: 'ResponseProcessor',
      level: 1000,
    );

    return FaceDetectionResponse(
      type: ResponseMessageType.error,
      faces: [],
      error: error,
      frameId: json['frameId'] as String?,
      timestamp: FaceDetectionResponse._parseTimestamp(json['timestamp']),
    );
  }

  /// Process heartbeat message
  FaceDetectionResponse _processHeartbeatMessage(Map<String, dynamic> json) {
    developer.log(
      'Heartbeat received from backend',
      name: 'ResponseProcessor',
      level: 700,
    );

    return FaceDetectionResponse(
      type: ResponseMessageType.heartbeat,
      faces: [],
      timestamp: DateTime.now(),
    );
  }

  /// Validate response message structure
  bool validateMessage(dynamic message) {
    try {
      final result = processMessage(message);
      return result != null;
    } catch (e) {
      developer.log(
        'Message validation failed: $e',
        name: 'ResponseProcessor',
        level: 900,
      );
      return false;
    }
  }

  /// Extract face detection metrics from response
  Map<String, dynamic> extractMetrics(FaceDetectionResponse response) {
    return {
      'faceCount': response.faceCount,
      'confidence': response.overallConfidence,
      'processingTime': response.processingTime ?? 0.0,
      'hasMultipleFaces': response.hasMultipleFaces,
      'isSuccess': response.isSuccess,
      'timestamp': response.timestamp?.millisecondsSinceEpoch,
      'frameId': response.frameId,
    };
  }

  /// Determine face detection status from response
  FaceDetectionStatus determineFaceStatus(FaceDetectionResponse response) {
    if (!response.isSuccess) {
      return FaceDetectionStatus.error;
    }

    if (response.faces.isEmpty) {
      return FaceDetectionStatus.noFace;
    }

    if (response.faces.length == 1) {
      final confidence = response.faces.first.confidence;
      if (confidence >= 0.8) {
        return FaceDetectionStatus.faceFound;
      } else if (confidence >= 0.5) {
        return FaceDetectionStatus.detecting;
      } else {
        return FaceDetectionStatus.noFace;
      }
    }

    return FaceDetectionStatus.multipleFaces;
  }
}

/// Extension methods for FaceDetectionStatus
extension FaceDetectionStatusExtension on FaceDetectionStatus {
  String get description {
    switch (this) {
      case FaceDetectionStatus.none:
        return 'No face detection performed';
      case FaceDetectionStatus.detecting:
        return 'Detecting faces...';
      case FaceDetectionStatus.faceFound:
        return 'Face detected successfully';
      case FaceDetectionStatus.multipleFaces:
        return 'Multiple faces detected';
      case FaceDetectionStatus.noFace:
        return 'No face detected';
      case FaceDetectionStatus.error:
        return 'Face detection error';
    }
  }

  bool get isSuccess => this == FaceDetectionStatus.faceFound;
  bool get isError => this == FaceDetectionStatus.error;
  bool get needsAction =>
      this == FaceDetectionStatus.multipleFaces ||
      this == FaceDetectionStatus.noFace;
}
