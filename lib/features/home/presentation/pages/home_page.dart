import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:demo_first/core/constants/app_strings.dart';
import 'package:demo_first/core/routes/route_paths.dart';
import 'package:demo_first/features/dashboard/domain/di/dashboard_injector.dart';
import 'package:demo_first/features/home/presentation/provider/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/theme_injector.dart';
import '../../../../core/dimentions/app_dimentions.dart';
import '../../../../core/widgets/app_search_text_field.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../checkout/domain/di/checkout_injector.dart';
import '../../domain/di/home_injector.dart';
import '../widgets/product_filter_sheet.dart';
import '../widgets/product_item.dart';

class HomePage extends ConsumerStatefulWidget {
   HomePage( {super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = AppDimensions.screenHeight(context);
    final screenWidth = AppDimensions.screenWidth(context);
    final state = ref.watch(homeViewModelProvider);
    final vm = ref.read(homeViewModelProvider.notifier);

    return AddToCartAnimation(
      cartKey: cartKey,
      height: 25,
      width: 25,
      opacity: 0.80,
      dragAnimation: const DragToCartAnimationOptions(rotation: true),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          title: AppText(AppStrings.textHome,style:Theme.of(context).textTheme.bodyLarge),
          centerTitle: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.notifications,
      
              ),
            )
          ],
        ),
        body: SizedBox(
          height: screenHeight,
          width:screenWidth ,
          child: Column(
            children: [
              searchFilterPart(vm,state),
              productListPart(screenWidth,state,vm),
            ],
          ),
        ),
      ),
    );
  }



  Widget searchFilterPart(HomeViewModel vm, HomeState state){
    return Padding(
      padding: EdgeInsets.only(left: AppDimensions.leftRightPadding,right:AppDimensions.leftRightPadding,top: 10,bottom: 10 ),
      child: Row(
        children: [
          Expanded(
            child: AppSearchTextField(
              controller:state.searchTextController,
                onChanged:(String value){
                  vm.searchProducts(value);
                },
                suffixIconPress:(){
            
                }
             ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: (){
              ProductFilterSheet().showSheet(context,vm,state);
            },
            child: Icon(
              Icons.filter_list_rounded,
              color: AppColors.colorPrimary,
            ),
          )
        ],
      ),
    );
  }

 Widget productListPart(double screenWidth, HomeState state, HomeViewModel vm) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.filteredProductList.length,
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftRightPadding),
        itemBuilder: (context, index) {
          var item=state.filteredProductList[index];

          return ProductItem(
              item,
              onTap:(){
                context.pushNamed(RoutePaths.productDetail,extra:item );
              },
              cartTap:(){
            vm.addRemoveCart(item,ref);
            vm.listClick(cartKey,cartKey,runAddToCartAnimation,_cartQuantityItems,ref);
          });
          },),
    );
 }

}
