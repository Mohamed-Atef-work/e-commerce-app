import 'package:e_commerce_app/test_screen.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/modules/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce_app/modules/user/presentation/screens/details_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/splash_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/address_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/profile_screen.dart';
import 'package:e_commerce_app/modules/user/presentation/screens/user_layout_screen.dart';
import 'package:e_commerce_app/modules/orders/presentation/screens/user_order_screen.dart';
import 'package:e_commerce_app/modules/admin/presentation/screens/admin_layout_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/edit_profile_screen.dart';
import 'package:e_commerce_app/modules/admin/presentation/screens/admin_details_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/change_password_screen.dart';
import 'package:e_commerce_app/modules/admin/presentation/screens/admin_add_product_screen.dart';
import 'package:e_commerce_app/modules/shared/presentation/screens/splash_after_login_screen.dart';

routes() => {
      Screens.testScreen: (context) => const TestScreen(),
      Screens.loginScreen: (context) => const LoginScreen(),
      Screens.splashScreen: (context) => const SplashScreen(),
      Screens.signUpScreen: (context) => const SignUpScreen(),
      Screens.detailsScreen: (context) => const DetailsScreen(),
      Screens.profileScreen: (context) => const ProfileScreen(),
      Screens.userOrderScreen: (context) => const UserOrderScreen(),
      Screens.userLayoutScreen: (context) => const UserLayoutScreen(),
      Screens.addProductScreen: (context) => const AddProductScreen(),
      Screens.adminLayoutScreen: (context) => const AdminLayoutScreen(),
      Screens.editProfileScreen: (context) => const EditProfileScreen(),
      Screens.editAddressScreen: (context) => const EditAddressScreen(),
      Screens.adminDetailsScreen: (context) => const AdminDetailsScreen(),
      Screens.changePasswordScreen: (context) => const ChangePasswordScreen(),
      Screens.splashAfterLoginScreen: (context) =>
          const SplashAfterLoginScreen(),
    };
