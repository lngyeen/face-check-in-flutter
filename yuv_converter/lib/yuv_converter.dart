import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:yuv_converter/yuv_converter_bindings_generated.dart';

// Inspired by the structure of package:native_test

const String _libName = 'yuv_converter';

final DynamicLibrary _dylib = () {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
}();

final YuvConverterBindings _bindings = YuvConverterBindings(_dylib);

/// Converts a [CameraImage] to an RGB [Uint8List] synchronously.
///
/// This is a blocking call and should only be used on a background isolate
/// to avoid dropping frames in a Flutter application.
Uint8List? convertYuvToRgb(CameraImage image) {
  final yPlane = calloc<Uint8>(
    image.planes[0].bytes.length,
  )..asTypedList(image.planes[0].bytes.length).setAll(0, image.planes[0].bytes);

  Pointer<RgbImage> result;

  if (Platform.isIOS) {
    // iOS is typically bi-planar NV12. `planes[1]` contains the interleaved UV data.
    final uvPlane = calloc<Uint8>(image.planes[1].bytes.length)
      ..asTypedList(
        image.planes[1].bytes.length,
      ).setAll(0, image.planes[1].bytes);
    result = _bindings.convert_yuv_to_rgb_biplanar(
      yPlane,
      uvPlane,
      image.planes[0].bytesPerRow,
      image.planes[1].bytesPerRow,
      image.planes[1].bytesPerPixel ?? 2,
      image.width,
      image.height,
      BiplanarFormat.NV12,
    );
    calloc.free(uvPlane);
  } else if (Platform.isAndroid) {
    // Android can be planar (I420) or semi-planar (NV21).
    // We distinguish by checking the pixel stride of the second plane.
    if (image.planes.length > 1 && image.planes[1].bytesPerPixel == 2) {
      // This is NV21 (semi-planar).
      // The V plane buffer in `planes[2]` contains the VUVU data.
      final uvPlane = calloc<Uint8>(image.planes[2].bytes.length)
        ..asTypedList(
          image.planes[2].bytes.length,
        ).setAll(0, image.planes[2].bytes);
      result = _bindings.convert_yuv_to_rgb_biplanar(
        yPlane,
        uvPlane,
        image.planes[0].bytesPerRow,
        image.planes[2].bytesPerRow,
        image.planes[2].bytesPerPixel ?? 2,
        image.width,
        image.height,
        BiplanarFormat.NV21,
      );
      calloc.free(uvPlane);
    } else {
      // This is I420 (true planar).
      final uPlane = calloc<Uint8>(image.planes[1].bytes.length)
        ..asTypedList(
          image.planes[1].bytes.length,
        ).setAll(0, image.planes[1].bytes);
      final vPlane = calloc<Uint8>(image.planes[2].bytes.length)
        ..asTypedList(
          image.planes[2].bytes.length,
        ).setAll(0, image.planes[2].bytes);
      result = _bindings.convert_yuv_to_rgb_planar(
        yPlane,
        uPlane,
        vPlane,
        image.planes[0].bytesPerRow,
        image.planes[1].bytesPerRow,
        image.planes[2].bytesPerRow,
        image.width,
        image.height,
      );
      calloc.free(uPlane);
      calloc.free(vPlane);
    }
  } else {
    calloc.free(yPlane);
    throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
  }

  calloc.free(yPlane);

  // Inlined logic from the former _processResult helper.
  if (result == nullptr) {
    _bindings.free_image_memory(result);
    return null;
  }
  final rgbImage = result.ref;
  final imageBytes = rgbImage.data.asTypedList(
    rgbImage.width * rgbImage.height * 3,
  );

  // The data from FFI must be copied into a Dart-managed list before returning.
  final clonedBytes = Uint8List.fromList(imageBytes);

  _bindings.free_image_memory(result);
  return clonedBytes;
}
