import 'dart:ui';

extension BrightnessX on Brightness {
  Brightness get opposite =>
      this == Brightness.light ? Brightness.dark : Brightness.light;
}
