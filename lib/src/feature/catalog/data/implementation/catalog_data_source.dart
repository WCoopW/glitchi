import 'package:dio/dio.dart';
import 'package:glitchi/src/core/network/endpoints/catalog_endpoints.dart';
import 'package:glitchi/src/feature/catalog/data/i_catalog_data_source.dart';
import 'package:glitchi/src/feature/catalog/model/paginated_d_t_o.dart';

class CatalogDataSource implements ICatalogDataSource {
  final Dio dioClient;
  final CatalogEndpoints catalogEndpoints;

  CatalogDataSource({
    required this.dioClient,
    required this.catalogEndpoints,
  });

  @override
  Future<PaginatedDTO> fetchProducts(
      int page, int limit, String category) async {
    final response = await dioClient.post(
      catalogEndpoints.catalogList,
      data: {
        'shop': 2,
        'lang': 1,
        'page': page,
        'limit': limit,
        'category': category,
      },
    );
    final data = response.data['api_data'];
    if (data == null) throw Exception('Failed to fetch products');
    return PaginatedDTO.fromJson(data);
  }
}
