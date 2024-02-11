import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/modules/auth/data/data_source/auth_remote_data_source.dart';
import 'package:e_commerce_app/modules/auth/data/repository/auth_data_repository.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/update_profile_use_case.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/up_date_profile_controller/update_profile_cubit.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_bloc.dart';
void auth() {
  // < --------------------------------- Auth --------------------------------- >
  /// blocs
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => SignUpBloc(sl(), sl(), sl()));
  sl.registerFactory(() => UpdateProfileCubit(sl()));

  /// UseCases
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginInUseCase(sl()));
  sl.registerLazySingleton(() => GetUserDataUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => StoreUserDataUseCase(sl()));

  /// Repositories
  sl.registerLazySingleton<AuthRepositoryDomain>(
          () => AuthRepositoryData(sl()));

  /// Data Sources
  sl.registerLazySingleton<AuthBaseRemoteDatSource>(
          () => AuthRemoteDatSourceImpl(sl(), sl()));
}
