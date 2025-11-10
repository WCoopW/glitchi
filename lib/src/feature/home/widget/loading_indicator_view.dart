import 'package:flutter/material.dart';

/// {@template loading_indicator_view}
/// LoadingIndicatorView widget for pagination loading.
/// {@endtemplate}
class LoadingIndicatorView extends StatelessWidget {
  /// {@macro loading_indicator_view}
  const LoadingIndicatorView({
    super.key,
  });
  static const double _loadingIndicatorSize = 15;
  static const double _loadingIndicatorSpacing = 8;
  static const double _loadingIndicatorHeight = 50;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: _loadingIndicatorHeight,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: _loadingIndicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
            const SizedBox(width: _loadingIndicatorSpacing),
            Text(
              'Загрузка...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
