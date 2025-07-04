import 'package:demo_first/core/constants/app_strings.dart';
import 'package:demo_first/core/dimentions/app_dimentions.dart';
import 'package:demo_first/core/widgets/app_text.dart';
import 'package:demo_first/features/home/presentation/provider/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';


class ProductFilterSheet {

  void showSheet(BuildContext context, HomeViewModel vm, HomeState state){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 330,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.leftRightPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 10,bottom: 20),
                      width: 70,
                      height: 2,
                      color: AppColors.colorPrimary,
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          vm.clearFilter();
                          Navigator.pop(context);
                        },
                          child: AppText(AppStrings.textClearFilter,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.colorPrimary),))),
                  AppText(AppStrings.textSelectPrice,style: Theme.of(context).textTheme.titleSmall,),
                  FlutterSlider(
                    values: [state.lowerPriceValue, state.upperPriceValue],
                    rangeSlider: true,
                    max: 100.0,
                    min: 0.0,
                    // handlerHeight: 20,
                    handlerWidth: 20,
                    trackBar: FlutterSliderTrackBar(
                      activeTrackBarHeight: 4,
                      inactiveTrackBarHeight: 4,
                      activeTrackBar: BoxDecoration(
                        color: AppColors.colorPrimary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      inactiveTrackBar: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    tooltip: FlutterSliderTooltip(disabled: false,
                        textStyle:TextStyle(color: AppColors.colorBlack),
                        boxStyle: FlutterSliderTooltipBox(decoration: BoxDecoration(color: AppColors.colorPrimary))), // Hides default tooltip
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      vm.updatePrice(lowerValue,upperValue);
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),


                  AppText(AppStrings.textSelectCategory,style: Theme.of(context).textTheme.titleSmall,),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width:AppDimensions.screenWidth(context),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButton(
                  value: "category1",
                  isExpanded: true,
                  underline: SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ["category1","category2","category3","category4"].map((String items) {
                    return DropdownMenuItem(value: items, child: AppText(items,style: Theme.of(context).textTheme.titleSmall,));
                  }).toList(),
                  onChanged: (String? newValue) {

                  },
                ),
              ),



                  Center(
                    child: AppButton(
                       AppStrings.textApply,
                      margin:EdgeInsets.only(top: 30,bottom: 30),
                        width:200,
                    onTap:(){
                      vm.filterApply();
                      Navigator.pop(context);
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
