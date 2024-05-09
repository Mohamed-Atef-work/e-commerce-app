import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/account_item_widget.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 5, vertical: context.height * 0.05),
      child: Column(
        children: [
          AccountItemsWidget(
            onTap: () {
              Navigator.pushNamed(context, Screens.profileScreen);
            },
            name: AppStrings.profile,
            icon: Icons.person_outline,
          ),
          SizedBox(height: context.height * 0.03),
          AccountItemsWidget(
            onTap: () {
              Navigator.pushNamed(context, Screens.userOrderScreen);
            },
            name: AppStrings.orders,
            icon: Icons.shopping_basket_outlined,
          ),
          SizedBox(height: context.height * 0.03),
          AccountItemsWidget(
            onTap: () {
              Navigator.pushNamed(context, Screens.editAddressScreen);
            },
            name: AppStrings.address,
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }
}
