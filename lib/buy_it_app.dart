import 'config/routes/pages.dart';
import 'core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'config/routes/routes_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/config/providers.dart';
import 'package:e_commerce_app/core/constants/colors.dart';

class BuyItApp extends StatelessWidget {
  const BuyItApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers(),
      child: MaterialApp(
        routes: routes(),
        title: AppStrings.buyIt,
        initialRoute: Screens.testScreen,
        theme: ThemeData(scaffoldBackgroundColor: kPrimaryColorYellow),
      ),
    );
  }
}
