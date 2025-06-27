import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

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
/// This class provides static methods to convert [CameraImage] objects
/// into different formats, running intensive operations in a separate isolate
/// to prevent UI jank.
abstract class ImageConverter {
  /// Converts a [CameraImage] to a [ProcessedFrame] with metadata.
  ///
  /// This method provides a richer output including the original image,
  /// base64 string, and timestamp for comprehensive frame processing.
  /// It also handles image rotation based on sensor orientation.
  static Future<ProcessedFrame?> convertCameraImageToProcessedFrame(
    CameraImage cameraImage, [
    int sensorOrientation = 0,
  ]) async {
    try {
      // Use Isolate.run to run the conversion in a separate isolate.
      final result = await Isolate.run(
        () => processImageInIsolateWithMetadata(cameraImage, sensorOrientation),
      );

      if (result == null) {
        return null;
      }

      return ProcessedFrame(
        base64Image: result['base64'] as String,
        originalImage: result['image'] as img.Image,
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

  /// Orchestrates image processing with metadata for ProcessedFrame creation.
  /// This runs in an isolate.
  static Map<String, dynamic>? processImageInIsolateWithMetadata(
    CameraImage cameraImage,
    int sensorOrientation,
  ) {
    final image = convertCameraImageToImage(
      cameraImage,
      sensorOrientation: sensorOrientation,
    );
    if (image == null) {
      return null;
    }
    final base64 = encodeImageToBase64(image);
    return {'base64': base64, 'image': image};
  }

  /// Converts a [CameraImage] to a library-agnostic [img.Image] object.
  /// This function handles platform-specific image formats (YUV, BGRA) and
  /// corrects the image rotation.
  /// Made public for testability.
  static img.Image? convertCameraImageToImage(
    CameraImage cameraImage, {
    int sensorOrientation = 0,
  }) {
    try {
      img.Image? image;

      if (cameraImage.format.group == ImageFormatGroup.yuv420) {
        image = convertYUV420(cameraImage);
      } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
        image = convertBGRA8888(cameraImage);
      } else {
        log('Unsupported image format: ${cameraImage.format.group}');
        return null;
      }

      if (image == null) {
        return null;
      }

      // Apply rotation to correct the image orientation
      return _rotateImage(image, sensorOrientation);
    } catch (e, stackTrace) {
      log('Error converting CameraImage to Image: $e', stackTrace: stackTrace);
      return null;
    }
  }

  /// Encodes an [img.Image] object to a Base64 JPEG string.
  /// Made public for testability.
  static String encodeImageToBase64(img.Image image) {
    final jpegBytes = img.encodeJpg(image, quality: 85);
    return base64Encode(jpegBytes);
  }

  /// A secondary dispatcher for YUV420 format. It checks the number of planes
  /// to decide which specific conversion algorithm to use.
  static img.Image? convertYUV420(CameraImage image) {
    if (image.planes.length == 3) {
      // Handles planar YUV420 (I420) - common on Android
      return _convertFrom3Planes(image);
    } else if (image.planes.length == 2) {
      // Handles bi-planar YUV420 (NV12) - common on iOS
      return _convertFrom2Planes(image);
    } else {
      // Unsupported YUV plane count.
      log('Unsupported YUV plane count: ${image.planes.length}');
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

  /// Converts a single YUV pixel to RGB values.
  static List<int> _yuvToRgb(int y, int u, int v) {
    final r = (y + 1.402 * (v - 128)).round();
    final g = (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).round();
    final b = (y + 1.772 * (u - 128)).round();
    return [r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255)];
  }

  /// Converts an image from 3-plane YUV (Y, U, V) to RGB.
  static img.Image _convertFrom3Planes(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final convertedImage = img.Image(width: width, height: height);

    final yPlane = image.planes[0].bytes;
    final uPlane = image.planes[1].bytes;
    final vPlane = image.planes[2].bytes;

    final yRowStride = image.planes[0].bytesPerRow;
    final uvRowStride = image.planes[1].bytesPerRow;
    final uvPixelStride = image.planes[1].bytesPerPixel ?? 1;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final int index = y * yRowStride + x;

        final yValue = yPlane[index];
        final uValue = uPlane[uvIndex];
        final vValue = vPlane[uvIndex];

        final rgb = _yuvToRgb(yValue, uValue, vValue);
        convertedImage.setPixelRgb(x, y, rgb[0], rgb[1], rgb[2]);
      }
    }
    return convertedImage;
  }

  /// Converts an image from 2-plane YUV (NV12) to RGB.
  static img.Image _convertFrom2Planes(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final newImage = img.Image(width: width, height: height);

    final yPlane = image.planes[0].bytes;
    final uvPlane = image.planes[1].bytes;

    final yRowStride = image.planes[0].bytesPerRow;
    final uvRowStride = image.planes[1].bytesPerRow;
    final uvPixelStride =
        image.planes[1].bytesPerPixel ?? 2; // Should be 2 for NV12

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final yIndex = y * yRowStride + x;
        final yValue = yPlane[yIndex];

        final uvx = (x / 2).floor();
        final uvy = (y / 2).floor();
        final uvIndex = uvy * uvRowStride + uvx * uvPixelStride;

        final uValue = uvPlane[uvIndex];
        final vValue = uvPlane[uvIndex + 1];

        final rgb = _yuvToRgb(yValue, uValue, vValue);
        newImage.setPixelRgb(x, y, rgb[0], rgb[1], rgb[2]);
      }
    }
    return newImage;
  }

  /// Converts a BGRA8888 image to a standard RGB image.
  static img.Image convertBGRA8888(CameraImage image) {
    return img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: image.planes[0].bytes.buffer,
      order: img.ChannelOrder.bgra,
    );
  }
}
