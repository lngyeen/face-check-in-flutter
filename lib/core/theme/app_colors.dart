import 'package:flutter/material.dart';

/// Minimalist color palette for Face Check-In app
/// Reduced to 8 essential colors with semantic usage
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ========== CORE PALETTE (Refined) ==========

  /// 1. Primary Red - Main brand color from OWT logo
  static const Color primary = Color(0xFFE4002B);

  /// 2. Secondary Teal - A sophisticated accent for info states
  static const Color secondary = Color(0xFF00796B); // Teal 700

  /// 3. Success Green - For positive states
  static const Color success = Color(0xFF4CAF50); // Green 500

  /// 4. Warning Amber - A softer, more harmonious warning color
  static const Color warning = Color(0xFFFFA000); // Amber 700

  /// 5. White - Pure white for surfaces
  static const Color white = Color(0xFFFFFFFF);

  /// 6. Light Grey - For backgrounds and disabled states
  static const Color greyLight = Color(0xFFF5F5F5); // Grey 100

  /// 7. Medium Grey - For borders and secondary text
  static const Color greyMedium = Color(0xFF757575); // Grey 600

  /// 8. Dark Grey - For primary text
  static const Color greyDark = Color(0xFF212121); // Grey 900

  // ========== SEMANTIC ALIASES ==========
  // All other colors reference the 8 core colors above

  // Surface colors
  static const Color surface = white;
  static const Color background = greyLight;
  static const Color surfaceVariant = greyLight;

  // Text colors
  static const Color textPrimary = greyDark;
  static const Color textSecondary = greyMedium;
  static const Color textDisabled = greyMedium;
  static const Color textOnPrimary = white;

  // Status colors (reuse primary colors)
  static const Color error = primary; // Use primary red for errors
  static const Color info = secondary; // Use secondary teal for info

  // Border colors
  static const Color border = greyMedium;
  static const Color borderFocused = primary;
  static const Color borderError = primary;

  // Overlay colors (derived from existing colors)
  static const Color shadow = Color(0x1F000000); // 12% black
  static const Color overlay = Color(0x80000000); // 50% black

  // Derived colors for variations
  static Color get primaryLight => Color.lerp(primary, white, 0.3)!;
  static Color get primaryDark => Color.lerp(primary, greyDark, 0.3)!;
  static Color get secondaryLight => Color.lerp(secondary, white, 0.3)!;
  static Color get secondaryDark => Color.lerp(secondary, greyDark, 0.3)!;
}

/// Semantic color extensions for specific use cases
extension AppColorsExtensions on AppColors {
  // Flavor colors (reuse status colors)
  static Color get devBanner => AppColors.success;
  static Color get stagBanner => AppColors.warning;
  static Color get prodBanner => AppColors.primary;

  // Connection status (reuse status colors)
  static Color get connected => AppColors.success;
  static Color get connecting => AppColors.warning;
  static Color get disconnected => AppColors.primary;

  // Camera status (reuse status colors)
  static Color get cameraActive => AppColors.success;
  static Color get cameraInactive => AppColors.greyMedium;
  static Color get cameraError => AppColors.primary;
}

/// Simplified material color swatch
class AppMaterialColors {
  AppMaterialColors._();

  static const MaterialColor primarySwatch = MaterialColor(
    0xFFE4002B, // OWT Red
    <int, Color>{
      50: Color(0xFFFDE4E8),
      100: Color(0xFFF9BCC7),
      200: Color(0xFFF490A2),
      300: Color(0xFFF0637C),
      400: Color(0xFFEC405F),
      500: Color(0xFFE81D43),
      600: Color(0xFFE6193D),
      700: Color(0xFFE4002B), // The primary color
      800: Color(0xFFE10025),
      900: Color(0xFFDD001A),
    },
  );
}

/// Design tokens for consistent spacing, sizing, and other design values
class AppDesignTokens {
  AppDesignTokens._();

  // ========== BORDER RADIUS ==========
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;

  // ========== ELEVATION ==========
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 6.0;
  static const double elevationXHigh = 8.0;

  // ========== SPACING ==========
  static const double spaceXSmall = 4.0;
  static const double spaceSmall = 8.0;
  static const double spaceMedium = 16.0;
  static const double spaceLarge = 24.0;
  static const double spaceXLarge = 32.0;

  // ========== ICON SIZES ==========
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
}
