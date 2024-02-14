import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class EditProfileItemWidget extends StatelessWidget {
  final String title;
  final String value;
  const EditProfileItemWidget(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteGray,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(style: BorderStyle.solid, color: Colors.white),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              fontSize: 20,
              text: "$title :",
              textColor: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: kPacifico,
            ),
            CustomText(
              fontSize: 20,
              text: " $value",
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
