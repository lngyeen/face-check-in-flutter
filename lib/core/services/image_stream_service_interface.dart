import 'package:camera/camera.dart';

import 'package:face_check_in_flutter/domain/entities/hybrid_processing_result.dart';
import 'package:face_check_in_flutter/domain/entities/processing_mode.dart';
import 'package:face_check_in_flutter/domain/entities/streaming_status.dart';

abstract class ImageStreamServiceV2 {
  Stream<StreamingStatus> get streamingStatusStream;
  Stream<ProcessingStatus> get processingStatusStream;
  Stream<HybridProcessingResult> get processingResultStream;
  ProcessingMode get processingMode;

  Future<void> startStreaming(CameraController controller);
  Future<void> stopStreaming();
  void dispose();
}
