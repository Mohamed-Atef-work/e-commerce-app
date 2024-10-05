import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/components/logo.dart';
import 'package:e_commerce_app/config/routes/pages.dart';import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/user_data_after_login_use_case.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_state.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';

class SplashAfterLoginScreen extends StatefulWidget {
  const SplashAfterLoginScreen({super.key});

  @override
  State<SplashAfterLoginScreen> createState() => _SplashAfterLoginScreenState();
}

class _SplashAfterLoginScreenState extends State<SplashAfterLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as AfterLoginParams;
    final controller = BlocProvider.of<SharedUserDataCubit>(context);
    Future.delayed(
      const Duration(seconds: 3),
      () => controller.userDataAfterLogin(params),
    );

    return Scaffold(
      body: BlocListener<SharedUserDataCubit, SharedUserDataState>(
        listener: _listener,
        child: const Center(
          child: CustomFadingWidget(child: LogoWidget()),
        ),
      ),
    );
  }

  void _listener(BuildContext context, SharedUserDataState state) {
    if (state.afterLoginState == RequestState.success) {
      if (state.sharedEntity!.user.adminOrUser == AdminUser.user) {
        Navigator.of(context).pushReplacementNamed(Screens.userLayoutScreen);
      } else {
        Navigator.of(context).pushReplacementNamed(Screens.adminLayoutScreen);
      }
    } else if (state.afterLoginState == RequestState.error) {
      showMyToast(state.message!, context, Colors.red);
      Navigator.of(context).pushReplacementNamed(Screens.loginScreen);
    }
  }
}
