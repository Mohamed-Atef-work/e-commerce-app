import 'package:e_commerce_app/core/services/init_service.dart';
import 'package:get_it/get_it.dart';
import 'package:e_commerce_app/core/services/auth_service.dart';
import 'package:e_commerce_app/core/services/user_service.dart';
import 'package:e_commerce_app/core/services/order_service.dart';
import 'package:e_commerce_app/core/services/admin_service.dart';
import 'package:e_commerce_app/core/services/shared_service.dart';
import 'package:e_commerce_app/core/services/favorite_service.dart';

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
