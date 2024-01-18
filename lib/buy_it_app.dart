import 'package:e_commerce_app/modules/admin/presentation/screens/admin_layout_screen.dart';

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
import 'modules/admin/presentation/screens/admin_add_product_screen.dart';
import 'modules/admin/presentation/screens/admin_details_screen.dart';
import 'modules/admin/presentation/screens/admin_explore_products_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/details_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/profile_screen.dart';
import 'package:e_commerce_app/modules/orders/presentation/screens/user_order_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

class BuyItApp extends StatelessWidget {
  const BuyItApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// shared < ----------------------------------------------------------- >
        BlocProvider<ProductDetailsCubit>(
          create: (context) => sl<ProductDetailsCubit>(),
        ),

        /// User < ----------------------------------------------------------- >
        BlocProvider<GetFavoriteCubit>(
          create: (context) => sl<GetFavoriteCubit>()..getFavorites(),
        ),
        BlocProvider<ManageCartProductsCubit>(
          create: (context) =>
              sl<ManageCartProductsCubit>()..getCartProducts("uId"),
        ),

        /// Admin < ----------------------------------------------------------- >
      ],
      child: MaterialApp(
        title: AppStrings.buyIt,
        initialRoute: Screens.adminLayoutScreen,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.primaryColorYellow),
        routes: {
          Screens.testScreen: (context) => const TestScreen(),
          Screens.cartScreen: (context) => const CartScreen(),
          Screens.loginScreen: (context) => const LoginScreen(),
          Screens.signUpScreen: (context) => const SignUpScreen(),
          Screens.adminPanelScreen: (context) => AdminPanelScreen(),
          Screens.detailsScreen: (context) => const DetailsScreen(),
          Screens.profileScreen: (context) => const ProfileScreen(),
          Screens.userOrderScreen: (context) => const UserOrderScreen(),
          Screens.addProductScreen: (context) => const AddProductScreen(),
          Screens.exploreScreen: (context) => const ExploreProductsScreen(),
          Screens.userLayoutScreen: (context) => const UserLayoutScreen(),
          Screens.adminLayoutScreen: (context) => const AdminLayoutScreen(),
          Screens.adminProductDetailsScreen: (context) =>
              const AdminDetailsScreen(),
          //Screens.productsOfCategory: (context) => const ProductsOfCategoryScreen(),
        },
      ),
    );
  }
}

String? uId;
