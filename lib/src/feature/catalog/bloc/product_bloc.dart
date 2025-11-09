import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchi/src/feature/catalog/bloc/product_event.dart';
import 'package:glitchi/src/feature/catalog/bloc/product_state.dart';
import 'package:glitchi/src/feature/catalog/data/i_catalog_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>
    implements EventSink<ProductEvent> {
  final ICatalogRepository repository;

  ProductBloc({
    required this.repository,
    ProductState initialState = const ProductState.idle(endOfList: false),
  }) : super(initialState) {
    on<ProductEvent>(
      (event, emit) => event.map(
        fetchProducts: (event) => _fetchProducts(event, emit),
      ),
    );
  }

  _fetchProducts(FetchProductsEvent event, Emitter<ProductState> emit) async {
    try {
      // Get current characters list
      final currentProducts = state.products;

      emit(event.processing(
        state: state,
        products: currentProducts,
      ));

      final result = await repository.fetchProducts(
          event.page, event.limit, event.category);

      // Combine existing characters with new ones
      final allProducts = event.page == 1
          ? result.products
          : [...currentProducts, ...result.products];

      emit(event.successful(
        state: state,
        products: allProducts,
        endOfList: result.lastPage == event.page,
      ));
    } on Exception catch (e) {
      emit(event.error(
        state: state,
        message: e.toString(),
      ));
    } on Object catch (e, stackTrace) {
      emit(event.error(
        state: state,
        message: 'Произошла неожиданная ошибка',
      ));
    } finally {
      event.idle(
        state: state,
      );
    }
  }
}
