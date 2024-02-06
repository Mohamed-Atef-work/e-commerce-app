import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/components/logo.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_bloc.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/service_locator.dart';
import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => sl<SignUpBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColorYellow,
        body: ListView(
          padding: EdgeInsets.only(
            top: context.height * 0.1,
            right: context.width * 0.05,
            left: context.width * 0.05,
          ),
          children: [
            const LogoWidget(),
            SizedBox(height: context.height * 0.06),
            SignUpFormWidget(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  fontSize: 15,
                  textColor: AppColors.white,
                  text: AppStrings.haveAnAccount,
                ),
                CustomText(
                  fontSize: 15,
                  text: AppStrings.login,
                  textColor: AppColors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
