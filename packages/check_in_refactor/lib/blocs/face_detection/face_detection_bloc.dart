import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../entities/face_detection_state.dart';
import '../../services/face_detection_service.dart';

import 'face_detection_event.dart';

@injectable
class FaceDetectionBloc extends Bloc<FaceDetectionEvent, FaceDetectionState> {
  final FaceDetectionService _faceDetectionService;
  StreamSubscription? _detectionSubscription;

  FaceDetectionBloc(this._faceDetectionService)
      : super(const FaceDetectionState()) {
    on<DetectionReceived>((event, emit) {
      if (isClosed) return;
      emit(state.copyWith(
        detectedFaces: event.faceDetectionData.faces,
        annotatedImage: event.faceDetectionData.annotatedImage,
        lastDetectionTime: DateTime.now(),
        isProcessing: false,
      ));
    });

    on<ConnectionStatusChanged>((event, emit) {
      emit(state.withConnectionStatus(event.newStatus));
    });

    on<ClearResults>((event, emit) {
      if (isClosed) return;
      emit(state.copyWith(
        detectedFaces: [],
        annotatedImage: null,
      ));
    });

    on<StartProcessing>((event, emit) {
      if (isClosed) return;
      emit(state.copyWith(isProcessing: true));
    });

    on<StopProcessing>((event, emit) {
      if (isClosed) return;
      emit(state.copyWith(isProcessing: false));
    });

    _listenToServices();
  }

  void _listenToServices() {
    _detectionSubscription = _faceDetectionService.detectionStream.listen(
      (data) => add(FaceDetectionEvent.detectionReceived(data)),
    );
  }

  @override
  Future<void> close() {
    _detectionSubscription?.cancel();
    return super.close();
  }
}
