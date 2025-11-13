import 'package:flutter/material.dart';

class CartErrorScreen extends StatelessWidget {
  final VoidCallback onRetry;
  const CartErrorScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flex(
        spacing: 25,
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Произошла ошибка, пожалуйста повторите позднее',
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(
            height: 71,
            child: ElevatedButton(
              onPressed: onRetry,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Повторить',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
            ),
          ),
        ]);
  }
}
