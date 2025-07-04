import 'package:demo_first/features/dashboard/domain/di/dashboard_injector.dart';
import 'package:demo_first/features/home/data/models/product_res_model.dart';
import 'package:demo_first/features/home/domain/di/home_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/dimentions/app_dimentions.dart';
import '../../../../core/widgets/app_text.dart';


class CartProductItem extends ConsumerWidget {
  ProductResModel item;
   CartProductItem(this.item, {super.key});

  @override
  Widget build(BuildContext context,ref) {
    final screenHeight = AppDimensions.screenHeight(context);
    final screenWidth = AppDimensions.screenWidth(context);
    final vm=ref.read(dashViewModelProvider.notifier);
    final homeVM=ref.read(homeViewModelProvider.notifier);
    final state=ref.watch(dashViewModelProvider);

    return  Container(
      // height: 200,
      width:screenWidth ,
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),

      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color:AppColors.colorPrimary, )
              ),
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(item.imageUrl??'',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,

                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(item.name??'',style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),),
                AppText(item.description??'',style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 11,color: AppColors.colorBlackLight),),
              ],
            )),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color:AppColors.colorPrimary,
                      borderRadius: BorderRadius.circular(5),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          vm.decreaseQuantity(item.name,ref);
                          homeVM.updateQuantity(item, ref);
                        },
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Container(
                              height: 1.5,
                              width: 12,
                              color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      AppText("${item.quantity ?? 0}",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          vm.increaseQuantity(item.name);
                          homeVM.updateQuantity(item, ref);
                        },
                          child: Icon(Icons.add,color: AppColors.colorWhite,size: 20,)),
                    ],
                  ),
                ),
                AppText("\$${item.price??''}",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12),),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
