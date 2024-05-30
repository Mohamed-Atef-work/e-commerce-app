import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/core/services/local_data_base_service/local_data_base_interface.dart';
import 'package:e_commerce_app/core/services/local_data_base_service/shared_prefs_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/core/fire_base/fire_storage.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/cart.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/user.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/order.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/product.dart';
import 'package:e_commerce_app/core/fire_base/fire_auth/user_auth.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/favorite.dart';

void init() {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<UserAuth>(() => UserAuthImpl(sl()));
  sl.registerLazySingleton<UserStore>(() => UserStoreImpl(sl()));
  sl.registerLazySingleton<StoreHelper>(() => StoreHelperImpl(sl()));
  sl.registerLazySingleton<ProductStore>(() => ProductStoreImpl(sl(),sl()));
  sl.registerLazySingleton<CartStore>(() => CartStoreImpl(sl(), sl()));
  sl.registerLazySingleton<OrderStore>(() => OrderStoreImpl(sl(), sl()));
  sl.registerLazySingleton<StorageService>(() => StorageServiceImpl(sl()));
  sl.registerLazySingleton<FavoriteStore>(() => FavoriteStoreImpl(sl(), sl()));
  sl.registerSingletonAsync<LocalDataBaseService>(() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefsImpl(prefs);
  });
}
