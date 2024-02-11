import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/modules/home/data/data_source/cart_remote_data_source.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_product_quantities_of_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/user_layout_controller/user_layout_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/home/data/repository/cart_data_repository.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_order_view/user_order_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_orders/manage_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_item_to_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';

void user() {
  /// blocs
  sl.registerFactory(() => UserLayoutCubit());
  sl.registerFactory(() => ProductDetailsCubit(sl()));
  sl.registerFactory(() => ManageUserOrderViewCubit());
  sl.registerFactory(() => ProductsViewCubit(sl(), sl()));
  sl.registerFactory(
      () => ManageCartProductsCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ManageUserOrdersCubit(sl(), sl(), sl(), sl()));

  /// Use Case
  /// <-------------------- Orders ------------------------------->
  sl.registerLazySingleton(() => AddOrderUseCase(sl()));
  sl.registerLazySingleton(() => AddItemToOrderUseCase(sl()));

  /// <--------------------- Cart ------------------------------->
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));
  sl.registerLazySingleton(() => DeleteFromCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCartProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetCartProductsQuantitiesUseCase(sl()));

  /// Repositories
  sl.registerLazySingleton<CartDomainRepo>(() => CartDataRepo(sl()));

  /// Data Sources
  sl.registerLazySingleton<CartBaseRemoteDataSource>(
      () => CartRemoteDataSource(sl()));
}
