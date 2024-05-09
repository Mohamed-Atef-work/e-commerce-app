import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/account_item_widget.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/profile_item_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/logout_controller/logout_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.profile),
      body: BlocProvider(
        create: (context) => sl<LogoutCubit>(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Builder(
            builder: (context) {
              return BlocConsumer<LogoutCubit, LogoutState>(
                listener: _listener,
                builder: (context, state) {
                  if (state.logoutState == RequestState.loading) {
                    return const LoadingWidget();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.height * 0.03),
                        ProfileItemsWidget(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Screens.editProfileScreen);
                          },
                          icon: Icons.person_outline,
                          name: AppStrings.editProfile,
                        ),
                        SizedBox(height: context.height * 0.03),
                        ProfileItemsWidget(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Screens.changePasswordScreen);
                          },
                          icon: Icons.key_outlined,
                          name: AppStrings.changePassword,
                        ),
                        SizedBox(height: context.height * 0.03),
                        ProfileItemsWidget(
                          onTap: () {},
                          name: AppStrings.myCards,
                          icon: Icons.add_card_outlined,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: context.height * 0.03,
                            bottom: context.height * 0.03,
                          ),
                          child: const CustomText(
                            fontSize: 25,
                            fontFamily: kPacifico,
                            textColor: Colors.black,
                            fontWeight: FontWeight.bold,
                            text: AppStrings.appSettings,
                          ),
                        ),
                        ProfileItemsWidget(
                          onTap: () {},
                          name: AppStrings.language,
                          icon: Icons.language_outlined,
                        ),
                        SizedBox(height: context.height * 0.03),
                        AccountItemsWidget(
                          onTap: () {
                            BlocProvider.of<LogoutCubit>(context).logout();
                          },
                          name: AppStrings.logout,
                          icon: Icons.logout_outlined,
                        ),
                      ],
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, LogoutState state) {
    if (state.logoutState == RequestState.success) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Screens.loginScreen, (route) => false);
    }
  }
}
