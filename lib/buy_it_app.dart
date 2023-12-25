import 'package:e_commerce_app/modules/home/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/favorites_screen.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/details_screen.dart';
import 'package:e_commerce_app/test_screen.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_strings.dart';
import 'core/utils/screens_strings.dart';
import 'modules/admin/presentation/screens/admin_add_product_screen.dart';
import 'modules/admin/presentation/screens/admin_panel_screen.dart';
import 'modules/admin/presentation/screens/admin_product_details_screen.dart';
import 'modules/admin/presentation/screens/admin_explore_products_screen.dart';
import 'modules/auth/presentation/screens/login_screen.dart';
import 'modules/auth/presentation/screens/sign_up_screen.dart';
import 'modules/home/presentation/screens/home_layout_screen.dart';
import 'modules/orders/presentaion/screens/orders_screen.dart';
import 'modules/home/presentation/screens/products_of_category_screen.dart';

class BuyItApp extends StatelessWidget {
  const BuyItApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.buyIt,
      initialRoute: Screens.homeScreen,
      routes: {
        Screens.testScreen: (context) => const TestScreen(),
        Screens.cartScreen: (context) => const CartScreen(),
        Screens.ordersScreen: (context) => const OrdersScreen(),
        Screens.loginScreen: (context) => const LoginScreen(),
        Screens.signUpScreen: (context) => const SignUpScreen(),
        Screens.adminPanelScreen: (context) => AdminPanelScreen(),
        Screens.detailsScreen: (context) => const DetailsScreen(),
        Screens.homeScreen: (context) => const HomeLayoutScreen(),
        Screens.favoritesScreen: (context) => const FavoritesScreen(),
        Screens.addProductScreen: (context) => const AddProductScreen(),
        Screens.exploreScreen: (context) => const ExploreProductsScreen(),
        Screens.adminProductDetailsScreen: (context) =>
            const AdminProductDetailsScreen(),
        Screens.productsOfCategory: (context) =>
            const ProductsOfCategoryScreen(),
      },
    );
  }
}

String? uId;
