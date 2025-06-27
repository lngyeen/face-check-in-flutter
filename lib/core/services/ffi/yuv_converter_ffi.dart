import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart' as img;

// FFI signature for the C function for planar YUV.
typedef _ConvertYuvToRgbPlanarNative =
    Pointer<Uint8> Function(
      Pointer<Uint8>,
      Pointer<Uint8>,
      Pointer<Uint8>,
      Int32,
      Int32,
      Int32,
      Int32,
    );

// Dart signature for the C function for planar YUV.
typedef _ConvertYuvToRgbPlanarDart =
    Pointer<Uint8> Function(
      Pointer<Uint8>,
      Pointer<Uint8>,
      Pointer<Uint8>,
      int,
      int,
      int,
      int,
    );

// FFI signature for the C function for bi-planar YUV.
typedef _ConvertYuvToRgbBiPlanarNative =
    Pointer<Uint8> Function(
      Pointer<Uint8>,
      Pointer<Uint8>,
      Int32,
      Int32,
      Int32,
      Int32,
      Int32,
    );

// Dart signature for the C function for bi-planar YUV.
typedef _ConvertYuvToRgbBiPlanarDart =
    Pointer<Uint8> Function(
      Pointer<Uint8>,
      Pointer<Uint8>,
      int,
      int,
      int,
      int,
      int,
    );

// FFI signature for the memory freeing function.
typedef _FreeImageMemoryNative = Void Function(Pointer<Uint8>);
// Dart signature for the memory freeing function.
typedef _FreeImageMemoryDart = void Function(Pointer<Uint8>);

/// A bridge class to interact with the native C++ YUV conversion functions.
class YuvConverterFfi {
  late final _ConvertYuvToRgbPlanarDart _convertYuvToRgbPlanar;
  late final _ConvertYuvToRgbBiPlanarDart _convertYuvToRgbBiplanar;
  late final _FreeImageMemoryDart _freeImageMemory;

  YuvConverterFfi() {
    final dylib =
        Platform.isAndroid
            ? DynamicLibrary.open('libyuv_converter.so')
            : DynamicLibrary.process();

    _convertYuvToRgbPlanar =
        dylib
            .lookup<NativeFunction<_ConvertYuvToRgbPlanarNative>>(
              'convert_yuv_to_rgb_planar',
            )
            .asFunction<_ConvertYuvToRgbPlanarDart>();

    _convertYuvToRgbBiplanar =
        dylib
            .lookup<NativeFunction<_ConvertYuvToRgbBiPlanarNative>>(
              'convert_yuv_to_rgb_biplanar',
            )
            .asFunction<_ConvertYuvToRgbBiPlanarDart>();

    _freeImageMemory =
        dylib
            .lookup<NativeFunction<_FreeImageMemoryNative>>('free_image_memory')
            .asFunction<_FreeImageMemoryDart>();
  }

  /// Converts a [CameraImage] from YUV format to an [img.Image] in RGB format.
  ///
  /// This function checks the number of planes in the [CameraImage] and calls
  /// the appropriate native conversion function.
  /// Returns `null` if the conversion fails or the plane count is unsupported.
  img.Image? convertYuvToRgb(CameraImage cameraImage) {
    if (cameraImage.planes.length == 3) {
      return _convertPlanarYuv(cameraImage);
    } else if (cameraImage.planes.length == 2) {
      return _convertBiPlanarYuv(cameraImage);
    } else {
      log('Unsupported plane count: ${cameraImage.planes.length}');
      return null;
    }
  }

  /// Handles 3-plane (planar) YUV conversion.
  img.Image? _convertPlanarYuv(CameraImage cameraImage) {
    Pointer<Uint8> yPlane = nullptr;
    Pointer<Uint8> uPlane = nullptr;
    Pointer<Uint8> vPlane = nullptr;
    Pointer<Uint8> rgbBuffer = nullptr;

    try {
      yPlane = malloc.allocate<Uint8>(cameraImage.planes[0].bytes.length);
      uPlane = malloc.allocate<Uint8>(cameraImage.planes[1].bytes.length);
      vPlane = malloc.allocate<Uint8>(cameraImage.planes[2].bytes.length);

      yPlane
          .asTypedList(cameraImage.planes[0].bytes.length)
          .setAll(0, cameraImage.planes[0].bytes);
      uPlane
          .asTypedList(cameraImage.planes[1].bytes.length)
          .setAll(0, cameraImage.planes[1].bytes);
      vPlane
          .asTypedList(cameraImage.planes[2].bytes.length)
          .setAll(0, cameraImage.planes[2].bytes);

      rgbBuffer = _convertYuvToRgbPlanar(
        yPlane,
        uPlane,
        vPlane,
        cameraImage.planes[0].bytesPerRow,
        cameraImage.planes[1].bytesPerRow,
        cameraImage.width,
        cameraImage.height,
      );

      if (rgbBuffer == nullptr) return null;

      return _createImageFromBuffer(cameraImage, rgbBuffer);
    } finally {
      if (yPlane != nullptr) malloc.free(yPlane);
      if (uPlane != nullptr) malloc.free(uPlane);
      if (vPlane != nullptr) malloc.free(vPlane);
      if (rgbBuffer != nullptr) _freeImageMemory(rgbBuffer);
    }
  }

  /// Handles 2-plane (bi-planar) YUV conversion.
  img.Image? _convertBiPlanarYuv(CameraImage cameraImage) {
    Pointer<Uint8> yPlane = nullptr;
    Pointer<Uint8> uvPlane = nullptr;
    Pointer<Uint8> rgbBuffer = nullptr;

    try {
      yPlane = malloc.allocate<Uint8>(cameraImage.planes[0].bytes.length);
      uvPlane = malloc.allocate<Uint8>(cameraImage.planes[1].bytes.length);

      yPlane
          .asTypedList(cameraImage.planes[0].bytes.length)
          .setAll(0, cameraImage.planes[0].bytes);
      uvPlane
          .asTypedList(cameraImage.planes[1].bytes.length)
          .setAll(0, cameraImage.planes[1].bytes);

      rgbBuffer = _convertYuvToRgbBiplanar(
        yPlane,
        uvPlane,
        cameraImage.planes[0].bytesPerRow,
        cameraImage.planes[1].bytesPerRow,
        cameraImage.planes[1].bytesPerPixel ?? 1,
        cameraImage.width,
        cameraImage.height,
      );

      if (rgbBuffer == nullptr) return null;

      return _createImageFromBuffer(cameraImage, rgbBuffer);
    } finally {
      if (yPlane != nullptr) malloc.free(yPlane);
      if (uvPlane != nullptr) malloc.free(uvPlane);
      if (rgbBuffer != nullptr) _freeImageMemory(rgbBuffer);
    }
  }

  /// Creates an [img.Image] from a native RGB buffer.
  img.Image _createImageFromBuffer(
    CameraImage cameraImage,
    Pointer<Uint8> rgbBuffer,
  ) {
    return img.Image.fromBytes(
      width: cameraImage.width,
      height: cameraImage.height,
      bytes:
          rgbBuffer
              .asTypedList(cameraImage.width * cameraImage.height * 4)
              .buffer,
      order: img.ChannelOrder.bgra,
    );
  }
}
