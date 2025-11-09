import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/home/widget/home_screen.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MaterialApp(
      home: const HomeScreen(),
      builder: (context, child) => MediaQuery(
        key: _globalKey,
        data: mediaQueryData,
        child: child!,
      ),
    );
  }
}
