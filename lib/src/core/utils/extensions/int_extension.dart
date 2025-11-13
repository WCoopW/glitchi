/// Common extensions for [int]
extension IntExtension on int {
  /// Formats the number with space as thousands separator.
  /// Example: 1234 -> "1 234"
  String get formattedWithSpaces {
    final String numberString = toString();
    final StringBuffer buffer = StringBuffer();
    const int thousandsGroupSize = 3;

    for (int i = 0; i < numberString.length; i++) {
      if (i > 0 && (numberString.length - i) % thousandsGroupSize == 0) {
        buffer.write(' ');
      }
      buffer.write(numberString[i]);
    }

    return buffer.toString();
  }
}
