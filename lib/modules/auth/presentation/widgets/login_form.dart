import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/user_data_after_login_use_case.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_states.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_state.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    final loginController = BlocProvider.of<LoginBloc>(context);
    final userDataController = BlocProvider.of<SharedUserDataCubit>(context);

    return Form(
      key: loginController.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            prefixIcon: Icons.email,
            validator: _emailValidator,
            hintText: AppStrings.enterYourEmail,
            onChanged: (email) => loginController.email = email,
          ),
          SizedBox(height: height * 0.02),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.obSecure != current.obSecure,
            builder: (_, state) => PasswordTextFormField(
              obSecure: state.obSecure,
              hintText: AppStrings.enterYourPassword,
              onChanged: (password) => loginController.password = password,
              suffixPressed: () => loginController.add(const ObSecureEvent()),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.05),
            child: MultiBlocListener(
              listeners: _listeners(),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (_, state) {
                  print(
                      " ------------------------------------------------- > Rebuild.....");
                  if (state.loginState == RequestState.loading ||
                      userDataController.state.afterLoginState ==
                          RequestState.loading) {
                    return const LoadingWidget();
                  } else {
                    return CustomButton(
                      width: width * 0.4,
                      height: height * 0.05,
                      text: AppStrings.login,
                      onPressed: () => loginController.add(
                        SignInEvent(state.adminUser),
                      ),
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

  String? _emailValidator(String? value) => Validators.emailValidator(value);

  _listeners() => [
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.loginState != current.loginState,
          listener: _loginListener,
        ),
        BlocListener<SharedUserDataCubit, SharedUserDataState>(
          listenWhen: (previous, current) =>
              previous.afterLoginState != current.afterLoginState,
          listener: _userDataListener,
        ),
      ];

  void _loginListener(BuildContext context, LoginState state) {
    final loginController = BlocProvider.of<LoginBloc>(context);
    final userDataController = BlocProvider.of<SharedUserDataCubit>(context);

    print("LoginState ----------- listener ----------- > ${state.loginState}");
    if (state.loginState == RequestState.success) {
      final afterLogin = AfterLoginParams(
        adminUser: state.adminUser,
        password: loginController.password!,
        uId: state.userCredential!.user!.uid,
        userCredential: state.userCredential!,
      );
      userDataController.userDataAfterLogin(afterLogin);
    } else if (state.loginState == RequestState.error) {
      showMyToast(state.errorMessage!, context, Colors.red);
    }
  }

  void _userDataListener(BuildContext context, SharedUserDataState state) {
    final loginController = BlocProvider.of<LoginBloc>(context);

    print(
        "afterLoginState ----------- listener ----------- > ${state.afterLoginState}");
    if (state.afterLoginState == RequestState.error ||
        state.afterLoginState == RequestState.success) {
      loginController.add(const RebuildEvent());
    }

    /// < ------------------------------ listener ------------------------------ >
    if (state.afterLoginState == RequestState.success) {
      if (state.sharedEntity!.user.adminOrUser == AdminUser.user) {
        Navigator.of(context).pushReplacementNamed(Screens.userLayoutScreen);
      } else {
        Navigator.of(context).pushReplacementNamed(Screens.adminLayoutScreen);
      }
    }
  }
}
