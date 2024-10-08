import 'package:e_commerce_app/modules/user/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/products_view_controller/products_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_order_view/user_order_view_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/user_layout_controller/user_layout_cubit.dart';
import 'package:e_commerce_app/modules/user/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/user/data/data_source/cart_remote_data_source.dart';
import 'package:e_commerce_app/modules/user/data/data_source/payment_data_source.dart';
import 'package:e_commerce_app/modules/user/data/repository/cart_data_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/user/data/repository/payment_impl.dart';
import 'package:e_commerce_app/modules/user/domain/repository/payment.dart';
import 'package:e_commerce_app/core/services/stripe/stripe_service.dart';
import 'package:e_commerce_app/modules/user/use_case/check_out.dart';
import 'package:e_commerce_app/config/service_locator/sl.dart';

void user() {
  sl.registerLazySingleton(() => StripeService(sl()));

  /// blocs
  sl.registerFactory(() => UserLayoutCubit());
  sl.registerFactory(() => ProductDetailsCubit(sl()));
  sl.registerFactory(() => ManageUserOrderViewCubit());
  sl.registerFactory(() => ProductsViewCubit(sl(), sl()));
  sl.registerFactory(() => ManageCartProductsCubit(sl(), sl()));

  /// Use Case
  /// <-------------------- Orders ------------------------------->
  sl.registerLazySingleton(() => AddOrderUseCase(sl(), sl()));
  sl.registerLazySingleton(() => CheckoutUseCase(sl(), sl()));

  /// Repositories
  sl.registerLazySingleton<PaymentRepo>(() => PaymentRepoImpl(sl()));
  sl.registerLazySingleton<CartDomainRepo>(() => CartDataRepo(sl()));

  /// Data Sources
  sl.registerLazySingleton<PaymentDataSource>(() => StripDataSource(sl()));
  sl.registerLazySingleton<CartBaseRemoteDataSource>(
      () => CartRemoteDataSource(sl(), sl()));
}
