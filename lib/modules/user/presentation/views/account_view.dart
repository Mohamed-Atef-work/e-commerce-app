import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/account_item_widget.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: height * 0.05),
      child: Column(
        children: [
          AccountItemsWidget(
            name: AppStrings.profile,
            icon: Icons.person_outline,
            onTap: () => Navigator.pushNamed(context, Screens.profileScreen),
          ),
          SizedBox(height: height * 0.03),
          AccountItemsWidget(
            name: AppStrings.orders,
            icon: Icons.shopping_basket_outlined,
            onTap: () => Navigator.pushNamed(context, Screens.userOrderScreen),
          ),
          SizedBox(height: height * 0.03),
          AccountItemsWidget(
            name: AppStrings.address,
            icon: Icons.location_on_outlined,
            onTap: () =>
                Navigator.pushNamed(context, Screens.editAddressScreen),
          ),
        ],
      ),
    );
  }
}
