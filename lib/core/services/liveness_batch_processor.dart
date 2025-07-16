import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

import 'liveness_service_v2.dart';

class LivenessBatchProcessorConfig {
  /// Minimum number of frames/faces required for liveness detection
  static const int minFramesForLiveness = 8;

  /// Maximum batch size to prevent memory issues
  static const int maxBatchSize = 16;

  /// Duration to cache liveness results
  static const Duration resultCacheDuration = Duration(seconds: 2);
}

class LivenessBatchProcessor {
  final LivenessServiceV2 _livenessService;

  final List<Face> _batchBuffer = [];
  DateTime? _batchStartTime;
  bool _isProcessing = false;
  LivenessResult? _lastResult;
  DateTime? _lastResultTime;

  LivenessBatchProcessor(this._livenessService);

  int get batchBufferLength => _batchBuffer.length;

  void addFace(Face face) {
    if (_isProcessing) return;

    _batchBuffer.add(face);
    _batchStartTime ??= DateTime.now();

    if (_batchBuffer.length > LivenessBatchProcessorConfig.maxBatchSize) {
      _batchBuffer.removeAt(0);
    }
  }

  bool canUseCachedResult(Face? currentFace) {
    if (_lastResult == null || _lastResultTime == null) {
      return false;
    }

    if (_lastResult != LivenessResult.passed) {
      return false;
    }

    final timeSinceResult = DateTime.now().difference(_lastResultTime!);
    if (timeSinceResult >= LivenessBatchProcessorConfig.resultCacheDuration) {
      return false;
    }

    return true;
  }

  LivenessResult? getCachedResult(Face? currentFace) {
    return canUseCachedResult(currentFace) ? _lastResult : null;
  }

  bool get isBatchReady {
    return _batchBuffer.length >=
        LivenessBatchProcessorConfig.minFramesForLiveness;
  }

  Future<LivenessResult> processBatch() async {
    if (_isProcessing) {
      final currentFace = _batchBuffer.isNotEmpty ? _batchBuffer.last : null;
      return getCachedResult(currentFace) ?? LivenessResult.processing;
    }

    if (!isBatchReady) {
      return LivenessResult.needMoreFrames;
    }

    _isProcessing = true;

    try {
      final isAlive = await _livenessService.processFaceList(_batchBuffer);
      final result = isAlive ? LivenessResult.passed : LivenessResult.failed;

      if (isAlive) {
        _lastResult = result;
        _lastResultTime = DateTime.now();

        _resetBatch();
      } else {
        _lastResult = null;
        _lastResultTime = null;
      }

      return result;
    } catch (e) {
      return LivenessResult.error;
    } finally {
      _isProcessing = false;
    }
  }

  void invalidateLivenessCache() {
    _lastResult = null;
    _lastResultTime = null;
  }

  void _resetBatch() {
    _batchBuffer.clear();
    _batchStartTime = null;
  }

  void reset() {
    _resetBatch();
    _lastResult = null;
    _lastResultTime = null;
    _isProcessing = false;
  }

  void handleFaceLost() {
    if (_batchStartTime != null) {
      final timeSinceStart = DateTime.now().difference(_batchStartTime!);
      if (timeSinceStart > Duration(seconds: 1)) {
        _resetBatch();
        invalidateLivenessCache();
      }
    }
  }
}
