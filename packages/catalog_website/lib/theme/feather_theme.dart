import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatherBrand {
  FeatherBrand._();

  // Core brand colors (from README examples and existing gradients)
  static const Color teal = Color(0xFF00C9A7);
  static const Color blue = Color(0xFF0072FF);
  static const Color navy = Color(0xFF0B1622);
  static const Color navyLight = Color(0xFF0D1B2A);
}

final ThemeData featherTheme = _buildFeatherTheme(Brightness.light);
final ThemeData featherDarkTheme = _buildFeatherTheme(Brightness.dark);

ThemeData _buildFeatherTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  final base = ThemeData(
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: FeatherBrand.blue,
      brightness: brightness,
      primary: FeatherBrand.blue,
      secondary: FeatherBrand.teal,
      surface: isDark ? const Color(0xFF101826) : Colors.white,
      background: isDark ? const Color(0xFF0A121E) : const Color(0xFFF6F7FB),
    ),
    useMaterial3: true,
  );

  // Typography
  final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
    displayLarge: GoogleFonts.inter(fontWeight: FontWeight.w700),
    displayMedium: GoogleFonts.inter(fontWeight: FontWeight.w700),
    displaySmall: GoogleFonts.inter(fontWeight: FontWeight.w700),
    headlineLarge: GoogleFonts.inter(fontWeight: FontWeight.w700),
    headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.w600),
    headlineSmall: GoogleFonts.inter(fontWeight: FontWeight.w600),
    titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600),
    titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w600),
    titleSmall: GoogleFonts.inter(fontWeight: FontWeight.w600),
  );

  // Common gradient for brand accents
  const gradient = LinearGradient(
    colors: [FeatherBrand.teal, FeatherBrand.blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  return base.copyWith(
    scaffoldBackgroundColor: base.colorScheme.background,
    splashFactory: InkSparkle.splashFactory,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: base.colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: base.colorScheme.onSurface,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
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
    ),
    tabBarTheme: base.tabBarTheme.copyWith(
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: textTheme.titleSmall,
      unselectedLabelStyle: textTheme.titleSmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ).merge(
            ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return base.colorScheme.primary.withOpacity(0.4);
                }
                return null; // Use gradient container wrapper where needed
              }),
            ),
          ),
    ),
    extensions: <ThemeExtension<dynamic>>[_FeatherGradients(brand: gradient)],
  );
}

class _FeatherGradients extends ThemeExtension<_FeatherGradients> {
  const _FeatherGradients({required this.brand});
  final Gradient brand;

  @override
  ThemeExtension<_FeatherGradients> copyWith({Gradient? brand}) =>
      _FeatherGradients(brand: brand ?? this.brand);

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
