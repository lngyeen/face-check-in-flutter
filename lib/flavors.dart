import 'package:face_check_in_flutter/core/config/flavors/flavor_config.dart';

enum Flavor { dev, stag, prod }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static FlavorConfig get flavorConfig => FlavorConfig.fromFlavor(appFlavor);

  static String get title => flavorConfig.title;

  static String get baseWebSocketUrl => flavorConfig.baseWebSocketUrl;
}
