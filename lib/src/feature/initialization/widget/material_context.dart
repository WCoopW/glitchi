import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/home/widget/home_screen.dart';
import 'package:glitchi/src/feature/theme/widget/theme_provider.dart';
import 'package:provider/provider.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomeScreen(),
            builder: (context, child) => MediaQuery(
              key: _globalKey,
              data: mediaQueryData,
              child: child!,
            ),
          );
        },
      ),
    );
  }
}
