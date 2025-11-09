import 'package:glitchi/src/feature/catalog/data/i_catalog_data_source.dart';
import 'package:glitchi/src/feature/catalog/data/i_catalog_repository.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';

final class CatalogRepository implements ICatalogRepository {
  final ICatalogDataSource catalogDataSource;

  CatalogRepository({
    required this.catalogDataSource,
  });

  @override
  Future<({List<Product> products, int lastPage})> fetchProducts(
      int page, int limit, String category) {
    return catalogDataSource.fetchProducts(page, limit, category).then(
          (paginatedData) => (
            products: paginatedData.products,
            lastPage: paginatedData.lastPage,
          ),
        );
  }
}
