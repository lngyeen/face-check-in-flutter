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

import '../../features/camera/bloc/camera_bloc_v2.dart' as _i463;
import '../../features/check_in/bloc/check_in_bloc.dart' as _i435;
import '../../features/check_in/bloc/check_in_bloc_v2.dart' as _i1051;
import '../../features/check_in/services/check_in_notification_service.dart'
    as _i320;
import '../../features/connection/bloc/connection_bloc.dart' as _i348;
import '../../features/streaming/bloc/streaming_bloc_v2.dart' as _i782;
import '../services/camera_service_v2.dart' as _i41;
import '../services/image_stream_service_v2.dart' as _i251;
import '../services/network_connectivity_service.dart' as _i234;
import '../services/permission_service.dart' as _i165;
import '../services/stream_service.dart' as _i121;
import '../services/wakelock_service.dart' as _i669;
import '../services/websocket_service.dart' as _i555;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i165.PermissionService>(
      () => _i165.PermissionServiceImpl(),
    );
    gh.lazySingleton<_i669.WakelockService>(() => _i669.WakelockServiceImpl());
    gh.lazySingleton<_i234.NetworkConnectivityService>(
      () => _i234.NetworkConnectivityServiceImpl(),
    );
    gh.factory<_i320.CheckInNotificationService>(
      () => _i320.CheckInNotificationServiceImpl(),
    );
    gh.lazySingleton<_i41.CameraServiceV2>(
      () => _i41.CameraServiceV2Impl(gh<_i165.PermissionService>()),
    );
    gh.lazySingleton<_i555.WebSocketService>(
      () => _i555.WebSocketServiceImpl(gh<_i234.NetworkConnectivityService>()),
    );
    gh.lazySingleton<_i463.CameraBlocV2>(
      () => _i463.CameraBlocV2(gh<_i41.CameraServiceV2>()),
    );
    gh.lazySingleton<_i348.ConnectionBloc>(
      () => _i348.ConnectionBloc(gh<_i555.WebSocketService>()),
    );
    gh.lazySingleton<_i251.ImageStreamServiceV2>(
      () => _i251.ImageStreamServiceV2Impl(gh<_i555.WebSocketService>()),
    );
    gh.lazySingleton<_i121.StreamService>(
      () => _i121.StreamServiceImpl(
        gh<_i555.WebSocketService>(),
        gh<_i165.PermissionService>(),
      ),
    );
    gh.lazySingleton<_i782.StreamingBlocV2>(
      () => _i782.StreamingBlocV2(gh<_i251.ImageStreamServiceV2>()),
    );
    gh.factory<_i1051.CheckInBlocV2>(
      () => _i1051.CheckInBlocV2(
        gh<_i463.CameraBlocV2>(),
        gh<_i782.StreamingBlocV2>(),
        gh<_i348.ConnectionBloc>(),
      ),
    );
    gh.factory<_i435.CheckInBloc>(
      () => _i435.CheckInBloc(
        gh<_i348.ConnectionBloc>(),
        gh<_i121.StreamService>(),
      ),
    );
    return this;
  }
}
