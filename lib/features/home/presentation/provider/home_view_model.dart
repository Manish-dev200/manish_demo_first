import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:demo_first/features/dashboard/domain/di/dashboard_injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product_res_model.dart';

class HomeState {
  final bool isLoading;
  final double lowerPriceValue;
  final double upperPriceValue;
  final TextEditingController searchTextController;
  final List<ProductResModel> productList;
  final List<ProductResModel> filteredProductList;


  HomeState({
    this.isLoading = false,
    this.lowerPriceValue=0.0,
    this.upperPriceValue=100.0,
    required this.searchTextController,
    required this.productList,
    required this.filteredProductList});

  HomeState copyWith({
    bool? isLoading,
    double? lowerPriceValue,
    double? upperPriceValue,
    TextEditingController? searchTextController,
    List<ProductResModel>? productList,
    List<ProductResModel>? filteredProductList }) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        lowerPriceValue: lowerPriceValue ?? this.lowerPriceValue,
        upperPriceValue: upperPriceValue ?? this.upperPriceValue,
        searchTextController: searchTextController ?? this.searchTextController,
        productList:productList??this.productList,
        filteredProductList:filteredProductList??this.filteredProductList);
  }
}



class HomeViewModel extends StateNotifier<HomeState> {

  HomeViewModel() : super(HomeState(
      searchTextController:   TextEditingController(),
    productList: [],
    filteredProductList:[],

  )) {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final dummyProducts = List.generate(10, (index) {
        return ProductResModel(
          name: 'Product ${index + 1}',
          description: 'This is a description for product ${index + 1}.',
          rating: (3 + index % 3).toDouble(),
          price: (10*index).toString(),
          imageUrl: 'https://picsum.photos/200?random=$index',
        );
      });

      state = state.copyWith(isLoading: false, productList: dummyProducts,filteredProductList: dummyProducts);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredProductList: state.productList);
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filtered = state.productList.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery);
    }).toList();

    state = state.copyWith(filteredProductList: filtered);
  }


  void addRemoveCart(ProductResModel item, WidgetRef ref) {
    final dashboardNotifier = ref.read(dashViewModelProvider.notifier);

    final updatedList = state.filteredProductList.map((product) {
      if (product.name == item.name) {
        final isNowInCart = !(product.isCart ?? false);

        final updatedProduct = product.copyWith(
          isCart: isNowInCart,
          quantity: isNowInCart ?   product.quantity:1,
        );

        if (isNowInCart) {
          dashboardNotifier.addToCart(updatedProduct);
        } else {
          dashboardNotifier.removeFromCart(updatedProduct);
        }

        return updatedProduct;
      } else {
        return product;
      }
    }).toList();

    state = state.copyWith(filteredProductList: updatedList);
  }


  void updateQuantity(ProductResModel item, WidgetRef ref) {
    var newQuantity=item.quantity;
    final updatedList = state.filteredProductList.map((product) {
      if (product.name == item.name) {
        return product.copyWith(
          quantity: newQuantity,

        );
      }
      return product;
    }).toList();

    state = state.copyWith(filteredProductList: updatedList);


  }


  void filterApply() {
    final minPrice=state.lowerPriceValue;
    final maxPrice=state.upperPriceValue;

    final filtered = state.productList.where((product) {
      final productPrice = double.tryParse(product.price) ?? 0;
      return productPrice >= minPrice && productPrice <= maxPrice;
    }).toList();

    state = state.copyWith(filteredProductList: filtered);
  }



  void listClick(GlobalKey widgetKey, GlobalKey<CartIconKey> cartKey, Function(GlobalKey<State<StatefulWidget>> p1) runAddToCartAnimation, int cartQuantityItems,
      WidgetRef ref) async {
    final dashState = ref.watch(dashViewModelProvider);

    if(dashState.cartProductList.length>1){
      await runAddToCartAnimation(widgetKey);
      if(cartKey.currentState!=null){
        await cartKey.currentState!
            .runCartAnimation((++cartQuantityItems).toString());
      }
    }


  }

  void updatePrice(lowerValue, upperValue) {
    state=state.copyWith(lowerPriceValue: lowerValue,upperPriceValue: upperValue);
  }

  void clearFilter() {
    state=state.copyWith(lowerPriceValue: 0.0,upperPriceValue: 100.0,filteredProductList: state.productList,searchTextController: TextEditingController());

  }


}
