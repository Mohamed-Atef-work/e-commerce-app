import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/services/fire_storage_service.dart';
import 'package:e_commerce_app/core/services/fire_store_services/cart.dart';
import 'package:e_commerce_app/core/services/fire_store_services/favorite.dart';
import 'package:e_commerce_app/core/services/fire_store_services/order.dart';
import 'package:e_commerce_app/core/services/fire_store_services/product.dart';
import 'package:e_commerce_app/core/services/fire_store_services/user.dart';
import 'package:e_commerce_app/modules/admin/data/data_source/admin_remote_data_source.dart';
import 'package:e_commerce_app/modules/admin/data/repository/admin_data_repository.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_new_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/download_product_image_url_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/edit_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/get_all_product_categories.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/up_date_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/upload_product_image_use_case.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_product_details_controller/admin_product_details_cubit.dart';
import 'package:e_commerce_app/modules/auth/data/data_source/auth_remote_data_source.dart';
import 'package:e_commerce_app/modules/auth/data/repository/auth_data_repository.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_bloc.dart';
import 'package:e_commerce_app/modules/home/data/data_source/cart_remote_data_source.dart';
import 'package:e_commerce_app/modules/home/data/data_source/favorite_remote_data_source.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/add_cart_product_controller/add_cart_product_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/add_delete_favorite_controller/add_delete_favorite_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/delete_cart_product_controller/delete_cart_product_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_cart_products_controller/get_cart_products_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/layout_controller/layout_cubit.dart';
import 'package:e_commerce_app/modules/orders/data/data_source/order_remote_data_source.dart';
import 'package:e_commerce_app/modules/home/data/repository/cart_data_repository.dart';
import 'package:e_commerce_app/modules/orders/data/repository/order_data_repository.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_favorites_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorites_controller/get_favorites_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../../modules/admin/domain/use_cases/load_product_use_case.dart';
import '../../modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_cubit.dart';
import '../../modules/admin/presentation/controllers/explore_product_controller/explore_product_cubit.dart';
import '../../modules/home/data/repository/favorite_data_repository.dart';
import '../../modules/home/domain/repository/favorite_domain_repository.dart';
import '../../modules/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import '../../modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';

final sl = GetIt.instance;

void serviceLocatorInit() {
  _auth();
  _admin();
  _home();
  _init();
}

void _init() {
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton<StorageService>(() => StorageServiceImpl(sl()));
  sl.registerLazySingleton<UserStore>(() => UserStoreImpl(sl()));
  sl.registerLazySingleton<ProductStore>(() => ProductStoreImpl(sl()));
  sl.registerLazySingleton<FavoriteStore>(() => FavoriteStoreImpl(sl()));
  sl.registerLazySingleton<CartStore>(() => CartStoreImpl(sl()));
  sl.registerLazySingleton<OrderStore>(() => OrderStoreImpl(sl()));
}

void _admin() {
  // < --------------------------------- Admin -------------------------------- >
  /// blocs
  sl.registerFactory(() => ExploreProductsCubit(sl()));
  sl.registerFactory(() => AdminProductDetailsCubit(sl(), sl()));
  sl.registerFactory(() => CategoriesModelSheetCubit(sl(), sl(), sl()));
  sl.registerFactory(() => EditAddProductCubit(sl(), sl(), sl(), sl(), sl()));

  /// Repositories
  sl.registerLazySingleton<AdminRepositoryDomain>(
      () => AdminRepositoryData(sl()));

  /// Data Sources
  sl.registerLazySingleton<AdminBaseRemoteDataSource>(
      () => AdminRemoteDataSourceImpl(sl(), sl()));

  /// UseCases
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  sl.registerLazySingleton(() => LoadProductsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
  sl.registerLazySingleton(() => UploadProductImageUseCase(sl()));
  sl.registerLazySingleton(() => AddNewProductCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductsCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetAllProductCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => DownloadProductImageUrlUseCase(sl()));
}

void _auth() {
  // < --------------------------------- Auth --------------------------------- >
  /// blocs
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => SignUpBloc(sl(), sl()));

  /// UseCases
  sl.registerLazySingleton(() => LoginInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => StoreUserDataUseCase(sl()));

  /// Repositories
  sl.registerLazySingleton<AuthRepositoryDomain>(
      () => AuthRepositoryData(sl()));

  /// Data Sources
  sl.registerLazySingleton<AuthBaseRemoteDatSource>(
      () => AuthRemoteDatSourceImpl(sl()));
}

void _home() {
  /// blocs
  sl.registerFactory(() => ProductDetailsCubit(sl()));
  sl.registerFactory(() => HomeCubit(sl(), sl()));
  sl.registerFactory(() => LayoutCubit());
  sl.registerFactory(() => GetFavoritesCubit(sl()));
  sl.registerFactory(() => AddDeleteFavoriteCubit(sl(), sl()));
  sl.registerFactory(() => GetCartProductsCubit(sl()));
  sl.registerFactory(() => DeleteCartProductCubit(sl()));
  sl.registerFactory(() => AddCartProductCubit(sl()));

  /// Use Case
  sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => DeleteFromCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCartProductsUseCase(sl()));

  /// Repositories
  sl.registerLazySingleton<FavoriteDomainRepository>(
      () => FavoriteDataRepository(sl()));
  sl.registerLazySingleton<CartDomainRepo>(() => CartDataRepo(sl()));
  sl.registerLazySingleton<OrderDomainRepo>(() => OrderDataRepo(sl()));

  /// Data Sources
  sl.registerLazySingleton<FavoriteBaseRemoteDataSource>(
      () => FavoriteRemoteDataSource(sl()));
  sl.registerLazySingleton<CartBaseRemoteDataSource>(
      () => CartRemoteDataSource(sl()));
  sl.registerLazySingleton<OrderBaseRemoteDataSource>(
      () => OrderRemoteDataSource(sl()));

  /// External
}
