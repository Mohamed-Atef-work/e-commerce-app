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
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_states.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<SignUpBloc>(context);

    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            fontSize: 15,
            prefixIcon: Icons.person,
            hintText: AppStrings.enterYourName,
            validator: (value) =>
                Validators.stringValidator(value, AppStrings.enterYourName),
            onChanged: (name) {
              controller.name = name;
              print(controller.name);
            },
          ),
          SizedBox(height: context.height * 0.02),
          CustomTextFormField(
            fontSize: 15,
            prefixIcon: Icons.email,
            hintText: AppStrings.enterYourEmail,
            validator: (value) => Validators.emailValidator(value),
            onChanged: (email) {
              controller.email = email;
              print(controller.email);
            },
          ),
          SizedBox(height: context.height * 0.02),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) =>
                previous.obSecure != current.obSecure,
            builder: (context, state) {
              return CustomTextFormField(
                fontSize: 15,
                prefixIcon: Icons.lock,
                obSecure: state.obSecure,
                suffixIcon: state.obSecure
                    ? Icons.remove_red_eye
                    : Icons.panorama_fish_eye,
                suffixPressed: () {
                  controller.obSecure();
                },
                hintText: AppStrings.enterYourPassword,
                validator: (value) => Validators.passwordValidator(value),
                onChanged: (password) {
                  controller.password = password;
                  print(controller.password);
                },
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height * 0.05),
            child: BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
              if (state.signUpState == RequestState.success &&
                  state.storeUserDataState == RequestState.success) {
                Navigator.of(context).pushReplacementNamed(Screens.loginScreen);
              }
            }, builder: (context, state) {
              if (state.signUpState == RequestState.loading ||
                  state.storeUserDataState == RequestState.loading) {
                return SizedBox(
                  height: context.height * 0.05,
                  child: const LoadingWidget(),
                );
              } else {
                return CustomButton(
                    text: AppStrings.signUp,
                    width: context.width * 0.3,
                    height: context.height * 0.05,
                    onPressed: () {
                      controller.signUp();
                    });
              }
            }),
          ),
        ],
      ),
    );
  }
}
