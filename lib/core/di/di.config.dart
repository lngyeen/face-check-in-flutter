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
import '../../features/connection/bloc/connection_bloc.dart' as _i348;
import '../../features/connection/connection.dart' as _i566;
import '../services/network_connectivity_service.dart' as _i234;
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
    gh.singleton<_i669.WakelockService>(() => _i669.WakelockService());
    gh.lazySingleton<_i234.NetworkConnectivityService>(
      () => _i234.NetworkConnectivityService(),
    );
    gh.lazySingleton<_i474.PermissionService>(
      () => _i372.PermissionServiceImpl(),
    );
    gh.lazySingleton<_i555.WebSocketService>(
      () => _i555.WebSocketService(gh<_i234.NetworkConnectivityService>()),
    );
    gh.lazySingleton<_i121.StreamService>(
      () => _i121.StreamService(gh<_i555.WebSocketService>()),
    );
    gh.lazySingleton<_i348.ConnectionBloc>(
      () => _i348.ConnectionBloc(
        gh<_i555.WebSocketService>(),
        gh<_i121.StreamService>(),
      ),
    );
    gh.factory<_i435.CheckInBloc>(
      () => _i435.CheckInBloc(
        gh<_i474.PermissionService>(),
        gh<_i566.ConnectionBloc>(),
        gh<_i121.StreamService>(),
      ),
    );
    return this;
  }
}
