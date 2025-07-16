import 'dart:math' as math;

import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';

/// Configuration constants for face detection.
class FaceDetectionCacheConfig {
  /// Cache expiry duration for face detection results.
  static const Duration cacheExpiry = Duration(seconds: 3);

  /// Number of frames needed for stable face detection.
  static const int stabilityThreshold = 3;

  /// Number of frames needed to invalidate face detection cache.
  static const int invalidationThreshold = 2;

  /// Spatial threshold for face comparison (stricter).
  static const double spatialThreshold = 0.8;
}

class FaceDetectionCache {
  LocalFaceDetectionResult? _cachedResult;
  DateTime? _cacheTimestamp;
  int _consecutiveValidFrames = 0;
  int _consecutiveInvalidFrames = 0;

  bool get isValidAndStable =>
      _cachedResult != null &&
      _cacheTimestamp != null &&
      DateTime.now().difference(_cacheTimestamp!) <
          FaceDetectionCacheConfig.cacheExpiry &&
      _consecutiveValidFrames >= FaceDetectionCacheConfig.stabilityThreshold;

  bool get isFaceStable =>
      _consecutiveValidFrames >= FaceDetectionCacheConfig.stabilityThreshold;

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

    return overlapRatio > FaceDetectionCacheConfig.spatialThreshold;
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

      if (_consecutiveInvalidFrames >=
          FaceDetectionCacheConfig.invalidationThreshold) {
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

      if (_consecutiveInvalidFrames >=
          FaceDetectionCacheConfig.invalidationThreshold) {
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
