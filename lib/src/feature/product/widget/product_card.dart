import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';
import 'package:glitchi/src/feature/product/widget/image_slider.dart';

/// {@template product_card}
/// ProductCard widget.
/// {@endtemplate}
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onCardTap;
  const ProductCard({
    super.key, // ignore: unused_element
    required this.product,
    required this.onCardTap,
  });

  static const double _priceTopMargin = 17;
  static const double _nameTopMargin = 12;
  static const double _colorsTopMargin = 19;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: ImageSlider(
              photos: product.photos,
            ),
          ),
          SizedBox(height: _priceTopMargin),
          Text(
            product.formattedPrice,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            height: _nameTopMargin,
          ),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: _colorsTopMargin),
          Flex(
            direction: Axis.horizontal,
            spacing: 9,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var color in [Colors.red, Colors.green, Colors.blue])
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: SizedBox.square(
                    dimension: 10.2,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
