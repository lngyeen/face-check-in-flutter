import 'package:face_check_in_flutter/core/config/flavors/flavor_config.dart';

class StagConfig implements FlavorConfig {
  @override
  Future<String> baseHost() => Future.value('https://facedetection-be.owt.vn');

  @override
  String get baseWebSocketUrl => 'wss://facedetection-ws.owt.vn';

  @override
  String get title => '[Stag] Face Check-In';
}
