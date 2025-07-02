/// Check-In Refactor Package
///
/// A refactored implementation of the check-in feature following Clean Architecture principles.
/// This package provides:
/// - Separated concerns with specialized BLoCs
/// - Clean service layer abstractions
/// - Domain-driven design with use cases
/// - Improved testability and maintainability
// Services
export 'services/camera_service.dart';
export 'services/image_streaming_service.dart';
export 'services/face_detection_service.dart';

// Use Cases
export 'usecases/check_in_orchestrator.dart';
export 'usecases/notification_interactor.dart';
export 'usecases/app_lifecycle_interactor.dart';

// BLoCs
export 'blocs/camera/camera_bloc.dart';
export 'blocs/camera/camera_event.dart' hide Start;

export 'blocs/face_detection/face_detection_bloc.dart';
export 'blocs/face_detection/face_detection_event.dart';

export 'blocs/screen/check_in_screen_bloc.dart';
export 'blocs/screen/check_in_screen_event.dart';

// Entities
export 'entities/camera_state.dart';
export 'entities/streaming_state.dart';
export 'entities/face_detection_state.dart';
export 'entities/check_in_screen_state.dart';

// Widgets
// export 'widgets/refactored_camera_preview.dart';
// export 'widgets/refactored_check_in_listeners.dart';

// NOTE: Uncomment exports as files are implemented
