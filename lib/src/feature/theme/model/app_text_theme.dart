import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Текстовая тема приложения:
/// - Заголовок 1 (displayLarge): 30px, weight 400, line-height 22px
/// - Заголовок 2 (displayMedium): 25px, weight 400, line-height 22px
/// - Заголовок 3 (displaySmall): 20px, weight 400, line-height 22px
/// - Заголовок 4 (headlineLarge): 16px, weight 400, line-height 22px
/// - Заголовок 5 (headlineMedium): 14px, weight 300, line-height 22px
/// - Параграф (bodyLarge): 13px, weight 300, line-height 22px
class AppTextTheme {
  AppTextTheme._();
  static const double _heading1 = 30;
  static const double _heading2 = 25;
  static const double _heading3 = 20;
  static const double _heading4 = 16;
  static const double _heading5 = 14;
  static const double _paragraph = 13;
  static const double _cartButtonText = 21;
  static const double _lineHeight = 22;
  static const double _letterSpacing = -0.41;

  static TextStyle _baseStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return GoogleFonts.openSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: _lineHeight / fontSize,
      letterSpacing: _letterSpacing,
    );
  }

  static TextTheme create(ColorScheme colorScheme) {
    return TextTheme(
      // Заголовок 1
      displayLarge: _baseStyle(
        fontSize: _heading1,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      // Заголовок 2: 25px, weight 400, line-height 22px
      displayMedium: _baseStyle(
        fontSize: _heading2,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      // Заголовок 3: 20px, weight 400, line-height 22px
      displaySmall: _baseStyle(
        fontSize: _heading3,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      // Заголовок 4: 16px, weight 400, line-height 22px
      headlineLarge: _baseStyle(
        fontSize: _heading4,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      // Заголовок 5: 14px, weight 300, line-height 22px
      headlineMedium: _baseStyle(
        fontSize: _heading5,
        fontWeight: FontWeight.w300,
        color: colorScheme.onSurface,
      ),
      // Параграф: 13px, weight 300, line-height 22px
      bodyLarge: _baseStyle(
        fontSize: _paragraph,
        fontWeight: FontWeight.w300,
        color: colorScheme.onSurface,
      ),
      // Кнопка корзины: 21px, weight 400, line-height 22px, Rubik
      labelLarge: GoogleFonts.rubik(
        fontSize: _cartButtonText,
        fontWeight: FontWeight.w400,
        height: _lineHeight / _cartButtonText,
        letterSpacing: _letterSpacing,
        color: colorScheme.onSurface,
      ),
    );
  }
}
