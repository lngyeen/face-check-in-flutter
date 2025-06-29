import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:yuv_converter/yuv_converter.dart' as yuv_converter;

// Forward declaration for ProcessedFrame
class ProcessedFrame {
  final String base64Image;
  final img.Image originalImage;
  final DateTime timestamp;

  const ProcessedFrame({
    required this.base64Image,
    required this.originalImage,
    required this.timestamp,
  });
}

/// A static utility class for image conversion tasks.
///
/// This class provides a high-level static method to convert [CameraImage]
/// objects into a [ProcessedFrame]. Intensive YUV conversion is offloaded to a
/// background isolate via the `yuv_converter` package.
abstract class ImageConverter {
  // Use the singleton instance of the YuvConverter.

  /// Converts a [CameraImage] to a [ProcessedFrame] with metadata.
  ///
  /// This method handles platform-specific image formats, corrects for sensor
  /// orientation, and produces a ProcessedFrame containing a base64 string
  /// and the final [img.Image] object.
  static Future<ProcessedFrame?> convertCameraImageToProcessedFrame(
    CameraImage cameraImage, [
    int sensorOrientation = 0,
  ]) async {
    try {
      img.Image? image;

      if (cameraImage.format.group == ImageFormatGroup.yuv420) {
        // Asynchronously convert YUV to RGB using the helper isolate in the package.
        image = await _convertYUV420(cameraImage);
      } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
        // Directly convert BGRA on the main thread (less intensive).
        image = _convertBGRA8888(cameraImage);
      } else {
        log('Unsupported image format: ${cameraImage.format.group}');
        return null;
      }

      if (image == null) {
        log('Image conversion resulted in null.');
        return null;
      }

      // Rotation and encoding are less intensive and can run on the main thread.
      final rotatedImage = _rotateImage(image, sensorOrientation);
      final base64String = _encodeImageToBase64(rotatedImage);

      return ProcessedFrame(
        base64Image: base64String,
        originalImage: rotatedImage,
        timestamp: DateTime.now(),
      );
    } catch (e, stackTrace) {
      log(
        'Error in convertCameraImageToProcessedFrame: $e',
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Encodes an [img.Image] object to a Base64 JPEG string.
  static String _encodeImageToBase64(img.Image image) {
    // This is a CPU-bound operation, but fast enough for this context.
    final jpegBytes = img.encodeJpg(image, quality: 85);
    return base64Encode(jpegBytes);
  }

  /// A secondary dispatcher for YUV420 format. It uses the FFI-based
  /// converter to transform YUV planes into an RGB image.
  static Future<img.Image?> _convertYUV420(CameraImage image) async {
    try {
      // Call the async method which uses an isolate under the hood.
      final Uint8List? rgbBytes = await yuv_converter.convertYuvToRgbAsync(
        image,
      );

      if (rgbBytes == null) {
        log('YUV to RGB conversion returned null.');
        return null;
      }

      // Create an img.Image from the raw RGB bytes returned by the FFI call.
      // The C code produces 3-byte RGB, so we use ChannelOrder.rgb.
      return img.Image.fromBytes(
        width: image.width,
        height: image.height,
        bytes: rgbBytes.buffer,
        order: img.ChannelOrder.rgb,
      );
    } catch (e, stackTrace) {
      log('Failed to convert YUV to RGB using FFI: $e', stackTrace: stackTrace);
      return null;
    }
  }

  /// Rotates an [img.Image] based on the camera's sensor orientation.
  static img.Image _rotateImage(img.Image image, int sensorOrientation) {
    switch (sensorOrientation) {
      case 90:
        return img.copyRotate(image, angle: 90);
      case 180:
        return img.copyRotate(image, angle: 180);
      case 270:
        return img.copyRotate(image, angle: -90);
      case 0:
      default:
        return image;
    }
  }

  /// Converts a BGRA8888 image to a standard RGB image.
  static img.Image _convertBGRA8888(CameraImage image) {
    return img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: image.planes[0].bytes.buffer,
      order: img.ChannelOrder.bgra,
    );
  }
}
