

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_products_use_case.dart';

class CartState {
  final bool isLoading;

  CartState({this.isLoading = false});

  CartState copyWith({bool? isLoading}) {
    return CartState(isLoading: isLoading ?? this.isLoading);
  }
}



class CartViewModel extends StateNotifier<CartState> {
  final GetCartProductUseCase getCartProductsUseCase;

  CartViewModel(this.getCartProductsUseCase) : super(CartState()) {
    _loadCartProducts();
  }

  Future<void> _loadCartProducts() async {
    state = state.copyWith(isLoading: true);
    try {
      final products = await getCartProductsUseCase.call();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}
