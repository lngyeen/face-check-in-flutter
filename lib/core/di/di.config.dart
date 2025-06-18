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
import '../services/websocket_service.dart' as _i555;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i555.WebSocketService>(() => _i555.WebSocketService());
    gh.lazySingleton<_i474.PermissionService>(
      () => _i372.PermissionServiceImpl(),
    );
    gh.factory<_i435.CheckInBloc>(
      () => _i435.CheckInBloc(
        gh<_i474.PermissionService>(),
        gh<_i555.WebSocketService>(),
      ),
    );
    return this;
  }
}
