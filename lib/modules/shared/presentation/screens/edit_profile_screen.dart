import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/update_email_sheet.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/update_name_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/update_phone_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/edit_profile_item_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_state.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.profile),
      body: BlocBuilder<SharedUserDataCubit, SharedUserDataState>(
          builder: (_, state) {
        /// -------------------------------------------------------------

        final height = context.height;

        final userDataController =
            BlocProvider.of<SharedUserDataCubit>(context);
        final userData = userDataController.state.sharedEntity!.user.userEntity;

        /// -------------------------------------------------------------
        if (state.getState == RequestState.loading) {
          return const LoadingWidget();
        } else {
          return ListView(
            children: [
              SizedBox(height: height * 0.02),
              SvgPicture.asset(Images.user, width: 100, height: 100),
              SizedBox(height: height * 0.01),
              CustomText(
                fontSize: 25,
                fontFamily: kPacifico,
                textColor: Colors.black,
                textAlign: TextAlign.center,
                text: "${AppStrings.hiThere} ${userData.name} !",
              ),
              SizedBox(height: height * 0.03),
              EditProfileItemWidget(
                value: userData.name,
                title: AppStrings.name,
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => const UpDateNameWidget()),
              ),
              EditProfileItemWidget(
                value: userData.email,
                title: AppStrings.email,
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => const UpDateEmailWidget()),
              ),
              EditProfileItemWidget(
                title: AppStrings.phone,
                value: userData.phone ?? AppStrings.pleaseAddPhone,
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => const UpDatePhoneWidget()),
              ),
              AddressWidget(
                address: userData.address ?? AppStrings.pleaseAddAddress,
              ),
            ],
          );
        }
      }),
    );
  }
}
