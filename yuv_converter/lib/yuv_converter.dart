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
  final uPlane = calloc<Uint8>(
    image.planes[1].bytes.length,
  )..asTypedList(image.planes[1].bytes.length).setAll(0, image.planes[1].bytes);

  Pointer<RgbImage> result;

  if (image.planes.length == 3) {
    // Android (Planar)
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
      image.width,
      image.height,
    );
    calloc.free(vPlane);
  } else {
    // iOS (Bi-Planar)
    result = _bindings.convert_yuv_to_rgb_biplanar(
      yPlane,
      uPlane,
      image.planes[0].bytesPerRow,
      image.planes[1].bytesPerRow,
      image.planes[1].bytesPerPixel ?? 2,
      image.width,
      image.height,
    );
  }

  calloc.free(yPlane);
  calloc.free(uPlane);

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
