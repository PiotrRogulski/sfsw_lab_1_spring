import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

const _seedColor = Color(0xFFF35F51);

class AppTheme {
  static ThemeData get light => _makeTheme(Brightness.light);
  static ThemeData get dark => _makeTheme(Brightness.dark);

  static ThemeData _makeTheme(Brightness brightness) {
    final colorScheme = _makeColorScheme(brightness);
    return ThemeData.from(
      colorScheme: colorScheme,
    ).copyWith(
      splashFactory: InkSparkle.splashFactory,
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
