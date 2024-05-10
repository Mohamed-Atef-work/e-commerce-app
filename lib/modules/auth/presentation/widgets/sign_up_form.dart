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
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_states.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<SignUpBloc>(context);
    final height = context.height;
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            prefixIcon: Icons.person,
            validator: _nameValidator,
            hintText: AppStrings.enterYourName,
            onChanged: (name) {
              controller.name = name;
              print(controller.name);
            },
          ),
          SizedBox(height: height * 0.02),
          CustomTextFormField(
            onChanged: (email) {
              controller.email = email;
              print(controller.email);
            },
            prefixIcon: Icons.email,
            validator: _emailValidator,
            hintText: AppStrings.enterYourEmail,
          ),
          SizedBox(height: height * 0.02),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) =>
                previous.obSecure != current.obSecure,
            builder: (_, state) {
              return PasswordTextFormField(
                suffixPressed: () {
                  controller.obSecure();
                },
                onChanged: (password) {
                  controller.password = password;
                  print(controller.password);
                },
                obSecure: state.obSecure,
                hintText: AppStrings.enterYourPassword,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.05),
            child: BlocConsumer<SignUpBloc, SignUpState>(
              listener: _listener,
              builder: (_, state) {
                if (state.signUpState == RequestState.loading ||
                    state.storeUserDataState == RequestState.loading) {
                  return SizedBox(
                    height: height * 0.05,
                    child: const LoadingWidget(),
                  );
                } else {
                  return CustomButton(
                    text: AppStrings.signUp,
                    width: context.width * 0.3,
                    height: height * 0.05,
                    onPressed: () {
                      controller.signUp();
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String? _emailValidator(String? value) => Validators.emailValidator(value);

  String? _nameValidator(String? value) =>
      Validators.stringValidator(value, AppStrings.enterYourName);

  void _listener(BuildContext context, SignUpState state) {
    if (state.signUpState == RequestState.success &&
        state.storeUserDataState == RequestState.success) {
      showMyToast(AppStrings.success, context, Colors.green);
      Navigator.of(context).pushReplacementNamed(Screens.loginScreen);
    } else if (state.signUpState == RequestState.error ||
        state.storeUserDataState == RequestState.error) {
      showMyToast(AppStrings.ops, context, Colors.red);
    }
  }
}
