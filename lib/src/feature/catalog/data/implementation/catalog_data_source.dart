import 'package:dio/dio.dart';
import 'package:glitchi/src/core/network/endpoints/catalog_endpoints.dart';
import 'package:glitchi/src/feature/catalog/data/i_catalog_data_source.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';

class CatalogDataSource implements ICatalogDataSource {
  final Dio dioClient;
  final CatalogEndpoints catalogEndpoints;

  CatalogDataSource({
    required this.dioClient,
    required this.catalogEndpoints,
  });

  @override
  Future<List<Product>> fetchProducts(
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
    final data = response.data;
    if (data == null) throw Exception('Failed to fetch products');
    return data
        .whereType<Map<String, Object?>>()
        .map<Product>(Product.fromJson)
        .toList(growable: false);
  }
}
