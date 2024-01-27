import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/edit_profile_item_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/up_date_profile_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.profile),
      body: ListView(
        children: [
          SizedBox(height: context.height * 0.02),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Images.orderImage),
              ),
              border: Border.all(style: BorderStyle.solid, color: Colors.white),
            ),
          ),
          SizedBox(height: context.height * 0.009),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                fontSize: 18,
                textColor: Colors.black,
                textAlign: TextAlign.center,
                text: AppStrings.editProfile,
              ),
              const SizedBox(width: 5),
              IconButton(
                //hoverColor: Colors.red,
                splashColor: Colors.red,
                focusColor: Colors.white,
                highlightColor: AppColors.whiteGray,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const UpDateProfileWidget(),
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.teal),
              ),
            ],
          ),
          SizedBox(height: context.height * 0.01),
          const CustomText(
            fontSize: 25,
            textColor: Colors.black,
            textAlign: TextAlign.center,
            text: "${AppStrings.hiThere} Mohamed !",
            fontFamily: AppStrings.pacifico,
          ),
          SizedBox(height: context.height * 0.03),
          const EditProfileItemWidget(
            title: AppStrings.name,
            value: "Mohamed",
          ),
          const EditProfileItemWidget(
            title: AppStrings.email,
            value: "atef9463@gmail.com",
          ),
          const EditProfileItemWidget(
            title: AppStrings.phone,
            value: "01554465660",
          ),
          const EditProfileItemWidget(
            title: AppStrings.address,
            value: "Egypt,Dakahlya,Bilqas,Eldaas",
          ),
        ],
      ),
    );
  }
}
