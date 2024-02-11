import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/modules/orders/data/repository/order_data_repository.dart';
import 'package:e_commerce_app/modules/orders/data/data_source/order_remote_data_source.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_item_from_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_items_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_user_orders_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/up_date_order_data_use_case.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/update_order_data_controller/update_order_data_cubit.dart';
void orders() {
  sl.registerFactory(() => UpdateOrderDataCubit(sl()));
  sl.registerFactory(() => OrderItemsCubit(sl(), sl()));
  sl.registerFactory(() => GetUserOrdersCubit(sl(), sl()));

  sl.registerLazySingleton(() => DeleteOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetOrderItemsUseCase(sl()));
  sl.registerLazySingleton(() => GetUserOrdersUseCase(sl()));
  sl.registerLazySingleton(() => UpDateOrderDataUseCase(sl()));
  sl.registerLazySingleton(() => DeleteItemFromOrderUseCase(sl()));

  sl.registerLazySingleton<OrderDomainRepo>(() => OrderDataRepo(sl()));

  sl.registerLazySingleton<OrderBaseRemoteDataSource>(
          () => OrderRemoteDataSource(sl(), sl()));
}
