import 'package:flutter/material.dart';
import 'package:glitchi/src/core/utils/extensions/int_extension.dart';
import 'package:glitchi/src/core/widget/animated_text.dart';
import 'package:glitchi/src/feature/cart/widget/cart_scope.dart';
import 'package:glitchi/src/feature/catalog/widget/cart_card.dart';
import 'package:glitchi/src/feature/catalog/widget/cart_empty_screen.dart';
import 'package:glitchi/src/feature/catalog/widget/cart_error_screen.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@template cart_screen}
/// CartScreen widget.
/// {@endtemplate}
class CartScreen extends StatelessWidget {
  /// {@macro cart_screen}
  const CartScreen({
    super.key, // ignore: unused_element
  });

  static const double _defaultToolbarHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final toolbarHeight = _defaultToolbarHeight + statusBarHeight;
    final theme = Theme.of(context);
    final scope = CartScope.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: toolbarHeight,
        title: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Text(
            'Каталог товаров',
            style: theme.textTheme.headlineMedium,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 12,
          right: 12,
        ),
        child: CustomScrollView(
          slivers: [
            if (scope.state.items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: scope.state.isProcessing
                    ? Center(child: CircularProgressIndicator())
                    : CartEmptyScreen(),
              ),
            if (scope.state.hasError)
              SliverFillRemaining(
                hasScrollBody: false,
                child: CartErrorScreen(
                  onRetry: () {},
                ),
              ),
            if (scope.state.items.isNotEmpty)
              SliverList.builder(
                addRepaintBoundaries: true,
                itemCount: scope.state.items.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: CartCard(cartItem: scope.state.items[index]));
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: scope.state.items.isEmpty
          ? null
          : Padding(
              padding: EdgeInsetsGeometry.only(
                bottom: 59,
                left: 12,
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'К оплате',
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      height: 40.0 / 14.0,
                      letterSpacing: -0.41,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  AnimatedText(
                    text: '${scope.state.totalPrice.formattedWithSpaces} руб.',
                    style: GoogleFonts.rubik(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      height: 40.0 / 30.0,
                      letterSpacing: -0.41,
                      color: theme.colorScheme.onSurface,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
