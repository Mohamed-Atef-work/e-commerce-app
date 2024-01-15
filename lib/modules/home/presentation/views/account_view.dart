import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountItemsWidget(
          onTap: () {
            Navigator.pushNamed(context, Screens.profileScreen);
          },
          icon: Icons.person,
          name: AppStrings.profile,
        ),
        SizedBox(height: context.height * 0.03),
        AccountItemsWidget(
          onTap: () {
            Navigator.pushNamed(context, Screens.userOrderScreen);
          },
          name: AppStrings.orders,
          icon: Icons.shopping_basket,
        ),
        SizedBox(height: context.height * 0.03),
        AccountItemsWidget(
          onTap: () {},
          name: AppStrings.address,
          icon: Icons.location_on_rounded,
        ),
      ],
    );
  }
}

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
      splashColor: AppColors.loginTextFormFieldGray,
      // the color is spread gradually.
      highlightColor: Colors.transparent,
      // changes all it's color ,when putting the mouse on it .
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.darkBrown,
              size: context.width * 0.07,
            ),
            const SizedBox(width: 10),
            CustomText(
              text: name,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColors.darkBrown,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
