import 'package:e_commerce_app/config/service_locator/sl.dart';
import 'package:e_commerce_app/modules/orders/data/repository/order_data_repository.dart';
import 'package:e_commerce_app/modules/orders/data/data_source/order_remote_data_source.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/update_order_data_controller/update_order_data_cubit.dart';

void orders() {
  sl.registerFactory(() => UpdateOrderDataCubit(sl()));
  sl.registerFactory(() => OrderItemsCubit(sl()));
  sl.registerFactory(() => GetUserOrdersCubit(sl()));

  sl.registerLazySingleton<OrderDomainRepo>(() => OrderDataRepo(sl()));

  sl.registerLazySingleton<OrderBaseRemoteDataSource>(
      () => OrderRemoteDataSource(sl(), sl()));
}
