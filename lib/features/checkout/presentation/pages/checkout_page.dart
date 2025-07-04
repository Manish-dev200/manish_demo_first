import 'package:demo_first/core/constants/app_strings.dart';
import 'package:demo_first/core/widgets/app_button.dart';
import 'package:demo_first/features/dashboard/presentation/provider/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/dimentions/app_dimentions.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../dashboard/domain/di/dashboard_injector.dart';
import '../../domain/di/checkout_injector.dart';
import '../widgets/bill_detail_item.dart';
import '../widgets/cart_product_item.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = AppDimensions.screenHeight(context);
    final screenWidth = AppDimensions.screenWidth(context);
    final dashState = ref.watch(dashViewModelProvider);
    final state = ref.watch(checkoutViewModelProvider);
    final vm = ref.read(checkoutViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios)),
        title: AppText(AppStrings.textCheckOut,style:Theme.of(context).textTheme.bodyLarge),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.leftRightPadding),
        height: screenHeight,
        width:screenWidth ,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              productListPart(screenWidth,dashState),
              BillDetailItem(),
              checkOutButton(),
            ],
          ),
        ),
      ),
    );
  }




  Widget productListPart(double screenWidth, DashboardState dashState) {
   var cartProductList=dashState.cartProductList;
    return Container(
      margin: EdgeInsets.only(top: 12),
      width: screenWidth,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: AppColors.colorPrimary,
                spreadRadius: 0.1,
                blurRadius: 0.1
            )
          ]
      ),

      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(Icons.ac_unit,color: AppColors.colorPrimary,),
              ),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText("Delivery in 8 minutes",style: Theme.of(context).textTheme.titleMedium,),
                  AppText("3 item of shipping",style: Theme.of(context).textTheme.displaySmall,),
                ],
              ),
            ],
          ),
          SizedBox(height: 5,),
          ListView.builder(
            itemCount:cartProductList .length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return CartProductItem(cartProductList[index]);
            },),
        ],
      ),
    );
  }

  Widget checkOutButton() {
    return AppButton(
     AppStrings.textCheckOut,
      margin: EdgeInsets.only(bottom: 50,top: 50),
      onTap: (){

      },
    );
  }
}
