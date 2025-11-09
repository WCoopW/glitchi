final class Photo {
  const Photo({required this.big});

  final String big;

  factory Photo.fromJson(Map<String, Object?> json) {
    return Photo(
      big: json['big'] as String,
    );
  }
}
