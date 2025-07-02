import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:check_in_refactor/blocs/face_detection/face_detection_bloc.dart';
import 'package:check_in_refactor/blocs/face_detection/face_detection_event.dart';
import 'package:check_in_refactor/entities/face_detection_state.dart';
import 'package:check_in_refactor/services/face_detection_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFaceDetectionService extends Mock implements FaceDetectionService {}

void main() {
  late FaceDetectionBloc faceDetectionBloc;
  late MockFaceDetectionService mockFaceDetectionService;
  late StreamController<FaceDetectionData> detectionStreamController;

  setUp(() {
    mockFaceDetectionService = MockFaceDetectionService();
    detectionStreamController = StreamController<FaceDetectionData>.broadcast();
    when(() => mockFaceDetectionService.detectionStream)
        .thenAnswer((_) => detectionStreamController.stream);
    faceDetectionBloc = FaceDetectionBloc(mockFaceDetectionService);
  });

  tearDown(() {
    detectionStreamController.close();
    faceDetectionBloc.close();
  });

  group('FaceDetectionBloc', () {
    test('initial state is correct', () {
      expect(faceDetectionBloc.state, const FaceDetectionState());
    });

    blocTest<FaceDetectionBloc, FaceDetectionState>(
      'emits state with new face data when detectionStream emits',
      build: () => faceDetectionBloc,
      act: (bloc) {
        final data = FaceDetectionData(faces: [], timestamp: DateTime.now());
        detectionStreamController.add(data);
      },
      expect: () => [
        isA<FaceDetectionState>()
            .having((s) => s.detectedFaces, 'detectedFaces', []),
      ],
    );

    blocTest<FaceDetectionBloc, FaceDetectionState>(
      'emits state with empty faces on ClearResults event',
      build: () => faceDetectionBloc,
      act: (bloc) => bloc.add(const FaceDetectionEvent.clearResults()),
      expect: () => [
        const FaceDetectionState(detectedFaces: [], annotatedImage: null),
      ],
    );
  });
}
