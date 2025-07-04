
import 'package:demo_first/features/home/data/models/product_res_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/dimentions/app_dimentions.dart';
import '../../../../core/widgets/app_text.dart';


class ProductItem extends ConsumerWidget {
  ProductResModel item;
  Function()? cartTap;
  Function()? onTap;
   ProductItem(this.item, {super.key, this.cartTap, this.onTap});

  @override
  Widget build(BuildContext context,ref) {
    final screenHeight = AppDimensions.screenHeight(context);
    final screenWidth = AppDimensions.screenWidth(context);

    return  GestureDetector(
      onTap: (){
        if(onTap!=null){
          onTap!.call();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        // height: 200,
        width:screenWidth ,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: AppColors.colorPrimary,
                  spreadRadius: 0.1,
                  blurRadius: 0.1
              )
            ]
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color:AppColors.colorPrimary, )
                ),
                height: 90,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(item.imageUrl??'',
                    height: 90,
                    width: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(),

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
                  AppText(item.name??'',style: Theme.of(context).textTheme.displayMedium,),
                  RatingBar.builder(
                    initialRating: item.rating??2.0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 18,
                    itemPadding: EdgeInsets.only(right: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {

                    },
                  ),
                  AppText(item.description??'',style: Theme.of(context).textTheme.displaySmall,),
                ],
              )),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      if(cartTap!=null){
                        cartTap!.call();
                      }

                    },
                    child: Icon(item.isCart==true?Icons.favorite:Icons.favorite_border,
                      color: AppColors.colorPrimary,),
                  ),


                  AppText("\$${item.price??''}",style: Theme.of(context).textTheme.titleMedium,),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
