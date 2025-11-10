import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/home/widget/loading_indicator_view.dart';
import 'package:glitchi/src/feature/home/widget/toggle_theme_buttons.dart';
import 'package:glitchi/src/feature/catalog/widget/catalog_scope.dart';
import 'package:glitchi/src/feature/product/widget/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _flexibleSpaceHeight = 320;
  static const double _cartButtonBorderRadius = 20;
  static const double _cartButtonHorizontalPadding = 12;
  static const double _cartButtonVerticalPadding = 8;
  static const double _cartIconSize = 20;
  static const double _cartIconSpacing = 4;
  static const double _cartButtonMargin = 16;
  static const double _defaultToolbarHeight = 56.0;
  static const double _textVerticalPadding = 40;
  static const double _textHorizontalPadding = 22;
  static const double _bottomSpacing = 60;

  @override
  Widget build(BuildContext context) {
    final scope = CatalogScope.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final toolbarHeight = _defaultToolbarHeight + statusBarHeight;

    return Scaffold(
      body: CustomScrollView(
        controller: scope.scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: _flexibleSpaceHeight + statusBarHeight,
            toolbarHeight: toolbarHeight,
            backgroundColor: colorScheme.surface,
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Text(
                'Каталог товаров',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  top: statusBarHeight,
                  right: _cartButtonMargin,
                ),
                child: SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(_cartButtonBorderRadius),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _cartButtonHorizontalPadding,
                        vertical: _cartButtonVerticalPadding,
                      ),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '0',
                            style: theme.textTheme.displaySmall?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(width: _cartIconSpacing),
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: colorScheme.onPrimary,
                            size: _cartIconSize,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Padding(
                padding: EdgeInsets.only(top: statusBarHeight),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: _textVerticalPadding,
                        horizontal: _textHorizontalPadding,
                      ),
                      child: Text(
                        'Каждый день тысячи девушек распаковывают пакеты с новинками Lichi и становятся счастливее, ведь очевидно, что новое платье может изменить день, а с ним и всю жизнь!',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    ToggleThemeButtons(),
                    const SizedBox(height: _bottomSpacing),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            sliver: SliverGrid.builder(
                itemCount: scope.state.products.length, // Убрали + 1
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 26,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, index) {
                  // Убрали проверку последнего элемента
                  return ProductCard(
                    onCardTap: () =>
                        scope.onProductTap(scope.state.products[index]),
                    product: scope.state.products[index],
                    key: ValueKey(scope.state.products[index].id),
                  );
                }),
          ),
          // Добавляем индикатор загрузки отдельно, если идет загрузка и есть еще данные
          if (scope.state.isProcessing && scope.state.hasMore)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: RepaintBoundary(
                  child: LoadingIndicatorView(),
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }
}
