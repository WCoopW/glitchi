import 'package:glitchi/src/feature/catalog/model/photo.dart';
import 'package:glitchi/src/feature/catalog/model/size.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.photos,
    required this.colors,
    required this.sizes,
  });

  final String id;
  final String name;
  final int price;
  final List<Photo> photos;
  final List<String> colors;
  final Map<String, Size> sizes;

  factory Product.fromJson(Map<String, Object?> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      photos: (json['photos'] as List<Object?>?)
              ?.whereType<Map<String, Object?>>()
              .map((e) => Photo.fromJson(e))
              .toList() ??
          [],
      colors: (json['colors'] as List<Object?>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sizes: _parseSizes(json['sizes']),
    );
  }

  static Map<String, Size> _parseSizes(Object? sizesJson) {
    if (sizesJson == null) {
      return {};
    }

    final sizesMap = sizesJson as Map<String, Object?>;
    final result = <String, Size>{};

    for (final entry in sizesMap.entries) {
      final sizeData = entry.value as Map<String, Object?>?;
      if (sizeData != null) {
        final sizeName = sizeData['name'] as String?;
        if (sizeName != null) {
          result[sizeName] = Size.fromJson(sizeData);
        }
      }
    }

    return result;
  }
}
