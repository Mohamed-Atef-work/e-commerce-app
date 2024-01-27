import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/account_item_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/profile_item_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.profile),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.height * 0.03),
            ProfileItemsWidget(
              onTap: () {
                Navigator.pushNamed(context, Screens.editProfileScreen);
              },
              icon: Icons.person_outline,
              name: AppStrings.editProfile,
            ),
            SizedBox(height: context.height * 0.03),
            ProfileItemsWidget(
              onTap: () {
                Navigator.pushNamed(context, Screens.changePasswordScreen);

              },
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
                fontFamily: AppStrings.pacifico,
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
      ),
    );
  }
}
