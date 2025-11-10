import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/home/widget/theme_button.dart';
import 'package:glitchi/src/feature/theme/widget/theme_provider.dart';
import 'package:provider/provider.dart';

class ToggleThemeButtons extends StatelessWidget {
  const ToggleThemeButtons({super.key});
  static const double _themeButtonsHorizontalPadding = 4;
  static const double _themeButtonsSpacing = 8;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _themeButtonsHorizontalPadding,
          ),
          child: Flex(
            spacing: _themeButtonsSpacing,
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ThemeButton.dark(
                  isActive: isDarkMode,
                  onTap: () {
                    themeProvider.setThemeMode(ThemeMode.dark);
                  },
                ),
              ),
              Flexible(
                child: ThemeButton.light(
                  isActive: !isDarkMode,
                  onTap: () {
                    themeProvider.setThemeMode(ThemeMode.light);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
