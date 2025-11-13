import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glitchi/src/feature/cart/bloc/cart_state.dart';
import 'package:glitchi/src/feature/cart/model/cart_item.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';

part 'cart_event.freezed.dart';

@freezed
sealed class CartEvent with _$CartEvent {
  const CartEvent._();

  @With<_ProcessingStateEmitter>()
  @With<_SuccessfulStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory CartEvent.addProduct({
    required Product product,
    required String selectedSize,
  }) = AddProductEvent;

  @With<_ProcessingStateEmitter>()
  @With<_SuccessfulStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory CartEvent.removeProduct({
    required int productId,
    @Default(false) final bool deleteAll,
  }) = RemoveProductEvent;
}

mixin _ProcessingStateEmitter on CartEvent {
  CartState processing({
    required final CartState state,
    final List<CartItem>? items,
    final String? message,
  }) =>
      CartState.processing(
        message: message ?? 'Processing',
        items: items ?? state.items,
      );
}

mixin _SuccessfulStateEmitter on CartEvent {
  CartState successful({
    required final CartState state,
    required final List<CartItem> items,
    final String? message,
  }) =>
      CartState.successful(
        items: items,
        message: message ?? 'Successful',
      );
}

mixin _ErrorStateEmitter on CartEvent {
  CartState error({
    required final CartState state,
    final String? message,
  }) =>
      CartState.error(
        items: state.items,
        message: message ?? 'An error has occurred',
      );
}

mixin _IdleStateEmitter on CartEvent {
  CartState idle({
    required final CartState state,
    final String? message,
  }) =>
      CartState.idle(
        message: message ?? 'Idle',
        items: state.items,
      );
}
