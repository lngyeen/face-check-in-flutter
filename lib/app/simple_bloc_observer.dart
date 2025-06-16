import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Simple BLoC observer for debugging and logging state transitions
/// Provides comprehensive logging for development and debugging purposes
class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('🟢 BLoC Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('🔄 BLoC Change: ${bloc.runtimeType}');
    debugPrint('   Current State: ${change.currentState}');
    debugPrint('   Next State: ${change.nextState}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('🚀 BLoC Transition: ${bloc.runtimeType}');
    debugPrint('   Event: ${transition.event}');
    debugPrint('   Current State: ${transition.currentState}');
    debugPrint('   Next State: ${transition.nextState}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('📨 BLoC Event: ${bloc.runtimeType} - $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('❌ BLoC Error: ${bloc.runtimeType}');
    debugPrint('   Error: $error');
    debugPrint('   StackTrace: $stackTrace');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('🔴 BLoC Closed: ${bloc.runtimeType}');
  }
}
