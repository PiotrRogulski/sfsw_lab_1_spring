import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

const _seedColor = Color(0xFF00FF8C);

class AppTheme {
  static ThemeData light(ColorScheme? systemScheme) =>
      _makeTheme(Brightness.light, systemScheme);
  static ThemeData dark(ColorScheme? systemScheme) =>
      _makeTheme(Brightness.dark, systemScheme);

  static ThemeData _makeTheme(
    Brightness brightness,
    ColorScheme? systemScheme,
  ) {
    final colorScheme = systemScheme ?? _makeColorScheme(brightness);
    return ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    ).copyWith(
      splashFactory: InkSparkle.splashFactory,
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        errorStyle: const TextStyle(
          fontSize: 0,
        ),
      ),
    );
  }

  static ColorScheme _makeColorScheme(Brightness brightness) {
    final scheme = SchemeFidelity(
      sourceColorHct: Hct.fromInt(_seedColor.value),
      isDark: brightness == Brightness.dark,
      contrastLevel: 1,
    );
    return CorePalette.fromList([
      ...scheme.primaryPalette.asList,
      ...scheme.secondaryPalette.asList,
      ...scheme.tertiaryPalette.asList,
      ...scheme.neutralPalette.asList,
      ...scheme.neutralVariantPalette.asList,
    ]).toColorScheme(brightness: brightness).harmonized();
  }
}
