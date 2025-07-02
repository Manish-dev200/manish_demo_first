import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppSearchTextField extends StatelessWidget {
   TextEditingController controller;
   Function(String value)? onChanged;
   Function()? suffixIconPress;
   AppSearchTextField({ required this.controller,this.onChanged, this.suffixIconPress,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 200,
      child: TextField(
        controller: controller,
        onChanged: (String value){
          if(onChanged!=null){
            onChanged!.call(value);
          }

        },
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          fillColor: AppColors.colorWhite
        ),
      ),
    );
  }
}
