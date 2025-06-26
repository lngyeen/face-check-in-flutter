import 'package:face_check_in_flutter/core/config/flavors/flavor_config.dart';

class DevConfig implements FlavorConfig {
  @override
  Future<String> baseHost() => Future.value('https://facedetection-be.owt.vn');

  @override
  String get baseWebSocketUrl => 'wsss://facedetection-ws.owt.vn';

  @override
  String get title => '[Dev] Face Check-In';
}
