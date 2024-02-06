import 'package:e_commerce_app/modules/shared/presentation/controller/change_password_controller/change_password_cubit.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChangePasswordCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: appBar(title: AppStrings.changePassword, height: 80),
            body: Padding(
              padding: EdgeInsets.only(
                  top: context.height * 0.1, left: 10, right: 10),
              child: Form(
                key: BlocProvider.of<ChangePasswordCubit>(context).formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      fontSize: 15,
                      prefixIcon: Icons.lock,
                      fillColor: AppColors.whiteGray,
                      hintText: AppStrings.oldPassword,
                      textEditingController:
                          BlocProvider.of<ChangePasswordCubit>(context)
                              .oldPassword,
                      validator: (value) => Validators.passwordValidator(value),
                    ),
                    SizedBox(height: context.height * 0.02),
                    CustomTextFormField(
                      fontSize: 15,
                      prefixIcon: Icons.lock,
                      fillColor: AppColors.whiteGray,
                      hintText: AppStrings.newPassword,
                      textEditingController:
                          BlocProvider.of<ChangePasswordCubit>(context)
                              .newPassword,
                      validator: (value) => Validators.passwordValidator(value),
                    ),
                    SizedBox(height: context.height * 0.02),
                    CustomTextFormField(
                      fontSize: 15,
                      prefixIcon: Icons.lock,
                      fillColor: AppColors.whiteGray,
                      hintText: AppStrings.confirmPassword,
                      textEditingController:
                          BlocProvider.of<ChangePasswordCubit>(context)
                              .confirmPassword,
                      validator: (value) => Validators.passwordValidator(value),
                    ),
                    SizedBox(height: context.height * 0.02),
                    BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        if (state.changeState == RequestState.loading) {
                          return const LoadingWidget();
                        } else {
                          return CustomButton(
                            height: 50,
                            fontSize: 18,
                            onPressed: () {
                              BlocProvider.of<ChangePasswordCubit>(context)
                                  .changePassword();
                            },
                            text: AppStrings.update,
                            width: context.width * 0.7,
                            fontFamily: AppStrings.pacifico,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}