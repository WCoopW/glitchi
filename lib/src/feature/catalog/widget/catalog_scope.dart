import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glitchi/src/core/utils/extensions/context_extension.dart';
import 'package:glitchi/src/feature/catalog/bloc/product_bloc.dart';
import 'package:glitchi/src/feature/catalog/bloc/product_event.dart';
import 'package:glitchi/src/feature/catalog/bloc/product_state.dart';
import 'package:glitchi/src/feature/catalog/data/i_catalog_repository.dart';
import 'package:glitchi/src/feature/initialization/widget/dependencies_scope.dart';

class CatalogScope extends StatefulWidget {
  const CatalogScope({
    required this.child,
    super.key,
  });

  final Widget child;

  static CatalogScopeState of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhOf<_CatalogInherited>(
            listen: listen,
          )
          .scopeState;

  @override
  State<CatalogScope> createState() => CatalogScopeState();
}

/* -------------------------------------------------------------------------- */
class CatalogScopeState extends State<CatalogScope> {
  ScrollController scrollController = ScrollController();
  late final ProductBloc _catalogBloc;
  late final StreamSubscription<void> _streamSubscription;
  late final ICatalogRepository repo;
  static const double _scrollThreshold = 200.0;
  static const int _limit = 10;
  var _currentPage = 1;
  var _catalogBlocState =
      const ProductState.idle(products: [], endOfList: false);

  /* -------------------------------------------------------------------------- */
  @override
  void initState() {
    super.initState();
    repo = DependenciesScope.of(context).catalogRepository;
    _catalogBloc = ProductBloc(
      repository: repo,
      initialState: _catalogBlocState,
    );
    initListeners();
  }

  /* -------------------------------------------------------------------------- */
  void initListeners() {
    _streamSubscription = _catalogBloc.stream.listen(_didStateChanged);
    // favoritesScope = FavoritesScope.of(context, listen: false);
    scrollController.addListener(_onScrollCallback);
    this.fetchProducts();
  }

  /* -------------------------------------------------------------------------- */
  void _onScrollCallback() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - _scrollThreshold) {
      if (_catalogBlocState.hasMore && !_catalogBlocState.isProcessing) {
        fetchProducts();
      }
    }
  }

  @override
  void dispose() {
    _catalogBloc.close();
    _streamSubscription.cancel();
    scrollController.dispose();
    super.dispose();
  }

  /* -------------------------------------------------------------------------- */
  void _didStateChanged(ProductState state) {
    if (state != _catalogBlocState) {
      setState(
        () => _catalogBlocState = state,
      );

      // Increment page after successful load
      if (state.maybeMap(
        orElse: () => false,
        successful: (successful) {
          if (!successful.endOfList) {
            _currentPage += 1;
          }
          return true;
        },
      )) {
        return;
      }
    }
  }

/* -------------------------------------------------------------------------- */
  String? get error {
    if (_catalogBlocState.hasError) {
      return _catalogBlocState.message;
    }
    return null;
  }

/* -------------------------------------------------------------------------- */
  void fetchProducts() {
    _catalogBloc.add(
      ProductEvent.fetchProducts(_currentPage, _limit, 'dresses'),
    );
  }

  void refreshProducts() {
    _catalogBloc.add(
      ProductEvent.fetchProducts(1, _limit, 'dresses'),
    );
  }

  /* -------------------------------------------------------------------------- */
  ProductState get state => _catalogBlocState;

  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) => _CatalogInherited(
        state: _catalogBlocState,
        scopeState: this,
        child: widget.child,
      );
}

/* -------------------------------------------------------------------------- */
class _CatalogInherited extends InheritedWidget {
  const _CatalogInherited({
    required super.child,
    required this.state,
    required this.scopeState,
  });

  final ProductState state;
  final CatalogScopeState scopeState;

  @override
  bool updateShouldNotify(
    _CatalogInherited oldWidget,
  ) =>
      state != oldWidget.state;
}
/* -------------------------------------------------------------------------- */