import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/catalog/model/photo.dart';
import 'package:glitchi/src/feature/product/widget/product_image_view.dart';

class ImageSlider extends StatefulWidget {
  final List<Photo> photos;

  const ImageSlider({
    super.key,
    required this.photos,
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const double _imageAspectRatio = 207 / 276;
  static const double _imageBorderRadius = 15;
  static const double _indicatorDotSize = 6.5;
  static const double _indicatorDotMargin = 8.5;
  static const double _indicatorDotSpacing = 3.2;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (widget.photos.isEmpty) {
      return const SizedBox.shrink();
    }
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(_imageBorderRadius),
          ),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.photos.length,
            itemBuilder: (context, index) {
              return ProductImageView(
                imageAspectRatio: _imageAspectRatio,
                photo: widget.photos[index],
              );
            },
          ),
        ),
        if (widget.photos.length > 1)
          Positioned(
            bottom: 14,
            left: 14,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(_imageBorderRadius),
                ),
                color: Color(0xFF9D948F),
              ),
              child: Padding(
                padding: const EdgeInsets.all(_indicatorDotMargin),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.photos.length,
                    (index) {
                      final isActive = index == _currentPage;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _indicatorDotSpacing / 2,
                        ),
                        child: SizedBox.square(
                          dimension: _indicatorDotSize,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: isActive
                                  ? colorScheme.primary
                                  : colorScheme.surfaceContainerHighest,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
