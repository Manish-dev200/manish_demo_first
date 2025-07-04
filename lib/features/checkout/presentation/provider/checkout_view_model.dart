

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_products_use_case.dart';

class CheckoutState {
  final bool isLoading;

  CheckoutState({this.isLoading = false});

  CheckoutState copyWith({bool? isLoading}) {
    return CheckoutState(isLoading: isLoading ?? this.isLoading);
  }
}



class CheckoutViewModel extends StateNotifier<CheckoutState> {

  CheckoutViewModel() : super(CheckoutState()) {
    _loadCheckoutProducts();
  }

  Future<void> _loadCheckoutProducts() async {
    state = state.copyWith(isLoading: true);
    try {
      // final products = await getCartProductsUseCase.call();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}
