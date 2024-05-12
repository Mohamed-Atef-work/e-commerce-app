import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/shared/data/repository/repository.dart';
import 'package:e_commerce_app/modules/shared/data/data_source/local_data_source.dart';
import 'package:e_commerce_app/modules/shared/data/data_source/remote_data_source.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/get_initial_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/save_address_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/update_user_data_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/user_data_after_login_use_case.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/address_controller/edit_address_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/up_date_profile_controller/update_profile_cubit.dart';

void shared() {
  sl.registerFactory(() => EditAddressCubit(sl()));
  sl.registerFactory(() => UpdateProfileCubit(sl()));
  sl.registerFactory(() => SharedUserDataCubit(sl(), sl(), sl()));

  sl.registerLazySingleton<SharedDomainRepo>(() => SharedDataRepo(sl(), sl()));
  sl.registerLazySingleton<SharedLocalDataSource>(
      () => SharedLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<SharedRemoteDataSource>(
      () => SharedRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton(() => LoadProductsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateAddressUseCase(sl(), sl()));
  sl.registerLazySingleton(() => UpdateUserDataUseCase(sl(), sl()));
  sl.registerLazySingleton(() => GetInitialDataUseCase(sl(), sl()));
  sl.registerLazySingleton(() => UserDataAfterLoginUseCase(sl(), sl()));
}
