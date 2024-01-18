import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/fire_base/strings.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';

abstract class FavoriteStore {
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getFavProductsOfCategory(
      {required List<String> productIds, required String category});
  Future<QuerySnapshot<Map<String, dynamic>>> getFavProductsIdsOfCategory(
      DocumentReference reference);
  Future<QuerySnapshot<Map<String, dynamic>>> getFavCategories(String uId);
  Future<void> addFav(AddDeleteFavoriteParams params);
  Future<void> deleteFav(AddDeleteFavoriteParams parameters);
}

class FavoriteStoreImpl implements FavoriteStore {
  final FirebaseFirestore store;
  FavoriteStoreImpl(this.store);

  @override
  Future<void> deleteFav(AddDeleteFavoriteParams parameters) async {
    await store
        .collection(FirebaseStrings.users)
        .doc(parameters.uId)
        .collection(FirebaseStrings.favorites)
        .doc(parameters.category)
        .collection(FirebaseStrings.products)
        .doc(parameters.productId)
        .delete();
  }

  @override
  Future<void> addFav(AddDeleteFavoriteParams params) async {
    await _setFavCategoryToBeAvailableToFetch(
      FavoriteParameters(
        uId: params.uId,
        category: params.category,
        productId: params.productId,
      ),
    );
    await store
        .collection(FirebaseStrings.users)
        .doc(params.uId)
        .collection(FirebaseStrings.favorites)
        .doc(params.category)
        .collection(FirebaseStrings.products)
        .doc(params.productId)
        .set(const {});
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getFavCategories(
      String uId) async {
    return await store
        .collection(FirebaseStrings.users)
        .doc(uId)
        .collection(FirebaseStrings.favorites)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getFavProductsIdsOfCategory(
      DocumentReference reference) async {
    final response = await reference.collection(FirebaseStrings.products).get();
    if (response.docs.isEmpty) {
      /// Solving the second part of database problem :) .....
      /// Deleting categories that doesn't contain [Favs] :) .....
      await reference.delete();
    }
    return response;
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>>
      getFavProductsOfCategory({
    required List<String> productIds,
    required String category,
  }) async {
    List<DocumentSnapshot<Map<String, dynamic>>> products = [];

    for (int index = 0; index < productIds.length; index++) {
      final productDoc = await _getFavProduct(
          category: category, productId: productIds[index]);
      products.add(productDoc);
    }
    return products;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getFavProduct(
      {required String category, required String productId}) async {
    return await store
        .collection(FirebaseStrings.products)
        .doc(FirebaseStrings.categories)
        .collection(category)
        .doc(productId)
        .get();
  }

  Future<void> _setFavCategoryToBeAvailableToFetch(
      FavoriteParameters parameters) async {
    await store
        .collection(FirebaseStrings.users)
        .doc(parameters.uId)
        .collection(FirebaseStrings.favorites)
        .doc(parameters.category)
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
class FavoriteParameters extends Equatable {
  final String uId;
  final String productId;
  final String category;

  const FavoriteParameters({
    required this.uId,
    required this.productId,
    required this.category,
  });

  @override
  List<Object?> get props => [
        uId,
        productId,
        category,
      ];
}
