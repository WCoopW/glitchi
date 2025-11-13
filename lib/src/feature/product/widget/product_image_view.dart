import 'package:flutter/material.dart';
import 'package:glitchi/src/feature/catalog/model/photo.dart';

class ProductImageView extends StatelessWidget {
  final Photo photo;
  final double imageAspectRatio;
  const ProductImageView({
    super.key,
    required this.photo,
    required this.imageAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: imageAspectRatio,
      child: Image.network(
        photo.big,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          final totalBytes = loadingProgress.expectedTotalBytes;
          return Center(
            child: CircularProgressIndicator(
              value: totalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / totalBytes
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error),
          );
        },
      ),
    );
  }
}
