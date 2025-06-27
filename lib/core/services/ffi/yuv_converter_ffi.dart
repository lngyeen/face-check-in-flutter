import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart' as img;

// FFI signature for the C function.
typedef _ConvertYuvToRgbNative =
    Pointer<Uint32> Function(
      Pointer<Uint8>,
      Pointer<Uint8>,
      Pointer<Uint8>,
      Int32,
      Int32,
      Int32,
      Int32,
      Int32,
    );

// Dart signature for the C function.
typedef _ConvertYuvToRgbDart =
    Pointer<Uint32> Function(
      Pointer<Uint8>,
      Pointer<Uint8>,
      Pointer<Uint8>,
      int,
      int,
      int,
      int,
      int,
    );

// FFI signature for the memory freeing function.
typedef _FreeImageMemoryNative = Void Function(Pointer<Uint32>);
// Dart signature for the memory freeing function.
typedef _FreeImageMemoryDart = void Function(Pointer<Uint32>);

/// A bridge class to interact with the native C++ YUV conversion functions.
class YuvConverterFfi {
  late final _ConvertYuvToRgbDart _convertYuvToRgb;
  late final _FreeImageMemoryDart _freeImageMemory;

  YuvConverterFfi() {
    final dylib =
        Platform.isAndroid
            ? DynamicLibrary.open('libyuv_converter.so')
            : DynamicLibrary.process();

    _convertYuvToRgb =
        dylib
            .lookup<NativeFunction<_ConvertYuvToRgbNative>>(
              'convert_yuv_to_rgb',
            )
            .asFunction<_ConvertYuvToRgbDart>();

    _freeImageMemory =
        dylib
            .lookup<NativeFunction<_FreeImageMemoryNative>>('free_image_memory')
            .asFunction<_FreeImageMemoryDart>();
  }

  /// Converts a [CameraImage] from YUV format to an [img.Image] in RGB format.
  ///
  /// Returns `null` if the conversion fails.
  img.Image? convertYuvToRgb(CameraImage cameraImage) {
    Pointer<Uint8> yPlane = nullptr;
    Pointer<Uint8> uPlane = nullptr;
    Pointer<Uint8> vPlane = nullptr;
    Pointer<Uint32> rgbBuffer = nullptr;

    try {
      // Allocate memory for the planes and copy data.
      yPlane = malloc.allocate<Uint8>(cameraImage.planes[0].bytes.length);
      uPlane = malloc.allocate<Uint8>(cameraImage.planes[1].bytes.length);
      vPlane =
          (cameraImage.planes.length > 2)
              ? malloc.allocate<Uint8>(cameraImage.planes[2].bytes.length)
              : nullptr;

      yPlane
          .asTypedList(cameraImage.planes[0].bytes.length)
          .setAll(0, cameraImage.planes[0].bytes);
      uPlane
          .asTypedList(cameraImage.planes[1].bytes.length)
          .setAll(0, cameraImage.planes[1].bytes);
      if (vPlane != nullptr) {
        vPlane
            .asTypedList(cameraImage.planes[2].bytes.length)
            .setAll(0, cameraImage.planes[2].bytes);
      }

      // Call the native function.
      rgbBuffer = _convertYuvToRgb(
        yPlane,
        uPlane,
        vPlane,
        cameraImage.planes[0].bytesPerRow,
        cameraImage.planes[1].bytesPerRow,
        cameraImage.planes[1].bytesPerPixel ?? 1,
        cameraImage.width,
        cameraImage.height,
      );

      if (rgbBuffer == nullptr) {
        return null;
      }

      // Create an img.Image from the returned buffer.
      // The buffer is in ARGB format, but the image library expects ABGR or RGBA.
      // We need to swap the R and B channels.
      final image = img.Image.fromBytes(
        width: cameraImage.width,
        height: cameraImage.height,
        bytes:
            rgbBuffer
                .asTypedList(cameraImage.width * cameraImage.height * 4)
                .buffer,
        order:
            img
                .ChannelOrder
                .bgra, // The native code produces ARGB, which is BGRA in little-endian.
      );

      return image;
    } finally {
      // Free all allocated memory.
      if (yPlane != nullptr) malloc.free(yPlane);
      if (uPlane != nullptr) malloc.free(uPlane);
      if (vPlane != nullptr) malloc.free(vPlane);
      if (rgbBuffer != nullptr) _freeImageMemory(rgbBuffer);
    }
  }
}
