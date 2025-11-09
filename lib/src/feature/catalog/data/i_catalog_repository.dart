import 'package:glitchi/src/feature/catalog/model/product.dart';

abstract interface class ICatalogRepository {
  Future<List<Product>> fetchProducts(
    int page,
    int limit,
    String category,
  );
}
