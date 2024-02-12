import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/components/logo.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/init_controller/init_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: BlocListener<InitCubit, InitState>(
          listener: (context, state) {
            print("${state.message}  ${state.dataState}");
            if (state.dataState == RequestState.success) {
              if (state.initEntity!.userEntity.userOrAdmin == AdminUser.user) {
                Navigator.of(context)
                    .pushReplacementNamed(Screens.adminLayoutScreen);
              } else {
                Navigator.of(context)
                    .pushReplacementNamed(Screens.userLayoutScreen);
              }
            } else if (state.dataState == RequestState.error) {
              if (state.message == kThereIsNoData) {
                Navigator.of(context).pushReplacementNamed(Screens.loginScreen);
              } else {
                /// show snake bar .....
              }
            }
          },
          child: const CustomFadingWidget(child: LogoWidget()),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        BlocProvider.of<InitCubit>(context).init();
      },
    );
  }
}
