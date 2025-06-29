import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:yuv_converter/yuv_converter_bindings_generated.dart';

// Inspired by the structure of package:native_test

// 1. BINDINGS SETUP
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

// 2. SYNCHRONOUS API

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

  return _processResult(_bindings, result);
}

// 3. ASYNCHRONOUS API

/// Asynchronously converts a [CameraImage] to an RGB [Uint8List].
///
/// This offloads the conversion to a helper isolate to avoid blocking the UI.
Future<Uint8List?> convertYuvToRgbAsync(CameraImage image) async {
  final sendPort = await _helperIsolateSendPort;
  final requestId = _nextRequestId++;
  final request = _YuvRequest(
    requestId,
    image.width,
    image.height,
    image.planes.map((p) => p.bytes).toList(),
    image.planes.map((p) => p.bytesPerRow).toList(),
    image.planes.length > 1 ? image.planes[1].bytesPerPixel : null,
  );

  final completer = Completer<Uint8List?>();
  _requests[requestId] = completer;

  sendPort.send(request);
  return completer.future;
}

// 4. ISOLATE INFRASTRUCTURE

class _YuvRequest {
  final int id;
  final int width;
  final int height;
  final List<Uint8List> planes;
  final List<int> strides;
  final int? bytesPerPixel;

  const _YuvRequest(
    this.id,
    this.width,
    this.height,
    this.planes,
    this.strides,
    this.bytesPerPixel,
  );
}

class _YuvResponse {
  final int id;
  final Uint8List? result;
  const _YuvResponse(this.id, this.result);
}

int _nextRequestId = 0;
final Map<int, Completer<Uint8List?>> _requests = {};

final Future<SendPort> _helperIsolateSendPort = () async {
  final completer = Completer<SendPort>();
  final mainReceivePort =
      ReceivePort()..listen((message) {
        if (message is SendPort) {
          completer.complete(message);
          return;
        }
        if (message is _YuvResponse) {
          final requestCompleter = _requests.remove(message.id);
          requestCompleter?.complete(message.result);
          return;
        }
        throw UnsupportedError(
          'Unsupported message type: ${message.runtimeType}',
        );
      });

  await Isolate.spawn(_isolateEntrypoint, mainReceivePort.sendPort);
  return completer.future;
}();

void _isolateEntrypoint(SendPort mainSendPort) {
  final isolateBindings = YuvConverterBindings(_dylib);
  final helperReceivePort =
      ReceivePort()..listen((message) {
        if (message is _YuvRequest) {
          final result = _convertYuvToRgbInIsolate(isolateBindings, message);
          mainSendPort.send(_YuvResponse(message.id, result));
        }
      });
  mainSendPort.send(helperReceivePort.sendPort);
}

// This is the synchronous conversion logic that runs inside the isolate.
Uint8List? _convertYuvToRgbInIsolate(
  YuvConverterBindings bindings,
  _YuvRequest request,
) {
  final yPlane = calloc<Uint8>(request.planes[0].length)
    ..asTypedList(request.planes[0].length).setAll(0, request.planes[0]);
  final uPlane = calloc<Uint8>(request.planes[1].length)
    ..asTypedList(request.planes[1].length).setAll(0, request.planes[1]);

  Pointer<RgbImage> result;

  if (request.planes.length == 3) {
    final vPlane = calloc<Uint8>(request.planes[2].length)
      ..asTypedList(request.planes[2].length).setAll(0, request.planes[2]);
    result = bindings.convert_yuv_to_rgb_planar(
      yPlane,
      uPlane,
      vPlane,
      request.strides[0],
      request.strides[1],
      request.width,
      request.height,
    );
    calloc.free(vPlane);
  } else {
    result = bindings.convert_yuv_to_rgb_biplanar(
      yPlane,
      uPlane,
      request.strides[0],
      request.strides[1],
      request.bytesPerPixel ?? 2,
      request.width,
      request.height,
    );
  }

  calloc.free(yPlane);
  calloc.free(uPlane);

  return _processResult(bindings, result);
}

// 5. HELPER FUNCTIONS

/// Processes the native [RgbImage] pointer, extracts the data, and frees memory.
Uint8List? _processResult(
  YuvConverterBindings bindings,
  Pointer<RgbImage> result,
) {
  if (result == nullptr) {
    bindings.free_image_memory(result);
    return null;
  }
  final rgbImage = result.ref;
  final imageBytes = rgbImage.data.asTypedList(
    rgbImage.width * rgbImage.height * 3,
  );

  // The data from FFI must be copied into a Dart-managed list before returning.
  final clonedBytes = Uint8List.fromList(imageBytes);

  bindings.free_image_memory(result);
  return clonedBytes;
}
