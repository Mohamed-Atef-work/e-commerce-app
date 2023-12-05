import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLines;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    this.textColor,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.textAlign,
    this.fontFamily,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: textColor,
        overflow: overflow,
      ),
    );
  }
}
