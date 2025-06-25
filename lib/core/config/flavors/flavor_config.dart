import 'package:face_check_in_flutter/core/config/flavors/dev_config.dart';
import 'package:face_check_in_flutter/core/config/flavors/prod_env_config.dart';
import 'package:face_check_in_flutter/core/config/flavors/stag_env_config.dart';
import 'package:face_check_in_flutter/flavors.dart';

abstract class FlavorConfig {
  Future<String> baseHost();

  String get baseWebSocketUrl;

  String get title;

  factory FlavorConfig.fromFlavor(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        return DevConfig();
      case Flavor.stag:
        return StagConfig();
      case Flavor.prod:
        return ProdConfig();
    }
  }
}
