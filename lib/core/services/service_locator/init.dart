import 'package:e_commerce_app/core/services/service_locator/init_service.dart';
import 'package:get_it/get_it.dart';
import 'package:e_commerce_app/core/services/service_locator/auth_service.dart';
import 'package:e_commerce_app/core/services/service_locator/user_service.dart';
import 'package:e_commerce_app/core/services/service_locator/order_service.dart';
import 'package:e_commerce_app/core/services/service_locator/admin_service.dart';
import 'package:e_commerce_app/core/services/service_locator/shared_service.dart';
import 'package:e_commerce_app/core/services/service_locator/favorite_service.dart';

final sl = GetIt.instance;

void serviceLocatorInit() {
  init();
  auth();
  user();
  admin();
  shared();
  orders();
  favorite();
}
