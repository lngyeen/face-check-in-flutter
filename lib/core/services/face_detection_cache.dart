import 'dart:math' as math;

import 'package:face_check_in_flutter/domain/entities/image_stream_config.dart';
import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';

class FaceDetectionCache {
  LocalFaceDetectionResult? _cachedResult;
  DateTime? _cacheTimestamp;
  int _consecutiveValidFrames = 0;
  int _consecutiveInvalidFrames = 0;

  static const Duration _cacheExpiry =
      ImageStreamConfig.faceDetectionCacheExpiry;
  static const int _stabilityThreshold =
      ImageStreamConfig.faceDetectionStabilityThreshold;
  static const int _invalidationThreshold =
      ImageStreamConfig.faceDetectionInvalidationThreshold;
  static const double _spatialThreshold =
      ImageStreamConfig.faceDetectionSpatialThreshold;

  bool get isValidAndStable =>
      _cachedResult != null &&
      _cacheTimestamp != null &&
      DateTime.now().difference(_cacheTimestamp!) < _cacheExpiry &&
      _consecutiveValidFrames >= _stabilityThreshold;

  bool get isFaceStable => _consecutiveValidFrames >= _stabilityThreshold;

  bool _isSameFace(LocalFaceDetectionResult newResult) {
    if (_cachedResult == null) {
      return false;
    }

    if (!newResult.isSingleValidFace) {
      return false;
    }

    final newFace = newResult.face;
    final cachedFace = _cachedResult!.face;

    if (newFace == null || cachedFace == null) {
      return false;
    }

    final cachedBox = cachedFace.boundingBox;
    final newBox = newFace.boundingBox;

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

    return overlapRatio > _spatialThreshold;
  }

  bool canUseCachedResult() {
    return isValidAndStable;
  }

  LocalFaceDetectionResult? getCachedResult() {
    return canUseCachedResult() ? _cachedResult : null;
  }

  LocalFaceDetectionResult processDetectionResult(
    LocalFaceDetectionResult newResult,
  ) {
    if (!newResult.isSingleValidFace) {
      _consecutiveInvalidFrames++;
      _consecutiveValidFrames = 0;

      if (_consecutiveInvalidFrames >= _invalidationThreshold) {
        invalidate();
      }

      return newResult;
    }

    _consecutiveInvalidFrames = 0;

    if (_cachedResult != null && _isSameFace(newResult)) {
      _consecutiveValidFrames++;
      _cacheTimestamp = DateTime.now();

      if (isValidAndStable) {
        return _cachedResult!;
      }
    } else {
      _cachedResult = newResult;
      _cacheTimestamp = DateTime.now();
      _consecutiveValidFrames = 1;
    }

    return newResult;
  }

  void updateCache(LocalFaceDetectionResult result) {
    if (!result.isSingleValidFace) {
      _consecutiveValidFrames = 0;
      _consecutiveInvalidFrames++;

      if (_consecutiveInvalidFrames >= _invalidationThreshold) {
        invalidate();
      }
      return;
    }

    _cachedResult = result;
    _cacheTimestamp = DateTime.now();
    _consecutiveValidFrames++;
    _consecutiveInvalidFrames = 0;
  }

  void invalidate() {
    _cachedResult = null;
    _cacheTimestamp = null;
    _consecutiveValidFrames = 0;
    _consecutiveInvalidFrames = 0;
  }

  void reset() {
    invalidate();
  }
}
