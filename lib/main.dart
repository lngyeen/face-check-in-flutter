import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'app/simple_bloc_observer.dart';

/// Main entry point for the Face Check-In Flutter application
/// Configures BLoC observer and launches the app
void main() {
  // Configure BLoC observer for debugging and logging
  Bloc.observer = SimpleBlocObserver();

  // Run the application
  runApp(const App());
}
