import 'package:e_commerce_app/test_screen.dart';
import 'package:e_commerce_app/modules/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/modules/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce_app/modules/user/presentation/screens/details_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/splash_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/address_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/profile_screen.dart';
import 'package:e_commerce_app/modules/user/presentation/screens/user_layout_screen.dart';
import 'package:e_commerce_app/modules/orders/presentation/screens/user_order_screen.dart';
import 'package:e_commerce_app/modules/admin/presentation/screens/add_product_screen.dart';
import 'package:e_commerce_app/modules/admin/presentation/screens/edit_product_screen.dart';
import 'package:e_commerce_app/modules/admin/presentation/screens/admin_layout_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/edit_profile_screen.dart';
import 'package:e_commerce_app/modules/admin/presentation/screens/admin_details_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/change_password_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/splash_after_login_screen.dart';

import 'pages.dart';

routes() => {
      Screens.testScreen: (_) => const TestScreen(),
      Screens.loginScreen: (_) => const LoginScreen(),
      Screens.splashScreen: (_) => const SplashScreen(),
      Screens.signUpScreen: (_) => const SignUpScreen(),
      Screens.detailsScreen: (_) => const DetailsScreen(),
      Screens.profileScreen: (_) => const ProfileScreen(),
      Screens.userOrderScreen: (_) => const UserOrderScreen(),
      Screens.userLayoutScreen: (_) => const UserLayoutScreen(),
      Screens.addProductScreen: (_) => const AddProductScreen(),
      Screens.editProductScreen: (_) => const EditProductScreen(),
      Screens.adminLayoutScreen: (_) => const AdminLayoutScreen(),
      Screens.editProfileScreen: (_) => const EditProfileScreen(),
      Screens.editAddressScreen: (_) => const EditAddressScreen(),
      Screens.adminDetailsScreen: (_) => const AdminDetailsScreen(),
      Screens.changePasswordScreen: (_) => const ChangePasswordScreen(),
      Screens.splashAfterLoginScreen: (_) => const SplashAfterLoginScreen(),
    };
