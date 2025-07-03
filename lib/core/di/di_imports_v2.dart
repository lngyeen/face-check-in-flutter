// This file ensures all V2 services and blocs are registered in dependency injection
// Import all V2 services and blocs here

// V2 Services
export 'package:face_check_in_flutter/core/services/camera_service_v2.dart';
export 'package:face_check_in_flutter/core/services/image_stream_service_v2.dart';

// V2 Blocs
export 'package:face_check_in_flutter/features/camera/bloc/camera_bloc_v2.dart';
export 'package:face_check_in_flutter/features/streaming/bloc/streaming_bloc_v2.dart';
export 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc_v2.dart';
