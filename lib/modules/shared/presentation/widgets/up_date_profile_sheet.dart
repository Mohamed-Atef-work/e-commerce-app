import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/up_date_profile_controller/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/constants.dart';

class UpDateProfileWidget extends StatelessWidget {
  const UpDateProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UpdateProfileCubit>(),
      child: Container(
        height: context.height * 0.4,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: kWhite, style: BorderStyle.solid),
          color: kPrimaryColorYellow,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
          builder: (context, state) {
            if (state.updateState == RequestState.loading) {
              return const LoadingWidget();
            } else if (state.updateState == RequestState.success) {
              return const Center(
                child: CustomText(
                  fontSize: 25,
                  text: AppStrings.updated,
                  fontWeight: FontWeight.bold,
                  fontFamily: kPacifico,
                ),
              );
            } else {
              return Form(
                key: BlocProvider.of<UpdateProfileCubit>(context).formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextFormField(
                      fontSize: 15,
                      hintText: AppStrings.name,
                      prefixIcon: Icons.person,
                      textEditingController:
                          BlocProvider.of<UpdateProfileCubit>(context).name,
                      validator: (value) =>
                          Validators.stringValidator(value, AppStrings.name),
                      fillColor: kWhiteGray,
                    ),
                    CustomTextFormField(
                      fontSize: 15,
                      hintText: AppStrings.phone,
                      prefixIcon: Icons.phone_android,
                      textEditingController:
                          BlocProvider.of<UpdateProfileCubit>(context).phone,
                      validator: (value) =>
                          Validators.numericValidator(value, AppStrings.phone),
                      fillColor: kWhiteGray,
                    ),
                    CustomTextFormField(
                      fontSize: 15,
                      hintText: AppStrings.email,
                      prefixIcon: Icons.email,
                      textEditingController:
                          BlocProvider.of<UpdateProfileCubit>(context).email,
                      validator: (value) => Validators.emailValidator(value),
                      fillColor: kWhiteGray,
                    ),
                    CustomButton(
                      height: 50,
                      fontSize: 18,
                      onPressed: () {
                        BlocProvider.of<UpdateProfileCubit>(context)
                            .updateOrderData();
                      },
                      text: AppStrings.update,
                      width: context.width * 0.7,
                      fontFamily: kPacifico,
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
