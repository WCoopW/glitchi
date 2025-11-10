final class ProductSize {
  const ProductSize({
    required this.id,
    required this.exist,
  });

  final String id;
  final bool exist;

  factory ProductSize.fromJson(Map<String, Object?> json) {
    return ProductSize(
      id: json['name'] as String,
      exist: json['show'] as bool? ?? false,
    );
  }
}
