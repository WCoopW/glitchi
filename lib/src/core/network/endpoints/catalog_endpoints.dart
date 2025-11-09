import 'package:glitchi/src/core/network/endpoints/endpoints.dart';

class CatalogEndpoints extends Endpoints {
/* -------------------------------------------------------------------------- */
  final String _category;

  final String _listProducts;
/* -------------------------------------------------------------------------- */
  CatalogEndpoints({
    required super.baseUrl,
    required super.apiVersion,
    required String category,
    required String listProducts,
  })  : _category = category,
        _listProducts = listProducts;
/* -------------------------------------------------------------------------- */
  String get catalogList => buildEndpoint('${_category}/${_listProducts}');
}
