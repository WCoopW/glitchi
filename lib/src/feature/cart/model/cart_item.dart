import 'package:glitchi/src/core/utils/extensions/int_extension.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';

class CartItem {
  final Product product;
  final String selectedSize;
  final int count;
  final int _totalPrice;

  CartItem({
    required this.product,
    required this.count,
    required this.selectedSize,
  }) : _totalPrice = product.price * count;

  String get formattedTotalPrice => '${_totalPrice.formattedWithSpaces} руб.';

  CartItem copyWith({
    Product? product,
    int? count,
    String? selectedSize,
  }) {
    final newCount = count ?? this.count;
    return CartItem(
      product: product ?? this.product,
      count: newCount,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}
