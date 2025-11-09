import 'package:glitchi/src/feature/catalog/model/product.dart';

abstract interface class ICatalogRepository {
  Future<({List<Product> products, int lastPage})> fetchProducts(
    int page,
    int limit,
    String category,
  );
}
