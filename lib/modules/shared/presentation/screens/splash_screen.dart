import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/components/logo.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/init_controller/init_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<InitCubit, InitState>(
          listener: (context, state) {
            if (state.dataState == RequestState.success) {
              if (state.message == kThereIsNoUser) {
                Navigator.of(context).pushReplacementNamed(Screens.loginScreen);
              } else {
                // if User ----> userLayOut .
                // if admin ----> adminLayOut .
              }
            }
          },
          child: const CustomFadingWidget(child: LogoWidget()),
        ),
      ),
    );
  }
}
