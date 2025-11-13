import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glitchi/src/core/utils/extensions/context_extension.dart';
import 'package:glitchi/src/feature/cart/bloc/cart_bloc.dart';
import 'package:glitchi/src/feature/cart/bloc/cart_event.dart';
import 'package:glitchi/src/feature/cart/bloc/cart_state.dart';
import 'package:glitchi/src/feature/cart/model/cart_item.dart';
import 'package:glitchi/src/feature/catalog/model/product.dart';

class CartScope extends StatefulWidget {
  const CartScope({
    required this.child,
    super.key,
  });

  final Widget child;

  static CartScopeState of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhOf<_CartInherited>(
            listen: listen,
          )
          .scopeState;

  @override
  State<CartScope> createState() => CartScopeState();
}

/* -------------------------------------------------------------------------- */
class CartScopeState extends State<CartScope> {
  late final CartBloc _cartBloc;
  late final StreamSubscription<void> _streamSubscription;
  var _cartBlocState = const CartState.idle();

  /* -------------------------------------------------------------------------- */
  @override
  void initState() {
    super.initState();
    _cartBloc = CartBloc(
      initialState: _cartBlocState,
    );
    initListeners();
  }

  /* -------------------------------------------------------------------------- */
  void initListeners() {
    _streamSubscription = _cartBloc.stream.listen(_didStateChanged);
  }

  @override
  void dispose() {
    _cartBloc.close();
    _streamSubscription.cancel();
    super.dispose();
  }

  /* -------------------------------------------------------------------------- */
  void _didStateChanged(CartState state) {
    if (state != _cartBlocState) {
      setState(
        () => _cartBlocState = state,
      );
    }
  }

  CartItem getCartItem(int productId) => _cartBlocState.items.firstWhere(
        (item) => item.product.id == productId,
      );

  /* -------------------------------------------------------------------------- */
  String? get error {
    if (_cartBlocState.hasError) {
      return _cartBlocState.message;
    }
    return null;
  }

  /* -------------------------------------------------------------------------- */
  void addProduct(Product product, String selectedSize) {
    _cartBloc.add(
      CartEvent.addProduct(
        product: product,
        selectedSize: selectedSize,
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  void removeProduct(int productId, {bool deleteAll = false}) {
    _cartBloc.add(
      CartEvent.removeProduct(
        productId: productId,
        deleteAll: deleteAll,
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  CartState get state => _cartBlocState;

  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) => _CartInherited(
        state: _cartBlocState,
        scopeState: this,
        child: widget.child,
      );
}

/* -------------------------------------------------------------------------- */
class _CartInherited extends InheritedWidget {
  const _CartInherited({
    required super.child,
    required this.state,
    required this.scopeState,
  });

  final CartState state;
  final CartScopeState scopeState;

  @override
  bool updateShouldNotify(
    _CartInherited oldWidget,
  ) =>
      state != oldWidget.state;
}
/* -------------------------------------------------------------------------- */
