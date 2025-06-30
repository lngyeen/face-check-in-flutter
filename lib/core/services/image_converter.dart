import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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

  /// Converts a [CameraImage] to a [ProcessedFrame] synchronously.
  ///
  /// This is a blocking call and should ONLY be called from a background isolate.
  static ProcessedFrame? convertCameraImageToProcessedFrameSync(
    CameraImage cameraImage, {
    int sensorOrientation = 0,
    CameraLensDirection lensDirection = CameraLensDirection.back,
  }) {
    try {
      img.Image? image;

      if (cameraImage.format.group == ImageFormatGroup.yuv420) {
        // Synchronously convert YUV to RGB. This is a blocking call.
        image = _convertYUV420Sync(cameraImage);
      } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
        // Directly convert BGRA (less intensive).
        image = _convertBGRA8888(cameraImage);
      } else {
        log('Unsupported image format: ${cameraImage.format.group}');
        return null;
      }

      if (image == null) {
        log('Image conversion resulted in null.');
        return null;
      }

      // Rotation and encoding are less intensive and can run on the main thread,
      // but are kept here for simplicity since we're already on a worker.
      final processedImage = _processImageOrientation(
        image,
        sensorOrientation,
        lensDirection,
      );
      final base64String = _encodeImageToBase64(processedImage);

      return ProcessedFrame(
        base64Image: base64String,
        originalImage: processedImage,
        timestamp: DateTime.now(),
      );
    } catch (e, stackTrace) {
      log(
        'Error in convertCameraImageToProcessedFrameSync: $e',
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

  /// Synchronous version of [_convertYUV420].
  static img.Image? _convertYUV420Sync(CameraImage image) {
    try {
      // Call the sync method which blocks the current thread.
      final Uint8List? rgbBytes = yuv_converter.convertYuvToRgb(image);

      if (rgbBytes == null) {
        log('YUV to RGB conversion returned null.');
        return null;
      }

      // Create an img.Image from the raw RGB bytes returned by the FFI call.
      return img.Image.fromBytes(
        width: image.width,
        height: image.height,
        bytes: rgbBytes.buffer,
        order: img.ChannelOrder.rgb,
      );
    } catch (e, stackTrace) {
      log(
        'Failed to convert YUV to RGB using FFI (sync): $e',
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Rotates and flips an image based on camera properties and platform.
  static img.Image _processImageOrientation(
    img.Image image,
    int sensorOrientation,
    CameraLensDirection lensDirection,
  ) {
    // For iOS, the camera plugin generally provides correctly oriented images.
    // We can return the image directly without any processing.
    if (Platform.isIOS) {
      return image;
    }

    // For Android, we must handle rotation and mirroring manually.
    if (Platform.isAndroid) {
      img.Image rotatedImage;

      // First, rotate the image based on sensor orientation.
      switch (sensorOrientation) {
        case 90:
          rotatedImage = img.copyRotate(image, angle: 90);
          break;
        case 180:
          rotatedImage = img.copyRotate(image, angle: 180);
          break;
        case 270:
          rotatedImage = img.copyRotate(image, angle: -90);
          break;
        case 0:
        default:
          rotatedImage = image;
          break;
      }

      // Then, for the front camera, flip the image horizontally to create a
      // mirror effect, which is the expected behavior for selfies.
      if (lensDirection == CameraLensDirection.front) {
        return img.flipHorizontal(rotatedImage);
      }

      return rotatedImage;
    }

    // Fallback for any other platform, return the image as is.
    return image;
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
