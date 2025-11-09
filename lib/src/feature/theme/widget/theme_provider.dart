import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/theme/model/app_color_schemes.dart';
import 'package:glitchi/src/feature/theme/model/app_text_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final ColorScheme _darkScheme = darkColorScheme;
  final ColorScheme _lightScheme = lightColorScheme;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ColorScheme get darkScheme => _darkScheme;
  ColorScheme get lightScheme => _lightScheme;

  ThemeData get lightTheme => ThemeData(
        colorScheme: _lightScheme,
        textTheme: AppTextTheme.create(_lightScheme),
        useMaterial3: true,
        scaffoldBackgroundColor: _lightScheme.surface,
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: _darkScheme,
        textTheme: AppTextTheme.create(_darkScheme),
        useMaterial3: true,
        scaffoldBackgroundColor: _darkScheme.surface,
      );
}
