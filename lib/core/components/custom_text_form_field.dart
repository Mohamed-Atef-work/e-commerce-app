import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/app_strings.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final IconData? prefixIcon;
  final String? labelText;
  final double fontSize;
  final Color? hintTextColor;
  final Color? fillColor;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.textEditingController,
    this.labelText,
    this.hintTextColor,
    this.fillColor = AppColors.whiteGray,
    this.validator,
    this.onChanged,
    required this.hintText,
    required this.fontSize,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: hintText == AppStrings.enterYourPassword ? true : false,
      onChanged: onChanged,
      validator: validator,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        ),
        filled: true,
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.primaryColorYellow,
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontSize: fontSize,
        ),
        fillColor: fillColor,
      ),
    );
  }
}
