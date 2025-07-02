import 'package:flutter/material.dart';

import 'package:check_in_refactor/check_in_refactor.dart';
import 'package:check_in_refactor/services/camera_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:face_check_in_flutter/features/check_in/widgets/camera_section.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/check_in_listeners.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_panel_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/debug_toggle_button.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/permission_denied_widget.dart';
import 'package:face_check_in_flutter/features/check_in/widgets/user_information_section.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_event.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CameraBloc>(
          create:
              (context) =>
                  GetIt.instance<CameraBloc>()
                    ..add(const CameraEvent.initialize()),
        ),
        BlocProvider<FaceDetectionBloc>(
          create: (context) => GetIt.instance<FaceDetectionBloc>(),
        ),
        BlocProvider<CheckInScreenBloc>(
          create: (context) => GetIt.instance<CheckInScreenBloc>(),
        ),
        BlocProvider<ConnectionBloc>(
          create:
              (context) =>
                  GetIt.instance<ConnectionBloc>()..add(const Connect()),
        ),
      ],
      child: const CheckInScreenView(),
    );
  }
}

extension CameraStatusX on CameraStatus {
  bool get isPermissionDenied => this == CameraStatus.permissionDenied;
}

class CheckInScreenView extends StatefulWidget {
  const CheckInScreenView({super.key});

  @override
  State<CheckInScreenView> createState() => _CheckInScreenViewState();
}

class _CheckInScreenViewState extends State<CheckInScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<CheckInScreenBloc>().add(const CheckInScreenEvent.start());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Check-in'),
        actions: const [DebugToggleButton()],
      ),
      body: CheckInListeners(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    final state = context.watch<CheckInScreenBloc>().state;
    final cameraStatus = state.cameraState.status;

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onDoubleTap:
              () => context.read<CheckInScreenBloc>().add(
                const CheckInScreenEvent.toggleFullScreen(),
              ),
          child: const Positioned.fill(child: CameraSection()),
        ),
        const UserInformationSection(),
        if (cameraStatus.isPermissionDenied)
          const Positioned.fill(child: PermissionDeniedWidget()),
        if (state.isDebugMode)
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DebugPanelWidget(),
          ),
      ],
    );
  }
}
