import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import '../models/frame_data.dart';

/// Exception thrown when frame processing fails
class FrameProcessingException implements Exception {
  const FrameProcessingException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'FrameProcessingException: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

/// Service responsible for processing camera frames and converting them to base64
@injectable
class FrameProcessor {
  static const int _targetFrameSize = 640; // Target width for processing
  static const double _jpegQuality = 0.8; // JPEG compression quality

  /// Converts a CameraImage to base64 format
  /// Optimized for real-time processing with memory management
  Future<FrameData> processFrame(CameraImage image) async {
    final stopwatch = Stopwatch()..start();

    try {
      // Generate unique frame ID
      final frameId = _generateFrameId();

      // Convert camera image to RGB bytes
      final rgbBytes = await _convertToRgb(image);

      // Create UI image from RGB bytes
      final uiImage = await _createUiImage(rgbBytes, image.width, image.height);

      // Resize image for optimal processing
      final resizedImage = await _resizeImage(uiImage);

      // Convert to JPEG bytes
      final jpegBytes = await _imageToJpeg(resizedImage);

      // Encode to base64
      final base64String = base64Encode(jpegBytes);

      stopwatch.stop();

      // Calculate sizes
      final originalSize = _calculateOriginalSize(image);
      final encodedSize = base64String.length;

      return FrameData(
        id: frameId,
        base64Data: base64String,
        timestamp: DateTime.now(),
        width: resizedImage.width,
        height: resizedImage.height,
        format: _detectImageFormat(image),
        originalSize: originalSize,
        encodedSize: encodedSize,
        processingTimeMs: stopwatch.elapsedMilliseconds,
        quality: _jpegQuality,
      );
    } catch (e) {
      stopwatch.stop();
      throw FrameProcessingException(
        'Failed to process frame after ${stopwatch.elapsedMilliseconds}ms',
        e,
      );
    }
  }

  /// Converts CameraImage to RGB format
  Future<Uint8List> _convertToRgb(CameraImage image) async {
    try {
      switch (image.format.group) {
        case ImageFormatGroup.yuv420:
          return _convertYuv420ToRgb(image);
        case ImageFormatGroup.bgra8888:
          return _convertBgra8888ToRgb(image);
        case ImageFormatGroup.jpeg:
          return image.planes[0].bytes;
        case ImageFormatGroup.nv21:
          return _convertNv21ToRgb(image);
        default:
          throw FrameProcessingException(
            'Unsupported image format: ${image.format.group}',
          );
      }
    } catch (e) {
      throw FrameProcessingException('Format conversion failed', e);
    }
  }

  /// Converts YUV420 format to RGB
  Uint8List _convertYuv420ToRgb(CameraImage image) {
    final width = image.width;
    final height = image.height;
    final rgbBytes = Uint8List(width * height * 3);

    final yPlane = image.planes[0];
    final uPlane = image.planes[1];
    final vPlane = image.planes[2];

    int rgbIndex = 0;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final yIndex = y * yPlane.bytesPerRow + x;
        final uvIndex = (y ~/ 2) * uPlane.bytesPerRow + (x ~/ 2);

        if (yIndex < yPlane.bytes.length &&
            uvIndex < uPlane.bytes.length &&
            uvIndex < vPlane.bytes.length) {
          final yValue = yPlane.bytes[yIndex];
          final uValue = uPlane.bytes[uvIndex];
          final vValue = vPlane.bytes[uvIndex];

          // YUV to RGB conversion
          final r = (yValue + 1.402 * (vValue - 128)).clamp(0, 255).toInt();
          final g =
              (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
                  .clamp(0, 255)
                  .toInt();
          final b = (yValue + 1.772 * (uValue - 128)).clamp(0, 255).toInt();

          rgbBytes[rgbIndex++] = r;
          rgbBytes[rgbIndex++] = g;
          rgbBytes[rgbIndex++] = b;
        }
      }
    }

    return rgbBytes;
  }

  /// Converts BGRA8888 format to RGB
  Uint8List _convertBgra8888ToRgb(CameraImage image) {
    final bytes = image.planes[0].bytes;
    final rgbBytes = Uint8List((bytes.length * 3) ~/ 4);

    int rgbIndex = 0;
    for (int i = 0; i < bytes.length; i += 4) {
      rgbBytes[rgbIndex++] = bytes[i + 2]; // R
      rgbBytes[rgbIndex++] = bytes[i + 1]; // G
      rgbBytes[rgbIndex++] = bytes[i]; // B
      // Skip alpha channel
    }

    return rgbBytes;
  }

  /// Converts NV21 format to RGB
  Uint8List _convertNv21ToRgb(CameraImage image) {
    final width = image.width;
    final height = image.height;
    final rgbBytes = Uint8List(width * height * 3);

    final yPlane = image.planes[0].bytes;
    final uvPlane = image.planes[1].bytes;

    int rgbIndex = 0;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final yIndex = y * width + x;
        final uvIndex = ((y ~/ 2) * (width ~/ 2) + (x ~/ 2)) * 2;

        if (yIndex < yPlane.length && uvIndex + 1 < uvPlane.length) {
          final yValue = yPlane[yIndex];
          final vValue = uvPlane[uvIndex];
          final uValue = uvPlane[uvIndex + 1];

          // YUV to RGB conversion
          final r = (yValue + 1.402 * (vValue - 128)).clamp(0, 255).toInt();
          final g =
              (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
                  .clamp(0, 255)
                  .toInt();
          final b = (yValue + 1.772 * (uValue - 128)).clamp(0, 255).toInt();

          rgbBytes[rgbIndex++] = r;
          rgbBytes[rgbIndex++] = g;
          rgbBytes[rgbIndex++] = b;
        }
      }
    }

    return rgbBytes;
  }

  /// Creates a UI Image from RGB bytes
  Future<ui.Image> _createUiImage(
    Uint8List rgbBytes,
    int width,
    int height,
  ) async {
    final completer = Completer<ui.Image>();

    ui.decodeImageFromPixels(
      rgbBytes,
      width,
      height,
      ui.PixelFormat.rgba8888,
      completer.complete,
    );

    return completer.future;
  }

  /// Resizes image to target size while maintaining aspect ratio
  Future<ui.Image> _resizeImage(ui.Image image) async {
    final aspectRatio = image.width / image.height;

    int targetWidth, targetHeight;
    if (image.width > image.height) {
      targetWidth = _targetFrameSize;
      targetHeight = (_targetFrameSize / aspectRatio).round();
    } else {
      targetHeight = _targetFrameSize;
      targetWidth = (_targetFrameSize * aspectRatio).round();
    }

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    canvas.drawImageRect(
      image,
      ui.Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      ui.Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetHeight.toDouble()),
      ui.Paint(),
    );

    final picture = recorder.endRecording();
    return picture.toImage(targetWidth, targetHeight);
  }

  /// Converts UI Image to JPEG bytes
  Future<Uint8List> _imageToJpeg(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw FrameProcessingException('Failed to convert image to bytes');
    }
    return byteData.buffer.asUint8List();
  }

  /// Generates unique frame ID
  String _generateFrameId() {
    return 'frame_${DateTime.now().millisecondsSinceEpoch}_${_randomSuffix()}';
  }

  /// Generates random suffix for frame ID
  String _randomSuffix() {
    return DateTime.now().microsecond.toString().padLeft(6, '0');
  }

  /// Detects the original image format
  String _detectImageFormat(CameraImage image) {
    switch (image.format.group) {
      case ImageFormatGroup.yuv420:
        return 'yuv420';
      case ImageFormatGroup.bgra8888:
        return 'bgra8888';
      case ImageFormatGroup.jpeg:
        return 'jpeg';
      case ImageFormatGroup.nv21:
        return 'nv21';
      default:
        return 'unknown';
    }
  }

  /// Calculates original frame size in bytes
  int _calculateOriginalSize(CameraImage image) {
    return image.planes.fold(0, (sum, plane) => sum + plane.bytes.length);
  }

  /// Validates processing performance
  bool isPerformanceAcceptable(FrameData frameData) {
    return frameData.isWithinTargetTime &&
        frameData.compressionRatio > 0.1 && // Reasonable compression
        frameData.compressionRatio < 10.0; // Not too compressed
  }

  /// Gets recommended frame rate based on processing performance
  double getRecommendedFrameRate(List<FrameData> recentFrames) {
    if (recentFrames.isEmpty) return 30.0;

    final averageProcessingTime =
        recentFrames
            .where((frame) => frame.processingTimeMs != null)
            .map((frame) => frame.processingTimeMs!)
            .fold(0, (sum, time) => sum + time) /
        recentFrames.length;

    // Calculate max sustainable frame rate
    final maxFrameRate = 1000 / averageProcessingTime;

    // Return conservative estimate
    return (maxFrameRate * 0.8).clamp(1.0, 30.0);
  }
}
