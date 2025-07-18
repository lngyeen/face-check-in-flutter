// lib/core/services/face_detection_cache.dart

import 'dart:math' as math;

import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';

class FaceDetectionCacheConfig {
  static const int stabilityThreshold = 3;
  static const int invalidationThreshold = 5; // Tăng nhẹ để ổn định hơn
  static const double spatialThreshold = 0.8;
}

class FaceDetectionCache {
  LocalFaceDetectionResult? _lastValidResult;
  int _consecutiveValidFrames = 0;
  int _consecutiveInvalidFrames = 0;
  bool _hasCompletedLiveness = false; // ← NEW: Completion persistence flag

  /// Cờ báo hiệu quan trọng: Cho biết khuôn mặt đã ổn định hay chưa.
  bool get isFaceStable =>
      _consecutiveValidFrames >= FaceDetectionCacheConfig.stabilityThreshold;

  bool _isSameFace(LocalFaceDetectionResult newResult) {
    if (_lastValidResult == null || !newResult.isSingleValidFace) return false;
    final newFace = newResult.face;
    final lastFace = _lastValidResult!.face;
    if (newFace == null || lastFace == null) return false;

    final lastBox = lastFace.boundingBox;
    final newBox = newFace.boundingBox;
    final overlapArea =
        math.max(
          0,
          math.min(lastBox.right, newBox.right) -
              math.max(lastBox.left, newBox.left),
        ) *
        math.max(
          0,
          math.min(lastBox.bottom, newBox.bottom) -
              math.max(lastBox.top, newBox.top),
        );
    final lastArea = lastBox.width * lastBox.height;
    final newArea = newBox.width * newBox.height;
    final unionArea = lastArea + newArea - overlapArea;
    final overlapRatio = unionArea > 0 ? overlapArea / unionArea : 0.0;
    return overlapRatio > FaceDetectionCacheConfig.spatialThreshold;
  }

  /// Phương thức mới: Chỉ xử lý và cập nhật trạng thái ổn định.
  void process(LocalFaceDetectionResult newResult) {
    // ← NEW: Don't reset if liveness is completed
    if (_hasCompletedLiveness) return;

    if (!newResult.isSingleValidFace) {
      _consecutiveInvalidFrames++;
      _consecutiveValidFrames = 0; // Reset bộ đếm ổn định
      if (_consecutiveInvalidFrames >=
          FaceDetectionCacheConfig.invalidationThreshold) {
        invalidate();
      }
      return;
    }

    _consecutiveInvalidFrames = 0;

    if (_isSameFace(newResult)) {
      _consecutiveValidFrames++;
    } else {
      _consecutiveValidFrames = 1; // Bắt đầu đếm lại cho khuôn mặt mới
    }
    _lastValidResult = newResult;
  }

  /// ← NEW: Mark cache as completed to prevent resets
  void markCompleted() {
    _hasCompletedLiveness = true;
  }

  void invalidate() {
    _lastValidResult = null;
    _consecutiveValidFrames = 0;
    _consecutiveInvalidFrames = 0;
  }

  void reset() {
    _hasCompletedLiveness = false; // ← NEW: Reset completion flag
    invalidate();
  }
}
