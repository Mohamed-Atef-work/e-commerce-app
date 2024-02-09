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
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_states.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<LoginBloc>(context);

    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            fontSize: 15,
            onChanged: (email) {
              controller.email = email;
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
                  controller.add(const ObSecureEvent());
                },
                onChanged: (password) {
                  controller.password = password;
                },
                hintText: AppStrings.enterYourPassword,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height * 0.05),
            child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.loginState == RequestState.success) {
                    if (state.adminUser == AdminUser.user) {
                      Navigator.of(context)
                          .pushReplacementNamed(Screens.userLayoutScreen);
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed(Screens.adminLayoutScreen);
                    }
                  }
                },
                buildWhen: (previousState, currentState) =>
                    previousState.loginState != currentState.loginState,
                builder: (context, state) {
                  print(
                      "<------------------------ Hi Iam being built ------------------------>");

                  if (state.loginState == RequestState.loading) {
                    return const LoadingWidget();
                  } else {
                    return CustomButton(
                      text: AppStrings.login,
                      width: context.width * 0.4,
                      height: context.height * 0.05,
                      onPressed: () {
                        controller.add(const SignInEvent());
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
