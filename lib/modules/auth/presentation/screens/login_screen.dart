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
import '../../../../core/services/service_locator.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return BlocProvider<LoginBloc>(
      create: (context) => sl<LoginBloc>(),
      lazy: true,
      child: Scaffold(
        backgroundColor: AppColors.primaryColorYellow,
        body: ListView(
          padding: EdgeInsets.only(
            top: height * 0.1,
            right: width * 0.05,
            left: width * 0.05,
          ),
          children: [
            const LogoWidget(),
            SizedBox(
              height: height * 0.06,
            ),
            const LoginFormWidget(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: AppStrings.doNotHaveAnAccount,
                  fontSize: 15,
                  textColor: AppColors.white,
                ),
                CustomText(
                  text: AppStrings.signUp,
                  fontSize: 15,
                  textColor: AppColors.black,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.23,
                vertical: height * 0.03,
              ),
              child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previousState, currentState) =>
                      previousState.adminUser != currentState.adminUser,
                  //bloc: sl<LoginBloc>(),
                  builder: (context, state) => GestureDetector(
                        onTap: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(const ToggleAdminAndUserEvent());
                        },
                        child: CustomText(
                          text: state.adminUser == AdminUser.admin
                              ? AppStrings.iAmAnAdmin
                              : AppStrings.iAmAUser,
                          fontSize: 15,
                          textColor: AppColors.black,
                          textAlign: TextAlign.center,
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
