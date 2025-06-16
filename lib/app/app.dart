import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/check_in/bloc/check_in_bloc.dart';
import '../features/check_in/bloc/check_in_event.dart';
import '../features/check_in/view/check_in_screen.dart';

/// Main application widget
/// Configures BLoC providers, theme, and routing for the face check-in app
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckInBloc()..add(const CheckInEvent.appStarted()),
      child: MaterialApp(
        title: 'FaceCheckIn Employee',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Company brand colors - red theme
          primarySwatch: Colors.red,
          primaryColor: Colors.red[700],
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            brightness: Brightness.light,
          ),

          // App bar theme
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red[700],
            foregroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          // Button themes
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          // Card theme
          cardTheme: CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(8),
          ),

          // Text themes
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          ),

          // Input decoration theme
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red[700]!, width: 2),
            ),
          ),

          // Progress indicator theme
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.red[700],
          ),

          // Snackbar theme
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.grey[800],
            contentTextStyle: const TextStyle(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        ),

        // Dark theme (optional)
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          primaryColor: Colors.red[400],
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            brightness: Brightness.dark,
          ),
        ),

        // Theme mode
        themeMode: ThemeMode.system,

        // Home screen
        home: const CheckInScreen(),

        // Route configuration (for future expansion)
        routes: {'/check-in': (context) => const CheckInScreen()},

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
}
