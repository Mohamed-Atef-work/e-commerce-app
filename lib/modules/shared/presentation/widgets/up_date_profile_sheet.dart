import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/up_date_profile_controller/update_profile_cubit.dart';

class UpDateProfileWidget extends StatelessWidget {
  const UpDateProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final updateProfileController =
        BlocProvider.of<UpdateProfileCubit>(context);
    final userData = BlocProvider.of<SharedUserDataCubit>(context).state;
    final uId = userData.sharedEntity!.user.userEntity.id;
    return BlocProvider(
      create: (context) => sl<UpdateProfileCubit>(),
      child: Container(
        height: context.height * 0.4,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kPrimaryColorYellow,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          border: Border.all(color: kWhite, style: BorderStyle.solid),
        ),
        child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
          builder: (context, state) {
            if (state.updateState == RequestState.loading) {
              return const LoadingWidget();
            } else if (state.updateState == RequestState.success) {
              return const Center(
                child: CustomText(
                  fontSize: 25,
                  fontFamily: kPacifico,
                  text: AppStrings.updated,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Form(
                key: updateProfileController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextFormField(
                      prefixIcon: Icons.person,
                      hintText: AppStrings.name,
                      textEditingController: updateProfileController.name,
                      validator: (value) =>
                          Validators.stringValidator(value, AppStrings.name),
                    ),
                    CustomTextFormField(
                      hintText: AppStrings.phone,
                      prefixIcon: Icons.phone_android,
                      textEditingController: updateProfileController.phone,
                      validator: (value) =>
                          Validators.numericValidator(value, AppStrings.phone),
                    ),
                    CustomTextFormField(
                      prefixIcon: Icons.email,
                      hintText: AppStrings.email,
                      textEditingController: updateProfileController.email,
                      validator: (value) => Validators.emailValidator(value),
                    ),
                    CustomButton(
                      height: 50,
                      fontSize: 18,
                      fontFamily: kPacifico,
                      text: AppStrings.update,
                      width: context.width * 0.7,
                      onPressed: () {
                        updateProfileController.updateUserData(uId);
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
