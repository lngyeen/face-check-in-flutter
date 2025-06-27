import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

import 'ffi/yuv_converter_ffi.dart';

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
  // Lazily initialize the FFI converter to avoid issues on platforms
  // where it's not available or during tests.
  static final _yuvConverter = YuvConverterFfi();

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
      final result =
      // await Isolate.run(
      //() =>
      processImageInIsolateWithMetadata(cameraImage, sensorOrientation);
      //);

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
    try {
      return _yuvConverter.convertYuvToRgb(image);
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
  static img.Image convertBGRA8888(CameraImage image) {
    return img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: image.planes[0].bytes.buffer,
      order: img.ChannelOrder.bgra,
    );
  }
}
