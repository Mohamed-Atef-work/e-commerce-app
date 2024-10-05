import 'auth_service.dart';
import 'init_service.dart';
import 'user_service.dart';
import 'order_service.dart';
import 'admin_service.dart';
import 'shared_service.dart';
import 'favorite_service.dart';
import 'package:get_it/get_it.dart';

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
