import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/components/logo.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_states.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/service_locator/sl.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return BlocProvider<LoginBloc>(
      create: (context) => sl<LoginBloc>(),
      lazy: true,
      child: Scaffold(
        backgroundColor: kPrimaryColorYellow,
        body: ListView(
          padding: EdgeInsets.only(
            top: height * 0.1,
            right: width * 0.05,
            left: width * 0.05,
          ),
          children: [
            const LogoWidget(),
            SizedBox(height: height * 0.06),
            const LoginFormWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  fontSize: 15,
                  textColor: kWhite,
                  text: AppStrings.doNotHaveAnAccount,
                ),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(Screens.signUpScreen),
                  child: const CustomText(
                    fontSize: 15,
                    text: AppStrings.signUp,
                    textColor: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.03,
                horizontal: width * 0.23,
              ),
              child: BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previousState, currentState) =>
                    previousState.adminUser != currentState.adminUser,
                builder: (context, state) => GestureDetector(
                  onTap: () => BlocProvider.of<LoginBloc>(context)
                      .add(const ToggleAdminAndUserEvent()),
                  child: CustomText(
                    fontSize: 15,
                    textColor: Colors.black,
                    textAlign: TextAlign.center,
                    text: state.adminUser == AdminUser.admin
                        ? AppStrings.iAmAnAdmin
                        : AppStrings.iAmAUser,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
