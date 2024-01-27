import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_text_form_field.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/app_strings.dart';
import '../controllers/login_controller/login_bloc.dart';
import '../controllers/login_controller/login_states.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<LoginBloc>(context).formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: AppStrings.enterYourEmail,
            fontSize: 15,
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
            hintText: AppStrings.enterYourPassword,
            fontSize: 15,
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
            child: BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previousState, currentState) =>
                    previousState.requestState != currentState.requestState,
                //bloc: sl<LoginBloc>(),
                builder: (context, state) {
                  print(
                      "<------------------------ Hi Iam being built ------------------------>");
                  return state.requestState == RequestState.loading
                      ? SizedBox(
                          height: context.height * 0.05,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : CustomButton(
                          text: AppStrings.login,
                          width: context.width * 0.4,
                          height: context.height * 0.05,
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(const SignInEvent());
                          },
                        );
                }),
          ),
        ],
      ),
    );
  }
}
