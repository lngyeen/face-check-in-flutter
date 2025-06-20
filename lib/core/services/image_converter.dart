import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

/// A static utility class for image conversion tasks.
///
/// This class provides static methods to convert [CameraImage] objects
/// into different formats, running intensive operations in a separate isolate
/// to prevent UI jank.
abstract class ImageConverter {
  /// Converts a [CameraImage] to a Base64 encoded string.
  ///
  /// This is the primary entry point which orchestrates the conversion
  /// pipeline in a background isolate.
  static Future<String?> convertCameraImageToBase64(
    CameraImage cameraImage,
  ) async {
    // Use Isolate.run to run the conversion in a separate isolate.
    return Isolate.run(() => _processImageInIsolate(cameraImage));
  }

  /// Orchestrates the full image processing pipeline within an isolate.
  static String? _processImageInIsolate(CameraImage cameraImage) {
    final image = convertCameraImageToImage(cameraImage);
    if (image == null) {
      return null;
    }
    return encodeImageToBase64(image);
  }

  /// Converts a [CameraImage] to a library-agnostic [img.Image] object.
  /// This function handles platform-specific image formats (YUV, BGRA) and
  /// corrects the image rotation.
  /// Made public for testability.
  static img.Image? convertCameraImageToImage(CameraImage cameraImage) {
    try {
      img.Image? image;

      if (cameraImage.format.group == ImageFormatGroup.yuv420) {
        image = convertYUV420(cameraImage);
      } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
        image = convertBGRA8888(cameraImage);
      } else {
        return null;
      }

      if (image == null) return null;

      // The image is often captured in landscape, so we rotate it to portrait.
      return img.copyRotate(image, angle: -90);
    } catch (e) {
      debugPrint("Error during image conversion to Image object: $e");
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
      return convertFrom3Planes(image);
    } else if (image.planes.length == 2) {
      // Handles bi-planar YUV420 (NV12) - common on iOS
      return convertFrom2Planes(image);
    } else {
      // Unsupported YUV plane count.
      return null;
    }
  }

  /// Converts an image from 3-plane YUV (Y, U, V) to RGB.
  static img.Image convertFrom3Planes(CameraImage image) {
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

        final r = (yValue + 1.402 * (vValue - 128)).round();
        final g =
            (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
                .round();
        final b = (yValue + 1.772 * (uValue - 128)).round();

        convertedImage.setPixelRgb(
          x,
          y,
          r.clamp(0, 255),
          g.clamp(0, 255),
          b.clamp(0, 255),
        );
      }
    }
    return convertedImage;
  }

  /// Converts an image from 2-plane YUV (NV12) to RGB.
  static img.Image convertFrom2Planes(CameraImage image) {
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

        final r = (yValue + 1.402 * (vValue - 128)).round();
        final g =
            (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
                .round();
        final b = (yValue + 1.772 * (uValue - 128)).round();

        newImage.setPixelRgb(
          x,
          y,
          r.clamp(0, 255),
          g.clamp(0, 255),
          b.clamp(0, 255),
        );
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
