import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/account_item_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/profile_item_widget.dart';

class AdminProfileView extends StatelessWidget {
  const AdminProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.height * 0.03),
          ProfileItemsWidget(
            onTap: () {},
            icon: Icons.person_outline,
            name: AppStrings.editProfile,
          ),
          SizedBox(height: context.height * 0.03),
          ProfileItemsWidget(
            onTap: () {},
            icon: Icons.key_outlined,
            name: AppStrings.changePassword,
          ),
          SizedBox(height: context.height * 0.03),
          ProfileItemsWidget(
            onTap: () {},
            name: AppStrings.myCards,
            icon: Icons.add_card_outlined,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: context.height * 0.03,
              bottom: context.height * 0.03,
            ),
            child: const CustomText(
              fontSize: 25,
              textColor: Colors.black,
              fontWeight: FontWeight.bold,
              text: AppStrings.appSettings,
              fontFamily: kPacifico,
            ),
          ),
          ProfileItemsWidget(
            onTap: () {},
            name: AppStrings.language,
            icon: Icons.language_outlined,
          ),
          SizedBox(height: context.height * 0.03),
          AccountItemsWidget(
            onTap: () {},
            name: AppStrings.logout,
            icon: Icons.logout_outlined,
          ),
        ],
      ),
    );
  }
}
