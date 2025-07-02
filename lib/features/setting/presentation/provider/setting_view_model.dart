

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_product_detail_use_case.dart';

class ProductDetailState {
  final bool isLoading;

  ProductDetailState({this.isLoading = false});

  ProductDetailState copyWith({bool? isLoading}) {
    return ProductDetailState(isLoading: isLoading ?? this.isLoading);
  }
}



class ProductDetailViewModel extends StateNotifier<ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailViewModel(this.getProductDetailUseCase) : super(ProductDetailState()) {
    _loadProductDetail();
  }

  Future<void> _loadProductDetail() async {
    state = state.copyWith(isLoading: true);
    try {
      final products = await getProductDetailUseCase.call();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}
