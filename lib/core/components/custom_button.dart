import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  /*final double? verticalPadding;
  final double? horizontalPadding;*/
  final String text;
  final double? fontSize;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.black,
    this.fontSize = 14,
    this.onPressed,
    this.fontFamily,
    this.fontWeight,
    /*this.verticalPadding = 0.0,
    this.horizontalPadding = 0.0*/
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        /*padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding!,
          vertical: verticalPadding!,
        ),*/
        backgroundColor: backgroundColor,
        //disabledBackgroundColor: AppColors.black,
        //disabledForegroundColor: ,
        //backgroundColor: AppColors.green,
        //foregroundColor: AppColors.green,
        fixedSize: Size(
          width,
          height,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: CustomText(
        text: text,
        fontSize: fontSize,
        textColor: textColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
