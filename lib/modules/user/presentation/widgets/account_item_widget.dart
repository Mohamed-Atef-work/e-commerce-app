import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';

class AccountItemsWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final void Function() onTap;
  const AccountItemsWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //hoverColor: Colors.transparent,
      // when putting the mouse on it .
      splashColor: kWhiteGray,
      // the color is spread gradually, when pressing on.
      highlightColor: Colors.transparent,
      // changes all it's color ,after pressing on it .
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: kDarkBrown,
            ),
            const SizedBox(width: 10),
            CustomText(
              text: name,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: kDarkBrown,
            ),
          ],
        ),
      ),
    );
  }
}
