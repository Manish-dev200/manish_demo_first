import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final Function()? suffixIconPress;

  AppSearchTextField({
    required this.controller,
    this.onChanged,
    this.suffixIconPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width:200,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          // suffixIcon: suffixIconPress != null
          //     ? IconButton(
          //   icon: const Icon(Icons.clear),
          //   onPressed: suffixIconPress,
          // )
          //     : null,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
