import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/core/fire_base/fire_storage.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
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
  sl.registerLazySingleton(() => SharedPreferences.getInstance());
  sl.registerLazySingleton<UserAuth>(() => UserAuthImpl(sl()));
  sl.registerLazySingleton<CartStore>(() => CartStoreImpl(sl()));
  sl.registerLazySingleton<UserStore>(() => UserStoreImpl(sl()));
  sl.registerLazySingleton<OrderStore>(() => OrderStoreImpl(sl()));
  sl.registerLazySingleton<ProductStore>(() => ProductStoreImpl(sl()));
  sl.registerLazySingleton<FavoriteStore>(() => FavoriteStoreImpl(sl()));
  sl.registerLazySingleton<StorageService>(() => StorageServiceImpl(sl()));
}
