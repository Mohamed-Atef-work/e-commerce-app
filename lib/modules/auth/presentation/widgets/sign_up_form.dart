import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_states.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_text_form_field.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/validators.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Form(
      key: BlocProvider.of<SignUpBloc>(context).formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: AppStrings.enterYourName,
            fontSize: 15,
            validator: (value) =>
                Validators.stringValidator(value, AppStrings.enterYourName),
            onChanged: (name) {
              BlocProvider.of<SignUpBloc>(context).name = name;
              print(BlocProvider.of<SignUpBloc>(context).name);
            },
            prefixIcon: Icons.person,

          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          CustomTextFormField(
            hintText: AppStrings.enterYourEmail,
            fontSize: 15,
            validator: (value) => Validators.emailValidator(value),
            onChanged: (email) {
              BlocProvider.of<SignUpBloc>(context).email = email;
              print(BlocProvider.of<SignUpBloc>(context).email);
            },
            prefixIcon: Icons.email,

          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          CustomTextFormField(
            hintText: AppStrings.enterYourPassword,
            fontSize: 15,
            validator: (value) => Validators.passwordValidator(value),
            onChanged: (password) {
              BlocProvider.of<SignUpBloc>(context).password = password;
              print(BlocProvider.of<SignUpBloc>(context).password);
            },
            prefixIcon: Icons.lock,

          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.05),
            child: BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previousState, currentState) =>
                    previousState.signUpState != currentState.signUpState,
                builder: (context, state) {
                  print(
                      "<------------------------ Hi Iam being built ------------------------>");
                  return state.signUpState == RequestState.loading
                      ? SizedBox(
                          height: height * 0.05,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : CustomButton(
                          width: width * 0.3,
                          height: height * 0.05,
                          text: AppStrings.signUp,
                          onPressed: () {
                            BlocProvider.of<SignUpBloc>(context).signUp();
                          }
                          //SignUpController().formKey.currentState!.validate();
                          );
                }),
          ),
        ],
      ),
    );
  }
}
