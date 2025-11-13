import 'package:flutter/material.dart';

/// {@template animated_text}
/// AnimatedText widget that animates text changes with slide and fade transitions.
/// {@endtemplate}
class AnimatedText extends StatelessWidget {
  /// {@macro animated_text}
  const AnimatedText({
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 250),
    this.switchInCurve = Curves.easeOut,
    this.switchOutCurve = Curves.easeIn,
    this.slideOffset = const Offset(0.0, -0.2),
    super.key,
  });

  final String text;
  final TextStyle? style;
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Offset slideOffset;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetAnimation = Tween<Offset>(
          begin: slideOffset,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: switchInCurve,
          ),
        );
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Text(
        text,
        key: ValueKey(text),
        style: style,
      ),
    );
  }
}
