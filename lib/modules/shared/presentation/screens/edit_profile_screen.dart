import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/up_date_profile_sheet.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/edit_profile_item_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataController = BlocProvider.of<SharedUserDataCubit>(context);
    final userData = userDataController.state.sharedEntity!.user.userEntity;

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
          SizedBox(height: context.height * 0.01),
          CustomText(
            fontSize: 25,
            fontFamily: kPacifico,
            textColor: Colors.black,
            textAlign: TextAlign.center,
            text: "${AppStrings.hiThere} ${userData.name} !",
          ),
          SizedBox(height: context.height * 0.03),
          EditProfileItemWidget(
            title: AppStrings.name,
            value: userData.name,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => const UpDateProfileWidget());
            },
          ),
          EditProfileItemWidget(
            title: AppStrings.email,
            value: userData.email,
            onPressed: () {},
          ),
          EditProfileItemWidget(
            title: AppStrings.phone,
            value: userData.phone ?? AppStrings.pleaseAddPhone,
            onPressed: () {},
          ),
          EditProfileItemWidget(
            title: AppStrings.address,
            value: userData.address ?? AppStrings.pleaseAddAddress,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
/*Row(
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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const UpDateProfileWidget(),
                  );
                },
                //hoverColor: Colors.red,
                splashColor: Colors.red,
                focusColor: Colors.white,
                highlightColor: kWhiteGray,
                icon: const Icon(Icons.edit, color: Colors.teal),
              ),
            ],
          ),*/
