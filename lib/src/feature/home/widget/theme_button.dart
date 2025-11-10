import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton._({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  factory ThemeButton.light({
    required bool isActive,
    required VoidCallback onTap,
  }) =>
      ThemeButton._(
        label: 'Светлая тема',
        icon: Icons.light_mode_outlined,
        isActive: isActive,
        onTap: onTap,
      );

  factory ThemeButton.dark({
    required bool isActive,
    required VoidCallback onTap,
  }) =>
      ThemeButton._(
        label: 'Темная тема',
        icon: Icons.dark_mode_outlined,
        isActive: isActive,
        onTap: onTap,
      );

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  static const double _buttonHeight = 86;
  static const double _buttonBorderRadius = 20;
  static const double _iconSize = 20;
  static const double _iconSpacing = 8;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor =
        isActive ? colorScheme.primary : colorScheme.surfaceContainerHighest;
    final textColor = isActive ? colorScheme.onPrimary : colorScheme.onSurface;
    final iconColor = isActive ? colorScheme.onPrimary : colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _buttonHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(_buttonBorderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: _iconSize,
            ),
            const SizedBox(width: _iconSpacing),
            Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
