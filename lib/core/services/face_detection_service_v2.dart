import 'dart:async';

import 'package:flutter/services.dart';

import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';

///* -------------------------------------------------------------------------- */
///* DATA CLASSES                                */
///* -------------------------------------------------------------------------- */

/// The result of a face detection operation.
class FaceDetectionResult {
  /// The status of the detection.
  final FaceDetectionStatus status;

  /// The detected face. Can be null if no face is found or an error occurs.
  final Face? face;

  /// The total number of faces detected in the frame.
  final int totalFacesDetected;

  /// A user-friendly message describing the result.
  final String message;

  const FaceDetectionResult({
    required this.status,
    this.face,
    required this.totalFacesDetected,
    required this.message,
  });

  /// Returns true if a single, valid face was detected.
  bool get isSingleValidFace =>
      face != null && status == FaceDetectionStatus.singleFaceDetected;
}

/// The status of a face detection operation.
enum FaceDetectionStatus {
  noFaceDetected,
  singleFaceDetected,
  multipleFacesDetected,
  faceTooSmall,
  error,
}

///* -------------------------------------------------------------------------- */
///* CONFIGURATION                              */
///* -------------------------------------------------------------------------- */

/// Configuration constants for face detection.
class FaceDetectionConfig {
  /// The minimum width of the bounding box for a face to be considered valid (in pixels).
  static const double MIN_FACE_WIDTH = 120.0;

  /// The minimum height of the bounding box for a face to be considered valid (in pixels).
  static const double MIN_FACE_HEIGHT = 120.0;

  /// The minimum size of a face relative to the smaller dimension of the image.
  static const double MIN_FACE_SIZE_RATIO = 0.15;
}

///* -------------------------------------------------------------------------- */
///* PUBLIC SERVICE INTERFACE                           */
///* -------------------------------------------------------------------------- */

/// Abstract interface for a face detection service.
abstract class FaceDetectionServiceV2 {
  /// Detects faces in a camera image and returns the best result.
  ///
  /// - [image]: The `CameraImage` from the camera stream.
  /// - [camera]: The `CameraDescription` of the camera used, for rotation calculation.
  Future<FaceDetectionResult> detectFace(
    CameraImage image,
    CameraDescription camera,
  );

  /// Disposes of the underlying face detector.
  void dispose();
}

///* -------------------------------------------------------------------------- */
///* NON-STATIC IMPLEMENTATION (Singleton)                 */
///* -------------------------------------------------------------------------- */

/// An implementation of [FaceDetectionServiceV2] using Google ML Kit.
@LazySingleton(as: FaceDetectionServiceV2)
class FaceDetectionServiceV2Impl implements FaceDetectionServiceV2 {
  /// The ML Kit Face Detector instance.
  late final FaceDetector _faceDetector;

  FaceDetectionServiceV2Impl() {
    final options = FaceDetectorOptions(
      enableLandmarks: true, // Needed for liveness (e.g., eye blink)
      enableClassification: true, // Needed for liveness (e.g., eye open prob)
      enableTracking: false, // Not needed for single-frame check-in
      minFaceSize: FaceDetectionConfig.MIN_FACE_SIZE_RATIO,
      performanceMode: FaceDetectorMode.accurate,
    );
    _faceDetector = FaceDetector(options: options);
  }

  @override
  Future<FaceDetectionResult> detectFace(
    CameraImage image,
    CameraDescription camera,
  ) async {
    // This implementation now delegates to the central processor to avoid code duplication.
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

///* -------------------------------------------------------------------------- */
///* STATIC IMPLEMENTATION (Isolate)                     */
///* -------------------------------------------------------------------------- */

/// A class with static methods to run face detection in a separate Isolate.
class FaceDetectionStatic {
  /// Detects faces in an isolate-safe manner.
  /// This creates and disposes its own `FaceDetector` instance within the isolate.
  static Future<FaceDetectionResult> detectFaceInIsolate({
    required CameraImage image,
    required CameraDescription camera,
  }) async {
    // Create a new detector instance specifically for this isolate task.
    final options = FaceDetectorOptions(
      enableLandmarks: true,
      enableClassification: true,
      minFaceSize: FaceDetectionConfig.MIN_FACE_SIZE_RATIO,
      performanceMode: FaceDetectorMode.accurate,
    );
    final faceDetector = FaceDetector(options: options);

    try {
      // Process the image using the central logic.
      final result = await _FaceDetectionProcessor.processImage(
        image: image,
        camera: camera,
        faceDetector: faceDetector,
      );
      return result;
    } finally {
      // IMPORTANT: Always close the detector when done.
      faceDetector.close();
    }
  }
}

///* -------------------------------------------------------------------------- */
///* INTERNAL FACE DETECTION PROCESSOR                   */
///* (Shared Logic - DRY Principle)                       */
///* -------------------------------------------------------------------------- */

/// A private class containing the core, stateless face detection logic.
/// This logic is shared by both the singleton service and the isolate function.
class _FaceDetectionProcessor {
  /// Processes a [CameraImage] to detect faces.
  static Future<FaceDetectionResult> processImage({
    required CameraImage image,
    required CameraDescription camera,
    required FaceDetector faceDetector,
  }) async {
    try {
      // 1. Convert CameraImage to a cross-platform safe InputImage.
      final inputImage = await _convertCameraImageToInputImage(image, camera);

      // 2. Detect all faces in the image.
      final faces = await faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        return const FaceDetectionResult(
          status: FaceDetectionStatus.noFaceDetected,
          totalFacesDetected: 0,
          message: "No face detected. Please position your face in the frame.",
        );
      }

      // 3. Select the largest face (assumed to be the closest).
      final largestFace = _selectLargestFace(faces);

      // 4. Validate that the face is large enough.
      if (!_isValidFaceSize(largestFace)) {
        return FaceDetectionResult(
          status: FaceDetectionStatus.faceTooSmall,
          face: largestFace,
          totalFacesDetected: faces.length,
          message: "Face is too far. Please move closer to the camera.",
        );
      }

      // 5. Determine the final status and message.
      final status =
          faces.length == 1
              ? FaceDetectionStatus.singleFaceDetected
              : FaceDetectionStatus.multipleFacesDetected;

      final message =
          faces.length == 1
              ? "Face detected successfully."
              : "Multiple people detected. Please ensure only one person is in the frame.";

      return FaceDetectionResult(
        status: status,
        face: largestFace,
        totalFacesDetected: faces.length,
        message: message,
      );
    } catch (e) {
      return FaceDetectionResult(
        status: FaceDetectionStatus.error,
        totalFacesDetected: 0,
        message: "Face detection failed: ${e.toString()}",
      );
    }
  }

  /// Selects the face with the largest bounding box area.
  static Face _selectLargestFace(List<Face> faces) {
    faces.sort((a, b) {
      final areaA = a.boundingBox.width * a.boundingBox.height;
      final areaB = b.boundingBox.width * b.boundingBox.height;
      return areaB.compareTo(areaA); // Sort descending by area
    });
    return faces.first;
  }

  /// Checks if a face's bounding box meets the minimum size requirements.
  static bool _isValidFaceSize(Face face) {
    return face.boundingBox.width >= FaceDetectionConfig.MIN_FACE_WIDTH &&
        face.boundingBox.height >= FaceDetectionConfig.MIN_FACE_HEIGHT;
  }

  /// **CRITICAL:** Converts a [CameraImage] to an [InputImage] that ML Kit can process.
  /// This function handles the platform-specific image formats (YUV420 on Android, BGRA8888 on iOS).
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

  /// Concatenates the planes of a YUV420 image into a single byte buffer.
  static Future<Uint8List> _concatenatePlanes(List<Plane> planes) async {
    final allBytes = WriteBuffer();
    for (final Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  /// Calculates the correct [InputImageRotation] based on camera and device orientation.
  static InputImageRotation _getRotation(CameraDescription camera) {
    // Note: This assumes the device is in portrait mode.
    // For a more robust solution, you would pass the current device orientation.
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
