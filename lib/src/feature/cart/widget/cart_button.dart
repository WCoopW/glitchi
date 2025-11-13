import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/cart/widget/cart_scope.dart';
import 'package:glitchi/src/feature/catalog/widget/cart_screen.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});
  static const double _buttonBorderRadius = 100.0;
  static const double _iconWidth = 20.0;
  static const double _iconHeight = 22.0;
  static const double _horizontalPadding = 12.0;
  static const double _verticalPadding = 8.0;
  static const double _iconSpacing = 4.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scope = CartScope.of(context);
    final colorScheme = theme.colorScheme;
    final itemCount = scope.state.items.length;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartScreen(),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(_buttonBorderRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: _verticalPadding,
          ),
          child: Flex(
            spacing: _iconSpacing,
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                itemCount.toString(),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(
                width: _iconWidth,
                height: _iconHeight,
                child: Icon(
                  Icons.shopping_bag,
                  color: colorScheme.onPrimary,
                  size: _iconWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
