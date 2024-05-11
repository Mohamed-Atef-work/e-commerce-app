import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_email.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/log_out_use_case.dart';
import 'package:e_commerce_app/modules/auth/data/repository/auth_data_repository.dart';
import 'package:e_commerce_app/modules/auth/data/data_source/auth_remote_data_source.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_bloc.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/logout_controller/logout_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/change_email_controller/change_email_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/change_password_controller/change_password_cubit.dart';

void auth() {
  // < --------------------------------- Auth --------------------------------- >
  /// blocs

  sl.registerFactory(() => LogoutCubit(sl()));
  sl.registerFactory(() => LoginBloc(sl(), sl()));
  sl.registerFactory(() => ChangeEmailCubit(sl()));
  sl.registerFactory(() => ChangePasswordCubit(sl()));
  sl.registerFactory(() => SignUpBloc(sl(), sl()));

  /// UseCases
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginInUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl(), sl()));

  /// Repositories
  sl.registerLazySingleton<AuthRepositoryDomain>(
      () => AuthRepositoryData(sl()));

  /// Data Sources
  sl.registerLazySingleton<AuthBaseRemoteDatSource>(
      () => AuthRemoteDatSourceImpl(sl(), sl()));
  sl.registerLazySingleton(() => UpdateEmailUseCase(sl(), sl()));
}
