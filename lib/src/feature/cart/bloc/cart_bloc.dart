import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchi/src/feature/cart/bloc/cart_event.dart';
import 'package:glitchi/src/feature/cart/bloc/cart_state.dart';
import 'package:glitchi/src/feature/cart/model/cart_item.dart';

class CartBloc extends Bloc<CartEvent, CartState>
    implements EventSink<CartEvent> {
  CartBloc({
    CartState initialState = const CartState.idle(),
  }) : super(initialState) {
    on<CartEvent>(
      (event, emit) => event.map(
        addProduct: (event) => _addProduct(event, emit),
        removeProduct: (event) => _removeProduct(event, emit),
      ),
    );
  }

  void _addProduct(AddProductEvent event, Emitter<CartState> emit) {
    try {
      final currentItems = List<CartItem>.of(state.items);

      emit(event.processing(
        state: state,
        items: currentItems,
      ));
      final existingItemIndex = currentItems.indexWhere(
        (item) =>
            item.product.id == event.product.id &&
            item.selectedSize == event.selectedSize,
      );

      if (existingItemIndex != -1) {
        final existingItem = currentItems[existingItemIndex];
        currentItems[existingItemIndex] =
            existingItem.copyWith(count: existingItem.count + 1);
      } else {
        currentItems.add(
          CartItem(
            product: event.product,
            count: 1,
            selectedSize: event.selectedSize,
          ),
        );
      }

      emit(event.successful(
        state: state,
        items: currentItems,
      ));
    } on Exception catch (e) {
      emit(event.error(
        state: state,
        message: e.toString(),
      ));
    } on Object {
      emit(event.error(
        state: state,
        message: 'Произошла неожиданная ошибка',
      ));
    } finally {
      emit(event.idle(
        state: state,
      ));
    }
  }

  void _removeProduct(RemoveProductEvent event, Emitter<CartState> emit) {
    try {
      final currentItems = List<CartItem>.of(state.items);

      emit(event.processing(
        state: state,
        items: currentItems,
      ));

      if (event.deleteAll) {
        currentItems.removeWhere(
          (item) => item.product.id == event.productId,
        );
      } else {
        final itemIndex = currentItems.indexWhere(
          (item) => item.product.id == event.productId,
        );

        if (itemIndex != -1) {
          final item = currentItems[itemIndex];
          if (item.count > 1) {
            currentItems[itemIndex] = item.copyWith(count: item.count - 1);
          } else {
            currentItems.removeAt(itemIndex);
          }
        }
      }

      emit(event.successful(
        state: state,
        items: currentItems,
      ));
    } on Exception catch (e) {
      emit(event.error(
        state: state,
        message: e.toString(),
      ));
    } on Object {
      emit(event.error(
        state: state,
        message: 'Произошла неожиданная ошибка',
      ));
    } finally {
      emit(event.idle(
        state: state,
      ));
    }
  }
}
