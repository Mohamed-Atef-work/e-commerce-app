import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
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
    this.width,
    this.onPressed,
    this.fontFamily,
    this.fontWeight,
    this.height = 50,
    this.fontSize = 18,
    required this.text,
    this.textColor = kWhite,
    this.backgroundColor = Colors.black,

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
        //disabledBackgroundColor: Colors.black,
        //disabledForegroundColor: ,
        //backgroundColor: green,
        //foregroundColor: green,
        fixedSize: Size(
          width ?? double.infinity,
          height!,
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
