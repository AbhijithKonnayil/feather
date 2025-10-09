import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatherColors {
  // Brand Colors
  static const Color teal = Color(0xFF00C9A7);
  static const Color blue = Color(0xFF0072FF);
  static const Color navy = Color(0xFF0B1622);
  static const Color navyLight = Color(0xFF0D1B2A);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF6F7FB);
  static const Color lightSurface = Colors.white;
  static const Color lightError = Color(0xFFD32F2F);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF1A1A1A);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0A121E);
  static const Color darkSurface = Color(0xFF101826);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkOnBackground = Color(0xFFE1E1E1);
  static const Color darkOnSurface = Color(0xFFE1E1E1);

  // Common Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF424242);
}

class FeatherTheme {
  static ThemeData get lightTheme => _buildTheme(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: FeatherColors.blue,
      secondary: FeatherColors.teal,
      surface: FeatherColors.lightSurface,
      background: FeatherColors.lightBackground,
      error: FeatherColors.lightError,
      onPrimary: FeatherColors.white,
      onSecondary: FeatherColors.white,
      onSurface: FeatherColors.lightOnSurface,
      onBackground: FeatherColors.lightOnBackground,
      onError: FeatherColors.white,
      brightness: Brightness.light,
    ),
  );

  static ThemeData get darkTheme => _buildTheme(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: FeatherColors.blue,
      secondary: FeatherColors.teal,
      surface: FeatherColors.darkSurface,
      background: FeatherColors.darkBackground,
      error: FeatherColors.darkError,
      onPrimary: FeatherColors.white,
      onSecondary: FeatherColors.white,
      onSurface: FeatherColors.darkOnSurface,
      onBackground: FeatherColors.darkOnBackground,
      onError: FeatherColors.black,
      brightness: Brightness.dark,
    ),
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
  }) {
    final isDark = brightness == Brightness.dark;
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
    );

    // Typography
    final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: colorScheme.onBackground,
      ),
      displayMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: colorScheme.onBackground,
      ),
      displaySmall: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: colorScheme.onBackground,
      ),
      headlineLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: colorScheme.onBackground,
      ),
      headlineMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
      ),
      headlineSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
      ),
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      bodyLarge: GoogleFonts.inter(
        color: colorScheme.onBackground.withOpacity(0.87),
      ),
      bodyMedium: GoogleFonts.inter(
        color: colorScheme.onBackground.withOpacity(0.87),
      ),
      bodySmall: GoogleFonts.inter(
        color: colorScheme.onBackground.withOpacity(0.6),
      ),
    );

    // Common gradient for brand accents
    const gradient = LinearGradient(
      colors: [FeatherColors.teal, FeatherColors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return base.copyWith(
      scaffoldBackgroundColor: colorScheme.background,
      splashFactory: InkSparkle.splashFactory,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onBackground,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onBackground,
        ),
        iconTheme: IconThemeData(color: colorScheme.onBackground),
      ),
      cardTheme: CardThemeData(
        elevation: isDark ? 4 : 2,
        margin: const EdgeInsets.all(8),
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
            width: 1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? Colors.white.withOpacity(0.06)
            : Colors.black.withOpacity(0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(
          color: isDark
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colorScheme.primary),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      iconTheme: IconThemeData(color: colorScheme.onBackground, size: 24),
      dividerTheme: DividerThemeData(
        color: isDark ? Colors.white12 : Colors.black12,
        thickness: 1,
        space: 1,
      ),
      extensions: <ThemeExtension<dynamic>>[_FeatherGradients(brand: gradient)],
    );
  }
}

class _FeatherGradients extends ThemeExtension<_FeatherGradients> {
  const _FeatherGradients({required this.brand});

  final Gradient brand;

  @override
  ThemeExtension<_FeatherGradients> copyWith({Gradient? brand}) {
    return _FeatherGradients(brand: brand ?? this.brand);
  }

  @override
  ThemeExtension<_FeatherGradients> lerp(
    covariant ThemeExtension<_FeatherGradients>? other,
    double t,
  ) {
    if (other is! _FeatherGradients) return this;
    return _FeatherGradients(
      brand: LinearGradient(
        colors: [
          Color.lerp(
            (brand as LinearGradient).colors.first,
            (other.brand as LinearGradient).colors.first,
            t,
          )!,
          Color.lerp(
            (brand as LinearGradient).colors.last,
            (other.brand as LinearGradient).colors.last,
            t,
          )!,
        ],
      ),
    );
  }
}
