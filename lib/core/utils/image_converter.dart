import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

/// A utility class for image conversion tasks.
///
/// Provides static methods to handle complex image conversions,
/// specifically designed to run in a separate isolate to avoid
/// blocking the main UI thread.
class ImageConverter {
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
      return result;
    } else {
      throw Exception('Image conversion failed');
    }
  }

  /// The internal conversion function that runs in the isolate.
  static void _convertCameraImage(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final cameraImage = args[1] as CameraImage;

    try {
      final image = _convertYUV420ToImage(cameraImage);
      final jpg = img.encodeJpg(image, quality: 75);
      final base64String = base64Encode(jpg);
      Isolate.exit(sendPort, base64String);
    } catch (e) {
      Isolate.exit(sendPort, e.toString());
    }
  }

  /// Converts a `CameraImage` in YUV420 format to an `img.Image` object.
  static img.Image _convertYUV420ToImage(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;

    final yPlane = cameraImage.planes[0].bytes;
    final uPlane = cameraImage.planes[1].bytes;
    final vPlane = cameraImage.planes[2].bytes;

    final yuv420 = Uint8List(width * height * 3 ~/ 2);

    int yIndex = 0;
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        yuv420[yIndex++] = yPlane[i * cameraImage.planes[0].bytesPerRow + j];
      }
    }

    int uvIndex = width * height;
    final uRowStride = cameraImage.planes[1].bytesPerRow;
    final vRowStride = cameraImage.planes[2].bytesPerRow;
    final uPixelStride = cameraImage.planes[1].bytesPerPixel!;
    final vPixelStride = cameraImage.planes[2].bytesPerPixel!;

    for (int i = 0; i < height / 2; i++) {
      for (int j = 0; j < width / 2; j++) {
        final uIndex = i * uRowStride + j * uPixelStride;
        final vIndex = i * vRowStride + j * vPixelStride;
        yuv420[uvIndex++] = uPlane[uIndex];
        yuv420[uvIndex++] = vPlane[vIndex];
      }
    }

    final image = img.Image.fromBytes(
      width: width,
      height: height,
      bytes: yuv420.buffer,
      format: img.Format.uint8,
      order: img.ChannelOrder.rgb,
    );

    return img.copyRotate(image, angle: 90);
  }
}
