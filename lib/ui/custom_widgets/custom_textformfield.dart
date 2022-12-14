import 'package:flutter/material.dart';
import 'package:todo/core/utils/constant/kColors.dart';

class CustomTextFormField extends StatelessWidget {
  String hintText;
  Icon pIcon;
  Icon? sIcon;
  TextEditingController textEditingController;
  bool? obscureText;
  CustomTextFormField(
      {required this.hintText,
      required this.pIcon,
      this.sIcon,
      required this.textEditingController,
      this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kColors.textFormColor,
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText!,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: kColors.mainColor,
            fontSize: 15,
          ),
          prefixIcon: pIcon,
          suffixIcon: sIcon,
        ),
      ),
    );
  }
}
