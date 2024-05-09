import 'package:e_commerce_app/modules/shared/presentation/controllers/change_password_controller/change_password_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_state.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChangePasswordCubit>(),
      child: Builder(
        builder: (context) {
          final passwordController =
              BlocProvider.of<ChangePasswordCubit>(context);
          final userDataController =
              BlocProvider.of<SharedUserDataCubit>(context);

          return Scaffold(
            appBar: appBar(title: AppStrings.changePassword, height: 80),
            body: MultiBlocListener(
                listeners: [
                  BlocListener<ChangePasswordCubit, ChangePasswordState>(
                    listener: (context, state) {
                      print(
                          "Change State is ------------> ${state.changeState}");
                      if (state.changeState == RequestState.success) {
                        userDataController.savePartOfUserDataLocally(
                            password: passwordController.newPassword.text);
                      }
                    },
                  ),
                  BlocListener<SharedUserDataCubit, SharedUserDataState>(
                    listener: (context, state) {
                      print("save State is ------------> ${state.saveState}");
                      if (state.saveState == RequestState.success) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Screens.loginScreen, (route) => false);
                      }
                    },
                  ),
                ],
                child: BlocBuilder<SharedUserDataCubit, SharedUserDataState>(
                  builder: (context, state) {
                    if (state.saveState == RequestState.loading) {
                      return const LoadingWidget();
                    } else {
                      return BlocBuilder<ChangePasswordCubit,
                          ChangePasswordState>(
                        builder: (context, state) {
                          if (state.changeState == RequestState.loading) {
                            return const LoadingWidget();
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: context.height * 0.1,
                                left: 10,
                                right: 10,
                              ),
                              child: Form(
                                key: passwordController.formKey,
                                child: Column(
                                  children: [
                                    PasswordTextFormField(
                                      obSecure: state.oldPassword,
                                      hintText: AppStrings.oldPassword,
                                      textEditingController:
                                          passwordController.oldPassword,
                                      suffixPressed: () {
                                        passwordController.obSecure(
                                            oldPassword: !state.oldPassword);
                                      },
                                    ),
                                    _sizedBox(context.height * 0.02),
                                    PasswordTextFormField(
                                      obSecure: state.newPassword,
                                      hintText: AppStrings.newPassword,
                                      textEditingController:
                                          passwordController.newPassword,
                                      suffixPressed: () {
                                        passwordController.obSecure(
                                            newPassword: !state.newPassword);
                                      },
                                    ),
                                    _sizedBox(context.height * 0.02),
                                    PasswordTextFormField(
                                      obSecure: state.confirmPassword,
                                      hintText: AppStrings.confirmPassword,
                                      textEditingController:
                                          passwordController.confirmPassword,
                                      suffixPressed: () {
                                        passwordController.obSecure(
                                            confirmPassword:
                                                !state.confirmPassword);
                                      },
                                    ),
                                    _sizedBox(context.height * 0.02),
                                    CustomButton(
                                      height: 50,
                                      fontSize: 18,
                                      fontFamily: kPacifico,
                                      text: AppStrings.update,
                                      width: context.width * 0.7,
                                      onPressed: () {
                                        passwordController.changePassword();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                )),
          );
        },
      ),
    );
  }

  _sizedBox(double height) => SizedBox(height: height);
}
