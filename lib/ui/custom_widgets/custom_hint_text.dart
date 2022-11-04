import 'package:flutter/material.dart';
import 'package:todo/core/utils/constant/kColors.dart';

class CustomHintText extends StatelessWidget {
  final String text;
  final String buttonText;
  VoidCallback ontap;
  CustomHintText(
      {required this.text, required this.buttonText, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: kColors.whiteColor,
              fontSize: 15,
              decoration: TextDecoration.underline),
        ),
        GestureDetector(
          onTap: ontap,
          child: Text(
            buttonText,
            style: const TextStyle(
                color: kColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
