import 'package:glitchi/src/feature/catalog/model/paginated_d_t_o.dart';

abstract interface class ICatalogDataSource {
  Future<PaginatedDTO> fetchProducts(
    int page,
    int limit,
    String category,
  );
}
