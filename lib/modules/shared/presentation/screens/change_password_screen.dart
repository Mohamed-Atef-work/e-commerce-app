import 'package:e_commerce_app/core/utils/screens_strings.dart';
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
        final controller = BlocProvider.of<ChangePasswordCubit>(context);

        return Scaffold(
          appBar: appBar(title: AppStrings.changePassword, height: 80),
          body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
            listener: (context, state) {
              if (state.changeState == RequestState.success) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Screens.loginScreen, (route) => false);
              }
            },
            builder: (context, state) {
              if (state.changeState == RequestState.loading) {
                return const LoadingWidget();
              } else {
                return Padding(
                  padding: EdgeInsets.only(
                      top: context.height * 0.1, left: 10, right: 10),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        PasswordTextFormField(
                          obSecure: state.oldPassword,
                          hintText: AppStrings.oldPassword,
                          textEditingController: controller.oldPassword,
                          suffixPressed: () {
                            controller.obSecure(
                                oldPassword: !state.oldPassword);
                          },
                        ),
                        _sizedBox(context.height * 0.02),
                        PasswordTextFormField(
                          obSecure: state.newPassword,
                          hintText: AppStrings.newPassword,
                          textEditingController: controller.newPassword,
                          suffixPressed: () {
                            controller.obSecure(
                                newPassword: !state.newPassword);
                          },
                        ),
                        _sizedBox(context.height * 0.02),
                        PasswordTextFormField(
                          obSecure: state.confirmPassword,
                          hintText: AppStrings.confirmPassword,
                          textEditingController: controller.confirmPassword,
                          suffixPressed: () {
                            controller.obSecure(
                                confirmPassword: !state.confirmPassword);
                          },
                        ),
                        _sizedBox(context.height * 0.02),
                        CustomButton(
                          height: 50,
                          fontSize: 18,
                          onPressed: () {
                            controller.changePassword();
                          },
                          text: AppStrings.update,
                          width: context.width * 0.7,
                          fontFamily: AppStrings.pacifico,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }

  _sizedBox(double height) => SizedBox(height: height);
}
