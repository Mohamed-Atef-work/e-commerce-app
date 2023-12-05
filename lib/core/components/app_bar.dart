import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/app_strings.dart';
import 'custom_text.dart';

PreferredSizeWidget appBar({
  required String title,
  double? titleSize,
  double? height,
}) =>
    AppBar(
      elevation: 0.0,
      toolbarHeight: height ?? 50,
      backgroundColor: AppColors.primaryColorYellow,
      centerTitle: true,
      title: CustomText(
        text: title,
        fontSize: titleSize ?? 30,
        fontFamily: AppStrings.pacifico,
        fontWeight: FontWeight.bold,
        textColor: AppColors.black,
      ),
    );
