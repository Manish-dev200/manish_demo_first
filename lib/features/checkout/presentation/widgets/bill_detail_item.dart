import 'package:demo_first/features/dashboard/presentation/provider/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/dimentions/app_dimentions.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../dashboard/domain/di/dashboard_injector.dart';


class BillDetailItem extends ConsumerWidget {
  const BillDetailItem({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final screenHeight = AppDimensions.screenHeight(context);
    final screenWidth = AppDimensions.screenWidth(context);
    final dash = ref.watch(dashViewModelProvider.notifier);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(AppStrings.textBillDetail,style: Theme.of(context).textTheme.titleMedium,),
         SizedBox(height: 10,),
         billTitleIconValue(context,Icons.account_balance_wallet,AppStrings.textItemTotal,"\$2"),
         billTitleIconValue(context,Icons.delivery_dining_outlined,AppStrings.textDeliveryCharges,"\$50"),
         billTitleIconValue(context,Icons.handyman_rounded,AppStrings.textHandlingCharges,"\$20"),
         billTitleIconValue(context,Icons.account_balance_wallet,AppStrings.textSmallCartCharges,"\$29"),
          billGrandTotal(context,dash),
        ],
      ),
    );
  }

 Widget billTitleIconValue(BuildContext context, IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Row(children: [
        Icon(icon,size: 18,),
        SizedBox(width: 10,),
        AppText(title,style: Theme.of(context).textTheme.displaySmall,),
        Spacer(),
        AppText(value,style: Theme.of(context).textTheme.displaySmall,),

      ],),
    );
 }

  Widget billGrandTotal(BuildContext context, DashboardViewModel dash) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Divider(
            // height: 0.2,
            thickness: 0.3,
            color: AppColors.colorGrey,
          ),
          Row(children: [
            AppText(AppStrings.textGrandTotal,style: Theme.of(context).textTheme.displayMedium,),
            Spacer(),
            AppText("\$${dash.getTotalPrice()}",style: Theme.of(context).textTheme.displayMedium,),

          ],),
        ],
      ),
    );
  }

}
