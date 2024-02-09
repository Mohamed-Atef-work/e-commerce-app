import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final bool? obSecure;
  final String hintText;
  final double fontSize;
  final Color? fillColor;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? hintTextColor;
  final void Function()? suffixPressed;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;

  const CustomTextFormField({
    super.key,
    this.validator,
    this.onChanged,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixPressed,
    this.hintTextColor,
    this.obSecure = false,
    required this.hintText,
    required this.fontSize,
    this.textEditingController,
    this.fillColor = AppColors.whiteGray,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obSecure!,
      cursorColor: AppColors.white,
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true,
        border: _border(),
        hintText: hintText,
        labelText: labelText,
        fillColor: fillColor,
        enabledBorder: _border(),
        focusedBorder: _border(),
        hintStyle: TextStyle(color: hintTextColor, fontSize: fontSize),
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColorYellow),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)),
        ),
      ),
    );
  }

  _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.white),
      );
}

class PasswordTextFormField extends StatelessWidget {
  final bool obSecure;
  final String hintText;
  final String? labelText;
  final void Function(String?)? onChanged;
  final void Function()? suffixPressed;
  final TextEditingController textEditingController;

  const PasswordTextFormField({
    super.key,
    this.onChanged,
    this.labelText,
    required this.obSecure,
    required this.hintText,
    required this.suffixPressed,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obSecure,
      cursorColor: AppColors.white,
      controller: textEditingController,
      validator: (value) => Validators.passwordValidator(value),
      decoration: InputDecoration(
        filled: true,
        border: _border(),
        hintText: hintText,
        labelText: labelText,
        fillColor: AppColors.whiteGray,
        enabledBorder: _border(),
        focusedBorder: _border(),
        hintStyle: const TextStyle(fontSize: 15),
        prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColorYellow),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
              onPressed: suffixPressed, icon: Icon(_suffixIcon(obSecure))),
        ),
      ),
    );
  }

  _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.white),
      );
  _suffixIcon(bool obSecure) =>
      obSecure ? Icons.remove_red_eye : Icons.panorama_fish_eye_outlined;
}
