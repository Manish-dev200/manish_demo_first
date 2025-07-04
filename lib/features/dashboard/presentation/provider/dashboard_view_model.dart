import 'package:demo_first/features/dashboard/domain/usecases/get_product_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/data/models/product_res_model.dart';
import '../../../home/domain/di/home_injector.dart';


class DashboardState {
  final bool isLoading;
  final List<ProductResModel> cartProductList;

  DashboardState({this.isLoading = false,required this.cartProductList});

  DashboardState copyWith({bool? isLoading, List<ProductResModel>? cartProductList}) {
    return DashboardState(isLoading: isLoading ?? this.isLoading,
        cartProductList:cartProductList??this.cartProductList);
  }
}



class DashboardViewModel extends StateNotifier<DashboardState> {
  final GetProductUseCase getProductUseCase;
  DashboardViewModel(this.getProductUseCase) : super(DashboardState(
      cartProductList: []
  )) {
  }



  void addToCart(ProductResModel item) {
    if (!state.cartProductList.any((e) => e.name == item.name)) {
      state = state.copyWith(
        cartProductList: [...state.cartProductList, item],
      );
    }
  }

  void removeFromCart(ProductResModel item) {
    state = state.copyWith(
      cartProductList:
      state.cartProductList.where((e) => e.name != item.name).toList(),
    );
  }

  void increaseQuantity(String productName) {
    final updatedList = state.cartProductList.map((item) {
      if (item.name == productName) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    state = state.copyWith(cartProductList: updatedList);
  }



  void decreaseQuantity(String productName, WidgetRef ref) {
    final index = state.cartProductList.indexWhere((item) => item.name == productName);

    if (index == -1) return;

    final item = state.cartProductList[index];

    if (item.quantity > 1) {
      final updatedItem = item.copyWith(quantity: item.quantity - 1);
      final updatedList = [...state.cartProductList];
      updatedList[index] = updatedItem;
      state = state.copyWith(cartProductList: updatedList);
    } else {
      removeFromCart(item);

      ref.read(homeViewModelProvider.notifier).addRemoveCart(item, ref);
    }
  }

  double getTotalPrice() {
    double total = 0;

    for (final item in state.cartProductList) {
      final price = double.tryParse(item.price) ?? 0;
      total += price * item.quantity;
    }

    return total;
  }


}
