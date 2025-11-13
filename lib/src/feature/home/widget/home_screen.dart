import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/cart/widget/cart_button.dart';
import 'package:glitchi/src/feature/catalog/widget/cart_error_screen.dart';
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
  static const double _cartButtonMargin = 16;
  static const double _defaultToolbarHeight = 56.0;
  static const double _textVerticalPadding = 40;
  static const double _textHorizontalPadding = 22;
  static const double _bottomSpacing = 60;

  bool _isAppBarCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final scope = CatalogScope.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final toolbarHeight = _defaultToolbarHeight + statusBarHeight;
    final expandedHeight = _flexibleSpaceHeight + statusBarHeight;
    final collapseThreshold = expandedHeight - toolbarHeight;

    return Scaffold(
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          final isCollapsed = notification.metrics.pixels > collapseThreshold;
          if (_isAppBarCollapsed != isCollapsed) {
            setState(() {
              _isAppBarCollapsed = isCollapsed;
            });
          }
          return false;
        },
        child: CustomScrollView(
          controller: scope.scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: expandedHeight,
              toolbarHeight: toolbarHeight,
              backgroundColor: colorScheme.surface,
              elevation: 0,
              centerTitle: true,
              leading: _isAppBarCollapsed
                  ? ToggleThemeButtons.simpleButton(
                      padding: EdgeInsets.only(top: statusBarHeight),
                    )
                  : null,
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
                  child: CartButton(),
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
            if (scope.state.hasError)
              SliverFillRemaining(
                hasScrollBody: false,
                child: CartErrorScreen(
                  onRetry: scope.fetchProducts,
                ),
              ),
            if (scope.state.products.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                sliver: SliverGrid.builder(
                    itemCount: scope.state.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 26,
                      crossAxisSpacing: 6,
                      childAspectRatio: 0.5,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        onCardTap: () => scope.onProductTap(
                          scope.state.products[index],
                          context,
                        ),
                        product: scope.state.products[index],
                        key: ValueKey(scope.state.products[index].id),
                      );
                    }),
              ),
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
              child: const SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
