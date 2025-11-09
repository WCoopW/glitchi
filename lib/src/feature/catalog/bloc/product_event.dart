import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glitchi/src/feature/catalog/bloc/product_state.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';

part 'product_event.freezed.dart';

@freezed
sealed class ProductEvent with _$ProductEvent {
  const ProductEvent._();

  @With<_ProcessingStateEmitter>()
  @With<_SuccessfulStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory ProductEvent.fetchProducts(
      int page, int limit, String category) = FetchProductsEvent;
}

mixin _ProcessingStateEmitter on ProductEvent {
  ProductState processing({
    required final ProductState state,
    final List<Product>? products,
    final String? message,
  }) =>
      ProductState.processing(
        message: message ?? 'Processing',
        products: products ?? state.products,
        endOfList: state.endOfList,
      );
}

mixin _SuccessfulStateEmitter on ProductEvent {
  ProductState successful({
    required final ProductState state,
    required final List<Product> products,
    required final bool endOfList,
    final String? message,
  }) =>
      ProductState.successful(
        products: products,
        message: message ?? 'Successful',
        endOfList: state.endOfList,
      );
}

mixin _ErrorStateEmitter on ProductEvent {
  ProductState error({
    required final ProductState state,
    final String? message,
  }) =>
      ProductState.error(
        products: state.products,
        message: message ?? 'An error has occurred',
        endOfList: state.endOfList,
      );
}

mixin _IdleStateEmitter on ProductEvent {
  ProductState idle({
    required final ProductState state,
    final String? message,
  }) =>
      ProductState.idle(
        message: message ?? 'Idle',
        products: state.products,
        endOfList: state.endOfList,
      );
}
