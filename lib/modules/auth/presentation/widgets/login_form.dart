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

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    final loginController = BlocProvider.of<LoginBloc>(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: _loginListener,
      builder: (_, state) {
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
              PasswordTextFormField(
                obSecure: state.obSecure,
                hintText: AppStrings.enterYourPassword,
                onChanged: (password) => loginController.password = password,
                suffixPressed: () => loginController.add(const ObSecureEvent()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.05),
                child: state.loginState == RequestState.loading
                    ? const LoadingWidget()
                    : CustomButton(
                        width: width * 0.4,
                        height: height * 0.05,
                        text: AppStrings.login,
                        onPressed: () => loginController.add(
                          SignInEvent(state.adminUser),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? _emailValidator(String? value) => Validators.emailValidator(value);

  void _loginListener(BuildContext context, LoginState state) {
    final loginController = BlocProvider.of<LoginBloc>(context);

    print("LoginState ----------- listener ----------- > ${state.loginState}");
    if (state.loginState == RequestState.success) {
      final params = AfterLoginParams(
        adminUser: state.adminUser,
        password: loginController.password!,
        uId: state.userCredential!.user!.uid,
        userCredential: state.userCredential!,
      );
      Navigator.of(context).pushReplacementNamed(
        Screens.splashAfterLoginScreen,
        arguments: params,
      );
    } else if (state.loginState == RequestState.error) {
      showMyToast(state.errorMessage!, context, Colors.red);
    }
  }
}
