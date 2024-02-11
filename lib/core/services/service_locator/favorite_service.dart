import 'package:e_commerce_app/core/services/service_locator/init.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_email.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_password.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_favorites_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/data/data_source/favorite_remote_data_source.dart';
import 'package:e_commerce_app/modules/home/data/repository/favorite_data_repository.dart';
import 'package:e_commerce_app/modules/home/domain/repository/favorite_domain_repository.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_favorite_products_controller/manage_favorite_products_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';

void favorite() {
  /// Bloc
  sl.registerFactory(() => GetFavoriteCubit(sl()));
  sl.registerFactory(() => ManageFavoriteCubit(sl(), sl()));

  /// UseCases
  sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => DeleteFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEmailUseCase(sl()));

  /// Repository
  sl.registerLazySingleton<FavoriteDomainRepository>(
      () => FavoriteDataRepository(sl()));

  /// Data Source
  sl.registerLazySingleton<FavoriteBaseRemoteDataSource>(
      () => FavoriteRemoteDataSource(sl()));
}
