import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/domain/entities/face_detection_config.dart';
import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';

abstract class FaceDetectionServiceV2 {
  Future<LocalFaceDetectionResult> detectFace(
    CameraImage image,
    CameraDescription camera,
  );

  void dispose();
}

@LazySingleton(as: FaceDetectionServiceV2)
class FaceDetectionServiceV2Impl implements FaceDetectionServiceV2 {
  late final FaceDetector _faceDetector;

  FaceDetectionServiceV2Impl() {
    final options = FaceDetectorOptions(
      enableLandmarks: true,
      enableClassification: true,
      enableTracking: false,
      minFaceSize: FaceDetectionConfig.MIN_FACE_SIZE_RATIO,
      performanceMode: FaceDetectorMode.accurate,
    );
    _faceDetector = FaceDetector(options: options);
  }

  @override
  Future<LocalFaceDetectionResult> detectFace(
    CameraImage image,
    CameraDescription camera,
  ) async {
    return _FaceDetectionProcessor.processImage(
      image: image,
      camera: camera,
      faceDetector: _faceDetector,
    );
  }

  @override
  void dispose() {
    _faceDetector.close();
  }
}

class _FaceDetectionProcessor {
  static Future<LocalFaceDetectionResult> processImage({
    required CameraImage image,
    required CameraDescription camera,
    required FaceDetector faceDetector,
  }) async {
    try {
      final inputImage = await _convertCameraImageToInputImage(image, camera);
      final faces = await faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        return const LocalFaceDetectionResult.noFaceDetected();
      }

      final largestFace = _selectLargestFace(faces);

      if (!_isValidFaceSize(largestFace)) {
        return LocalFaceDetectionResult.faceTooSmall(face: largestFace);
      }

      return faces.length == 1
          ? LocalFaceDetectionResult.singleFaceDetected(face: faces.first)
          : LocalFaceDetectionResult.multipleFacesDetected(faces: faces);
    } catch (e) {
      return const LocalFaceDetectionResult.error(
        message: 'Error detecting face',
      );
    }
  }

  static Face _selectLargestFace(List<Face> faces) {
    faces.sort((a, b) {
      final areaA = a.boundingBox.width * a.boundingBox.height;
      final areaB = b.boundingBox.width * b.boundingBox.height;
      return areaB.compareTo(areaA);
    });
    return faces.first;
  }

  static bool _isValidFaceSize(Face face) {
    return face.boundingBox.width >= FaceDetectionConfig.MIN_FACE_WIDTH &&
        face.boundingBox.height >= FaceDetectionConfig.MIN_FACE_HEIGHT;
  }

  static Future<InputImage> _convertCameraImageToInputImage(
    CameraImage image,
    CameraDescription camera,
  ) async {
    final bytes = await _concatenatePlanes(image.planes);
    final rotation = _getRotation(camera);
    final size = Size(image.width.toDouble(), image.height.toDouble());

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
        InputImageFormat.nv21;

    final metadata = InputImageMetadata(
      size: size,
      rotation: rotation,
      format: inputImageFormat,
      bytesPerRow: image.planes.first.bytesPerRow,
    );

    return InputImage.fromBytes(bytes: bytes, metadata: metadata);
  }

  static Future<Uint8List> _concatenatePlanes(List<Plane> planes) async {
    final allBytes = WriteBuffer();
    for (final Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static InputImageRotation _getRotation(CameraDescription camera) {
    final sensorOrientation = camera.sensorOrientation;
    switch (sensorOrientation) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }
}
