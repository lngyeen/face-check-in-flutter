import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../services/camera_service.dart';
import '../../entities/camera_state.dart';
import 'camera_event.dart';

@injectable
class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraService _cameraService;
  StreamSubscription? _statusSubscription;

  CameraBloc(this._cameraService) : super(const CameraState()) {
    on<Initialize>((event, emit) async {
      await _handleInitialize(emit);
    });
    on<Start>((event, emit) async {
      await _handleStart(emit);
    });
    on<Stop>((event, emit) async {
      await _handleStop(emit);
    });
    on<PermissionRequested>((event, emit) async {
      await _handleRequestPermission(emit);
    });
    on<StatusChanged>((event, emit) {
      _handleStatusChanged(event.newStatus, emit);
    });

    _listenToCameraService();
  }

  void _listenToCameraService() {
    _statusSubscription = _cameraService.statusStream.listen(
      (status) => add(CameraEvent.statusChanged(status)),
    );
  }

  Future<void> _handleInitialize(Emitter<CameraState> emit) async {
    if (isClosed) return;
    emit(state.copyWith(isInitializing: true, errorMessage: null));
    try {
      await _cameraService.start();
      if (isClosed) return;
      emit(state.copyWith(
          isInitializing: false,
          controller: _cameraService.currentController,
          hasPermission: true));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        isInitializing: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _handleStart(Emitter<CameraState> emit) async {
    await _cameraService.start();
  }

  Future<void> _handleStop(Emitter<CameraState> emit) async {
    await _cameraService.stop();
  }

  Future<void> _handleRequestPermission(Emitter<CameraState> emit) async {
    // Permission logic is now handled inside CameraService
    await _cameraService.start();
  }

  void _handleStatusChanged(CameraStatus newStatus, Emitter<CameraState> emit) {
    if (isClosed) return;
    emit(state.copyWith(
        status: newStatus,
        controller: _cameraService.currentController,
        isInitializing: newStatus == CameraStatus.initializing));
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _cameraService.dispose();
    return super.close();
  }
}
