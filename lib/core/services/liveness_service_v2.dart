import 'dart:isolate';

import 'package:flutter/foundation.dart';

import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';

///* -------------------------------------------------------------------------- */
///* DATA CLASSES                                */
///* -------------------------------------------------------------------------- */

/// The result of the liveness detection process.
class LivenessResult {
  /// The current status of the detection process.
  final LivenessStatus status;

  /// `true` if the user is determined to be a live person.
  final bool isAlive;

  /// The overall confidence score (from 0.0 to 1.0).
  final double confidence;

  /// A message describing the result.
  final String message;

  /// Detailed data about the checks performed.
  final Map<String, dynamic> details;

  const LivenessResult({
    required this.status,
    required this.isAlive,
    required this.confidence,
    required this.message,
    required this.details,
  });

  /// `true` if the liveness check passed and met the confidence threshold.
  bool get isPassed =>
      isAlive && confidence >= LivenessConfig.LIVENESS_THRESHOLD;
}

/// The status of the liveness detection process.
enum LivenessStatus {
  /// More frames are needed for processing.
  needMoreFrames,

  /// Currently processing.
  processing,

  /// Liveness check passed.
  passed,

  /// Liveness check failed.
  failed,

  /// An error occurred.
  error,
}

/// Data for a single frame to be analyzed.
class LivenessFrame {
  final Face face;
  final CameraImage? image;
  final DateTime timestamp;

  const LivenessFrame({
    required this.face,
    required this.image,
    required this.timestamp,
  });
}

///* -------------------------------------------------------------------------- */
///* CONFIGURATION                              */
///* -------------------------------------------------------------------------- */

/// Configuration for the liveness detection algorithms.
class LivenessConfig {
  // Frame Buffer
  static const int MIN_FRAMES_FOR_LIVENESS = 8;
  static const int MAX_FRAMES_BUFFER = 15;

  // Confidence Threshold
  static const double LIVENESS_THRESHOLD =
      0.6; //0.75; // TODO: Change back to 0.75

  // Stability Check Threshold (formerly movement)
  static const double MAX_STABILITY_MOVEMENT = 15.0; // Max movement in pixels

  // Quality Check Thresholds
  static const double MIN_QUALITY_FRAME_RATIO =
      0.7; // 70% of frames must be good quality
  static const double MAX_HEAD_ANGLE_Y = 15.0; // Max head yaw (left/right)
  static const double MAX_HEAD_ANGLE_Z = 10.0; // Max head roll

  // Eye Check Thresholds
  static const double EYE_OPEN_PROBABILITY = 0.8;
  static const double EYE_CLOSED_PROBABILITY = 0.2;
}

///* -------------------------------------------------------------------------- */
///* PUBLIC SERVICE INTERFACE                           */
///* -------------------------------------------------------------------------- */

/// Abstract interface for liveness detection services.
abstract class LivenessServiceV2 {
  /// Process a single frame for liveness detection.
  Future<LivenessResult> processFrame(Face face, CameraImage? image);

  /// Process a batch of faces for liveness detection.
  Future<LivenessResult> processFaceList(List<Face> faces);

  /// Reset the state and frame buffer.
  void reset();

  /// Dispose of any resources.
  void dispose();
}

///* -------------------------------------------------------------------------- */
///* NON-STATIC IMPLEMENTATION (Singleton)                 */
///* -------------------------------------------------------------------------- */

/// Singleton implementation of LivenessServiceV2 for use within the main app.
@LazySingleton(as: LivenessServiceV2)
class LivenessServiceV2Impl implements LivenessServiceV2 {
  final List<LivenessFrame> _frameBuffer = [];

  @override
  Future<LivenessResult> processFrame(Face face, CameraImage? image) async {
    // Add the new frame to the buffer
    _addFrame(face, image);

    // Check if we have enough frames to proceed
    if (_frameBuffer.length < LivenessConfig.MIN_FRAMES_FOR_LIVENESS) {
      return LivenessResult(
        status: LivenessStatus.needMoreFrames,
        isAlive: false,
        confidence: 0.0,
        message:
            "Need more frames... (${_frameBuffer.length}/${LivenessConfig.MIN_FRAMES_FOR_LIVENESS})",
        details: {'framesCollected': _frameBuffer.length},
      );
    }

    // Once enough frames are collected, perform the check
    return _LivenessProcessor.performCheck(
      List<LivenessFrame>.from(_frameBuffer),
    );
  }

  @override
  Future<LivenessResult> processFaceList(List<Face> faces) async {
    // Convert faces to LivenessFrame format
    final livenessFrames =
        faces
            .map(
              (face) => LivenessFrame(
                face: face,
                image: null, // Image not needed for face-based liveness checks
                timestamp: DateTime.now(),
              ),
            )
            .toList();

    // Check if we have enough frames to proceed
    if (livenessFrames.length < LivenessConfig.MIN_FRAMES_FOR_LIVENESS) {
      return LivenessResult(
        status: LivenessStatus.needMoreFrames,
        isAlive: false,
        confidence: 0.0,
        message:
            "Need more frames... (${livenessFrames.length}/${LivenessConfig.MIN_FRAMES_FOR_LIVENESS})",
        details: {'framesCollected': livenessFrames.length},
      );
    }

    // Process the batch directly
    return _LivenessProcessor.performCheck(livenessFrames);
  }

  @override
  void reset() {
    _frameBuffer.clear();
  }

  @override
  void dispose() {
    _frameBuffer.clear();
  }

  /// Adds a frame to the buffer and maintains the buffer's size limit.
  void _addFrame(Face face, CameraImage? image) {
    _frameBuffer.add(
      LivenessFrame(face: face, image: image, timestamp: DateTime.now()),
    );
    if (_frameBuffer.length > LivenessConfig.MAX_FRAMES_BUFFER) {
      _frameBuffer.removeAt(0);
    }
  }
}

///* -------------------------------------------------------------------------- */
///* INTERNAL LIVENESS PROCESSOR                         */
///* (Shared Logic - DRY Principle)                       */
///* -------------------------------------------------------------------------- */

/// A class containing the core liveness processing logic, shared by both implementations.
class _LivenessProcessor {
  /// Performs the liveness check on a buffer of frames.
  /// This is a PURE function with no internal state, making it safe for Isolates.
  static Future<LivenessResult> performCheck(List<LivenessFrame> frames) async {
    try {
      // Perform all checks
      final blinkResult = _detectBlink(frames);
      final stabilityResult = _detectStability(frames);
      final qualityResult = _checkQuality(frames);

      // Calculate the overall confidence score
      final confidence = _calculateOverallConfidence(
        blinkResult,
        stabilityResult,
        qualityResult,
      );

      // Make a decision based on the overall confidence
      final isAlive = confidence >= LivenessConfig.LIVENESS_THRESHOLD;
      final status = isAlive ? LivenessStatus.passed : LivenessStatus.failed;
      final message = _getFinalMessage(
        isAlive,
        blinkResult,
        stabilityResult,
        qualityResult,
      );

      final details = {
        'status': isAlive ? 'passed' : 'failed',
        'overallConfidence': confidence.toStringAsFixed(2),
        'blinkCheck': blinkResult.toMap(),
        'stabilityCheck': stabilityResult.toMap(),
        'qualityCheck': qualityResult.toMap(),
      };

      if (kDebugMode) {
        print("[Liveness] Details: $details");
      }

      return LivenessResult(
        status: status,
        isAlive: isAlive,
        confidence: confidence,
        message: message,
        details: details,
      );
    } catch (e) {
      return LivenessResult(
        status: LivenessStatus.error,
        isAlive: false,
        confidence: 0.0,
        message: "Liveness processing error: ${e.toString()}",
        details: {'error': e.toString()},
      );
    }
  }

  /// Detects a blink pattern.
  static _LivenessCheckResult _detectBlink(List<LivenessFrame> frames) {
    if (frames.length < 3) {
      return const _LivenessCheckResult.failed('Need more frames');
    }

    final eyeStates = frames.map((f) => _getEyeState(f.face)).toList();

    // Look for an OPEN -> CLOSED -> OPEN sequence
    bool foundOpenStart = false;
    bool foundClosed = false;
    for (final state in eyeStates) {
      if (state == _EyeState.open && !foundClosed) foundOpenStart = true;
      if (state == _EyeState.closed && foundOpenStart) foundClosed = true;
      if (state == _EyeState.open && foundClosed) {
        return _LivenessCheckResult(
          confidence: 1.0,
          reason: 'Blink detected',
          details: {'sequence': 'open-close-open'},
        );
      }
    }

    return const _LivenessCheckResult.failed('No blink detected');
  }

  /// Checks for face stability (i.e., minimal movement).
  static _LivenessCheckResult _detectStability(List<LivenessFrame> frames) {
    if (frames.length < 2) {
      return const _LivenessCheckResult.failed('Need more frames');
    }

    final firstCenter = frames.first.face.boundingBox.center;
    final lastCenter = frames.last.face.boundingBox.center;
    final movement = (firstCenter - lastCenter).distance;

    final isStable = movement < LivenessConfig.MAX_STABILITY_MOVEMENT;

    return _LivenessCheckResult(
      confidence: isStable ? 1.0 : 0.0,
      reason: isStable ? 'Face is stable' : 'Excessive movement detected',
      details: {
        'movement': movement.toStringAsFixed(2),
        'threshold': LivenessConfig.MAX_STABILITY_MOVEMENT,
      },
    );
  }

  /// Checks the overall quality of the frames.
  static _LivenessCheckResult _checkQuality(List<LivenessFrame> frames) {
    final goodFrames = frames.where((f) => _isFrameQualityGood(f.face)).length;
    final qualityRatio = goodFrames / frames.length;

    final passed = qualityRatio >= LivenessConfig.MIN_QUALITY_FRAME_RATIO;

    return _LivenessCheckResult(
      confidence: qualityRatio,
      reason: passed ? 'Good image quality' : 'Poor image quality',
      details: {
        'qualityRatio': qualityRatio.toStringAsFixed(2),
        'passedFrames': goodFrames,
        'totalFrames': frames.length,
      },
    );
  }

  // --- Helper Methods ---

  static double _calculateOverallConfidence(
    _LivenessCheckResult blink,
    _LivenessCheckResult stability,
    _LivenessCheckResult quality,
  ) {
    // Weights: Blink (50%), Quality (30%), Stability (20%)
    return (blink.confidence * 0.5) +
        (quality.confidence * 0.3) +
        (stability.confidence * 0.2);
  }

  static String _getFinalMessage(
    bool isAlive,
    _LivenessCheckResult blink,
    _LivenessCheckResult stability,
    _LivenessCheckResult quality,
  ) {
    if (isAlive) return "Liveness check passed!";

    // Provide the most helpful hint to the user
    if (quality.confidence < 0.7) {
      return "Please keep your face in the frame and check the lighting.";
    }
    if (stability.confidence < 0.5) {
      return "Please hold your face steady during the check.";
    }
    if (blink.confidence < 0.5) {
      return "Please blink naturally and clearly.";
    }

    return "Liveness check failed. Please try again.";
  }

  static bool _isFrameQualityGood(Face face) {
    final angleY = face.headEulerAngleY?.abs() ?? 99;
    final angleZ = face.headEulerAngleZ?.abs() ?? 99;
    return angleY < LivenessConfig.MAX_HEAD_ANGLE_Y &&
        angleZ < LivenessConfig.MAX_HEAD_ANGLE_Z;
  }

  static _EyeState _getEyeState(Face face) {
    final left = face.leftEyeOpenProbability;
    final right = face.rightEyeOpenProbability;
    if (left == null || right == null) return _EyeState.unknown;

    final avg = (left + right) / 2.0;
    if (avg > LivenessConfig.EYE_OPEN_PROBABILITY) return _EyeState.open;
    if (avg < LivenessConfig.EYE_CLOSED_PROBABILITY) return _EyeState.closed;
    return _EyeState.unknown;
  }
}

///* -------------------------------------------------------------------------- */
///* INTERNAL DATA STRUCTURES                         */
///* -------------------------------------------------------------------------- */

/// The internal result of a single, individual liveness check.
class _LivenessCheckResult {
  final double confidence;
  final String reason;
  final Map<String, dynamic> details;

  const _LivenessCheckResult({
    required this.confidence,
    required this.reason,
    required this.details,
  });

  const _LivenessCheckResult.failed(this.reason)
    : confidence = 0.0,
      details = const {};

  Map<String, dynamic> toMap() => {
    'confidence': confidence.toStringAsFixed(2),
    'reason': reason,
    'details': details,
  };
}

/// The state of the user's eyes.
enum _EyeState { open, closed, unknown }
