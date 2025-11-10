import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';
import 'package:glitchi/src/feature/catalog/model/size.dart';

class SelectSizeBottomSheet extends StatefulWidget {
  final Product product;
  final Function(ProductSize?)? onSizeSelected;

  const SelectSizeBottomSheet({
    super.key,
    required this.product,
    this.onSizeSelected,
  });

  @override
  State<SelectSizeBottomSheet> createState() => _SelectSizeBottomSheetState();
}

class _SelectSizeBottomSheetState extends State<SelectSizeBottomSheet> {
  ProductSize? _selectedSize;

  void _onSizeChanged(ProductSize? size) {
    setState(() {
      _selectedSize = size;
    });
  }

  void _onSubmit() {
    final selected = _selectedSize;
    if (selected != null && selected.exist) {
      widget.onSizeSelected?.call(selected);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите размер',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 28),
          Flexible(
            child: SizeTileView(
              product: widget.product,
              sizes: widget.product.sizes.values.toList(),
              selectedSize: _selectedSize,
              onSizeChanged: _onSizeChanged,
              onSubmit: _onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template size_bottom_sheet}
/// SizeTileView widget.
/// {@endtemplate}
class SizeTileView extends StatelessWidget {
  final Product product;
  final List<ProductSize> sizes;
  final ProductSize? selectedSize;
  final Function(ProductSize?) onSizeChanged;
  final VoidCallback onSubmit;

  /// {@macro size_bottom_sheet}
  const SizeTileView({
    super.key,
    required this.product,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeChanged,
    required this.onSubmit,
  });

  static const double _buttonHeight = 71.0;
  static const int _linkTextColor = 0xFF5D5D5D;
  static const double _buttonBorderRadius = 100.0;
  static const double _bottomSpacing = 32.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              for (var size in sizes)
                if (size.exist)
                  AvailableSizeTile(
                    size: size,
                    isSelected: selectedSize?.id == size.id,
                    onTap: () => onSizeChanged(size),
                  )
                else
                  UnavailableSizeTile(size: size),
              Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 24),
                    child: Text(
                      'Как подобрать размер?',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(_linkTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: _buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(_buttonBorderRadius),
                          ),
                        ),
                      ),
                      onPressed:
                          selectedSize != null && selectedSize?.exist == true
                              ? onSubmit
                              : null,
                      child: Text(
                        'В корзину · ${product.price.toString()} ₽',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: _bottomSpacing,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// {@template available_size_tile}
/// AvailableSizeTile widget for displaying a size option that is in stock.
/// {@endtemplate}
class AvailableSizeTile extends StatelessWidget {
  final ProductSize size;
  final bool isSelected;
  final VoidCallback onTap;

  static const double _borderWidth = 2.0;
  static const double _borderRadius = 4.0;
  static const double _verticalPadding = 12.0;

  /// {@macro available_size_tile}
  const AvailableSizeTile({
    super.key,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                size.id,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              Checkbox(
                value: isSelected,
                onChanged: (_) => onTap(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                side: const BorderSide(
                  color: Colors.transparent,
                  width: _borderWidth,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(_borderRadius),
                  ),
                ),
                fillColor: WidgetStateProperty.all(Colors.transparent),
                checkColor: colorScheme.primary,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// {@template unavailable_size_tile}
/// UnavailableSizeTile widget for displaying a size option that is out of stock.
/// {@endtemplate}
class UnavailableSizeTile extends StatelessWidget {
  final ProductSize size;

  static const double _disabledOpacity = 0.5;
  static const double _verticalPadding = 12.0;

  /// {@macro unavailable_size_tile}
  const UnavailableSizeTile({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            size.id,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface.withValues(alpha: _disabledOpacity),
            ),
          ),
          Text(
            'нет в наличии',
            style: theme.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
