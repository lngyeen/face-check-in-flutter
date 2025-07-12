import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/core/services/image_converter.dart';
import 'package:face_check_in_flutter/core/services/websocket_service.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';
import 'package:face_check_in_flutter/domain/entities/websocket_connection_status.dart';

// Assuming these files are in your project and have been updated
import 'face_detection_service_v2.dart';
import 'liveness_service_v2.dart';

///* -------------------------------------------------------------------------- */
///* Face Detection Cache System                                                */
///* -------------------------------------------------------------------------- */

/// Cache system for face detection results with identity tracking and automatic invalidation.
class _FaceDetectionCache {
  FaceDetectionResult? _cachedResult;
  DateTime? _cacheTimestamp;
  int _consecutiveValidFrames = 0;
  int _consecutiveInvalidFrames = 0;

  // Face identity tracking
  String? _cachedFaceId;

  // Configuration
  static const Duration _cacheExpiry = Duration(seconds: 3);
  static const int _stabilityThreshold = 3; // frames needed for stable face
  static const int _invalidationThreshold = 2; // frames needed to invalidate
  static const double _faceChangeThreshold =
      0.3; // threshold for face identity change

  /// Check if cached result is still valid and face is stable
  bool get isValidAndStable =>
      _cachedResult != null &&
      _cacheTimestamp != null &&
      DateTime.now().difference(_cacheTimestamp!) < _cacheExpiry &&
      _consecutiveValidFrames >= _stabilityThreshold;

  /// Check if face has been stable for enough frames
  bool get isFaceStable => _consecutiveValidFrames >= _stabilityThreshold;

  /// Generate a comprehensive face identity hash using landmarks and bounding box
  String _generateFaceId(FaceDetectionResult result) {
    if (result.face == null) return '';

    final face = result.face!;
    final boundingBox = face.boundingBox;

    // Start with bounding box as baseline
    final buffer = StringBuffer();
    buffer.write('${boundingBox.left.toInt()}_${boundingBox.top.toInt()}_');
    buffer.write('${boundingBox.width.toInt()}_${boundingBox.height.toInt()}');

    // Add key landmarks if available for better identity matching
    final landmarks = face.landmarks;

    // Use stable landmarks that are less likely to change with minor face movements
    final keyLandmarkTypes = [
      FaceLandmarkType.noseBase,
      FaceLandmarkType.leftEye,
      FaceLandmarkType.rightEye,
      FaceLandmarkType.leftMouth,
      FaceLandmarkType.rightMouth,
    ];

    for (final landmarkType in keyLandmarkTypes) {
      final landmark = landmarks[landmarkType];
      if (landmark != null) {
        final pos = landmark.position;
        buffer.write('_${pos.x.toInt()}_${pos.y.toInt()}');
      }
    }

    return buffer.toString();
  }

  /// Check if the current face is the same as cached face
  bool _isSameFace(FaceDetectionResult newResult) {
    if (_cachedResult == null || _cachedFaceId == null) return false;
    if (!newResult.isSingleValidFace) return false;

    final newFaceId = _generateFaceId(newResult);
    if (newFaceId.isEmpty) return false;

    // Simple bounding box comparison - in production you might want face embeddings
    final cachedFace = _cachedResult!.face!;
    final newFace = newResult.face!;

    final cachedBox = cachedFace.boundingBox;
    final newBox = newFace.boundingBox;

    // Calculate overlap ratio
    final overlapArea =
        math.max(
          0,
          math.min(cachedBox.right, newBox.right) -
              math.max(cachedBox.left, newBox.left),
        ) *
        math.max(
          0,
          math.min(cachedBox.bottom, newBox.bottom) -
              math.max(cachedBox.top, newBox.top),
        );

    final cachedArea = cachedBox.width * cachedBox.height;
    final newArea = newBox.width * newBox.height;
    final unionArea = cachedArea + newArea - overlapArea;

    final overlapRatio = unionArea > 0 ? overlapArea / unionArea : 0.0;

    return overlapRatio > (1.0 - _faceChangeThreshold);
  }

  /// Check if we can use cached result instead of running detection
  bool canUseCachedResult() {
    return isValidAndStable;
  }

  /// Get cached result if available
  FaceDetectionResult? getCachedResult() {
    return canUseCachedResult() ? _cachedResult : null;
  }

  /// Process detection result and determine if we should use cache or new result
  FaceDetectionResult processDetectionResult(FaceDetectionResult newResult) {
    // If no valid face, handle invalidation
    if (!newResult.isSingleValidFace) {
      _consecutiveInvalidFrames++;
      _consecutiveValidFrames = 0;

      // Invalidate cache if face has been absent for too long
      if (_consecutiveInvalidFrames >= _invalidationThreshold) {
        invalidate();
      }

      return newResult;
    }

    // Reset invalid frame counter since we have a valid face
    _consecutiveInvalidFrames = 0;

    // Check if this is the same face as cached
    if (_cachedResult != null && _isSameFace(newResult)) {
      // Same face - increment stability counter
      _consecutiveValidFrames++;

      // Update cache timestamp to keep it fresh
      _cacheTimestamp = DateTime.now();

      // Return cached result if stable (more consistent)
      if (isValidAndStable) {
        return _cachedResult!;
      }
    } else {
      // Different face or first detection
      final newFaceId = _generateFaceId(newResult);

      // Check if this is a face change
      if (_cachedFaceId != null &&
          _cachedFaceId != newFaceId &&
          newFaceId.isNotEmpty) {
        // Face changed - invalidate cache and start fresh
        invalidate();
        debugPrint('Face change detected, cache invalidated');
      }

      // Update cache with new result
      _cachedResult = newResult;
      _cachedFaceId = newFaceId;
      _cacheTimestamp = DateTime.now();
      _consecutiveValidFrames = 1;

      debugPrint(
        'Face detection cache updated (consecutive: $_consecutiveValidFrames)',
      );
    }

    return newResult;
  }

  /// Update cache with new face detection result
  void updateCache(FaceDetectionResult result) {
    if (!result.isSingleValidFace) {
      _consecutiveValidFrames = 0;
      _consecutiveInvalidFrames++;

      // Invalidate if no valid face for too long
      if (_consecutiveInvalidFrames >= _invalidationThreshold) {
        invalidate();
      }
      return;
    }

    final newFaceId = _generateFaceId(result);

    // Check if this is a face change
    if (_cachedFaceId != null &&
        _cachedFaceId != newFaceId &&
        newFaceId.isNotEmpty) {
      // Face changed - invalidate cache and start fresh
      invalidate();
      debugPrint('Face change detected, cache invalidated');
    }

    _cachedResult = result;
    _cachedFaceId = newFaceId;
    _cacheTimestamp = DateTime.now();
    _consecutiveValidFrames++;
    _consecutiveInvalidFrames = 0;

    debugPrint(
      'Face detection cache updated (consecutive: $_consecutiveValidFrames, stable: $isFaceStable)',
    );
  }

  /// Invalidate the cache (e.g., when face disappears or changes)
  void invalidate() {
    _cachedResult = null;
    _cachedFaceId = null;
    _cacheTimestamp = null;
    _consecutiveValidFrames = 0;
    _consecutiveInvalidFrames = 0;
    debugPrint('Face detection cache invalidated');
  }

  /// Reset cache for new session
  void reset() {
    invalidate();
    debugPrint('Face detection cache reset');
  }
}

///* -------------------------------------------------------------------------- */
///* Liveness Batch Processing System                                           */
///* -------------------------------------------------------------------------- */

/// Coordinates batch processing for liveness detection to reduce redundant calls.
class _LivenessBatchProcessor {
  final LivenessServiceV2 _livenessService;

  // Batch state
  final List<Face> _batchBuffer = [];
  DateTime? _batchStartTime;
  bool _isProcessing = false;
  LivenessResult? _lastResult;
  DateTime? _lastResultTime;
  int _failedRetryCount = 0;

  // Configuration
  static const int _minBatchSize = 8;
  static const int _maxBatchSize = 15;
  static const Duration _batchTimeout = Duration(seconds: 5);
  static const Duration _resultCacheDuration = Duration(seconds: 2);
  static const int _maxFailedRetries = 2;
  static const double _partialResetRatio = 0.5; // Keep 50% of frames on failed

  _LivenessBatchProcessor(this._livenessService);

  /// Get current batch buffer length for monitoring
  int get batchBufferLength => _batchBuffer.length;

  /// Add a face to the batch buffer
  void addFace(Face face) {
    if (_isProcessing) return; // Skip if currently processing

    _batchBuffer.add(face);
    _batchStartTime ??= DateTime.now();

    // Limit batch size
    if (_batchBuffer.length > _maxBatchSize) {
      _batchBuffer.removeAt(0);
    }

    debugPrint(
      'Liveness batch: ${_batchBuffer.length}/$_minBatchSize faces collected',
    );
  }

  /// Check if we can use cached liveness result
  bool canUseCachedResult() {
    if (_lastResult == null || _lastResultTime == null) return false;

    final timeSinceResult = DateTime.now().difference(_lastResultTime!);
    return timeSinceResult < _resultCacheDuration &&
        _lastResult!.status != LivenessStatus.needMoreFrames;
  }

  /// Get cached liveness result if available
  LivenessResult? getCachedResult() {
    return canUseCachedResult() ? _lastResult : null;
  }

  /// Check if batch is ready for processing
  bool get isBatchReady {
    if (_batchBuffer.length < _minBatchSize) return false;

    // Check timeout - process even if not enough frames after timeout
    if (_batchStartTime != null) {
      final timeSinceStart = DateTime.now().difference(_batchStartTime!);
      if (timeSinceStart > _batchTimeout && _batchBuffer.length >= 3) {
        return true;
      }
    }

    return _batchBuffer.length >= _minBatchSize;
  }

  /// Process the current batch
  Future<LivenessResult> processBatch() async {
    if (_isProcessing) {
      // If already processing, return cached result or default
      return getCachedResult() ??
          LivenessResult(
            status: LivenessStatus.processing,
            isAlive: false,
            confidence: 0.0,
            message: 'Liveness processing in progress...',
            details: {},
          );
    }

    if (!isBatchReady) {
      return LivenessResult(
        status: LivenessStatus.needMoreFrames,
        isAlive: false,
        confidence: 0.0,
        message:
            'Collecting frames for batch processing... (${_batchBuffer.length}/$_minBatchSize)',
        details: {'framesCollected': _batchBuffer.length},
      );
    }

    _isProcessing = true;

    try {
      // Process entire batch using the new processFaceList method
      final result = await _livenessService.processFaceList(
        List<Face>.from(_batchBuffer),
      );

      // Cache the result
      _lastResult = result;
      _lastResultTime = DateTime.now();

      // Smart reset strategy based on result type
      if (result.status == LivenessStatus.passed) {
        // Success: Reset for next person/session
        _resetBatch();
        debugPrint(
          'Liveness PASSED: Batch reset for next session (${_batchBuffer.length} faces)',
        );
      } else if (result.status == LivenessStatus.failed) {
        // Failed: Partial reset strategy to give user another chance
        _handleFailedLiveness();
        debugPrint(
          'Liveness FAILED: Applying partial reset strategy (${_batchBuffer.length} faces)',
        );
      }

      return result;
    } catch (e) {
      _resetBatch();
      return LivenessResult(
        status: LivenessStatus.error,
        isAlive: false,
        confidence: 0.0,
        message: 'Batch processing error: $e',
        details: {'error': e.toString()},
      );
    } finally {
      _isProcessing = false;
    }
  }

  /// Handle failed liveness with smart partial reset strategy
  void _handleFailedLiveness() {
    _failedRetryCount++;

    if (_failedRetryCount <= _maxFailedRetries) {
      // Partial reset: Keep recent frames for retry
      final framesToKeep = (_batchBuffer.length * _partialResetRatio).floor();
      if (framesToKeep > 0) {
        // Keep the most recent frames (better temporal continuity)
        final recentFrames =
            _batchBuffer.skip(_batchBuffer.length - framesToKeep).toList();
        _batchBuffer.clear();
        _batchBuffer.addAll(recentFrames);

        debugPrint(
          'Partial reset: Kept $framesToKeep recent frames (retry ${_failedRetryCount}/$_maxFailedRetries)',
        );
      } else {
        _resetBatch();
      }

      // Clear cache to allow immediate retry
      _lastResult = null;
      _lastResultTime = null;
    } else {
      // Max retries reached: Full reset
      _resetBatch();
      debugPrint(
        'Max retries reached: Full batch reset (${_failedRetryCount} attempts)',
      );
    }
  }

  /// Reset the batch buffer
  void _resetBatch() {
    _batchBuffer.clear();
    _batchStartTime = null;
    _failedRetryCount = 0; // Reset retry counter
    debugPrint('Liveness batch reset');
  }

  /// Reset everything including cached results
  void reset() {
    _resetBatch();
    _lastResult = null;
    _lastResultTime = null;
    _isProcessing = false;
    _failedRetryCount = 0;
    _livenessService.reset();
    debugPrint('Liveness batch processor reset');
  }

  /// Handle face disappearance
  void handleFaceLost() {
    // Don't immediately reset - give some time for face to reappear
    if (_batchStartTime != null) {
      final timeSinceStart = DateTime.now().difference(_batchStartTime!);
      if (timeSinceStart > Duration(seconds: 1)) {
        _resetBatch();
      }
    }
  }
}

///* -------------------------------------------------------------------------- */
///* Enums and Data Classes                                                     */
///* -------------------------------------------------------------------------- */

/// Defines the processing strategy for the image stream.
enum ProcessingMode {
  /// Sends all frames to the server for processing.
  serverSide,

  /// Performs face detection and liveness checks locally before sending data.
  hybrid,
}

/// Represents the status of the local hybrid processing pipeline.
enum ProcessingStatus {
  /// Waiting for a valid face to be detected.
  waitingForFace,

  /// Liveness checks are in progress.
  livenessChecking,

  /// Liveness passed, ready for server-side recognition.
  readyForCheckIn,

  /// An error occurred during processing.
  error,
}

/// The result of a single hybrid processing operation.
class HybridProcessingResult {
  final ProcessingStatus status;
  final FaceDetectionResult? faceDetectionResult;
  final LivenessResult? livenessResult;
  final String? feedbackMessage;
  final DateTime timestamp;
  final String? error;

  const HybridProcessingResult({
    required this.status,
    this.faceDetectionResult,
    this.livenessResult,
    this.feedbackMessage,
    required this.timestamp,
    this.error,
  });

  /// True if the system is ready to perform the final check-in.
  bool get isReadyForCheckIn => status == ProcessingStatus.readyForCheckIn;

  /// True if there's an error
  bool get hasError => status == ProcessingStatus.error;
}

///* -------------------------------------------------------------------------- */
///* Service Definition                                                       */
///* -------------------------------------------------------------------------- */

/// Abstract interface for the complete image streaming and processing service.
abstract class ImageStreamServiceV2 {
  /// Stream for the raw hardware status of the camera.
  Stream<StreamingStatus> get streamingStatusStream;

  /// Stream for the logical processing status.
  Stream<ProcessingStatus> get processingStatusStream;

  /// Stream for the detailed hybrid processing result.
  Stream<HybridProcessingResult> get processingResultStream;

  ProcessingMode get processingMode;

  Future<void> startStreaming(CameraController controller);
  Future<void> stopStreaming();
  void dispose();
}

/// Main implementation that orchestrates camera streaming, local processing, and WebSocket communication.
@LazySingleton(as: ImageStreamServiceV2)
class ImageStreamServiceV2Impl implements ImageStreamServiceV2 {
  final WebSocketService _webSocketService;
  final LivenessServiceV2 _livenessService;
  final FaceDetectionServiceV2 _faceDetectionService;

  // Configuration - Updated throttling approach
  /// Throttle for waiting for face detection (responsive UX).
  static const Duration _waitingForFaceThrottleDuration = Duration(
    milliseconds: 500,
  ); // 2fps

  /// Throttle for liveness checking phase (efficient processing).
  static const Duration _livenessCheckingThrottleDuration = Duration(
    milliseconds: 250,
  ); // 4fps

  /// Throttle for ready state (conservative server communication).
  static const Duration _readyForCheckInThrottleDuration = Duration(
    seconds: 1,
  ); // 1fps

  // Stream Management
  CameraController? _activeController;
  StreamSubscription? _frameProcessorSubscription;
  final _frameSubject = PublishSubject<CameraImage>();

  // State Management
  final ProcessingMode _processingMode = ProcessingMode.hybrid;
  final _streamingStatusSubject = BehaviorSubject<StreamingStatus>.seeded(
    StreamingStatus.idle,
  );
  final _processingResultSubject =
      BehaviorSubject<HybridProcessingResult>.seeded(
        HybridProcessingResult(
          status: ProcessingStatus.waitingForFace,
          timestamp: DateTime.now(),
        ),
      );

  // Throttling Management - Separate from processing results
  late final BehaviorSubject<Duration> _throttleDurationSubject;

  // Face Detection Cache
  final _faceDetectionCache = _FaceDetectionCache();

  // Liveness Batch Processor
  late final _LivenessBatchProcessor _livenessBatchProcessor;

  bool get _isStreaming => switch (_streamingStatusSubject.value) {
    StreamingStatus.idle => false,
    StreamingStatus.initializing => true,
    StreamingStatus.active => true,
    StreamingStatus.error => false,
  };

  @override
  Stream<StreamingStatus> get streamingStatusStream =>
      _streamingStatusSubject.stream;

  @override
  Stream<ProcessingStatus> get processingStatusStream =>
      _processingResultSubject.stream.map((result) => result.status).distinct();

  @override
  Stream<HybridProcessingResult> get processingResultStream =>
      _processingResultSubject.stream;

  @override
  ProcessingMode get processingMode => _processingMode;

  ImageStreamServiceV2Impl(
    this._webSocketService,
    this._livenessService,
    this._faceDetectionService,
  ) {
    // Initialize liveness batch processor
    _livenessBatchProcessor = _LivenessBatchProcessor(_livenessService);

    // Initialize throttle duration based on initial processing status
    final initialThrottleDuration = _getThrottleForCurrentStage(
      ProcessingStatus.waitingForFace,
    );

    _throttleDurationSubject = BehaviorSubject<Duration>.seeded(
      initialThrottleDuration,
    );
  }

  /// Initializes frame processing pipeline
  void _initialize() {
    _initializeFrameProcessor();
  }

  /// Gets the appropriate throttle duration based on current processing stage and batch status.
  Duration _getThrottleForCurrentStage(ProcessingStatus status) {
    switch (status) {
      case ProcessingStatus.waitingForFace:
        return _waitingForFaceThrottleDuration; // 5fps - responsive
      case ProcessingStatus.livenessChecking:
        // During liveness checking, optimize for batch collection
        if (_livenessBatchProcessor.canUseCachedResult()) {
          return _readyForCheckInThrottleDuration; // 1fps - use cached result
        }
        return _livenessCheckingThrottleDuration; // 2fps - continue collection
      case ProcessingStatus.readyForCheckIn:
        return _readyForCheckInThrottleDuration; // 1fps - conservative
      case ProcessingStatus.error:
        return _waitingForFaceThrottleDuration; // fallback to responsive
    }
  }

  /// Updates throttle duration based on current processing status.
  void _updateThrottleDuration() {
    final currentResult = _processingResultSubject.value;
    final newDuration = _getThrottleForCurrentStage(currentResult.status);

    if (_throttleDurationSubject.value != newDuration) {
      _throttleDurationSubject.add(newDuration);
      debugPrint(
        'Throttle duration updated to: $newDuration (${currentResult.status})',
      );
    }
  }

  /// Sets up the RxDart pipeline for processing frames with dynamic throttling
  /// and optimized concurrent processing flow.
  void _initializeFrameProcessor() {
    _frameProcessorSubscription?.cancel();

    // Create a throttled stream that only resets when throttle duration changes
    final throttledFrameStream = _throttleDurationSubject.stream
        .distinct()
        .switchMap((duration) {
          return _frameSubject
              .where((_) => _isStreaming)
              .throttleTime(duration, trailing: true);
        });

    _frameProcessorSubscription = throttledFrameStream
        .map((image) {
          final controller = _activeController;
          if (controller == null) return null;
          return _FramePipelineData(image, controller.description);
        })
        .where((data) => data != null)
        .cast<_FramePipelineData>()
        // OPTIMIZED: Face Detection with smart caching
        .asyncMap((data) async {
          if (_processingMode == ProcessingMode.hybrid) {
            try {
              // First check if we can use cached result
              final cachedResult = _faceDetectionCache.getCachedResult();

              if (cachedResult != null) {
                data.faceResult = cachedResult;
                debugPrint('Using cached face detection result');
              } else {
                final detectionResult = await _faceDetectionService.detectFace(
                  data.image,
                  data.camera,
                );
                data.faceResult = _faceDetectionCache.processDetectionResult(
                  detectionResult,
                );
                debugPrint('Face detection executed and cached');
              }
            } catch (e) {
              data.error = 'Face detection failed: $e';
              _faceDetectionCache.invalidate();
            }
          } else {
            data.faceResult = FaceDetectionResult(
              status: FaceDetectionStatus.singleFaceDetected,
              totalFacesDetected: 1,
              message: '',
            );
          }
          return data;
        })
        // OPTIMIZED: Concurrent Liveness + Image Processing
        .asyncMap((data) async {
          if (data.error != null) return data;

          final isHybridMode = _processingMode == ProcessingMode.hybrid;
          final isFaceDetected = data.faceResult?.isSingleValidFace == true;
          final isServerSide = _processingMode == ProcessingMode.serverSide;

          // Start concurrent operations
          final futures = <Future>[];

          // 1. Liveness Processing (non-blocking for batch collection)
          if (isHybridMode && isFaceDetected) {
            futures.add(_processLivenessNonBlocking(data));
          } else if (isHybridMode) {
            // Handle face loss without blocking
            _livenessBatchProcessor.handleFaceLost();
            data.livenessResult = LivenessResult(
              status: LivenessStatus.needMoreFrames,
              isAlive: false,
              confidence: 0.0,
              message: 'No face detected',
              details: {},
            );
          } else {
            // Server-side mode
            data.livenessResult = LivenessResult(
              status: LivenessStatus.passed,
              isAlive: true,
              confidence: 1.0,
              message: 'Server-side processing active',
              details: {},
            );
          }

          // 2. Concurrent Image Conversion (for eligible frames)
          final shouldConvertImage =
              isServerSide || (isHybridMode && isFaceDetected);

          if (shouldConvertImage) {
            futures.add(_convertImageConcurrently(data));
          }

          // Wait for concurrent operations to complete
          if (futures.isNotEmpty) {
            try {
              await Future.wait(futures);
            } catch (e) {
              debugPrint('Concurrent processing error: $e');
              // Individual operations handle their own errors
            }
          }

          return data;
        })
        // OPTIMIZED: Smart Result Processing
        .map(_mapOptimizedPipelineDataToResult)
        .listen(
          (result) {
            if (result == null || !_isStreaming) return;

            final (processingResult, processedFrame) = result;
            _processingResultSubject.add(processingResult);

            // Update throttle duration when processing result changes
            _updateThrottleDuration();

            // Send frame to WebSocket if available
            if (processedFrame != null) {
              _sendFrameToWebSocket(processedFrame);
            }
          },
          onError: (error) {
            debugPrint('Pipeline error: $error');
            _processingResultSubject.add(
              HybridProcessingResult(
                status: ProcessingStatus.error,
                timestamp: DateTime.now(),
                error: error.toString(),
                feedbackMessage: 'Pipeline processing error: $error',
              ),
            );
          },
        );
  }

  /// Non-blocking liveness processing that prioritizes batch collection
  Future<void> _processLivenessNonBlocking(_FramePipelineData data) async {
    try {
      // Check cache first (fast path)
      final cachedResult = _livenessBatchProcessor.getCachedResult();

      if (cachedResult != null) {
        data.livenessResult = cachedResult;
        debugPrint('Using cached liveness result');
        return;
      }

      // Add to batch (non-blocking)
      _livenessBatchProcessor.addFace(data.faceResult!.face!);

      // Process batch if ready, otherwise return placeholder
      if (_livenessBatchProcessor.isBatchReady) {
        data.livenessResult = await _livenessBatchProcessor.processBatch();
        debugPrint('Liveness batch processing completed');
      } else {
        // Non-blocking placeholder for batch collection
        data.livenessResult = LivenessResult(
          status: LivenessStatus.needMoreFrames,
          isAlive: false,
          confidence: 0.0,
          message:
              'Collecting frames for liveness... (${_livenessBatchProcessor.batchBufferLength})',
          details: {
            'framesCollected': _livenessBatchProcessor.batchBufferLength,
          },
        );
      }
    } catch (e) {
      debugPrint('Liveness processing error: $e');
      data.error = 'Liveness check failed: $e';
    }
  }

  /// Concurrent image conversion that doesn't block other operations
  Future<void> _convertImageConcurrently(_FramePipelineData data) async {
    try {
      final image = data.image;
      final sensorOrientation = data.camera.sensorOrientation;
      final lensDirection = data.camera.lensDirection;

      data.processedFrame = await _convertImageInIsolate(
        image,
        sensorOrientation,
        lensDirection,
      );

      debugPrint('Concurrent image conversion completed');
    } catch (e) {
      debugPrint('Image conversion error: $e');
      // Don't set data.error here to avoid breaking the pipeline
      // Just log the error and continue without processed frame
    }
  }

  Future<ProcessedFrame?> _convertImageInIsolate(
    CameraImage image,
    int sensorOrientation,
    CameraLensDirection lensDirection,
  ) {
    return Isolate.run(
      () => ImageConverter.convertCameraImageToProcessedFrameSync(
        image,
        sensorOrientation: sensorOrientation,
        lensDirection: lensDirection,
      ),
    );
  }

  @override
  Future<void> startStreaming(CameraController controller) async {
    if (_isStreaming) return;

    _streamingStatusSubject.add(StreamingStatus.initializing);
    _activeController = controller;

    try {
      // Reset cache for new streaming session
      _faceDetectionCache.reset();
      _livenessBatchProcessor.reset(); // Reset liveness batch processor

      // Initialize frame processor
      _initialize();

      _streamingStatusSubject.add(StreamingStatus.active);
      _processingResultSubject.add(
        HybridProcessingResult(
          status: ProcessingStatus.waitingForFace,
          timestamp: DateTime.now(),
        ),
      );

      await controller.startImageStream((CameraImage image) {
        if (_isStreaming) {
          _frameSubject.add(image);
        }
      });

      debugPrint('Image streaming started with fresh cache');
    } catch (e) {
      _streamingStatusSubject.add(StreamingStatus.error);
      _processingResultSubject.add(
        HybridProcessingResult(
          status: ProcessingStatus.error,
          timestamp: DateTime.now(),
          error: e.toString(),
          feedbackMessage: 'Failed to start streaming: $e',
        ),
      );
    }
  }

  @override
  Future<void> stopStreaming() async {
    if (!_isStreaming && _activeController == null) return;

    try {
      if (_activeController?.value.isStreamingImages ?? false) {
        await _activeController?.stopImageStream();
      }
    } catch (e) {
      // Ignore errors on stopping stream
    }

    _activeController = null;
    _streamingStatusSubject.add(StreamingStatus.idle);

    // Reset cache when streaming stops
    _faceDetectionCache.reset();
    _livenessBatchProcessor.reset(); // Reset liveness batch processor

    debugPrint('Image streaming stopped and cache reset');
  }

  void _sendFrameToWebSocket(ProcessedFrame frame) {
    if (_webSocketService.currentStatus !=
        WebSocketConnectionStatus.connected) {
      return;
    }

    final payload = {'type': 'processFrame', 'image': frame.base64Image};
    _webSocketService.sendMessage(json.encode(payload));
  }

  @override
  void dispose() {
    stopStreaming();
    _frameProcessorSubscription?.cancel();
    _frameSubject.close();
    _streamingStatusSubject.close();
    _processingResultSubject.close();
    _throttleDurationSubject.close();

    // Reset cache on disposal
    _faceDetectionCache.reset();
    _livenessBatchProcessor.reset(); // Reset liveness batch processor

    _faceDetectionService.dispose();
    _livenessService.dispose();

    debugPrint('ImageStreamServiceV2 disposed with cache reset');
  }

  /// Maps the final pipeline data object to the service's output tuple.
  (HybridProcessingResult, ProcessedFrame?)? _mapPipelineDataToResult(
    _FramePipelineData data,
  ) {
    // Handle errors first
    if (data.error != null) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.error,
          timestamp: DateTime.now(),
          error: data.error,
          feedbackMessage: data.error,
        ),
        null,
      );
    }

    // Handle server-side mode
    if (_processingMode == ProcessingMode.serverSide) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.readyForCheckIn,
          timestamp: DateTime.now(),
          feedbackMessage: "Server-side processing active",
        ),
        data.processedFrame,
      );
    }

    // --- Hybrid Mode Logic ---
    final faceResult = data.faceResult;
    if (faceResult == null) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.error,
          timestamp: DateTime.now(),
          error: 'Face detection result is null',
          feedbackMessage: 'Face detection failed',
        ),
        null,
      );
    }

    // If no single valid face is found, reset to the waiting state.
    if (!faceResult.isSingleValidFace) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.waitingForFace,
          faceDetectionResult: faceResult,
          feedbackMessage: faceResult.message,
          timestamp: DateTime.now(),
        ),
        null,
      );
    }

    final livenessResult = data.livenessResult;

    // If liveness check has passed, we're ready for the final check-in.
    if (livenessResult != null && livenessResult.isPassed) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.readyForCheckIn,
          faceDetectionResult: faceResult,
          livenessResult: livenessResult,
          feedbackMessage: "Liveness passed. Ready for check-in.",
          timestamp: DateTime.now(),
        ),
        data.processedFrame, // This is the frame to send.
      );
    } else {
      // Otherwise, the liveness check is still in progress.
      return (
        HybridProcessingResult(
          status: ProcessingStatus.livenessChecking,
          faceDetectionResult: faceResult,
          livenessResult: livenessResult,
          feedbackMessage: livenessResult?.message,
          timestamp: DateTime.now(),
        ),
        null, // No frame to send yet.
      );
    }
  }

  /// Maps the final pipeline data object to the service's output tuple.
  (HybridProcessingResult, ProcessedFrame?)? _mapOptimizedPipelineDataToResult(
    _FramePipelineData data,
  ) {
    // Handle errors first
    if (data.error != null) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.error,
          timestamp: DateTime.now(),
          error: data.error,
          feedbackMessage: data.error,
        ),
        null,
      );
    }

    // Handle server-side mode
    if (_processingMode == ProcessingMode.serverSide) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.readyForCheckIn,
          timestamp: DateTime.now(),
          feedbackMessage: "Server-side processing active",
        ),
        data.processedFrame,
      );
    }

    // --- Hybrid Mode Logic ---
    final faceResult = data.faceResult;
    if (faceResult == null) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.error,
          timestamp: DateTime.now(),
          error: 'Face detection result is null',
          feedbackMessage: 'Face detection failed',
        ),
        null,
      );
    }

    // If no single valid face is found, reset to the waiting state.
    if (!faceResult.isSingleValidFace) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.waitingForFace,
          faceDetectionResult: faceResult,
          feedbackMessage: faceResult.message,
          timestamp: DateTime.now(),
        ),
        null,
      );
    }

    final livenessResult = data.livenessResult;

    // If liveness check has passed, we're ready for the final check-in.
    if (livenessResult != null && livenessResult.isPassed) {
      return (
        HybridProcessingResult(
          status: ProcessingStatus.readyForCheckIn,
          faceDetectionResult: faceResult,
          livenessResult: livenessResult,
          feedbackMessage: "Liveness passed. Ready for check-in.",
          timestamp: DateTime.now(),
        ),
        data.processedFrame, // This is the frame to send.
      );
    } else {
      // Otherwise, the liveness check is still in progress.
      return (
        HybridProcessingResult(
          status: ProcessingStatus.livenessChecking,
          faceDetectionResult: faceResult,
          livenessResult: livenessResult,
          feedbackMessage: livenessResult?.message,
          timestamp: DateTime.now(),
        ),
        null, // No frame to send yet.
      );
    }
  }
}

/// Helper class to carry data through the stream processing pipeline.
/// Made immutable to prevent side effects.
class _FramePipelineData {
  final CameraImage image;
  final CameraDescription camera;

  // Results from processing steps
  FaceDetectionResult? faceResult;
  LivenessResult? livenessResult;
  ProcessedFrame? processedFrame;
  String? error;

  _FramePipelineData(this.image, this.camera);
}
