import 'package:dio/dio.dart';
import 'package:glitchi/src/core/network/endpoints/catalog_endpoints.dart';
import 'package:glitchi/src/feature/catalog/data/implementation/catalog_data_source.dart';
import 'package:glitchi/src/feature/catalog/data/implementation/catalog_repository.dart';
import 'package:glitchi/src/feature/initialization/logic/composition_root.dart';

class CatalogRepositoryFactory extends AsyncFactory<CatalogRepository> {
/* -------------------------------------------------------------------------- */
  final Dio client;

/* -------------------------------------------------------------------------- */
  CatalogRepositoryFactory({
    required this.client,
  });
/* -------------------------------------------------------------------------- */
  @override
  Future<CatalogRepository> create() async {
    return CatalogRepository(
      catalogDataSource: CatalogDataSource(
        dioClient: client,
        catalogEndpoints: CatalogEndpoints(
          baseUrl: 'https://api.lichi.com',
          apiVersion: 'api',
          category: 'category',
          listProducts: 'get_category_product_list',
        ),
      ),
    );
  }
/* -------------------------------------------------------------------------- */
}
