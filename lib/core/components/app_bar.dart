import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';

PreferredSizeWidget appBar({
  required String title,
  double? titleSize,
  List<Widget>? actions,
  Widget? leading,
  double? height,
}) =>
    AppBar(
      leading: leading,
      elevation: 0.0,
      toolbarHeight: height ?? 50,
      backgroundColor: AppColors.primaryColorYellow,
      actions: actions,
      centerTitle: true,
      title: CustomText(
        text: title,
        fontSize: titleSize ?? 30,
        fontFamily: kPacifico,
        fontWeight: FontWeight.bold,
        textColor: AppColors.black,
      ),
    );
