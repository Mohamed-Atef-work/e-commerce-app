import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileItemsWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final void Function() onTap;
  const ProfileItemsWidget({
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
      highlightColor: Colors.transparent,
      // changes all it's color ,when putting the mouse on it .
      splashColor: kWhiteGray,
      // the color is spread gradually.
      // then disappear quickly..
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: kDarkBrown,
              size: 35,
            ),
            const SizedBox(width: 10),
            CustomText(
              text: name,
              fontSize: 20,
              textColor: kDarkBrown,
              fontWeight: FontWeight.bold,
              //overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
