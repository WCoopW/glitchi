import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glitchi/src/feature/cart/model/cart_item.dart';

part 'cart_state.freezed.dart';

@freezed
sealed class CartState with _$CartState {
  /* -------------------------------------------------------------------------- */
  const CartState._();
/* -------------------------------------------------------------------------- */
  /// Idling state
  const factory CartState.idle({
    @Default([]) final List<CartItem> items,
    @Default('Idle') final String message,
  }) = IdleCartState;
/* -------------------------------------------------------------------------- */
  /// Processing
  const factory CartState.processing({
    @Default([]) final List<CartItem> items,
    @Default('Processing') final String message,
  }) = ProcessingCartState;
/* -------------------------------------------------------------------------- */
  /// Successful
  const factory CartState.successful({
    required final List<CartItem> items,
    @Default('Successful') final String message,
  }) = SuccessfulCartState;
/* -------------------------------------------------------------------------- */
  /// An error has occurred
  const factory CartState.error({
    @Default([]) final List<CartItem> items,
    @Default('An error has occurred') final String message,
  }) = ErrorCartState;
/* -------------------------------------------------------------------------- */
  static const CartState initialState = CartState.idle(
    items: <CartItem>[],
  );
/* -------------------------------------------------------------------------- */
  /// If an error has occurred
  bool get hasError => maybeMap<bool>(
        orElse: () => false,
        error: (_) => true,
      );
/* -------------------------------------------------------------------------- */
  /// Is in progress state
  bool get isProcessing => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => true,
      );
/* -------------------------------------------------------------------------- */
  /// Get items list
  List<CartItem> get items => map<List<CartItem>>(
        idle: (state) => state.items,
        processing: (state) => state.items,
        successful: (state) => state.items,
        error: (state) => state.items,
      );
/* -------------------------------------------------------------------------- */
  /// Total count of items in cart
  int get totalCount => items.fold<int>(
        0,
        (sum, item) => sum + item.count,
      );
/* -------------------------------------------------------------------------- */
  /// Total price of all items in cart
  int get totalPrice => items.fold<int>(
        0,
        (sum, item) => sum + (item.product.price * item.count),
      );
/* -------------------------------------------------------------------------- */
}
