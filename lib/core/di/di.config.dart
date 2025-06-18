// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/services/permission_service_impl.dart' as _i372;
import '../../domain/services/permission_service.dart' as _i474;
import '../../features/check_in/bloc/check_in_bloc.dart' as _i435;
import '../services/frame_capture_service.dart' as _i351;
import '../services/frame_processor.dart' as _i653;
import '../services/frame_streaming_service.dart' as _i635;
import '../services/performance_monitor.dart' as _i759;
import '../services/websocket_service.dart' as _i555;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i555.WebSocketService>(() => _i555.WebSocketService());
    gh.factory<_i653.FrameProcessor>(() => _i653.FrameProcessor());
    gh.lazySingleton<_i474.PermissionService>(
      () => _i372.PermissionServiceImpl(),
    );
    gh.factory<_i351.FrameCaptureService>(
      () => _i351.FrameCaptureService(gh<_i653.FrameProcessor>()),
    );
    gh.factory<_i635.FrameStreamingService>(
      () => _i635.FrameStreamingService(
        gh<_i351.FrameCaptureService>(),
        gh<_i555.WebSocketService>(),
      ),
    );
    gh.factory<_i759.PerformanceMonitor>(
      () => _i759.PerformanceMonitor(gh<_i351.FrameCaptureService>()),
    );
    gh.factory<_i435.CheckInBloc>(
      () => _i435.CheckInBloc(
        gh<_i474.PermissionService>(),
        gh<_i555.WebSocketService>(),
        gh<_i635.FrameStreamingService>(),
      ),
    );
    return this;
  }
}
