final class Size {
  const Size({
    required this.id,
    required this.exist,
  });

  final String id;
  final bool exist;

  factory Size.fromJson(Map<String, Object?> json) {
    return Size(
      id: json['name'] as String,
      exist: json['show'] as bool? ?? false,
    );
  }
}
