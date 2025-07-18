import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/domain/entities/local_face_detection_result.dart';

/// Configuration constants for face detection.
class FaceDetectionServiceV2Config {
  /// The minimum size of a face relative to the smaller dimension of the image.
  static const double minFaceSizeRatio = 0.03; // 3% of smaller dimension

  /// The maximum size of a face relative to the smaller dimension of the image.
  static const double maxFaceSizeRatio = 0.50; // 50% of smaller dimension

  /// Face size zones for better user feedback
  static const double tooSmallRatio = 0.03; // Below 3%
  static const double smallRatio = 0.08; // 3-8%
  static const double goodRatio = 0.15; // 8-15%
  static const double largeRatio = 0.25; // 15-25%
  static const double tooLargeRatio = 0.50; // Above 50%
}

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
      minFaceSize: FaceDetectionServiceV2Config.minFaceSizeRatio,
      performanceMode: FaceDetectorMode.accurate,
    );
    _faceDetector = FaceDetector(options: options);
  }

  @override
  Future<LocalFaceDetectionResult> detectFace(
    CameraImage image,
    CameraDescription camera,
  ) async {
    return _processImage(
      image: image,
      camera: camera,
      faceDetector: _faceDetector,
    );
  }

  @override
  void dispose() {
    _faceDetector.close();
  }

  Future<LocalFaceDetectionResult> _processImage({
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

      final faceSizeRatio = _calculateFaceSizeRatio(
        largestFace,
        image.width,
        image.height,
      );

      if (faceSizeRatio < FaceDetectionServiceV2Config.minFaceSizeRatio) {
        return LocalFaceDetectionResult.faceTooSmall(
          face: largestFace,
          faceSizeRatio: faceSizeRatio,
        );
      }

      if (faceSizeRatio > FaceDetectionServiceV2Config.maxFaceSizeRatio) {
        return LocalFaceDetectionResult.faceTooLarge(
          face: largestFace,
          faceSizeRatio: faceSizeRatio,
        );
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

  Face _selectLargestFace(List<Face> faces) {
    faces.sort((a, b) {
      final areaA = a.boundingBox.width * a.boundingBox.height;
      final areaB = b.boundingBox.width * b.boundingBox.height;
      return areaB.compareTo(areaA);
    });
    return faces.first;
  }

  double _calculateFaceSizeRatio(Face face, int imageWidth, int imageHeight) {
    final faceWidth = face.boundingBox.width;
    final faceHeight = face.boundingBox.height;

    // Calculate face size ratio based on the smaller dimension of the image
    final smallerImageDimension = min(imageWidth, imageHeight);
    final largerFaceDimension = max(faceWidth, faceHeight);

    return largerFaceDimension / smallerImageDimension;
  }

  Future<InputImage> _convertCameraImageToInputImage(
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

  Future<Uint8List> _concatenatePlanes(List<Plane> planes) async {
    final allBytes = WriteBuffer();
    for (final Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  InputImageRotation _getRotation(CameraDescription camera) {
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
