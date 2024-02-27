import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';

PreferredSizeWidget appBar({
  double? height,
  Widget? leading,
  double? titleSize,
  List<Widget>? actions,
  required String title,
}) =>
    AppBar(
      elevation: 0.0,
      actions: actions,
      leading: leading,
      centerTitle: true,
      toolbarHeight: height ?? 50,
      backgroundColor: kPrimaryColorYellow,
      title: CustomText(
        text: title,
        fontFamily: kPacifico,
        textColor: Colors.black,
        fontSize: titleSize ?? 30,
        fontWeight: FontWeight.bold,
      ),
    );
