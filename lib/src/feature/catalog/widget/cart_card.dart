import 'package:flutter/material.dart';
import 'package:glitchi/src/core/widget/animated_text.dart';
import 'package:glitchi/src/feature/cart/model/cart_item.dart';
import 'package:glitchi/src/feature/cart/widget/cart_scope.dart';
import 'package:glitchi/src/feature/product/widget/product_image_view.dart';

/// {@template cart_card}
/// CartCard widget.
/// {@endtemplate}
class CartCard extends StatelessWidget {
  final CartItem cartItem;

  /// {@macro cart_card}
  const CartCard({
    super.key, // ignore: unused_element
    required this.cartItem,
  });
  static const int _imageFlex = 137;
  static const int _contentFlex = 269;
  static const double _imageAspectRatio = 137 / 184;
  @override
  Widget build(BuildContext context) {
    final scope = CartScope.of(context);
    return IntrinsicHeight(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: _imageFlex,
            child: ProductImageView(
              photo: cartItem.product.photos.first,
              imageAspectRatio: _imageAspectRatio,
            ),
          ),
          Flexible(
            flex: _contentFlex,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  cartItem.selectedSize,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),
                // Spacer(),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedText(
                      text: cartItem.formattedTotalPrice,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                // Spacer(),
                SizedBox(
                  height: 35,
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ItemCounterWidget(
                        productId: cartItem.product.id,
                        key: ValueKey(cartItem.product),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => scope.removeProduct(
                            cartItem.product.id,
                            deleteAll: true,
                          ),
                          icon: const Icon(
                            Icons.delete,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCounterWidget extends StatelessWidget {
  final int productId;

  static const double _spacing = 16.0;

  const ItemCounterWidget({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scope = CartScope.of(context);
    final cartItem = scope.getCartItem(productId);
    return Flex(
      direction: Axis.horizontal,
      spacing: _spacing,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CounterButton.remove(
          onPressed: () => scope.removeProduct(productId),
        ),
        Text(
          '${cartItem.count} ед.',
          style: theme.textTheme.bodyLarge,
        ),
        CounterButton.add(
          onPressed: () => scope.addProduct(
            cartItem.product,
            cartItem.selectedSize,
          ),
        ),
      ],
    );
  }
}

class CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  static const double _buttonSize = 35.0;
  static const double _buttonBorderRadius = 8.0;
  static const double _iconSize = 16.0;

  const CounterButton._({
    required this.icon,
    required this.onPressed,
  });

  factory CounterButton.remove({
    required VoidCallback onPressed,
  }) =>
      CounterButton._(
        icon: Icons.remove,
        onPressed: onPressed,
      );

  factory CounterButton.add({
    required VoidCallback onPressed,
  }) =>
      CounterButton._(
        icon: Icons.add,
        onPressed: onPressed,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: _buttonSize,
      height: _buttonSize,
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.all(
          Radius.circular(_buttonBorderRadius),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: const BorderRadius.all(
            Radius.circular(_buttonBorderRadius),
          ),
          child: Icon(
            icon,
            size: _iconSize,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
