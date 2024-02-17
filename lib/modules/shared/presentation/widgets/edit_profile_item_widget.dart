import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class EditProfileItemWidget extends StatelessWidget {
  final String title;
  final String value;
  final void Function() onPressed;

  const EditProfileItemWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
  });

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
        child: Row(
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    fontSize: 20,
                    text: "$title :",
                    fontFamily: kPacifico,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    fontSize: 20,
                    text: " $value",
                    textColor: Colors.black,
                  ),
                ]),
            const Spacer(),
            IconButton(
              onPressed: onPressed,
              //hoverColor: Colors.red,
              splashColor: Colors.red,
              focusColor: Colors.white,
              highlightColor: kWhiteGray,
              icon: const Icon(Icons.edit, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  final String address;
  const AddressWidget({super.key, required this.address});

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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                fontSize: 20,
                text: AppStrings.address,
                fontFamily: kPacifico,
                textColor: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                fontSize: 20,
                text: address,
                textColor: Colors.black,
              ),
            ]),
      ),
    );
  }
}
