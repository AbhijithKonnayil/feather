import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A class to hold all the color constants from the UI
class AppColors {
  // Main Accent Color (derived from the feather's gradient start)
  static const Color primaryBlue = Color(
    0xFF1B69C4,
  ); // Darker blue from the feather's gradient
  static const Color primaryTeal = Color(
    0xFF23B5C0,
  ); // Lighter teal from the feather's gradient

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightSurface = Colors.white; // For cards and dialogs
  static const Color lightPrimaryText = Color(0xFF171717);
  static const Color lightSecondaryText = Color(0xFF696969);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF020618);
  static const Color darkSurface = Color(0xFF0f172b); // For cards and dialogs
  static const Color darkPrimaryText = Colors.white;
  static const Color darkSecondaryText = Color(0xFFA9AABC);

  // Common Colors
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color success = Color(
    0xFF4CAF50,
  ); // Example for transaction status
  static const Color error = Color(0xFFF44336); // Example for alerts
}

// A class to hold the gradients
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF1B69C4), // Darker blue
      Color(0xFF23B5C0), // Lighter teal
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// Main class to define and hold the themes
class FeatherTheme {
  // Private constructor to prevent instantiation
  FeatherTheme._();

  // --- LIGHT THEME ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // We'll use the darker blue of the gradient as the primary color for general components
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: GoogleFonts.poppins().fontFamily,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.primaryTeal,
      surface: AppColors.lightSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightPrimaryText,
      error: AppColors.error,
      onError: Colors.white,
    ),

    textTheme: _lightTextTheme,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.lightPrimaryText),
      titleTextStyle: _lightTextTheme.titleLarge,
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            // For buttons, we'll create a custom style to apply the gradient
            backgroundColor: Colors
                .transparent, // Set transparent to allow gradient background
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: _lightTextTheme.labelLarge,
          ).copyWith(
            // Define a custom background for the button that uses the gradient
            // This is a common pattern for gradient buttons in Flutter
            backgroundColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey; // Or a disabled gradient
              }
              return Colors
                  .transparent; // Managed by the `Container` or `ShaderMask` wrapping the button
            }),
          ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      hintStyle: TextStyle(
        color: AppColors.lightSecondaryText.withOpacity(0.6),
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.lightSecondaryText),
  );

  // --- DARK THEME ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: GoogleFonts.poppins().fontFamily,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryBlue,
      secondary: AppColors.primaryTeal,
      surface: AppColors.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.darkPrimaryText,
      error: AppColors.error,
      onError: Colors.white,
    ),

    textTheme: _darkTextTheme,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.darkPrimaryText),
      titleTextStyle: _darkTextTheme.titleLarge,
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: _darkTextTheme.labelLarge,
          ).copyWith(
            backgroundColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return Colors.transparent;
            }),
          ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      hintStyle: TextStyle(color: AppColors.darkSecondaryText.withOpacity(0.6)),
    ),

    iconTheme: const IconThemeData(color: AppColors.darkSecondaryText),
  );

  // --- TEXT THEMES ---
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.lightPrimaryText,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.lightPrimaryText,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.lightPrimaryText,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      color: AppColors.lightPrimaryText,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.lightSecondaryText,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.darkPrimaryText,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.darkPrimaryText,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.darkPrimaryText,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      color: AppColors.darkPrimaryText,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.darkSecondaryText,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}
