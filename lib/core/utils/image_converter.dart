import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';

/// A utility class for image conversion tasks.
///
/// Provides static methods to handle complex image conversions,
/// specifically designed to run in a separate isolate to avoid
/// blocking the main UI thread.
class ImageConverter {
  static int _debugImageCounter = 0;

  /// Converts a `CameraImage` from YUV420 format to a Base64 encoded JPEG string.
  ///
  /// This operation is computationally intensive and is performed in a
  /// separate isolate to prevent UI jank.
  static Future<String> convertCameraImageToBase64(
    CameraImage cameraImage,
  ) async {
    final port = ReceivePort();
    await Isolate.spawn(_convertCameraImage, [port.sendPort, cameraImage]);

    final result = await port.first;
    if (result is String) {
      // Check if result is an error message
      if (result.startsWith('Exception') ||
          result.startsWith('Error') ||
          result.startsWith('RangeError') ||
          result.length < 100) {
        throw Exception('Image conversion failed: $result');
      }

      // Debug: Log image quality info more frequently
      if (kDebugMode && _debugImageCounter % 5 == 0) {
        debugPrint(
          '📸 Image #$_debugImageCounter: Size=${cameraImage.width}x${cameraImage.height}, Base64=${result.length} chars',
        );
        debugPrint(
          '📸 Image planes: Y=${cameraImage.planes[0].bytes.length}, U=${cameraImage.planes[1].bytes.length}, V=${cameraImage.planes[2].bytes.length}',
        );
        debugPrint(
          '📸 Sample data: ${result.substring(0, result.length > 50 ? 50 : result.length)}...',
        );
      }
      _debugImageCounter++;

      return result;
    } else {
      throw Exception('Image conversion failed: Invalid result type');
    }
  }

  /// The internal conversion function that runs in the isolate.
  static void _convertCameraImage(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final cameraImage = args[1] as CameraImage;

    try {
      final image = _convertYUV420ToImage(cameraImage);

      // Debug: Log original image dimensions
      if (kDebugMode) {
        print('🔍 Original image: ${image.width}x${image.height}');
      }

      // Fix camera orientation for front camera
      // Front camera needs 270° rotation (or -90°) to be upright
      final rotatedImage = img.copyRotate(image, angle: 270);

      if (kDebugMode) {
        print(
          '🔍 Rotated image (270°): ${rotatedImage.width}x${rotatedImage.height}',
        );
      }

      // Apply auto-brightness adjustment for better face detection
      img.Image enhancedImage = img.adjustColor(
        rotatedImage,
        brightness: 1.1, // Slightly brighten
        contrast: 1.2, // Increase contrast
        saturation: 0.9, // Slightly reduce saturation
      );

      // Use enhanced image for processing
      img.Image processedImage = enhancedImage;

      // Resize image if it's too large (keep aspect ratio)
      if (enhancedImage.width > 1080 || enhancedImage.height > 1080) {
        // Calculate new dimensions maintaining aspect ratio
        double scale =
            1080 /
            (enhancedImage.width > enhancedImage.height
                ? enhancedImage.width
                : enhancedImage.height);
        int newWidth = (enhancedImage.width * scale).round();
        int newHeight = (enhancedImage.height * scale).round();

        processedImage = img.copyResize(
          enhancedImage,
          width: newWidth,
          height: newHeight,
          interpolation: img.Interpolation.linear,
        );

        if (kDebugMode) {
          print('🔍 Resized to: ${newWidth}x${newHeight}');
        }
      }

      // Use higher quality and ensure good contrast for face detection
      final jpg = img.encodeJpg(processedImage, quality: 95);
      final base64String = base64Encode(jpg);

      if (kDebugMode) {
        print(
          '🔍 Final image: ${processedImage.width}x${processedImage.height}, JPEG: ${jpg.length} bytes',
        );
      }

      Isolate.exit(sendPort, base64String);
    } catch (e) {
      Isolate.exit(sendPort, e.toString());
    }
  }

  /// Converts a `CameraImage` in YUV420 format to an `img.Image` object.
  static img.Image _convertYUV420ToImage(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;

    // Get the YUV420 data planes
    final yPlane = cameraImage.planes[0];
    final uPlane = cameraImage.planes[1];
    final vPlane = cameraImage.planes[2];

    // Create RGB image buffer
    final rgbBytes = Uint8List(width * height * 3);

    // YUV420 to RGB conversion
    int rgbIndex = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        // Get Y value
        final yIndex = y * yPlane.bytesPerRow + x;
        final yValue = yPlane.bytes[yIndex];

        // Get U and V values (subsampled at 2x2)
        final uvY = y ~/ 2;
        final uvX = x ~/ 2;
        final uIndex = uvY * uPlane.bytesPerRow + uvX * uPlane.bytesPerPixel!;
        final vIndex = uvY * vPlane.bytesPerRow + uvX * vPlane.bytesPerPixel!;

        // Bounds checking for U and V indices
        final uValue =
            (uIndex < uPlane.bytes.length) ? uPlane.bytes[uIndex] : 128;
        final vValue =
            (vIndex < vPlane.bytes.length) ? vPlane.bytes[vIndex] : 128;

        // YUV to RGB conversion formulas
        final r = (yValue + 1.402 * (vValue - 128)).clamp(0, 255).toInt();
        final g =
            (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
                .clamp(0, 255)
                .toInt();
        final b = (yValue + 1.772 * (uValue - 128)).clamp(0, 255).toInt();

        // Store RGB values
        rgbBytes[rgbIndex++] = r;
        rgbBytes[rgbIndex++] = g;
        rgbBytes[rgbIndex++] = b;
      }
    }

    // Create image from RGB bytes
    final image = img.Image.fromBytes(
      width: width,
      height: height,
      bytes: rgbBytes.buffer,
      format: img.Format.uint8,
      order: img.ChannelOrder.rgb,
    );

    // Keep original orientation as suggested
    // Return image without rotation to test server compatibility
    return image;
  }
}
