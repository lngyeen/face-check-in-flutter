import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/di/di.dart';
import 'package:face_check_in_flutter/core/services/network_connectivity_service.dart';
import 'package:face_check_in_flutter/core/services/wakelock_service.dart';

import 'app/app.dart';
import 'app/simple_bloc_observer.dart';

/// Main entry point for the Face Check-In Flutter application
/// Configures BLoC observer and launches the app
void main() async {
  // Ensure widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Dependency Injection
  configureDependencies();

  // Configure BLoC observer for debugging and logging
  Bloc.observer = SimpleBlocObserver();

  // Enable wake lock to keep screen awake for check-in operations
  final wakelockService = getIt<WakelockService>();
  await wakelockService.enable();

  // Initialize network connectivity service
  final networkService = getIt<NetworkConnectivityService>();
  await networkService.initialize();

  // Run the application
  runApp(const App());
}
