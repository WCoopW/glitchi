import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';

part 'product_state.freezed.dart';

@freezed
sealed class ProductState with _$ProductState {
  /* -------------------------------------------------------------------------- */
  const ProductState._();
/* -------------------------------------------------------------------------- */
  /// Idling state
  const factory ProductState.idle({
    @Default([]) final List<Product> products,
    required final bool endOfList,
    @Default('Idle') final String message,
  }) = IdleProductState;
/* -------------------------------------------------------------------------- */
  /// Processing
  const factory ProductState.processing({
    @Default([]) final List<Product> products,
    required final bool endOfList,
    @Default('Processing') final String message,
  }) = ProcessingProductState;
/* -------------------------------------------------------------------------- */
  /// Successful
  const factory ProductState.successful({
    required final List<Product> products,
    required final bool endOfList,
    @Default('Successful') final String message,
  }) = SuccessfulProductState;
/* -------------------------------------------------------------------------- */
  /// Successful fetch location
  const factory ProductState.successfulAddLocation({
    required final List<Product> products,
    required final bool endOfList,
    @Default('SuccessfulAddLocation') final String message,
  }) = SuccessfulLocationProductState;
/* -------------------------------------------------------------------------- */
  /// An error has occurred
  const factory ProductState.error({
    @Default([]) final List<Product> products,
    required final bool endOfList,
    @Default('An error has occurred') final String message,
  }) = ErrorProductState;
/* -------------------------------------------------------------------------- */
  static const ProductState initialState = ProductState.idle(
    products: <Product>[],
    endOfList: false,
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
  bool get hasMore => !endOfList;
/* -------------------------------------------------------------------------- */
}
