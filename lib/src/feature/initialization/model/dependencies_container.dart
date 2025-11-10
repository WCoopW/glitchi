import 'package:glitchi/src/feature/catalog/data/i_catalog_repository.dart';
import 'package:glitchi/src/feature/initialization/logic/composition_root.dart';

/// {@template dependencies_container}
/// Composed dependencies from the [CompositionRoot].
///
/// This class contains all the dependencies that are required for the application
/// to work.
///
/// {@macro composition_process}
/// {@endtemplate}
base class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({
    required this.catalogRepository,
  });
  final ICatalogRepository catalogRepository;
}
