import 'package:e_commerce_app/core/services/service_locator/init.dart';
import 'package:e_commerce_app/modules/admin/data/data_source/admin_remote_data_source.dart';
import 'package:e_commerce_app/modules/admin/data/repository/admin_data_repository.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_new_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/download_product_image_url_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/edit_product_use_case.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_users_who_ordered_controller/get_users_who_ordered_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_admin_order_view/admin_order_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_users_who_ordered_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/up_date_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/upload_product_image_use_case.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/explore_product_controller/explore_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_cubit.dart';
void admin() {
  // < --------------------------------- Admin -------------------------------- >
  /// blocs
  sl.registerFactory(() => AdminLayoutCubit());
  sl.registerFactory(() => AdminDetailsCubit(sl()));
  sl.registerFactory(() => ExploreProductsCubit(sl()));
  sl.registerFactory(() => ManageAdminOrderViewCubit());
  sl.registerFactory(() => GetUsersWhoOrderedCubit(sl()));
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
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersWhoOrderedUseCase(sl()));
  sl.registerLazySingleton(() => UploadProductImageUseCase(sl()));
  sl.registerLazySingleton(() => AddNewProductCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductsCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DownloadProductImageUrlUseCase(sl()));
}
