import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@template cart_empty_screen}
/// CartEmptyScreen widget.
/// {@endtemplate}
class CartEmptyScreen extends StatelessWidget {
  /// {@macro cart_empty_screen}
  const CartEmptyScreen({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Корзина пустая\nДобавьте все что вы хотите.',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 22.0 / 13.0,
                  letterSpacing: -0.41,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      );
}
