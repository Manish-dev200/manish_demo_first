import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dimentions/app_dimentions.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../home/domain/di/home_injector.dart';
import '../../../home/presentation/widgets/product_item.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = AppDimensions.screenHeight(context);
    final screenWidth = AppDimensions.screenWidth(context);
    final state = ref.watch(cartViewModelProvider);
    final vm = ref.read(cartViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: AppText("Cart",style:Theme.of(context).textTheme.bodyLarge),
      ),
      body: SizedBox(
        height: screenHeight,
        width:screenWidth ,
        child: Column(
          children: [
            productListPart(screenWidth),
          ],
        ),
      ),
    );
  }




  Widget productListPart(double screenWidth) {
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftRightPadding),

        itemBuilder: (context, index) {
          return ProductItem();
        },),
    );
  }
}
