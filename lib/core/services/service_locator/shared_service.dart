import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/shared/data/repository/repository.dart';
import 'package:e_commerce_app/modules/shared/data/data_source/local_data_source.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/get_initial_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/load_product_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/get_all_product_categories.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/update_user_data_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/user_data_after_login_use_case.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/address_controller/edit_address_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/up_date_profile_controller/update_profile_cubit.dart';

void shared() {
  //sl.registerFactory(() => InitCubit(sl()));
  //sl.registerFactory(() => SharedPasswordCubit(sl()));

  sl.registerFactory(() => EditAddressCubit(sl()));
  sl.registerFactory(() => UpdateProfileCubit(sl()));
  sl.registerFactory(() => SharedUserDataCubit(sl(), sl(), sl()));

  sl.registerLazySingleton<SharedDomainRepo>(() => SharedDataRepo(sl()));
  sl.registerLazySingleton<SharedLocalDataSource>(
      () => SharedLocalDataSourceImpl(sl()));

  sl.registerLazySingleton(() => GetUserDataUseCase(sl()));
  sl.registerLazySingleton(() => LoadProductsUseCase(sl()));
  sl.registerLazySingleton(() => StoreUserDataUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserDataUseCase(sl(), sl()));
  sl.registerLazySingleton(() => GetInitialDataUseCase(sl(), sl()));
  sl.registerLazySingleton(() => GetAllProductCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => UserDataAfterLoginUseCase(sl(), sl()));
}
