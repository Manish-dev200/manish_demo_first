

import 'package:demo_first/features/home/data/models/product_res_model.dart';
import 'package:demo_first/features/home/presentation/provider/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_product_detail_use_case.dart';

class ProductDetailState {
  final bool isLoading;
  final ProductResModel? productData;

  ProductDetailState({
    this.isLoading = false,
    this.productData
  });

  ProductDetailState copyWith({
    bool? isLoading,
    ProductResModel? productData
  }) {
    return ProductDetailState(
        isLoading: isLoading ?? this.isLoading,
        productData: productData ?? this.productData
    );
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

  void getProductDetail(ProductResModel product) {
    state=state.copyWith(productData: product);
  }

  void updateCartStatus() {
    final product = state.productData;
    if (product != null) {
      final isCurrentlyInCart = product.isCart ?? false;

      final updatedProduct = product.copyWith(
        isCart: !isCurrentlyInCart, // toggle
      );

      state = state.copyWith(productData: updatedProduct);
    }
  }

  void updateIncreaseQuantity(HomeViewModel homeVM, WidgetRef ref) {
    final product = state.productData;
    if (product != null) {

      final updatedProduct = product.copyWith(
        quantity:  product.quantity+1, // toggle
      );

      state = state.copyWith(productData: updatedProduct);
      homeVM.updateQuantity(state.productData!, ref);

    }
  }
  void updateDecreaseQuantity(HomeViewModel homeVM, WidgetRef ref) {
    final product = state.productData;
    if (product != null&&product.quantity>1) {

      final updatedProduct = product.copyWith(
        quantity:  product.quantity-1, // toggle
      );

      state = state.copyWith(productData: updatedProduct);
      homeVM.updateQuantity(state.productData!, ref);

    }
  }

}
