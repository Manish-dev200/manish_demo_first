import 'package:demo_first/core/constants/app_colors.dart';
import 'package:demo_first/core/dimentions/app_dimentions.dart';
import 'package:demo_first/core/widgets/app_text.dart';
import 'package:flutter/material.dart';



class AppButton extends StatelessWidget {
  String text;
  EdgeInsets? margin;
  double? width;
  Function()? onTap;
   AppButton(this.text, {super.key, this.margin,this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        if(onTap!=null){
          onTap!.call();

        }
      },
      child: Container(
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7 ),
        width:width?? AppDimensions.screenWidth(context),
        decoration: BoxDecoration(
          color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: AppText(text,style: Theme.of(context).textTheme.titleSmall,)),
      ),
    );
  }
}
