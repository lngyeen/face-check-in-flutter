import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/domain/entities/face_detection_status.dart';

import '../bloc/check_in_bloc.dart';

/// Widget that displays debug information including frame capture, statistics, and error details
class DebugInformationCard extends StatelessWidget {
  const DebugInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Debug Information',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const _AnnotatedImagePreview(),
            const _FaceDetectionInfo(),
            const _RecognitionInfo(),
            const _ResponseErrorInfo(),
          ],
        ),
      ),
    );
  }
}

/// Widget that displays the annotated image with face detection overlays if available
class _AnnotatedImagePreview extends StatelessWidget {
  const _AnnotatedImagePreview();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.annotatedImage != current.annotatedImage,
      builder: (context, state) {
        if (state.annotatedImage == null || state.annotatedImage!.isEmpty) {
          return const SizedBox.shrink();
        }

        try {
          // Decode base64 string to bytes
          final bytes = base64Decode(state.annotatedImage!);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Annotated Image:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Image.memory(
                  bytes,
                  gaplessPlayback: true,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'Failed to load image',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        } catch (e) {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

/// Widget that displays face detection information
class _FaceDetectionInfo extends StatelessWidget {
  const _FaceDetectionInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.faceStatus != current.faceStatus ||
              previous.detectedFaces != current.detectedFaces,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${_getStatusDisplayName(state.faceStatus)}'),
            if (state.detectedFaces.isNotEmpty)
              Text('Faces: ${state.detectedFaces.length}'),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }

  String _getStatusDisplayName(FaceDetectionStatus status) {
    switch (status) {
      case FaceDetectionStatus.faceFound:
        return 'Face Recognized';
      case FaceDetectionStatus.faceUnrecognized:
        return 'Face Detected (Unrecognized)';
      case FaceDetectionStatus.multipleFaces:
        return 'Multiple Faces';
      case FaceDetectionStatus.noFace:
        return 'No Face';
      case FaceDetectionStatus.error:
        return 'Processing Error';
      case FaceDetectionStatus.none:
        return 'Idle';
    }
  }
}

/// Widget that displays recognition information for recognized faces
class _RecognitionInfo extends StatelessWidget {
  const _RecognitionInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.detectedFaces != current.detectedFaces ||
              previous.faceStatus != current.faceStatus,
      builder: (context, state) {
        final recognizedFaces =
            state.detectedFaces.where((face) => face.isRecognized).toList();

        if (recognizedFaces.isEmpty ||
            state.faceStatus != FaceDetectionStatus.faceFound) {
          return const SizedBox.shrink();
        }

        final face = recognizedFaces.first;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recognition Details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (face.faceId != null) Text('Face ID: ${face.faceId}'),
            if (face.gender != null) Text('Gender: ${face.gender}'),
            if (face.age != null) Text('Age: ${face.age}'),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }
}

/// Widget that displays response error information if available
class _ResponseErrorInfo extends StatelessWidget {
  const _ResponseErrorInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      buildWhen:
          (previous, current) =>
              previous.responseError != current.responseError,
      builder: (context, state) {
        if (state.responseError == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Error: ${state.responseError!.error}',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (state.responseError!.message != null)
              Text(
                state.responseError!.message!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }
}
