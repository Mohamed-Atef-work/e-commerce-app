import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_states.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<LoginBloc>(context).formKey,
      child: Column(
        children: [
          CustomTextFormField(
            fontSize: 15,
            hintText: AppStrings.enterYourEmail,
            validator: (value) => Validators.emailValidator(value),
            onChanged: (email) {
              BlocProvider.of<LoginBloc>(context).email = email;
              print(BlocProvider.of<LoginBloc>(context).email);
              //LoginController().email = value!;
            },
            prefixIcon: Icons.email,
          ),
          SizedBox(height: context.height * 0.02),
          CustomTextFormField(
            fontSize: 15,
            hintText: AppStrings.enterYourPassword,
            validator: (value) => Validators.passwordValidator(value),
            onChanged: (password) {
              BlocProvider.of<LoginBloc>(context).password = password;
              print(BlocProvider.of<LoginBloc>(context).password);
              //LoginController().password = value;
            },
            prefixIcon: Icons.lock,
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
                        BlocProvider.of<LoginBloc>(context)
                            .add(const SignInEvent());
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
