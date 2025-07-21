import 'dart:async';

import 'package:face_check_in_flutter/core/services/liveness_config.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_challenge.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_frame.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_metrics.dart';
import 'package:face_check_in_flutter/domain/entities/liveness_result.dart';

import 'validators/index.dart';

class LivenessStateTracker {
  final List<LivenessValidator> _validators;
  final _metricsController = StreamController<LivenessMetrics>.broadcast();

  int _challengeIndex = 0;
  final List<LivenessFrame> _batchBuffer = [];
  bool _isProcessing = false;
  bool _hasCompleted = false; // ← NEW: Completion persistence flag
  LivenessFailureReason? _lastFailureReason;
  final Map<Type, LivenessResult> _cumulativeResults = {};

  LivenessStateTracker(this._validators);

  Stream<LivenessMetrics> get metricsStream => _metricsController.stream;

  bool get isReadyForProcessing =>
      !_isProcessing &&
      _batchBuffer.length >= ValidationConfig.minFramesForLiveness;

  void addFace(LivenessFrame face) {
    // ← NEW: Don't process if already completed
    if (_hasCompleted) return;

    if (ChallengeConfig.challengeOrder[_challengeIndex] ==
        LivenessChallenge.completed) {
      return;
    }

    if (_lastFailureReason != null) {
      _lastFailureReason = null;
    }
    _batchBuffer.add(face);

    if (_batchBuffer.length > ValidationConfig.maxFramesForLiveness) {
      _batchBuffer.removeAt(0);
    }
    _emitMetrics();
  }

  Future<LivenessResult> processCurrentChallenge() async {
    // ← NEW: Return completed if already done
    if (_hasCompleted) {
      return const LivenessResult.completed();
    }

    if (!isReadyForProcessing) {
      return const LivenessResult.needMoreFrames();
    }

    _isProcessing = true;

    final currentChallenge = ChallengeConfig.challengeOrder[_challengeIndex];
    final requiredValidatorTypes =
        ChallengeConfig.challengeValidators[currentChallenge] ?? [];
    final validatorsToRun =
        _validators
            .where((v) => requiredValidatorTypes.contains(v.runtimeType))
            .toList();

    LivenessResult finalResult = const LivenessResult.passed();

    for (final validator in validatorsToRun) {
      final result = validator.validate(List.from(_batchBuffer));
      _cumulativeResults[validator.runtimeType] = result;
      if (result is Failed) {
        _lastFailureReason = result.reason;
        finalResult = result;
        break;
      }
    }

    //_batchBuffer.clear();

    if (finalResult.isPassed) {
      _lastFailureReason = null;
      if (_challengeIndex < ChallengeConfig.challengeOrder.length - 1) {
        _challengeIndex++;
        finalResult = const LivenessResult.needMoreFrames();
      } else {
        _challengeIndex = ChallengeConfig.challengeOrder.indexOf(
          LivenessChallenge.completed,
        );
        _hasCompleted = true; // ← NEW: Mark as completed
      }
    }

    if (finalResult is! NeedMoreFrames) {
      _logResults(_cumulativeResults, finalResult);
    }

    _isProcessing = false;
    _emitMetrics();
    return finalResult;
  }

  void _logResults(
    Map<Type, LivenessResult> results,
    LivenessResult finalResult,
  ) {
    print('=================================');
    print('--- LIVENESS CHALLENGE RESULT ---');
    results.forEach((type, result) {
      final status = result.maybeWhen(
        passed: (c) => "${(c * 100).round()}% - Passed",
        failed: (r) => "0% - Failed: ${r.name}",
        orElse: () => "N/A - Not Applicable",
      );
      print('📊 ${type.toString()}: $status');
    });
    print('---------------------------------');
    print(
      '📊 Challenge Decision: ${finalResult.isPassed ? 'PASSED ✅' : 'FAILED ❌'}',
    );
    print('=================================');
  }

  void _emitMetrics({Set<LivenessFailureReason> currentFaceIssues = const {}}) {
    final metrics = _calculateCurrentMetrics();
    final allIssues = metrics.issues.union(currentFaceIssues);
    if (!_metricsController.isClosed) {
      _metricsController.add(
        LivenessMetrics(
          processingProgress: metrics.processingProgress,
          qualityScore: metrics.qualityScore,
          issues: allIssues,
        ),
      );
    }
  }

  LivenessMetrics _calculateCurrentMetrics() {
    if (_lastFailureReason != null) {
      return LivenessMetrics(issues: {_lastFailureReason!});
    }
    if (_batchBuffer.isEmpty) {
      return const LivenessMetrics(
        issues: {LivenessFailureReason.waitingForFace},
      );
    }

    final currentChallenge = ChallengeConfig.challengeOrder[_challengeIndex];
    LivenessFailureReason? hint;

    switch (currentChallenge) {
      case LivenessChallenge.positioning:
        hint = LivenessFailureReason.insufficientFrames;
        break;
      case LivenessChallenge.blinking:
        hint = LivenessFailureReason.noBlinkDetected;
        break;
      case LivenessChallenge.completed:
        hint = null;
        break;
    }

    return LivenessMetrics(issues: hint != null ? {hint} : {});
  }

  void handleFaceLost() {
    // ← NEW: Don't reset if already completed
    if (_hasCompleted) return;
    reset();
  }

  void reset() {
    _batchBuffer.clear();
    _challengeIndex = 0;
    _lastFailureReason = null;
    _isProcessing = false;
    _hasCompleted = false; // ← NEW: Reset completion flag
    _cumulativeResults.clear();
    _emitMetrics();
  }

  void dispose() {
    _metricsController.close();
  }
}
