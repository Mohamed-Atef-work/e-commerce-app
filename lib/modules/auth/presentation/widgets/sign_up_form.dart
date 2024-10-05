import 'package:e_commerce_app/config/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_states.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<SignUpBloc>(context);
    final height = context.height;
    final width = context.width;
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            prefixIcon: Icons.person,
            validator: _nameValidator,
            hintText: AppStrings.enterYourName,
            onChanged: (name) => controller.name = name,
          ),
          SizedBox(height: height * 0.02),
          CustomTextFormField(
            prefixIcon: Icons.email,
            validator: _emailValidator,
            hintText: AppStrings.enterYourEmail,
            onChanged: (email) => controller.email = email,
          ),
          SizedBox(height: height * 0.02),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) =>
                previous.obSecure != current.obSecure,
            builder: (_, state) {
              return PasswordTextFormField(
                obSecure: state.obSecure,
                hintText: AppStrings.enterYourPassword,
                suffixPressed: () => controller.obSecure(),
                onChanged: (password) => controller.password = password,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.05),
            child: BlocConsumer<SignUpBloc, SignUpState>(
              listenWhen: (previous, current) =>
                  previous.signUpState != current.signUpState,
              listener: _listener,
              builder: (_, state) {
                if (state.signUpState == RequestState.loading) {
                  return SizedBox(
                    height: height * 0.05,
                    child: const LoadingWidget(),
                  );
                } else {
                  return CustomButton(
                    width: width * 0.4,
                    height: height * 0.05,
                    text: AppStrings.signUp,
                    onPressed: () => controller.signUp(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _listener(BuildContext context, SignUpState state) {
    if (state.signUpState == RequestState.success) {
      showMyToast(
          AppStrings.youHaveSignedUpSuccessfully, context, Colors.green);
      Future.delayed(
        const Duration(milliseconds: 500),
        () => Navigator.of(context).pushReplacementNamed(Screens.loginScreen),
      );
    } else if (state.signUpState == RequestState.error) {
      showMyToast(state.errorMessage!, context, Colors.red);
    }
  }

  String? _emailValidator(String? value) => Validators.emailValidator(value);

  String? _nameValidator(String? value) =>
      Validators.stringValidator(value, AppStrings.enterYourName);
}
