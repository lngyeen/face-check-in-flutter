import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:face_check_in_flutter/core/services/camera_service_v2.dart';
import 'package:face_check_in_flutter/domain/entities/camera_status.dart';
import 'package:face_check_in_flutter/features/camera/bloc/camera_error.dart';

part 'camera_bloc_v2.freezed.dart';
part 'camera_event_v2.dart';
part 'camera_state_v2.dart';

@LazySingleton()
class CameraBlocV2 extends Bloc<CameraEventV2, CameraStateV2> {
  final CameraServiceV2 _cameraService;

  StreamSubscription? _controllerSubscription;
  StreamSubscription? _statusSubscription;

  CameraBlocV2(this._cameraService) : super(const CameraStateV2()) {
    _registerEventHandlers();
    _setupServiceListeners();
  }

  void _registerEventHandlers() {
    on<CameraEventV2>((event, emit) {
      event.when(
        startCamera: () => _onStartCamera(emit),
        stopCamera: () => _onStopCamera(emit),
        statusChanged: (status) => _onStatusChanged(status, emit),
        controllerChanged:
            (controller) => _onControllerChanged(controller, emit),
      );
    });
  }

  void _setupServiceListeners() {
    _controllerSubscription?.cancel();
    _controllerSubscription = _cameraService.controllerStream.listen(
      (controller) => add(CameraEventV2.controllerChanged(controller)),
    );

    _statusSubscription?.cancel();
    _statusSubscription = _cameraService.statusStream.listen(
      (status) => add(CameraEventV2.statusChanged(status)),
    );
  }

  Future<void> _onStartCamera(Emitter<CameraStateV2> emit) async {
    emit(state.copyWith(status: CameraStatus.initializing, error: null));
    await _cameraService.startCamera();
  }

  Future<void> _onStopCamera(Emitter<CameraStateV2> emit) async {
    emit(
      state.copyWith(
        status: CameraStatus.initial,
        controller: null,
        error: null,
      ),
    );
    await _cameraService.stopCamera();
  }

  void _onStatusChanged(CameraStatus status, Emitter<CameraStateV2> emit) {
    CameraError? error;

    switch (status) {
      case CameraStatus.permissionDenied:
        error = const CameraError.permissionDenied();
        break;
      case CameraStatus.frontCameraNotAvailable:
        error = const CameraError.notAvailable();
        break;
      case CameraStatus.error:
        error = const CameraError.unexpected();
        break;
      default:
        error = null;
        break;
    }

    emit(state.copyWith(status: status, error: error));
  }

  void _onControllerChanged(
    CameraController? controller,
    Emitter<CameraStateV2> emit,
  ) {
    emit(state.copyWith(controller: controller));
  }

  @override
  Future<void> close() async {
    await _controllerSubscription?.cancel();
    await _statusSubscription?.cancel();
    return super.close();
  }
}
