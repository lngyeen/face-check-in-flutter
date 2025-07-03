import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:face_check_in_flutter/core/di/di.dart';
import 'package:face_check_in_flutter/core/theme/app_theme.dart';
import 'package:face_check_in_flutter/features/check_in/bloc/check_in_bloc.dart';
import 'package:face_check_in_flutter/features/check_in/screens/check_in_screen_v2.dart';
import 'package:face_check_in_flutter/features/connection/bloc/connection_bloc.dart';
import 'package:face_check_in_flutter/flavors.dart';

/// Main application widget
/// Configures BLoC providers, theme, and routing for the face check-in app
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Core connection infrastructure - provide first
        BlocProvider<ConnectionBloc>(
          create: (context) => getIt<ConnectionBloc>(),
        ),
        // CheckInBloc depends on ConnectionBloc - provide second
        BlocProvider<CheckInBloc>(create: (context) => getIt<CheckInBloc>()),
      ],
      child: MaterialApp(
        title: F.title,
        debugShowCheckedModeBanner: false,

        // Use centralized theme configuration
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,

        // Home screen with flavor banner in debug mode
        home: _flavorBanner(child: const CheckInScreenV2(), show: kDebugMode),

        // Error handling
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0), // Prevent text scaling issues
            ),
            child: child!,
          );
        },
      ),
    );
  }

  /// Creates a flavor banner for debug mode to easily identify the current flavor
  Widget _flavorBanner({required Widget child, bool show = true}) =>
      show
          ? Banner(
            location: BannerLocation.topStart,
            message: F.name,
            color: AppTheme.getFlavorBannerColor().withAlpha(150),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              letterSpacing: 1.0,
            ),
            textDirection: TextDirection.ltr,
            child: child,
          )
          : Container(child: child);
}
