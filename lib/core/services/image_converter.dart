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

  /// Converts a [CameraImage] to a [ProcessedFrame] using original Dart implementation.
  ///
  /// This method uses pure Dart code for YUV conversion for performance comparison.
  static ProcessedFrame? convertCameraImageToProcessedFrameDart(
    CameraImage cameraImage, {
    int sensorOrientation = 0,
    CameraLensDirection lensDirection = CameraLensDirection.back,
  }) {
    try {
      img.Image? image;

      if (cameraImage.format.group == ImageFormatGroup.yuv420) {
        // Use original Dart implementation for YUV conversion
        image = _convertYUV420Dart(cameraImage);
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
        'Error in convertCameraImageToProcessedFrameDart: $e',
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

  /// Original Dart implementation for YUV420 to RGB conversion.
  /// This is the pure Dart version for performance comparison.
  static img.Image? _convertYUV420Dart(CameraImage image) {
    try {
      final int width = image.width;
      final int height = image.height;

      if (Platform.isIOS) {
        // iOS is typically bi-planar NV12. `planes[1]` contains the interleaved UV data.
        return _convertNV12Dart(image, width, height);
      } else if (Platform.isAndroid) {
        // Android can be planar (I420) or semi-planar (NV21).
        // We distinguish by checking the pixel stride of the second plane.
        if (image.planes.length > 1 && image.planes[1].bytesPerPixel == 2) {
          // This is NV21 (semi-planar).
          // The V plane buffer in `planes[2]` contains the VUVU data.
          return _convertNV21Dart(image, width, height);
        } else {
          // This is I420 (true planar).
          return _convertI420Dart(image, width, height);
        }
      } else {
        // Fallback to I420 for other platforms
        return _convertI420Dart(image, width, height);
      }
    } catch (e, stackTrace) {
      log(
        'Failed to convert YUV to RGB using Dart implementation: $e',
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Converts NV12 (bi-planar) format to RGB.
  /// Used for iOS and some Android devices.
  static img.Image _convertNV12Dart(CameraImage image, int width, int height) {
    final Uint8List yPlane = image.planes[0].bytes;
    final Uint8List uvPlane = image.planes[1].bytes;

    final int yRowStride = image.planes[0].bytesPerRow;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel ?? 2;

    final Uint8List rgbBytes = Uint8List(width * height * 3);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int yIndex = y * yRowStride + x;
        final int uvIndex = (y ~/ 2) * uvRowStride + (x ~/ 2) * uvPixelStride;

        final int yValue = yPlane[yIndex];
        final int uValue = uvPlane[uvIndex];
        final int vValue = uvPlane[uvIndex + 1]; // V comes after U in NV12

        // YUV to RGB conversion
        int r = yValue + (1.370705 * (vValue - 128)).round();
        int g =
            yValue -
            (0.698001 * (vValue - 128)).round() -
            (0.337633 * (uValue - 128)).round();
        int b = yValue + (1.732446 * (uValue - 128)).round();

        // Clamp values to 0-255 range
        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        final int rgbIndex = (y * width + x) * 3;
        rgbBytes[rgbIndex] = r;
        rgbBytes[rgbIndex + 1] = g;
        rgbBytes[rgbIndex + 2] = b;
      }
    }

    return img.Image.fromBytes(
      width: width,
      height: height,
      bytes: rgbBytes.buffer,
      order: img.ChannelOrder.rgb,
    );
  }

  /// Converts NV21 (semi-planar) format to RGB.
  /// Used for some Android devices.
  static img.Image _convertNV21Dart(CameraImage image, int width, int height) {
    final Uint8List yPlane = image.planes[0].bytes;
    final Uint8List vuPlane = image.planes[2].bytes; // VUVU data in planes[2]

    final int yRowStride = image.planes[0].bytesPerRow;
    final int vuRowStride = image.planes[2].bytesPerRow;
    final int vuPixelStride = image.planes[2].bytesPerPixel ?? 2;

    final Uint8List rgbBytes = Uint8List(width * height * 3);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int yIndex = y * yRowStride + x;
        final int vuIndex = (y ~/ 2) * vuRowStride + (x ~/ 2) * vuPixelStride;

        final int yValue = yPlane[yIndex];
        final int vValue = vuPlane[vuIndex]; // V comes first in NV21
        final int uValue = vuPlane[vuIndex + 1]; // U comes after V in NV21

        // YUV to RGB conversion
        int r = yValue + (1.370705 * (vValue - 128)).round();
        int g =
            yValue -
            (0.698001 * (vValue - 128)).round() -
            (0.337633 * (uValue - 128)).round();
        int b = yValue + (1.732446 * (uValue - 128)).round();

        // Clamp values to 0-255 range
        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        final int rgbIndex = (y * width + x) * 3;
        rgbBytes[rgbIndex] = r;
        rgbBytes[rgbIndex + 1] = g;
        rgbBytes[rgbIndex + 2] = b;
      }
    }

    return img.Image.fromBytes(
      width: width,
      height: height,
      bytes: rgbBytes.buffer,
      order: img.ChannelOrder.rgb,
    );
  }

  /// Converts I420 (true planar) format to RGB.
  /// Used for some Android devices and as fallback.
  static img.Image _convertI420Dart(CameraImage image, int width, int height) {
    final Uint8List yPlane = image.planes[0].bytes;
    final Uint8List uPlane = image.planes[1].bytes;
    final Uint8List vPlane = image.planes[2].bytes;

    final int yRowStride = image.planes[0].bytesPerRow;
    final int uRowStride = image.planes[1].bytesPerRow;
    final int vRowStride = image.planes[2].bytesPerRow;
    final int uPixelStride = image.planes[1].bytesPerPixel ?? 1;
    final int vPixelStride = image.planes[2].bytesPerPixel ?? 1;

    final Uint8List rgbBytes = Uint8List(width * height * 3);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int yIndex = y * yRowStride + x;
        final int uIndex = (y ~/ 2) * uRowStride + (x ~/ 2) * uPixelStride;
        final int vIndex = (y ~/ 2) * vRowStride + (x ~/ 2) * vPixelStride;

        final int yValue = yPlane[yIndex];
        final int uValue = uPlane[uIndex];
        final int vValue = vPlane[vIndex];

        // YUV to RGB conversion
        int r = yValue + (1.370705 * (vValue - 128)).round();
        int g =
            yValue -
            (0.698001 * (vValue - 128)).round() -
            (0.337633 * (uValue - 128)).round();
        int b = yValue + (1.732446 * (uValue - 128)).round();

        // Clamp values to 0-255 range
        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        final int rgbIndex = (y * width + x) * 3;
        rgbBytes[rgbIndex] = r;
        rgbBytes[rgbIndex + 1] = g;
        rgbBytes[rgbIndex + 2] = b;
      }
    }

    return img.Image.fromBytes(
      width: width,
      height: height,
      bytes: rgbBytes.buffer,
      order: img.ChannelOrder.rgb,
    );
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
