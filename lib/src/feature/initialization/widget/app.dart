import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/initialization/logic/composition_root.dart';
import 'package:glitchi/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:glitchi/src/feature/initialization/widget/material_context.dart';

class App extends StatelessWidget {
  const App({required this.result, super.key});

  final CompositionResult result;

  @override
  Widget build(BuildContext context) => DependenciesScope(
        dependencies: result.dependencies,
        child: MaterialContext(),
      );
}
