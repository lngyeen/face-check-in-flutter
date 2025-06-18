import 'package:flutter_test/flutter_test.dart';
import 'package:face_check_in_flutter/core/services/frame_capture_service.dart';
import 'package:face_check_in_flutter/core/services/frame_processor.dart';
import 'package:face_check_in_flutter/core/enums/frame_capture_status.dart';
import 'package:face_check_in_flutter/core/models/frame_data.dart';

void main() {
  group('FrameCaptureService', () {
    late FrameCaptureService frameCaptureService;
    late FrameProcessor frameProcessor;

    setUp(() {
      frameProcessor = FrameProcessor();
      frameCaptureService = FrameCaptureService(frameProcessor);
    });

    tearDown(() {
      frameCaptureService.dispose();
    });

    group('Service Lifecycle', () {
      test('should initialize with idle status', () {
        expect(frameCaptureService.status, equals(FrameCaptureStatus.idle));
        expect(frameCaptureService.metrics.totalFrames, equals(0));
      });

      test('should handle status transitions correctly', () async {
        // Initial state
        expect(frameCaptureService.status, equals(FrameCaptureStatus.idle));
        expect(frameCaptureService.status.canStart, isTrue);
        expect(frameCaptureService.status.canStop, isFalse);
      });

      test('should provide proper status descriptions', () {
        expect(
          FrameCaptureStatus.idle.description,
          equals('Ready to start capturing'),
        );
        expect(
          FrameCaptureStatus.active.description,
          equals('Capturing frames'),
        );
        expect(
          FrameCaptureStatus.error.description,
          equals('Frame capture error'),
        );
      });
    });

    group('Performance Monitoring', () {
      test('should track metrics correctly', () {
        final metrics = frameCaptureService.metrics;

        expect(metrics.totalFrames, equals(0));
        expect(metrics.successfulFrames, equals(0));
        expect(metrics.failedFrames, equals(0));
        expect(metrics.currentFps, equals(0.0));
        expect(metrics.averageFps, equals(0.0));
      });

      test('should calculate success rate correctly', () {
        const metrics = FrameCaptureMetrics(
          totalFrames: 100,
          successfulFrames: 85,
          failedFrames: 15,
        );

        expect(metrics.successRate, equals(85.0));
        expect(metrics.failureRate, equals(15.0));
      });

      test('should check performance targets', () {
        const fastMetrics = FrameCaptureMetrics(
          currentFps: 30.0,
          averageProcessingTimeMs: 25.0,
        );

        const slowMetrics = FrameCaptureMetrics(
          currentFps: 20.0,
          averageProcessingTimeMs: 45.0,
        );

        expect(fastMetrics.meetsTargetFps, isTrue);
        expect(fastMetrics.meetsTargetProcessingTime, isTrue);

        expect(slowMetrics.meetsTargetFps, isFalse);
        expect(slowMetrics.meetsTargetProcessingTime, isFalse);
      });

      test('should calculate throughput string', () {
        const metrics = FrameCaptureMetrics(
          totalBytesProcessed: 1024 * 1024, // 1 MB
          sessionStartTime: null,
        );

        // Since sessionStartTime is null, duration will be 0
        expect(metrics.throughputString, equals('0 B/s'));
      });
    });

    group('Frame Data Validation', () {
      test('should validate frame data properties', () {
        final frameData = FrameData(
          id: 'test_frame_123',
          base64Data: 'dGVzdCBkYXRh', // "test data" in base64
          timestamp: DateTime.now(),
          width: 640,
          height: 480,
          format: 'yuv420',
          originalSize: 460800, // 640 * 480 * 1.5 (YUV420)
          encodedSize: 12, // base64 encoded size
          processingTimeMs: 25,
          quality: 0.8,
        );

        expect(frameData.compressionRatio, closeTo(0.000026, 0.000001));
        expect(frameData.isWithinTargetTime, isTrue);
        expect(frameData.aspectRatio, closeTo(1.333, 0.001));
        expect(frameData.sizeString, equals('640x480'));
        expect(frameData.ageMs, greaterThanOrEqualTo(0));
      });

      test('should identify frames outside target time', () {
        final slowFrame = FrameData(
          id: 'slow_frame',
          base64Data: 'data',
          timestamp: DateTime.now(),
          width: 640,
          height: 480,
          format: 'yuv420',
          originalSize: 460800,
          encodedSize: 50000,
          processingTimeMs: 50, // Exceeds 33ms target
          quality: 0.8,
        );

        expect(slowFrame.isWithinTargetTime, isFalse);
      });
    });

    group('Error Handling', () {
      test('should handle invalid frame capture status transitions', () {
        expect(frameCaptureService.status.canStart, isTrue);
        expect(frameCaptureService.status.canStop, isFalse);
        expect(frameCaptureService.status.canPause, isFalse);
        expect(frameCaptureService.status.canResume, isFalse);
      });

      test('should handle frame processing exceptions gracefully', () {
        expect(
          () => const FrameProcessingException('Test error'),
          returnsNormally,
        );

        expect(
          () => const FrameProcessingException('Test error', 'Cause'),
          returnsNormally,
        );
      });

      test('should handle frame capture exceptions gracefully', () {
        expect(
          () => const FrameCaptureException('Test error'),
          returnsNormally,
        );

        expect(
          () => const FrameCaptureException('Test error', 'Cause'),
          returnsNormally,
        );
      });
    });

    group('Stream Management', () {
      test('should provide status stream', () {
        expect(
          frameCaptureService.statusStream,
          isA<Stream<FrameCaptureStatus>>(),
        );
      });

      test('should provide frame stream', () {
        expect(frameCaptureService.frameStream, isA<Stream<FrameData>>());
      });

      test('should provide metrics stream', () {
        expect(
          frameCaptureService.metricsStream,
          isA<Stream<FrameCaptureMetrics>>(),
        );
      });

      test('should provide error stream', () {
        expect(
          frameCaptureService.errorStream,
          isA<Stream<FrameCaptureException>>(),
        );
      });
    });

    group('Performance Recommendations', () {
      test('should handle empty performance history', () {
        expect(frameCaptureService.isPerformanceAcceptable, isTrue);
      });

      test('should calculate recommended frame rate', () {
        final recommendedFps = frameCaptureService.getRecommendedFrameRate();
        expect(recommendedFps, equals(30.0)); // Default when no history
      });
    });
  });
}
