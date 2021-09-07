import 'package:flutter/material.dart';

class ThemeService {
  static ThemeData get() {
    return ThemeData(colorScheme: ThemeService._colorScheme());
  }

  static ColorScheme _colorScheme() => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF1D2228),
        primaryVariant: Color(0xFF484C50),
        secondary: Color(0xFFFB8122),
        secondaryVariant: Color(0xFFEA9654),
        background: Color(0xFFF4F4F4),
        surface: Color(0xFFFDFDFD),
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFF000000),
        onBackground: Color(0xFF000000),
        onSurface: Color(0xFF000000),
        onError: Color(0xFFFFFFFF),
        error: Color(0xFFB00020),
      );
}
