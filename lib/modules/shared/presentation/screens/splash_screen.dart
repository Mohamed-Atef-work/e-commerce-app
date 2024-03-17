import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/components/logo.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_state.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';

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
      body: BlocListener<SharedUserDataCubit, SharedUserDataState>(
        listener: (context, state) {
          print("${state.message} < ------ listener ----- > ${state.getState}");
          print(state.sharedEntity?.user.userEntity.name);
          print(state.sharedEntity?.user.adminOrUser);
          print(state.sharedEntity?.user.password);

          /// < ------------------------------------------------------------ >
          if (state.getState == RequestState.success) {
            if (state.sharedEntity!.user.adminOrUser == AdminUser.admin) {
              Navigator.of(context)
                  .pushReplacementNamed(Screens.adminLayoutScreen);
            } else {
              Navigator.of(context)
                  .pushReplacementNamed(Screens.userLayoutScreen);
            }
          } else if (state.getState == RequestState.error) {
            if (state.message == kThereIsNoData) {
              Navigator.of(context).pushReplacementNamed(Screens.loginScreen);
            } else {
              /// show snake bar .....
              showToast(AppStrings.tryAgain, Colors.red);
            }
          }
        },
        child: const Center(child: CustomFadingWidget(child: LogoWidget())),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        BlocProvider.of<SharedUserDataCubit>(context).getInitialDataLocally();
      },
    );
  }
}
