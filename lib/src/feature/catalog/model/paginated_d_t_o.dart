import 'package:glitchi/src/feature/catalog/model/product.dart';

class PaginatedDTO {
  final List<Product> products;
  final int lastPage;

  PaginatedDTO({
    required this.products,
    required this.lastPage,
  });

  factory PaginatedDTO.fromJson(Map<String, Object?> json) {
    return PaginatedDTO(
      products: (json['aProduct'] as List<Object?>?)
              ?.map((e) => Product.fromJson(e as Map<String, Object?>))
              .toList() ??
          [],
      lastPage: json['iPages'] as int,
    );
  }
}
