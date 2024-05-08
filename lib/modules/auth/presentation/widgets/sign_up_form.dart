import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
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
            prefixIcon: Icons.person,
            hintText: AppStrings.enterYourName,
            onChanged: (name) {
              controller.name = name;
              print(controller.name);
            },
            validator: (value) =>
                Validators.stringValidator(value, AppStrings.enterYourName),
          ),
          SizedBox(height: context.height * 0.02),
          CustomTextFormField(
            prefixIcon: Icons.email,
            hintText: AppStrings.enterYourEmail,
            onChanged: (email) {
              controller.email = email;
              print(controller.email);
            },
            validator: (value) => Validators.emailValidator(value),
          ),
          SizedBox(height: context.height * 0.02),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) =>
                previous.obSecure != current.obSecure,
            builder: (context, state) {
              return PasswordTextFormField(
                obSecure: state.obSecure,
                hintText: AppStrings.enterYourPassword,
                suffixPressed: () {
                  controller.obSecure();
                },
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
              _listener(context, state);
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
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  void _listener(BuildContext context, SignUpState state) {
    if (state.signUpState == RequestState.success &&
        state.storeUserDataState == RequestState.success) {
      showMyToast(AppStrings.success, Colors.green);
      Navigator.of(context).pushReplacementNamed(Screens.loginScreen);
    } else if (state.signUpState == RequestState.error ||
        state.storeUserDataState == RequestState.error) {
      showMyToast(AppStrings.ops, Colors.red);
    }
  }
}
