import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_favorite_params.dart';

abstract class FavoriteStore {
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getProductsOfCategory(
      GetProductOfCategoryParams params);
  Future<QuerySnapshot<Map<String, dynamic>>> getCategories(String uId);
  Future<void> deleteFav(AddDeleteFavoriteParams params);
  Future<void> addFav(AddDeleteFavoriteParams params);
}

class FavoriteStoreImpl implements FavoriteStore {
  final FirebaseFirestore _store;
  final StoreHelper _storeHelper;
  FavoriteStoreImpl(this._store, this._storeHelper);

  @override
  Future<void> deleteFav(AddDeleteFavoriteParams params) async {
    await _store
        .collection(kUsers)
        .doc(params.uId)
        .collection(kFavorites)
        .doc(params.category)
        .collection(kProducts)
        .doc(params.productId)
        .delete();
  }

  @override
  Future<void> addFav(AddDeleteFavoriteParams params) async {
    final existParams = GetProductParams(
      category: params.category,
      productId: params.productId,
    );
    final favParams = FavoriteParams(
      uId: params.uId,
      category: params.category,
      productId: params.productId,
    );
    final exists = await _storeHelper.doesProductExists(existParams);
    if (exists) {
      await _setFavCategoryToBeAvailableToFetch(favParams);
      await _store
          .collection(kUsers)
          .doc(params.uId)
          .collection(kFavorites)
          .doc(params.category)
          .collection(kProducts)
          .doc(params.productId)
          .set(const {});
    } else {
      throw const ServerException(message: AppStrings.outOfStock);
    }
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getCategories(String uId) async {
    return await _store
        .collection(kUsers)
        .doc(uId)
        .collection(kFavorites)
        .get();
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getProductsOfCategory(
      GetProductOfCategoryParams params) async {
    List<DocumentSnapshot<Map<String, dynamic>>> products = [];

    for (String id in params.ids) {
      final productDoc = await _storeHelper.getProduct(
          GetProductParams(category: params.category, productId: id));

      if (productDoc.exists) {
        products.add(productDoc);
      } else {
        await deleteFav(
          AddDeleteFavoriteParams(
              uId: params.uId,
              productId: productDoc.id,
              category: params.category),
        );
      }
    }
    return products;
  }

  Future<void> _setFavCategoryToBeAvailableToFetch(
      FavoriteParams params) async {
    await _store
        .collection(kUsers)
        .doc(params.uId)
        .collection(kFavorites)
        .doc(params.category)
        .set({"able_to_fetch": true});
  }

  /// get Categories;
  // get Fav categories Items;
  /// LOOP
  // -----> {
  /// --------- > get Items of One category;
  // ----------------> get IDs of One category;
  /// ------------------ > LOOP
  /// ------------------------> {
  // ---------------------------- > On get One Fav Item;
  /// ------------------------> {
  // ---------------->
  // -----> }
}

/// ///////////////////////////////////////////////////////////
class FavoriteParams extends Equatable {
  final String uId;
  final String category;
  final String productId;

  const FavoriteParams({
    required this.uId,
    required this.category,
    required this.productId,
  });

  @override
  List<Object?> get props => [
        uId,
        category,
        productId,
      ];
}
