import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/user_data_after_login_use_case.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_states.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_state.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = BlocProvider.of<LoginBloc>(context);
    final userDataController = BlocProvider.of<SharedUserDataCubit>(context);

    return Form(
      key: loginController.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            onChanged: (email) {
              loginController.email = email;
            },
            prefixIcon: Icons.email,
            hintText: AppStrings.enterYourEmail,
            validator: (value) => Validators.emailValidator(value),
          ),
          SizedBox(height: context.height * 0.02),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.obSecure != current.obSecure,
            builder: (context, state) {
              return PasswordTextFormField(
                obSecure: state.obSecure,
                suffixPressed: () {
                  loginController.add(const ObSecureEvent());
                },
                onChanged: (password) {
                  loginController.password = password;
                },
                hintText: AppStrings.enterYourPassword,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height * 0.05),
            child: MultiBlocListener(
              listeners: [
                BlocListener<LoginBloc, LoginState>(
                  listenWhen: (previous, current) =>
                      previous.loginState != current.loginState,
                  listener: (context, state) {
                    _loginListener(state, loginController, userDataController);
                  },
                ),
                BlocListener<SharedUserDataCubit, SharedUserDataState>(
                  listenWhen: (previous, current) =>
                      previous.afterLoginState != current.afterLoginState,
                  listener: (context, state) {
                    _userDataListener(context, state, loginController);
                  },
                ),
              ],
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  print(
                      " ------------------------------------------------- > Rebuild.....");
                  if (state.loginState == RequestState.loading ||
                      userDataController.state.afterLoginState ==
                          RequestState.loading) {
                    return const LoadingWidget();
                  } else {
                    return CustomButton(
                      text: AppStrings.login,
                      width: context.width * 0.4,
                      height: context.height * 0.05,
                      onPressed: () {
                        loginController.add(SignInEvent(state.adminUser));
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _loginListener(
  LoginState state,
  LoginBloc loginController,
  SharedUserDataCubit userDataController,
) {
  print(
      "LoginState ------ listener ---------------------------- > ${state.loginState}");
  if (state.loginState == RequestState.success) {
    final afterLogin = AfterLoginParams(
      adminUser: state.adminUser,
      password: loginController.password!,
      uId: state.userCredential!.user!.uid,
      userCredential: state.userCredential!,
    );
    userDataController.userDataAfterLogin(afterLogin);
  }
}

void _userDataListener(
  BuildContext context,
  SharedUserDataState state,
  LoginBloc loginController,
) {
  print(
      "afterLoginState ------ listener ---------------------------- > ${state.afterLoginState}");
  if (state.afterLoginState == RequestState.error ||
      state.afterLoginState == RequestState.success) {
    loginController.add(const RebuildEvent());
  }
  if (state.afterLoginState == RequestState.success) {
    if (state.sharedEntity!.user.adminOrUser == AdminUser.user) {
      Navigator.of(context).pushReplacementNamed(Screens.userLayoutScreen);
    } else {
      Navigator.of(context).pushReplacementNamed(Screens.adminLayoutScreen);
    }
  }
}
