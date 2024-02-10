import 'package:e_commerce_app/modules/shared/presentation/controller/shared_password_controller/shared_password_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/shared_user_data_controller/shared_user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/address_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/change_password_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/edit_profile_screen.dart';

import 'core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'core/utils/screens_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/test_screen.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'modules/auth/presentation/screens/login_screen.dart';
import 'modules/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'modules/home/presentation/screens/user_layout_screen.dart';
import 'modules/admin/presentation/screens/admin_panel_screen.dart';
import 'modules/admin/presentation/screens/admin_details_screen.dart';
import 'modules/admin/presentation/screens/admin_add_product_screen.dart';
import 'modules/admin/presentation/screens/admin_explore_products_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/details_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/profile_screen.dart';
import 'package:e_commerce_app/modules/orders/presentation/screens/user_order_screen.dart';
import 'package:e_commerce_app/modules/admin/presentation/screens/admin_layout_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

class BuyItApp extends StatelessWidget {
  const BuyItApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _providers(),
      child: MaterialApp(
        routes: _routes(),
        title: AppStrings.buyIt,
        initialRoute: Screens.loginScreen,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.primaryColorYellow),
      ),
    );
  }

  _providers() => [
        /// shared < --------------------------------------------------------- >
        BlocProvider<GetFavoriteCubit>(
          create: (context) => sl<GetFavoriteCubit>()..getFavorites(),
        ),
        BlocProvider<SharedUserDataCubit>(
          create: (context) => sl<SharedUserDataCubit>(),
        ),
        BlocProvider<SharedPasswordCubit>(
          create: (context) => sl<SharedPasswordCubit>(),
        ),

        /// User < ----------------------------------------------------------- >
        BlocProvider<ManageCartProductsCubit>(
          create: (context) =>
              sl<ManageCartProductsCubit>()..getCartProducts("uId"),
        ),
        BlocProvider<ProductDetailsCubit>(
          create: (context) => sl<ProductDetailsCubit>(),
        ),

        /// Admin < ----------------------------------------------------------- >
        BlocProvider<AdminDetailsCubit>(
          create: (context) => sl<AdminDetailsCubit>(),
        ),
      ];

  _routes() => {
        Screens.testScreen: (context) => const TestScreen(),
        Screens.cartScreen: (context) => const CartScreen(),
        Screens.loginScreen: (context) => const LoginScreen(),
        Screens.signUpScreen: (context) => const SignUpScreen(),
        Screens.adminPanelScreen: (context) => AdminPanelScreen(),
        Screens.detailsScreen: (context) => const DetailsScreen(),
        Screens.profileScreen: (context) => const ProfileScreen(),
        Screens.userOrderScreen: (context) => const UserOrderScreen(),
        Screens.userLayoutScreen: (context) => const UserLayoutScreen(),
        Screens.addProductScreen: (context) => const AddProductScreen(),
        Screens.exploreScreen: (context) => const ExploreProductsScreen(),
        Screens.adminLayoutScreen: (context) => const AdminLayoutScreen(),
        Screens.editProfileScreen: (context) => const EditProfileScreen(),
        Screens.editAddressScreen: (context) => const EditAddressScreen(),
        Screens.adminDetailsScreen: (context) => const AdminDetailsScreen(),
        Screens.changePasswordScreen: (context) => const ChangePasswordScreen(),
      };
}

String? uId;
