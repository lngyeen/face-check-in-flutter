import 'dart:async';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

// Import existing ImageConverter for integration
import 'package:face_check_in_flutter/core/services/image_converter.dart'
    as img_converter;

/// Streaming status representing different streaming states
enum StreamingStatus {
  idle,
  active,
  error,
}

/// Frame data structure for image processing
class FrameData {
  final CameraImage image;
  final int sensorOrientation;
  final CameraLensDirection lensDirection;

  const FrameData({
    required this.image,
    required this.sensorOrientation,
    required this.lensDirection,
  });
}

/// Processed frame after image conversion
class ProcessedFrame {
  final String base64Image;
  final int width;
  final int height;
  final DateTime timestamp;

  const ProcessedFrame({
    required this.base64Image,
    required this.width,
    required this.height,
    required this.timestamp,
  });
}

/// Abstract interface for image streaming services
///
/// Handles image frame processing pipeline from camera to processed frames.
/// Manages frame rate control, throttling, and image conversion.
abstract class ImageStreamingService {
  /// Stream of streaming status changes
  Stream<StreamingStatus> get statusStream;

  /// Stream of processed frames ready for transmission
  Stream<ProcessedFrame> get processedFrameStream;

  /// Current streaming status
  StreamingStatus get currentStatus;

  /// Current maximum FPS setting
  int get maxFps;

  /// Set maximum frames per second for streaming
  ///
  /// [fps] must be between 1 and 30
  void setMaxFps(int fps);

  /// Start image streaming from camera controller
  ///
  /// [controller] must be initialized and ready
  Future<void> start(CameraController controller);

  /// Stop image streaming
  Future<void> stop();

  /// Dispose service and cleanup resources
  void dispose();
}

/// Implementation of ImageStreamingService
///
/// Extracted from StreamServiceImpl to follow Single Responsibility Principle.
/// Manages only image streaming and processing functionality.
@LazySingleton(as: ImageStreamingService)
class ImageStreamingServiceImpl implements ImageStreamingService {
  // Configuration
  int _maxFps = 2;
  Duration get _throttleDuration => Duration(milliseconds: 1000 ~/ _maxFps);

  // RxDart stream management
  final _frameSubject = PublishSubject<FrameData>();
  final _statusSubject =
      BehaviorSubject<StreamingStatus>.seeded(StreamingStatus.idle);
  final _processedFrameSubject = PublishSubject<ProcessedFrame>();

  StreamSubscription? _frameSubscription;
  CameraController? _currentController;

  @override
  Stream<StreamingStatus> get statusStream => _statusSubject.stream;

  @override
  Stream<ProcessedFrame> get processedFrameStream =>
      _processedFrameSubject.stream;

  @override
  StreamingStatus get currentStatus => _statusSubject.value;

  @override
  int get maxFps => _maxFps;

  ImageStreamingServiceImpl() {
    _initializeFrameProcessing();
  }

  /// Initializes the frame processing pipeline with RxDart
  void _initializeFrameProcessing() {
    _frameSubscription?.cancel();
    _frameSubscription = _frameSubject
        .throttleTime(_throttleDuration)
        .where((_) => _statusSubject.value == StreamingStatus.active)
        .asyncMap((frameData) {
      return Isolate.run(
        () => _convertCameraImageToProcessedFrame(frameData),
      );
    }).listen(
      (ProcessedFrame? processedFrame) {
        if (processedFrame != null) {
          _processedFrameSubject.add(processedFrame);
        }
      },
      onError: (error) {
        _statusSubject.add(StreamingStatus.error);
      },
    );
  }

  @override
  void setMaxFps(int fps) {
    if (fps < 1 || fps > 30) {
      throw ArgumentError('maxFps must be between 1 and 30');
    }

    final wasActive = currentStatus == StreamingStatus.active;
    _maxFps = fps;

    // Only reinitialize if currently streaming to avoid race condition
    if (wasActive) {
      _initializeFrameProcessing();
    }
  }

  @override
  Future<void> start(CameraController controller) async {
    if (currentStatus == StreamingStatus.active ||
        !controller.value.isInitialized) {
      return;
    }

    try {
      _currentController = controller;
      _statusSubject.add(StreamingStatus.active);

      await controller.startImageStream((CameraImage image) {
        // Double-check status to prevent processing after stop
        if (currentStatus != StreamingStatus.active) return;

        _frameSubject.add(FrameData(
          image: image,
          sensorOrientation: controller.description.sensorOrientation,
          lensDirection: controller.description.lensDirection,
        ));
      });

      // Verify stream actually started successfully
      if (!controller.value.isStreamingImages) {
        throw StateError('Failed to start image stream');
      }
    } catch (e) {
      // Cleanup on failure
      _currentController = null;
      _statusSubject.add(StreamingStatus.error);
      rethrow;
    }
  }

  @override
  Future<void> stop() async {
    if (currentStatus != StreamingStatus.active || _currentController == null) {
      return;
    }

    // Update status first to prevent new frames
    _statusSubject.add(StreamingStatus.idle);

    try {
      if (_currentController!.value.isStreamingImages) {
        await _currentController!.stopImageStream();
      }
    } catch (e) {
      // Log but don't fail the stop operation
      // Silent error handling during stop
    } finally {
      // Always cleanup regardless of errors
      _currentController = null;
    }
  }

  @override
  void dispose() {
    stop();
    _frameSubscription?.cancel();
    _frameSubject.close();
    _statusSubject.close();
    _processedFrameSubject.close();
  }

  /// Convert camera image to processed frame using existing ImageConverter
  static ProcessedFrame? _convertCameraImageToProcessedFrame(
      FrameData frameData) {
    try {
      // Use existing ImageConverter service for proper image conversion
      final convertedFrame =
          img_converter.ImageConverter.convertCameraImageToProcessedFrameSync(
        frameData.image,
        sensorOrientation: frameData.sensorOrientation,
        lensDirection: frameData.lensDirection,
      );

      if (convertedFrame == null) {
        return null;
      }

      // Map from existing ProcessedFrame to our ProcessedFrame format
      return ProcessedFrame(
        base64Image: convertedFrame.base64Image,
        width: convertedFrame.originalImage.width,
        height: convertedFrame.originalImage.height,
        timestamp: convertedFrame.timestamp,
      );
    } catch (e) {
      return null;
    }
  }
}
