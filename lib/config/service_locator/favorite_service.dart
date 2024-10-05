import 'package:e_commerce_app/config/service_locator/sl.dart';
import 'package:e_commerce_app/modules/user/data/data_source/favorite_remote_data_source.dart';
import 'package:e_commerce_app/modules/user/data/repository/favorite_data_repository.dart';
import 'package:e_commerce_app/modules/user/domain/repository/favorite_domain_repository.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_favorite_products_controller/manage_favorite_products_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';

void favorite() {
  /// Bloc
  sl.registerFactory(() => GetFavoriteCubit(sl()));
  sl.registerFactory(() => ManageFavoriteCubit(sl()));

  /// Repository
  sl.registerLazySingleton<FavoriteDomainRepository>(
      () => FavoriteDataRepository(sl()));

  /// Data Source
  sl.registerLazySingleton<FavoriteBaseRemoteDataSource>(
      () => FavoriteRemoteDataSource(sl(), sl()));
}
